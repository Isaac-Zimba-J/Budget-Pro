using BudgetPro.Models;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Linq;
using System;
using System.Collections.Generic;

namespace BudgetPro.ViewModels;

public partial class BudgetViewModel : BaseViewModel
{
    private readonly INavigationService _navigationService;
    private readonly IFirestoreService _firestoreService;
    private readonly IUserService _userService;

    [ObservableProperty]
    private ObservableCollection<Budget> budgets = new();

    [ObservableProperty]
    private bool isRefreshing;

    [ObservableProperty]
    private string errorMessage;

    [ObservableProperty]
    private bool hasData;

    [ObservableProperty]
    private bool isUserAuthenticated;


    public BudgetViewModel(INavigationService navigationService, IFirestoreService firestoreService, IUserService userService)
    {
        _navigationService = navigationService;
        _firestoreService = firestoreService;
        _userService = userService;
        HasData = false;
        IsUserAuthenticated = _userService.IsAuthenticated;
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
            string userId = _userService.CurrentUserId;
            if (string.IsNullOrEmpty(userId))
            {
                ErrorMessage = "User ID not found";
                HasData = false;
                return;
            }
            var allBudgets = await _firestoreService.GetAllAsync<Budget>("budgets");
            var userBudgets = allBudgets?.Where(b => b.UserId == userId && !b.IsDeleted).OrderByDescending(b => b.Created).ToList() ?? new List<Budget>();
            Budgets.Clear();
            foreach (var budget in userBudgets)
                Budgets.Add(budget);
            HasData = Budgets.Any();
            if (!HasData)
                ErrorMessage = "No budgets found. Add your first budget!";
            else
                ErrorMessage = string.Empty;
        }
        catch (Exception ex)
        {
            ErrorMessage = $"Error loading budgets: {ex.Message}";
        }
        finally
        {
            IsBusy = false;
            IsRefreshing = false;
        }
    }

    public async Task OnAppearingAsync()
    {
        IsUserAuthenticated = _userService.IsAuthenticated;
        if (IsUserAuthenticated)
            await LoadBudgetsAsync();
        else
            await _navigationService.NavigateToAsync("///LoginPage");
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

}