using BudgetPro.Pages;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Firebase.Auth;

namespace BudgetPro.ViewModels;

public partial class LoginViewModel : BaseViewModel
{
    private readonly INavigationService _navigationService;
    private readonly FirebaseAuthClient _firebaseAuthClient;
    private readonly IUserService _userService;

    // properties
    [ObservableProperty]
    private string _email = string.Empty;

    [ObservableProperty]
    private string _password = string.Empty;

    [ObservableProperty]
    private string _errorMessage = string.Empty;

    [ObservableProperty]
    private bool _isBusy;

    // constructor
    public LoginViewModel(
        INavigationService navigationService,
        FirebaseAuthClient firebaseAuthClient,
        IUserService userService)
    {
        _navigationService = navigationService;
        _firebaseAuthClient = firebaseAuthClient;
        _userService = userService;
    }


    // navigate to register page using relay command
    [RelayCommand]
    public async Task NavigateToRegisterPage()
    {
        try
        {
            Console.WriteLine("Navigating to Register Page...");
            await _navigationService.NavigateToAsync($"{nameof(RegisterPage)}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Navigation Error: {ex.Message}");
            ErrorMessage = $"Navigation Error: {ex.Message}";
            await Shell.Current.DisplayAlert("Navigation Error", ex.Message, "OK");
        }
    }


    // navigate to main after login
    [RelayCommand]
    public async Task Login()
    {
        if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
        {
            ErrorMessage = "Email and password are required";
            await Shell.Current.DisplayAlert("Validation Error", "Email and password are required", "OK");
            return;
        }

        IsBusy = true;
        ErrorMessage = "Connecting to server...";

        try
        {
            // Small delay to show loading indicator (can be removed in production)
            await Task.Delay(500);

            ErrorMessage = "Verifying credentials...";
            Console.WriteLine($"Attempting login with email: {Email}");

            var auth = await _firebaseAuthClient.SignInWithEmailAndPasswordAsync(Email, Password);

            if (auth != null)
            {
                // Save the user for future sessions
                var appUser = new BudgetPro.Models.User
                {
                    Id = auth.User.Uid,
                    Email = auth.User.Info.Email,
                    Name = auth.User.Info.DisplayName,
                    // Map other properties as needed
                };
                await _userService.SaveUserAsync(appUser);

                ErrorMessage = "Login successful! Redirecting..."; Console.WriteLine("Login successful, navigating to MainPage");

                // Small delay so user can see the success message
                await Task.Delay(500);

                // Navigate to the main page after successful login - using absolute navigation
                await Shell.Current.GoToAsync("//MainPage");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Login Error: {ex.Message}");
            ErrorMessage = $"Login Failed: {ex.Message}";
            await Shell.Current.DisplayAlert("Login Error", ex.Message, "OK");
        }
        finally
        {
            IsBusy = false;
        }
    }
}