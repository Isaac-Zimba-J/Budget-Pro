using System;
using BudgetPro.ViewModels;

namespace BudgetPro.Pages;

public partial class LoginPage : ContentPage
{
    public LoginPage(LoginViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }


    private void OnLoginClicked(object sender, EventArgs e)
    {
        // Login logic will go here
    }

    private void OnRegisterTapped(object sender, EventArgs e)
    {
        // Navigation logic will go here
    }
}