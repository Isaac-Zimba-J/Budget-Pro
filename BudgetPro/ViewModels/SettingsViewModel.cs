using BudgetPro.Services;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.Input;

namespace BudgetPro.ViewModels;

public partial class SettingsViewModel
{

    private readonly IUserService UserService;
    private readonly INavigationService NavigationService;


    [RelayCommand]
    public async Task LogoutAsync()
    {
        bool confirm = await Shell.Current.DisplayAlert(
            "Log Out",
            "Are you sure you want to log out?",
            "Yes", "No");

        if (confirm)
        {
            await UserService.ClearUserAsync();
            await NavigationService.NavigateToAsync("LoginPage");
        }
    }
}