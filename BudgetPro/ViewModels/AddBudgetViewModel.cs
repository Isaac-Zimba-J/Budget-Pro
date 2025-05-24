using BudgetPro.Models;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Maui.Controls;
using System.Net.Http;
using Newtonsoft.Json;
using System.Text;

namespace BudgetPro.ViewModels;

public partial class AddBudgetViewModel : BaseViewModel
{
    private readonly INavigationService _navigationService;
    private readonly IFirestoreService _firestoreService;
    private readonly IUserService _userService;
    private readonly HttpClient _httpClient;

    public AddBudgetViewModel(INavigationService navigationService, IFirestoreService firestoreService, IUserService userService)
    {
        _navigationService = navigationService;
        _firestoreService = firestoreService;
        _userService = userService;

        // Create HTTP client with HTTP/1.1 
        _httpClient = new HttpClient(new HttpClientHandler
        {
            // Force TLS 1.2
            SslProtocols = System.Security.Authentication.SslProtocols.Tls12
        });
        _httpClient.DefaultRequestVersion = new Version(1, 1); // Force HTTP/1.1

        // Set default title
        Title = "Add New Budget";
    }

    [ObservableProperty]
    private string _budgetName = string.Empty;

    [ObservableProperty]
    private double _budgetAmount;

    [ObservableProperty]
    private string _budgetDescription = string.Empty;

    [ObservableProperty]
    private DateTime _budgetStartDate = DateTime.UtcNow;

    [ObservableProperty]
    private DateTime _budgetEndDate = DateTime.UtcNow.AddMonths(1);

    [RelayCommand]
    public async Task SaveBudget()
    {
        if (string.IsNullOrWhiteSpace(BudgetName) || BudgetAmount <= 0)
        {
            await Shell.Current.DisplayAlert("Error", "Please enter valid budget details", "OK");
            return;
        }

        if (BudgetEndDate <= BudgetStartDate)
        {
            await Shell.Current.DisplayAlert("Error", "End date must be after start date", "OK");
            return;
        }

        try
        {
            IsBusy = true;

            var userId = GetCurrentUserId();
            if (string.IsNullOrEmpty(userId))
            {
                await Shell.Current.DisplayAlert("Error", "User not logged in", "OK");
                return;
            }

            // Create budget with proper UTC DateTimes
            var newBudget = new Budget
            {
                Id = Guid.NewGuid().ToString(),
                Name = BudgetName,
                Description = BudgetDescription,
                TotalAmount = BudgetAmount,
                UserId = userId,
                // Explicitly set DateTimeKind to UTC

                Created = DateTime.UtcNow,
                Updated = DateTime.UtcNow,
                IsDeleted = false,
                BudgetItems = new List<BudgetItem>()
            };

            // Try REST API approach instead of gRPC if normal approach fails
            try
            {
                await _firestoreService.InsertData("budgets", newBudget.Id, newBudget);
            }
            catch (Exception ex) when (ex.Message.Contains("HTTP/2") || ex.Message.Contains("gRPC"))
            {
                // Fallback to direct REST API call
                await SaveBudgetDirectly(newBudget);
            }

            await Shell.Current.DisplayAlert("Success", "Budget added successfully!", "OK");
            await _navigationService.GoBackAsync();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Budget save error: {ex}"); // Log the full exception
            await Shell.Current.DisplayAlert("Error", $"Failed to save budget: {ex.Message}", "OK");
        }
        finally
        {
            IsBusy = false;
        }
    }

    private async Task SaveBudgetDirectly(Budget budget)
    {
        // Use direct REST API call to Firebase as fallback
        string projectId = "budgetpro-33542"; // Your Firebase project ID
        string apiKey = "AIzaSyDhbSGVvSknhNwUhgU0un80mKWlsZAqH5I"; // Your Firebase API key

        // Get Firebase auth token for authentication
        string authToken = await _userService.GetAuthToken();

        // Create direct Firestore document
        var firestoreObject = new
        {
            fields = new
            {
                Id = new { stringValue = budget.Id },
                Name = new { stringValue = budget.Name },
                Description = new { stringValue = budget.Description },
                TotalAmount = new { doubleValue = budget.TotalAmount },
                UserId = new { stringValue = budget.UserId },

                Created = new { timestampValue = budget.Created.ToUniversalTime().ToString("o") },
                Updated = new { timestampValue = budget.Updated.ToUniversalTime().ToString("o") },
                IsDeleted = new { booleanValue = budget.IsDeleted }
            }
        };

        string jsonPayload = JsonConvert.SerializeObject(firestoreObject);

        var url = $"https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents/budgets?documentId={budget.Id}";

        var request = new HttpRequestMessage(HttpMethod.Post, url);
        request.Headers.Add("Authorization", $"Bearer {authToken}");
        request.Content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

        var response = await _httpClient.SendAsync(request);

        if (!response.IsSuccessStatusCode)
        {
            string errorContent = await response.Content.ReadAsStringAsync();
            throw new Exception($"Firebase REST API error: {response.StatusCode}, {errorContent}");
        }
    }

    private string GetCurrentUserId()
    {
        return _userService.CurrentUserId ?? string.Empty;
    }
}