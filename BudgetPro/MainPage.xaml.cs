using BudgetPro.ViewModels;

namespace BudgetPro;

public partial class MainPage : ContentPage
{
	private readonly MainPageViewModel _viewModel;

	public MainPage(MainPageViewModel viewModel)
	{
		InitializeComponent();
		_viewModel = viewModel;
		BindingContext = viewModel;
		Console.WriteLine("MainPage: Constructor called, BindingContext set");
	}

	protected override async void OnAppearing()
	{
		base.OnAppearing();
		Console.WriteLine("MainPage: OnAppearing called");
		await _viewModel.LoadBudgetsAsync();
	}
}

