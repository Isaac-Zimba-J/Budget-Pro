using BudgetPro.Helpers;
using BudgetPro.Pages;
using BudgetPro.Services;
using BudgetPro.Services.Contracts;
using BudgetPro.ViewModels;
using CommunityToolkit.Maui;
using Firebase.Auth;
using Firebase.Auth.Providers;
using Google.Cloud.Firestore;
using Microsoft.Extensions.Logging;

namespace BudgetPro;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
			.UseMauiCommunityToolkit()
			.ConfigureFonts(fonts =>
			{
				fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
				fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
			});

#if DEBUG
		builder.Logging.AddDebug();
#endif

		// Register FirestoreDb first
		builder.Services.AddSingleton(serviceProvider => FirebaseHelper.GetFirestoreDb());

		// Register services
		builder.Services.AddSingleton<INavigationService, NavigationService>();
		builder.Services.AddSingleton<IFirestoreService, FirestoreService>();
		builder.Services.AddSingleton<IUserService, UserService>();
		builder.Services.AddSingleton<IConnectivityService, ConnectivityService>();
		builder.Services.AddSingleton<ItemService>();

		// Register Firebase Authentication
		builder.Services.AddSingleton(new FirebaseAuthClient(new FirebaseAuthConfig()
		{
			ApiKey = "AIzaSyDhbSGVvSknhNwUhgU0un80mKWlsZAqH5I",
			AuthDomain = "budgetpro-33542.firebaseapp.com",
			Providers = new FirebaseAuthProvider[]
			{ new EmailProvider() }
		}));

		// Register pages
		builder.Services.AddTransient<MainPage>();
		builder.Services.AddTransient<BudgetsPage>();
		builder.Services.AddTransient<AddBudgetPage>();
		builder.Services.AddTransient<LoginPage>();
		builder.Services.AddTransient<RegisterPage>();
		builder.Services.AddTransient<EditBudgetPage>();
		builder.Services.AddTransient<TrackingPage>();


		// Register view models
		builder.Services.AddTransient<MainPageViewModel>();
		builder.Services.AddTransient<BudgetViewModel>();
		builder.Services.AddTransient<AddBudgetViewModel>();
		builder.Services.AddTransient<LoginViewModel>();
		builder.Services.AddTransient<RegisterViewModel>();
		builder.Services.AddTransient<EditBudgetViewModel>();
		builder.Services.AddTransient<TrackinngPageViewModel>();

		return builder.Build();
	}
}
