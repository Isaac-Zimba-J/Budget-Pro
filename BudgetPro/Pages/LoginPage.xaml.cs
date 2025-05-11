using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BudgetPro.ViewModels;

namespace BudgetPro.Pages;

public partial class LoginPage : ContentPage
{
    public LoginPage(LoginViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }
    private async void OnLoginClicked(object sender, EventArgs e)
    {
        string email = emailEntry.Text;
        string password = passwordEntry.Text;

        // Simple validation (replace with real auth)
        if (email == "admin@admin.com" && password == "1234")
        {
            // Navigate to main app
            Application.Current.MainPage = new AppShell();
        }
        else
        {
            await DisplayAlert("Login Failed", "Invalid email or password.", "OK");
        }
    }
}