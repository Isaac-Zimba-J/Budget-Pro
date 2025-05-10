using System;
using BudgetPro.Pages;
using BudgetPro.Services.Contracts;

namespace BudgetPro.ViewModels;

public class MainPageViewModel : BaseViewModel
{
    private readonly INavigationService _navigationService;

    public MainPageViewModel(INavigationService navigationService)
    {
        _navigationService = navigationService;
    }

    // Command to navigate to the AddBudgetPage
    public Command AddBudgetCommand => new Command(NavigateToAddBudgetPage);

    // Method to navigate to the AddBudgetPage
    // This method is called when the AddBudgetCommand is executed

    public async void NavigateToAddBudgetPage()
    {
        await _navigationService.NavigateToAsync($"{nameof(AddBudgetPage)}");
    }




}
