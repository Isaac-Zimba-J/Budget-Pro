using System;
using Microsoft.Maui.Controls;
using BudgetPro.Pages;

namespace BudgetPro
{
	public partial class AppShell : Shell
	{
		public AppShell()
		{
			InitializeComponent();

			// Register global exception handler
			AppDomain.CurrentDomain.UnhandledException += CurrentDomainOnUnhandledException;
			TaskScheduler.UnobservedTaskException += TaskSchedulerOnUnobservedTaskException;

			// Register the routes
			Routing.RegisterRoute(nameof(AddBudgetPage), typeof(AddBudgetPage));
			Routing.RegisterRoute(nameof(EditBudgetPage), typeof(EditBudgetPage));
			Routing.RegisterRoute(nameof(AddItemPage), typeof(AddItemPage));
			Routing.RegisterRoute(nameof(MainPage), typeof(MainPage));
			Routing.RegisterRoute(nameof(RegisterPage), typeof(RegisterPage));
			Routing.RegisterRoute(nameof(LoginPage), typeof(LoginPage));
			Routing.RegisterRoute(nameof(TrackingPage), typeof(TrackingPage));
		}

		private void CurrentDomainOnUnhandledException(object sender, UnhandledExceptionEventArgs e)
		{
			var exception = e.ExceptionObject as Exception;
			LogException(exception, "AppDomain Unhandled Exception");
		}

		private void TaskSchedulerOnUnobservedTaskException(object sender, UnobservedTaskExceptionEventArgs e)
		{
			LogException(e.Exception, "TaskScheduler Unobserved Exception");
			e.SetObserved(); // Mark as observed to prevent app crash
		}

		private void LogException(Exception ex, string source)
		{
			if (ex == null) return;

			Console.WriteLine($"===== {source} =====");
			Console.WriteLine($"Message: {ex.Message}");
			Console.WriteLine($"Stack Trace: {ex.StackTrace}");

			// In a production app, you would log this to a file or remote logging service
		}

		// Add this event handler for the logout menu item
		private async void OnLogoutClicked(object sender, EventArgs e)
		{
			bool confirm = await Shell.Current.DisplayAlert(
				"Log Out",
				"Are you sure you want to log out?",
				"Yes", "No");

			if (confirm)
			{
				// Try to resolve the IUserService and INavigationService from DI
				var userService = this.Handler?.MauiContext?.Services.GetService(typeof(BudgetPro.Services.Contracts.IUserService)) as BudgetPro.Services.Contracts.IUserService;
				var navigationService = this.Handler?.MauiContext?.Services.GetService(typeof(BudgetPro.Services.Contracts.INavigationService)) as BudgetPro.Services.Contracts.INavigationService;

				if (userService != null && navigationService != null)
				{
					await userService.ClearUserAsync();
					await navigationService.NavigateToAsync("LoginPage");
				}
				else
				{
					// Fallback: just go to login page
					await Shell.Current.GoToAsync("///LoginPage");
				}
			}
		}
	}
}
