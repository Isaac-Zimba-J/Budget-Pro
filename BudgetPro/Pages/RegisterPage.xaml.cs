using System;

namespace BudgetPro.Pages;

public partial class RegisterPage : ContentPage
{
    public RegisterPage(ViewModels.RegisterViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }

    private void OnRegisterClicked(object sender, EventArgs e)
    {
        // Registration logic will go here
    }

    private async void OnLoginTapped(object sender, EventArgs e)
    {
        // Navigate back to the login page
        await Shell.Current.GoToAsync("///LoginPage");
    }
}