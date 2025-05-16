using BudgetPro.Pages;
using BudgetPro.Services;
using BudgetPro.Services.Contracts;
using BudgetPro.ViewModels;
using CommunityToolkit.Maui;
using DotNet.Meteor.HotReload.Plugin;
using Firebase.Auth;
using Firebase.Auth.Providers;
using Microsoft.Extensions.Logging;
using Zimba.Maui;

namespace BudgetPro;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
			.UseMauiCommunityToolkit()


#if DEBUG
			.EnableHotReload()
#endif
			.ConfigureFonts(fonts =>
			{
				fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
				fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
			});

#if DEBUG
		builder.Logging.AddDebug();
#endif

		// Register the services
		builder.Services.AddSingleton<INavigationService, NavigationService>();
		builder.Services.AddSingleton(new FirebaseAuthClient(new FirebaseAuthConfig()
		{
			ApiKey = "AIzaSyDhbSGVvSknhNwUhgU0un80mKWlsZAqH5I",
			AuthDomain = "budgetpro-33542.firebaseapp.com",
			Providers = new FirebaseAuthProvider[]
			{ new EmailProvider()}
		}));

		// Register the pages 
		builder.Services.AddTransient<MainPage>();
		builder.Services.AddTransient<BudgetsPage>();
		builder.Services.AddTransient<ChatPage>();
		builder.Services.AddTransient<SettingsPage>();
		builder.Services.AddTransient<AddBudgetPage>();
		builder.Services.AddTransient<EditBudgetPage>();
		builder.Services.AddSingleton<AddItemPage>();
		builder.Services.AddTransient<LoginPage>();
		builder.Services.AddTransient<RegisterPage>();


		// register the view models
		builder.Services.AddTransient<MainPageViewModel>();
		builder.Services.AddTransient<BudgetViewModel>();
		builder.Services.AddTransient<ChatPageViewModel>();
		builder.Services.AddTransient<AddBudgetViewModel>();
		builder.Services.AddTransient<EditBudgetViewModel>();
		builder.Services.AddTransient<LoginViewModel>();
		builder.Services.AddTransient<RegisterViewModel>();
		builder.Services.AddTransient<SettingsViewModel>();


		return builder.Build();
	}
}
