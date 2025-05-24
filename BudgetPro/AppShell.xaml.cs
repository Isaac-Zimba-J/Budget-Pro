using BudgetPro.Pages;

namespace BudgetPro;

public partial class AppShell : Shell
{
	public AppShell()
	{
		InitializeComponent();

		// Register the routes
		Routing.RegisterRoute(nameof(AddBudgetPage), typeof(AddBudgetPage));
		Routing.RegisterRoute(nameof(EditBudgetPage), typeof(EditBudgetPage));
		Routing.RegisterRoute(nameof(AddItemPage), typeof(AddItemPage));
		Routing.RegisterRoute(nameof(MainPage), typeof(MainPage));
		Routing.RegisterRoute(nameof(RegisterPage), typeof(RegisterPage));
		Routing.RegisterRoute(nameof(LoginPage), typeof(LoginPage));
	}

	//
}
