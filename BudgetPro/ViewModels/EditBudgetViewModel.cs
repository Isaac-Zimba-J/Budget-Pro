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

namespace BudgetPro.ViewModels
{
    [QueryProperty(nameof(Budget), "Budget")]
    public partial class EditBudgetViewModel : BaseViewModel
    {
        private readonly INavigationService _navigationService;
        private readonly IFirestoreService _firestoreService;
        private readonly IUserService _userService;
        private readonly HttpClient _httpClient;

        public EditBudgetViewModel(INavigationService navigationService, IFirestoreService firestoreService, IUserService userService)
        {
            _navigationService = navigationService;
            _firestoreService = firestoreService;
            _userService = userService;

            // Create HTTP client with HTTP/1.1 (same pattern as AddBudgetViewModel)
            _httpClient = new HttpClient(new HttpClientHandler
            {
                SslProtocols = System.Security.Authentication.SslProtocols.Tls12
            });
            _httpClient.DefaultRequestVersion = new Version(1, 1);

            Title = "Edit Budget";
        }

        [ObservableProperty]
        private Budget _budget;

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

        // This method is called when the Budget property is set via navigation
        partial void OnBudgetChanged(Budget value)
        {
            if (value != null)
            {
                Console.WriteLine($"Loading budget for editing: {value.Name}");

                BudgetName = value.Name;
                BudgetAmount = value.TotalAmount;
                BudgetDescription = value.Description ?? string.Empty;
                BudgetStartDate = value.Created;
                BudgetEndDate = value.Updated;

                Title = $"Edit {value.Name}";
            }
        }

        [RelayCommand]
        public async Task UpdateBudget()
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

                // Update the budget object
                Budget.Name = BudgetName;
                Budget.Description = BudgetDescription;
                Budget.TotalAmount = BudgetAmount;
                Budget.Created = BudgetStartDate;
                Budget.Updated = DateTime.UtcNow;

                Console.WriteLine($"Updating budget: {Budget.Id}");

                // Try normal Firestore service first, then fallback to REST API
                try
                {
                    await _firestoreService.UpdateData("budgets", Budget.Id, Budget);
                }
                catch (Exception ex) when (ex.Message.Contains("HTTP/2") || ex.Message.Contains("gRPC"))
                {
                    // Fallback to direct REST API call
                    await UpdateBudgetDirectly(Budget);
                }

                await Shell.Current.DisplayAlert("Success", "Budget updated successfully!", "OK");
                await _navigationService.GoBackAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Budget update error: {ex}");
                await Shell.Current.DisplayAlert("Error", $"Failed to update budget: {ex.Message}", "OK");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        public async Task DeleteBudget()
        {
            var result = await Shell.Current.DisplayAlert(
                "Delete Budget",
                $"Are you sure you want to delete '{BudgetName}'? This action cannot be undone.",
                "Delete",
                "Cancel");

            if (!result) return;

            try
            {
                IsBusy = true;

                Console.WriteLine($"Deleting budget: {Budget.Id}");

                // Mark as deleted instead of actually deleting
                Budget.IsDeleted = true;
                Budget.Updated = DateTime.UtcNow;

                // Try normal Firestore service first, then fallback to REST API
                try
                {
                    await _firestoreService.UpdateData("budgets", Budget.Id, Budget);
                }
                catch (Exception ex) when (ex.Message.Contains("HTTP/2") || ex.Message.Contains("gRPC"))
                {
                    // Fallback to direct REST API call
                    await UpdateBudgetDirectly(Budget);
                }

                await Shell.Current.DisplayAlert("Success", "Budget deleted successfully!", "OK");
                await _navigationService.GoBackAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Budget delete error: {ex}");
                await Shell.Current.DisplayAlert("Error", $"Failed to delete budget: {ex.Message}", "OK");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        public async Task Cancel()
        {
            await _navigationService.GoBackAsync();
        }

        private async Task UpdateBudgetDirectly(Budget budget)
        {
            // Use direct REST API call to Firebase as fallback (same pattern as AddBudgetViewModel)
            string projectId = "budgetpro-33542";
            string authToken = await _userService.GetAuthToken();

            if (string.IsNullOrEmpty(authToken))
            {
                throw new UnauthorizedAccessException("No auth token available");
            }

            // Create direct Firestore document update
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

            var url = $"https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents/budgets/{budget.Id}";

            var request = new HttpRequestMessage(HttpMethod.Patch, url);
            request.Headers.Add("Authorization", $"Bearer {authToken}");
            request.Content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
            {
                string errorContent = await response.Content.ReadAsStringAsync();
                throw new Exception($"Firebase REST API error: {response.StatusCode}, {errorContent}");
            }

            Console.WriteLine($"Budget {budget.Id} successfully updated via REST API!");
        }

        private string GetCurrentUserId()
        {
            return _userService.CurrentUserId ?? string.Empty;
        }
    }
}