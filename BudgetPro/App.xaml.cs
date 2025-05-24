using BudgetPro.Services.Contracts;
using Microsoft.Maui.Controls;

namespace BudgetPro;

public partial class App : Application
{
	private readonly IUserService _userService;

	public App(IUserService userService)
	{
		InitializeComponent();

		_userService = userService;

		MainPage = new AppShell();
	}

	protected override async void OnStart()
	{
		base.OnStart();

		// Try to load saved user credentials on app start
		bool isLoggedIn = await _userService.LoadSavedUserAsync();

		// Navigate to MainPage if already logged in
		if (isLoggedIn)
		{
			await Shell.Current.GoToAsync("//MainPage");
		}
	}
}