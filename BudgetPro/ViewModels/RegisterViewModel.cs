using BudgetPro.Pages;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Firebase.Auth;

namespace BudgetPro.ViewModels;

public partial class RegisterViewModel : BaseViewModel
{
    private readonly INavigationService _navigationService;
    private FirebaseAuthClient _firebaseAuthClient;

    // properties
    [ObservableProperty]
    private string _email = string.Empty;

    [ObservableProperty]
    private string _password = string.Empty;

    [ObservableProperty]
    private string _username = string.Empty;

    [ObservableProperty]
    private string _errorMessage = string.Empty;


    // constructor
    public RegisterViewModel(INavigationService navigationService, FirebaseAuthClient firebaseAuthClient)
    {
        _navigationService = navigationService;
        _firebaseAuthClient = firebaseAuthClient;

    }


    // navigate to register page using relay command
    [RelayCommand]
    public async Task NavigateToLogin()
    {
        await _navigationService.NavigateToAsync($"{nameof(LoginPage)}");
    }


    // navigate to main after login

    [RelayCommand]
    public async Task Register()
    {
        if (string.IsNullOrWhiteSpace(Username))
        {
            ErrorMessage = "Please enter your full name";
            await Shell.Current.DisplayAlert("Validation Error", "Please enter your full name", "OK");
            return;
        }

        if (string.IsNullOrWhiteSpace(Email))
        {
            ErrorMessage = "Please enter your email";
            await Shell.Current.DisplayAlert("Validation Error", "Please enter your email", "OK");
            return;
        }

        if (string.IsNullOrWhiteSpace(Password))
        {
            ErrorMessage = "Please enter a password";
            await Shell.Current.DisplayAlert("Validation Error", "Please enter a password", "OK");
            return;
        }

        IsBusy = true;
        ErrorMessage = "Creating your account...";

        try
        {
            // Small delay to show loading indicator (can be removed in production)
            await Task.Delay(500);

            ErrorMessage = "Registering with server...";
            Console.WriteLine($"Attempting to register user: {Email}");

            var auth = await _firebaseAuthClient.CreateUserWithEmailAndPasswordAsync(Email, Password, Username);
            if (auth != null)
            {
                ErrorMessage = "Registration successful! Redirecting...";
                Console.WriteLine("Registration successful, navigating to MainPage");

                // Small delay so user can see the success message
                await Task.Delay(500);

                // Navigate to the main page after successful registration - using absolute navigation
                await Shell.Current.GoToAsync("//MainPage");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Registration Error: {ex.Message}");
            ErrorMessage = $"Registration Failed: {ex.Message}";
            await Shell.Current.DisplayAlert("Registration Error", ex.Message, "OK");
        }
        finally
        {
            IsBusy = false;
        }
    }

}