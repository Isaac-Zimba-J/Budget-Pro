using System;
using BudgetPro.Pages;
using BudgetPro.Services.Contracts;

namespace BudgetPro.Services;

public class NavigationService : INavigationService
{


    public async Task NavigateToAsync(string route, IDictionary<string, object>? parameters = null)
    {
        // Check if the route is for login or register pages which should use absolute navigation
        if (route == nameof(LoginPage) || route == nameof(RegisterPage))
        {
            if (!route.StartsWith("/"))
            {
                route = "///" + route;
            }
        }
        // For other pages, use relative navigation (no prefix needed)
        // This allows pushing pages onto the navigation stack

        try
        {
            if (parameters != null && parameters.Any())
            {
                await Shell.Current.GoToAsync(route, parameters);
            }
            else
            {
                await Shell.Current.GoToAsync(route);
            }
        }
        catch (Exception ex)
        {
            // Log navigation errors - you might want to show an alert instead
            Console.WriteLine($"Navigation error: {ex.Message}");
            await Shell.Current.DisplayAlert("Navigation Error", ex.Message, "OK");
        }
    }

    public Task GoBackAsync()
    {
        // Use Shell's GoBackAsync method to navigate back in the stack
        return Shell.Current.GoToAsync("..");
    }

}
