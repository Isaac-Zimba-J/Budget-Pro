using BudgetPro.Pages;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Firebase.Auth;

namespace BudgetPro.ViewModels;

public partial class LoginViewModel : BaseViewModel
{
    private readonly INavigationService _navigationService;
    private FirebaseAuthClient _firebaseAuthClient;

    // properties
    [ObservableProperty]
    private string _email;

    [ObservableProperty]
    private string _password;

    [ObservableProperty]
    private string _errorMessage;


    // constructor
    public LoginViewModel(INavigationService navigationService, FirebaseAuthClient firebaseAuthClient)
    {
        _navigationService = navigationService;
        _firebaseAuthClient = firebaseAuthClient;

    }


    // navigate to register page using relay command
    [RelayCommand]
    public async Task NavigateToRegisterPage()
    {
        await _navigationService.NavigateToAsync($"{nameof(RegisterPage)}");
    }


    // navigate to main after login

    [RelayCommand]
    public async Task Login()
    {


        try
        {
            var auth = await _firebaseAuthClient.SignInWithEmailAndPasswordAsync(Email, Password);
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