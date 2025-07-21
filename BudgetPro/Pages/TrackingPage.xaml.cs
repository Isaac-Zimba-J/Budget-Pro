using BudgetPro.ViewModels;

namespace BudgetPro.Pages;

public partial class TrackingPage : ContentPage
{
	public TrackingPage(TrackinngPageViewModel viewModel)
	{
		InitializeComponent();
		BindingContext = viewModel;
	}


}