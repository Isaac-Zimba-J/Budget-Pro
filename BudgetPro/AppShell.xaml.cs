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
	}

	//
}
