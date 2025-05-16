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
    private string _email;

    [ObservableProperty]
    private string _password;
    [ObservableProperty]
    private string _username;

    [ObservableProperty]
    private string _errorMessage;


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


        try
        {
            var auth = await _firebaseAuthClient.CreateUserWithEmailAndPasswordAsync(Email, Password, Username);
            if (auth != null)
            {
                // Navigate to the main page after successful login
                await _navigationService.NavigateToAsync($"{nameof(MainPage)}");
            }
        }
        catch (Exception ex)
        {
            ErrorMessage = ex.Message;
        }
    }

}