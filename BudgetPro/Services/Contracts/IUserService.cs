using System;
using BudgetPro.Models;

namespace BudgetPro.Services.Contracts;

public interface IUserService
{
    string? CurrentUserId { get; }
    User? CurrentUser { get; }
    bool IsAuthenticated { get; }

    Task<bool> LoadSavedUserAsync();
    Task SaveUserAsync(User user);
    Task ClearUserAsync();
    Task<bool> RefreshUserTokenAsync();
    Task<string> GetAuthToken();
}
