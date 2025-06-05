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
using Newtonsoft.Json;

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
            Title = "Budget Dashboard ";

            // Initial state
            HasData = false;
            IsUserAuthenticated = _userService.IsAuthenticated;
        }

        // Command to navigate to the AddBudgetPage
        public Command AddBudgetCommand => new Command(NavigateToAddBudgetPage);

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


        [RelayCommand]
        public async Task EditBudget(Budget budget)
        {
            if (budget == null) return;

            try
            {
                Console.WriteLine($"Navigating to edit budget: {budget.Name}");

                // Pass the budget data as navigation parameters
                var parameters = new Dictionary<string, object>
                {
                    ["Budget"] = budget
                };

                await _navigationService.NavigateToAsync("EditBudgetPage", parameters);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error navigating to edit budget: {ex.Message}");
                await Shell.Current.DisplayAlert("Error", "Failed to open budget for editing", "OK");
            }
        }

        [RelayCommand]
        public async Task LoadBudgetsAsync()
        {
            Console.WriteLine("=== Starting LoadBudgetsAsync ===");

            if (!_userService.IsAuthenticated)
            {
                Console.WriteLine("User is not authenticated");
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
                Console.WriteLine($"Current User ID: {userId}");

                if (string.IsNullOrEmpty(userId))
                {
                    Console.WriteLine("User ID is null or empty");
                    ErrorMessage = "User ID not found";
                    HasData = false;
                    return;
                }

                // Try to get budgets - with fallback mechanisms
                List<Budget> userBudgets = new List<Budget>();

                try
                {
                    Console.WriteLine("Attempting to fetch budgets from Firestore...");

                    // First attempt - standard Firestore approach
                    var allBudgets = await _firestoreService.GetAllAsync<Budget>("budgets");
                    Console.WriteLine($"Total budgets fetched from Firestore: {allBudgets?.Count ?? 0}");

                    if (allBudgets != null && allBudgets.Any())
                    {
                        userBudgets = allBudgets
                            .Where(b => b.UserId == userId && !b.IsDeleted)
                            .OrderByDescending(b => b.Created)
                            .ToList();

                        Console.WriteLine($"Filtered budgets for user {userId}: {userBudgets.Count}");
                    }
                    else
                    {
                        Console.WriteLine("No budgets returned from Firestore");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error fetching from Firestore: {ex}");

                    if (ex.Message.Contains("HTTP/2") || ex.Message.Contains("connection") || ex.Message.Contains("gRPC"))
                    {
                        // Fallback - use direct REST API call (same pattern as AddBudgetViewModel)
                        Console.WriteLine($"HTTP/2/gRPC connection error, trying REST API fallback: {ex.Message}");

                        try
                        {
                            userBudgets = await LoadBudgetsDirectly(userId);
                            Console.WriteLine($"Loaded {userBudgets.Count} budgets via REST API fallback");
                        }
                        catch (Exception restEx)
                        {
                            Console.WriteLine($"REST API fallback also failed: {restEx.Message}");

                            // Try to load from cache as last resort
                            userBudgets = await LoadBudgetsFromCache(userId);
                            Console.WriteLine($"Loaded {userBudgets.Count} budgets from cache");

                            if (!userBudgets.Any())
                            {
                                ErrorMessage = "Unable to connect to the server. Please check your connection.";
                            }
                        }
                    }
                    else
                    {
                        throw; // Re-throw if it's not a connection error
                    }
                }

                // Update the UI with whatever data we have
                Console.WriteLine($"Updating UI with {userBudgets.Count} budgets");

                Budgets.Clear();
                foreach (var budget in userBudgets)
                {
                    Console.WriteLine($"Adding budget to UI: {budget.Name}");
                    Budgets.Add(budget);
                }

                // Calculate totals
                TotalBudgeted = userBudgets.Sum(b => b.TotalAmount);
                TotalSpent = userBudgets.Sum(b => CalculateSpent(b));

                HasData = Budgets.Any();
                Console.WriteLine($"HasData: {HasData}, Budgets.Count: {Budgets.Count}");

                if (!HasData)
                {
                    ErrorMessage = "No budgets found. Add your first budget!";
                    Console.WriteLine("Setting error message: No budgets found");
                }
                else
                {
                    ErrorMessage = string.Empty;
                    Console.WriteLine("Budgets loaded successfully, clearing error message");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"General error loading budgets: {ex}");
                ErrorMessage = $"Error loading budgets: {ex.Message}";
            }
            finally
            {
                IsBusy = false;
                IsRefreshing = false;
                Console.WriteLine("=== Finished LoadBudgetsAsync ===");
            }
        }

        private double CalculateSpent(Budget budget)
        {
            // Calculate total spent for a budget based on budget items (price * quantity)
            return budget.BudgetItems?.Sum(i => i.Price * i.Quantity) ?? 0;
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

            // Use the same method as EditBudget to pass the full Budget object
            await _navigationService.NavigateToAsync("EditBudgetPage", new Dictionary<string, object>
            {
                { "Budget", budget }  // Changed from "BudgetId" to "Budget"
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

        // Add this new method to MainPageViewModel (same pattern as AddBudgetViewModel)
        private async Task<List<Budget>> LoadBudgetsDirectly(string userId)
        {
            try
            {
                Console.WriteLine("Loading budgets directly via REST API...");

                // Create HTTP client with HTTP/1.1 (same as AddBudgetViewModel)
                using var httpClient = new HttpClient(new HttpClientHandler
                {
                    SslProtocols = System.Security.Authentication.SslProtocols.Tls12
                });
                httpClient.DefaultRequestVersion = new Version(1, 1);

                string projectId = "budgetpro-33542";
                string authToken = await _userService.GetAuthToken();

                if (string.IsNullOrEmpty(authToken))
                {
                    throw new UnauthorizedAccessException("No auth token available");
                }

                var url = $"https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents/budgets";

                var request = new HttpRequestMessage(HttpMethod.Get, url);
                request.Headers.Add("Authorization", $"Bearer {authToken}");

                var response = await httpClient.SendAsync(request);
                var content = await response.Content.ReadAsStringAsync();

                Console.WriteLine($"REST API Response: {response.StatusCode}");

                if (!response.IsSuccessStatusCode)
                {
                    throw new Exception($"Firestore REST API error: {response.StatusCode} - {content}");
                }

                // Parse the Firestore REST API response
                var firestoreResponse = Newtonsoft.Json.JsonConvert.DeserializeObject<FirestoreListResponse>(content);
                var budgets = new List<Budget>();

                if (firestoreResponse?.Documents != null)
                {
                    foreach (var doc in firestoreResponse.Documents)
                    {
                        try
                        {
                            var budget = ConvertFirestoreDocumentToBudget(doc);
                            if (budget != null && budget.UserId == userId && !budget.IsDeleted)
                            {
                                budgets.Add(budget);
                                Console.WriteLine($"Converted budget: {budget.Name} for user {budget.UserId}");
                            }
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error converting document: {ex.Message}");
                        }
                    }
                }

                Console.WriteLine($"REST API: Returning {budgets.Count} filtered budgets");
                return budgets.OrderByDescending(b => b.Created).ToList();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"REST API Error: {ex}");
                throw;
            }
        }

        // Update this helper method to convert Firestore document to Budget object
        private Budget ConvertFirestoreDocumentToBudget(FirestoreDocument doc)
        {
            if (doc?.Fields == null)
                return null;

            var budget = new Budget();

            // Extract each field safely
            if (doc.Fields.TryGetValue("Id", out var idField) && idField.StringValue != null)
                budget.Id = idField.StringValue;

            if (doc.Fields.TryGetValue("Name", out var nameField) && nameField.StringValue != null)
                budget.Name = nameField.StringValue;

            if (doc.Fields.TryGetValue("Description", out var descField) && descField.StringValue != null)
                budget.Description = descField.StringValue;

            if (doc.Fields.TryGetValue("TotalAmount", out var amountField) && amountField.DoubleValue.HasValue)
                budget.TotalAmount = amountField.DoubleValue.Value;

            if (doc.Fields.TryGetValue("UserId", out var userIdField) && userIdField.StringValue != null)
                budget.UserId = userIdField.StringValue;

            if (doc.Fields.TryGetValue("Created", out var createdField) && createdField.TimestampValue != null)
                budget.Created = DateTime.Parse(createdField.TimestampValue).ToUniversalTime();

            if (doc.Fields.TryGetValue("Updated", out var updatedField) && updatedField.TimestampValue != null)
                budget.Updated = DateTime.Parse(updatedField.TimestampValue).ToUniversalTime();

            if (doc.Fields.TryGetValue("IsDeleted", out var deletedField) && deletedField.BooleanValue.HasValue)
                budget.IsDeleted = deletedField.BooleanValue.Value;

            // Extract budget items
            budget.BudgetItems = new List<BudgetItem>();

            // Check if BudgetItems array exists in the document
            if (doc.Fields.TryGetValue("BudgetItems", out var budgetItemsField) &&
                budgetItemsField.ArrayValue?.Values != null)
            {
                Console.WriteLine($"Found {budgetItemsField.ArrayValue.Values.Count} budget items in document");

                foreach (var itemValue in budgetItemsField.ArrayValue.Values)
                {
                    try
                    {
                        if (itemValue.MapValue?.Fields != null)
                        {
                            var item = new BudgetItem();
                            var fields = itemValue.MapValue.Fields;

                            // Extract item properties
                            if (fields.TryGetValue("Id", out var itemIdField) && itemIdField.StringValue != null)
                                item.Id = itemIdField.StringValue;

                            if (fields.TryGetValue("Name", out var itemNameField) && itemNameField.StringValue != null)
                                item.Name = itemNameField.StringValue;

                            if (fields.TryGetValue("Price", out var priceField) && priceField.DoubleValue.HasValue)
                                item.Price = priceField.DoubleValue.Value;

                            if (fields.TryGetValue("Quantity", out var qtyField))
                            {
                                if (qtyField.IntegerValue != null)
                                    item.Quantity = int.Parse(qtyField.IntegerValue);
                                else if (qtyField.DoubleValue.HasValue)
                                    item.Quantity = (int)qtyField.DoubleValue.Value;
                            }

                            if (fields.TryGetValue("BudgetId", out var budgetIdField) && budgetIdField.StringValue != null)
                                item.BudgetId = budgetIdField.StringValue;

                            if (fields.TryGetValue("Created", out var itemCreatedField) && itemCreatedField.TimestampValue != null)
                                item.Created = DateTime.Parse(itemCreatedField.TimestampValue).ToUniversalTime();

                            if (fields.TryGetValue("Updated", out var itemUpdatedField) && itemUpdatedField.TimestampValue != null)
                                item.Updated = DateTime.Parse(itemUpdatedField.TimestampValue).ToUniversalTime();

                            if (fields.TryGetValue("IsDeleted", out var itemDeletedField) && itemDeletedField.BooleanValue.HasValue)
                                item.IsDeleted = itemDeletedField.BooleanValue.Value;

                            // Add the item to the budget's items list
                            if (!item.IsDeleted)
                            {
                                budget.BudgetItems.Add(item);
                                Console.WriteLine($"Added item: {item.Name} - ${item.Price} x {item.Quantity}");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error parsing budget item: {ex.Message}");
                    }
                }
            }

            return budget;
        }

        // Add these helper classes to support the REST API response (same as AddBudgetViewModel pattern)
        public class FirestoreListResponse
        {
            public List<FirestoreDocument> Documents { get; set; }
        }

        public class FirestoreDocument
        {
            public Dictionary<string, FirestoreValue> Fields { get; set; }
        }

        public class FirestoreValue
        {
            public string StringValue { get; set; }
            public string IntegerValue { get; set; }
            public double? DoubleValue { get; set; }
            public bool? BooleanValue { get; set; }
            public string TimestampValue { get; set; }
            public FirestoreArrayValue ArrayValue { get; set; }
            public FirestoreMapValue MapValue { get; set; }
        }

        public class FirestoreArrayValue
        {
            public List<FirestoreValue> Values { get; set; }
        }

        public class FirestoreMapValue
        {
            public Dictionary<string, FirestoreValue> Fields { get; set; }
        }
    }
}
