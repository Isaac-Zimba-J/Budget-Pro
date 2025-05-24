using BudgetPro.Models;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using System;
using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Linq;
using System.Windows.Input;
using BudgetPro.Pages;
using System.IO;

namespace BudgetPro.ViewModels
{
    public partial class MainPageViewModel : BaseViewModel
    {
        private readonly INavigationService _navigationService;
        private readonly IFirestoreService _firestoreService;
        private readonly IUserService _userService;

        [ObservableProperty]
        private ObservableCollection<Budget> _budgets = new();

        [ObservableProperty]
        private bool _isRefreshing;

        [ObservableProperty]
        private string _errorMessage;

        [ObservableProperty]
        private bool _hasData;

        [ObservableProperty]
        private double _totalBudgeted;

        [ObservableProperty]
        private double _totalSpent;

        [ObservableProperty]
        private bool _isUserAuthenticated;

        public MainPageViewModel(INavigationService navigationService, IFirestoreService firestoreService, IUserService userService)
        {
            _navigationService = navigationService;
            _firestoreService = firestoreService;
            _userService = userService;
            Title = "Budget Dashboard";

            // Initial state
            HasData = false;
            IsUserAuthenticated = _userService.IsAuthenticated;
        }

        // Command to navigate to the AddBudgetPage
        public Command AddBudgetCommand => new Command(NavigateToAddBudgetPage);
        public Command EditBudgetCommand => new Command(NavigateToEditBudgetPage);

        // Method to navigate to the AddBudgetPage
        // This method is called when the AddBudgetCommand is executed

        public async void NavigateToAddBudgetPage()
        {
            try
            {
                // Using relative navigation (no /// prefix) to add the page to the navigation stack
                await _navigationService.NavigateToAsync($"{nameof(AddBudgetPage)}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Navigation error: {ex.Message}");
                await Shell.Current.DisplayAlert("Navigation Error", ex.Message, "OK");
            }
        }


        public async void NavigateToEditBudgetPage()
        {
            await _navigationService.NavigateToAsync($"{nameof(EditBudgetPage)}");
        }

        [RelayCommand]
        public async Task LoadBudgetsAsync()
        {
            if (!_userService.IsAuthenticated)
            {
                ErrorMessage = "Please login to view your budgets";
                HasData = false;
                return;
            }

            try
            {
                IsBusy = true;
                IsRefreshing = true;
                ErrorMessage = string.Empty;

                // Get the user ID for filtering budgets
                string userId = _userService.CurrentUserId;

                if (string.IsNullOrEmpty(userId))
                {
                    ErrorMessage = "User ID not found";
                    HasData = false;
                    return;
                }

                // Try to get budgets - with fallback mechanisms
                List<Budget> userBudgets = new List<Budget>();

                try
                {
                    // First attempt - standard Firestore approach
                    var allBudgets = await _firestoreService.GetAllAsync<Budget>("budgets");
                    userBudgets = allBudgets
                        .Where(b => b.UserId == userId && !b.IsDeleted)
                        .OrderByDescending(b => b.Created)
                        .ToList();
                }
                catch (Exception ex) when (ex.Message.Contains("HTTP/2") || ex.Message.Contains("connection"))
                {
                    // Fallback - try HTTP/1.1 approach or cached data
                    Console.WriteLine($"HTTP/2 connection error, trying fallback approach: {ex.Message}");

                    // Try to load from cache first
                    userBudgets = await LoadBudgetsFromCache(userId);

                    if (!userBudgets.Any())
                    {
                        // Show temporary offline message but don't return yet
                        ErrorMessage = "Unable to connect to the server. Showing cached data if available.";
                    }
                }

                // Update the UI with whatever data we have
                Budgets.Clear();
                foreach (var budget in userBudgets)
                {
                    Budgets.Add(budget);
                }

                // Calculate totals
                TotalBudgeted = userBudgets.Sum(b => b.TotalAmount);
                TotalSpent = userBudgets.Sum(b => CalculateSpent(b));

                HasData = Budgets.Any();

                if (!HasData)
                {
                    ErrorMessage = "No budgets found. Add your first budget!";
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading budgets: {ex}");
                ErrorMessage = $"Error loading budgets: {ex.Message}";
            }
            finally
            {
                IsBusy = false;
                IsRefreshing = false;
            }
        }

        private double CalculateSpent(Budget budget)
        {
            // Calculate total spent for a budget based on budget items
            return budget.BudgetItems?.Sum(i => (double)i.Amount) ?? 0;
        }

        [RelayCommand]
        public async Task AddNewBudgetAsync()
        {
            await _navigationService.NavigateToAsync("AddBudgetPage");
        }

        [RelayCommand]
        public async Task BudgetSelectedAsync(Budget budget)
        {
            if (budget == null)
                return;

            await _navigationService.NavigateToAsync("EditBudgetPage", new Dictionary<string, object>
            {
                { "BudgetId", budget.Id }
            });
        }

        [RelayCommand]
        public async Task RefreshAsync()
        {
            await LoadBudgetsAsync();
        }

        public async Task OnAppearingAsync()
        {
            IsUserAuthenticated = _userService.IsAuthenticated;

            if (IsUserAuthenticated)
            {
                await LoadBudgetsAsync();
            }
            else
            {
                // Navigate to login if not authenticated
                await _navigationService.NavigateToAsync("///LoginPage");
            }
        }

        private async Task<List<Budget>> LoadBudgetsFromCache(string userId)
        {
            try
            {
                var cacheDir = Path.Combine(FileSystem.AppDataDirectory, "Cache");
                var cacheFile = Path.Combine(cacheDir, $"budgets_{userId}.json");

                if (!Directory.Exists(cacheDir))
                {
                    Directory.CreateDirectory(cacheDir);
                }

                if (File.Exists(cacheFile))
                {
                    var json = await File.ReadAllTextAsync(cacheFile);
                    var budgets = System.Text.Json.JsonSerializer.Deserialize<List<Budget>>(json);
                    return budgets ?? new List<Budget>();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading from cache: {ex.Message}");
            }

            return new List<Budget>();
        }

        private async Task SaveBudgetsToCache(List<Budget> budgets, string userId)
        {
            try
            {
                var cacheDir = Path.Combine(FileSystem.AppDataDirectory, "Cache");
                var cacheFile = Path.Combine(cacheDir, $"budgets_{userId}.json");

                if (!Directory.Exists(cacheDir))
                {
                    Directory.CreateDirectory(cacheDir);
                }

                var json = System.Text.Json.JsonSerializer.Serialize(budgets);
                await File.WriteAllTextAsync(cacheFile, json);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error saving to cache: {ex.Message}");
            }
        }
    }
}
