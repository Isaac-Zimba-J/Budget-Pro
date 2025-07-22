using System;
using System.Collections.ObjectModel;
using System.Text;
using BudgetPro.Models;
using BudgetPro.Services;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Newtonsoft.Json;

namespace BudgetPro.ViewModels;

[QueryProperty(nameof(Budget), "Budget")]

public partial class TrackinngPageViewModel : BaseViewModel
{
    private readonly INavigationService _navigationService;
    private readonly IFirestoreService _firestoreService;
    private readonly IUserService _userService;
    private readonly HttpClient _httpClient;
    private readonly ItemService _itemService;

    public TrackinngPageViewModel(INavigationService navigationService, IFirestoreService firestoreService, IUserService userService, ItemService itemService)
    {
        _navigationService = navigationService;
        _firestoreService = firestoreService;
        _userService = userService;
        _itemService = itemService;

        // Create HTTP client with HTTP/1.1
        _httpClient = new HttpClient(new HttpClientHandler
        {
            SslProtocols = System.Security.Authentication.SslProtocols.Tls12
        });
        _httpClient.DefaultRequestVersion = new Version(1, 1);

        Title = "Edit Budget";

        // Initialize BudgetItems collection
        BudgetItems = new ObservableCollection<BudgetItem>();
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
    private ObservableCollection<BudgetItem> _budgetItems;

    [ObservableProperty]
    private double _totalItemsPrice;

    // This method is called when the Budget property is set via navigation
    partial void OnBudgetChanged(Budget value)
    {
        if (value != null)
        {
            Console.WriteLine($"Loading budget for editing: {value.Name}");

            BudgetName = value.Name;
            BudgetAmount = value.TotalAmount;
            BudgetDescription = value.Description ?? string.Empty;

            Title = $"Edit {value.Name}";
            LoadItemsAsync();
            Console.WriteLine($"Loaded {BudgetItems.Count} items for budget");
        }
    }


    // Update this method to calculate total price
    partial void OnBudgetItemsChanged(ObservableCollection<BudgetItem> value)
    {
        CalculateTotalItemsPrice();
    }

    // Add this method to calculate total price
    private void CalculateTotalItemsPrice()
    {
        TotalItemsPrice = BudgetItems?.Sum(item => item.Price * item.Quantity) ?? 0;
    }

    private async void LoadItemsAsync()
    {
        if (Budget == null) return;
        var items = await _itemService.GetAllAsync(Budget.Id);
        BudgetItems = new ObservableCollection<BudgetItem>(items);
        CalculateTotalItemsPrice();
    }

    // Update the DeleteItem method to include confirmation
    [RelayCommand]
    public async Task DeleteItem(BudgetItem item)
    {
        if (item == null || Budget == null) return;

        try
        {
            // Ask for confirmation before deleting
            var result = await Shell.Current.DisplayAlert(
                "Confirm Delete",
                $"Are you sure you want to delete '{item.Name}'?",
                "Yes, Delete",
                "Cancel");

            if (!result) return; // User canceled

            // Remove from UI collection
            BudgetItems.Remove(item);

            // Remove from budget's items list
            if (Budget.BudgetItems != null)
            {
                var budgetItem = Budget.BudgetItems.FirstOrDefault(x => x.Id == item.Id);
                if (budgetItem != null)
                {
                    Budget.BudgetItems.Remove(budgetItem);
                }
            }

            Budget.Updated = DateTime.UtcNow;

            // Update total price calculation
            CalculateTotalItemsPrice();

            Console.WriteLine($"Deleted item: {item.Name}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error deleting item: {ex.Message}");
            await Shell.Current.DisplayAlert("Error", $"Failed to delete item: {ex.Message}", "OK");
        }
    }

    [RelayCommand]
    public async Task IncreaseQuantity(BudgetItem item)
    {
        if (item == null || Budget == null) return;

        item.Quantity++;
        item.Updated = DateTime.UtcNow;
        await _itemService.UpdateAsync(Budget.Id, item);

        // Update the item in the budget's items list as well
        var budgetItem = Budget.BudgetItems?.FirstOrDefault(x => x.Id == item.Id);
        if (budgetItem != null)
        {
            budgetItem.Quantity = item.Quantity;
            budgetItem.Updated = DateTime.UtcNow;
        }

        CalculateTotalItemsPrice();
        Console.WriteLine($"Increased quantity for {item.Name}: {item.Quantity}");
    }

    [RelayCommand]
    public async Task DecreaseQuantity(BudgetItem item)
    {
        if (item == null || item.Quantity <= 0 || Budget == null) return;

        item.Quantity--;
        item.Updated = DateTime.UtcNow;
        await _itemService.UpdateAsync(Budget.Id, item);

        // Update the item in the budget's items list as well
        var budgetItem = Budget.BudgetItems?.FirstOrDefault(x => x.Id == item.Id);
        if (budgetItem != null)
        {
            budgetItem.Quantity = item.Quantity;
            budgetItem.Updated = DateTime.UtcNow;
        }

        CalculateTotalItemsPrice();
        Console.WriteLine($"Decreased quantity for {item.Name}: {item.Quantity}");
    }

    [RelayCommand]
    public async Task UpdateBudget()
    {
        if (string.IsNullOrWhiteSpace(BudgetName) || BudgetAmount <= 0)
        {
            await Shell.Current.DisplayAlert("Error", "Please enter valid budget details", "OK");
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

            // Update the budget object with current values
            Budget.Name = BudgetName;
            Budget.Description = BudgetDescription;
            Budget.TotalAmount = BudgetAmount;
            Budget.Updated = DateTime.UtcNow;

            // Make sure the budget items are up to date by copying from the observable collection
            // This is crucial - make sure we're updating the right collection
            Budget.BudgetItems = new List<BudgetItem>(BudgetItems);

            Console.WriteLine($"Updating budget: {Budget.Id} with {BudgetItems.Count} items");

            // Try normal Firestore service first, then fallback to REST API
            try
            {
                await _firestoreService.UpdateData("budgets", Budget.Id, Budget);
            }
            catch (Exception ex) when (ex.Message.Contains("HTTP/2") || ex.Message.Contains("gRPC"))
            {
                Console.WriteLine($"Falling back to REST API due to: {ex.Message}");
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
        // Use direct REST API call to Firebase as fallback
        string projectId = "budgetpro-33542";
        string authToken = await _userService.GetAuthToken();

        if (string.IsNullOrEmpty(authToken))
        {
            throw new UnauthorizedAccessException("No auth token available");
        }

        Console.WriteLine($"Updating budget via REST API with {budget.BudgetItems?.Count ?? 0} items");

        // Create proper array values for budget items
        var budgetItemsArray = new List<object>();

        if (budget.BudgetItems != null && budget.BudgetItems.Any())
        {
            foreach (var item in budget.BudgetItems)
            {
                Console.WriteLine($"Processing item: {item.Id} - {item.Name}");

                // Add each item as a map value
                budgetItemsArray.Add(new
                {
                    mapValue = new
                    {
                        fields = new
                        {
                            Id = new { stringValue = item.Id },
                            Name = new { stringValue = item.Name },
                            Price = new { doubleValue = item.Price },
                            Quantity = new { integerValue = item.Quantity.ToString() }, // Firebase expects string
                            BudgetId = new { stringValue = item.BudgetId },
                            Created = new { timestampValue = item.Created.ToUniversalTime().ToString("o") },
                            Updated = new { timestampValue = item.Updated.ToUniversalTime().ToString("o") },
                            IsDeleted = new { booleanValue = item.IsDeleted }
                        }
                    }
                });
            }
        }

        // Create direct Firestore document update with budget items array
        var firestoreObject = new
        {
            fields = new
            {
                Id = new { stringValue = budget.Id },
                Name = new { stringValue = budget.Name },
                Description = new { stringValue = budget.Description ?? string.Empty },
                TotalAmount = new { doubleValue = budget.TotalAmount },
                UserId = new { stringValue = budget.UserId },
                Created = new { timestampValue = budget.Created.ToUniversalTime().ToString("o") },
                Updated = new { timestampValue = budget.Updated.ToUniversalTime().ToString("o") },
                IsDeleted = new { booleanValue = budget.IsDeleted },
                BudgetItems = new { arrayValue = new { values = budgetItemsArray } }
            }
        };

        string jsonPayload = JsonConvert.SerializeObject(firestoreObject, Formatting.Indented);
        Console.WriteLine($"Sending payload to Firestore: {jsonPayload}");

        var url = $"https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents/budgets/{budget.Id}";

        var request = new HttpRequestMessage(HttpMethod.Patch, url);
        request.Headers.Add("Authorization", $"Bearer {authToken}");
        request.Content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

        var response = await _httpClient.SendAsync(request);
        var responseContent = await response.Content.ReadAsStringAsync();

        if (!response.IsSuccessStatusCode)
        {
            Console.WriteLine($"Firebase REST API error: {response.StatusCode}, {responseContent}");
            throw new Exception($"Firebase REST API error: {response.StatusCode}, {responseContent}");
        }

        Console.WriteLine($"Budget {budget.Id} successfully updated via REST API with {budgetItemsArray.Count} items!");
    }

    private string GetCurrentUserId()
    {
        return _userService.CurrentUserId ?? string.Empty;
    }


}
