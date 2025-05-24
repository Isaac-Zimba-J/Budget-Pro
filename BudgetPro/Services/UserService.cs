using BudgetPro.Models;
using BudgetPro.Services.Contracts;
using Firebase.Auth;

namespace BudgetPro.Services;

public class UserService : IUserService
{
    private readonly FirebaseAuthClient _firebaseAuthClient;
    public string? CurrentUserId => _firebaseAuthClient?.User?.Uid;

    public Models.User? CurrentUser => _firebaseAuthClient?.User != null
        ? new Models.User
        {
            Id = _firebaseAuthClient.User.Uid,
            Email = _firebaseAuthClient.User.Info.Email ?? string.Empty
        }
        : null;


    // Implement the IsAuthenticated property to check if user is logged in
    public bool IsAuthenticated => _firebaseAuthClient?.User != null;

    public UserService(FirebaseAuthClient firebaseAuthClient)
    {
        _firebaseAuthClient = firebaseAuthClient;

        // Subscribe to authentication state changes
        _firebaseAuthClient.AuthStateChanged += OnAuthStateChanged;
    }

    private void OnAuthStateChanged(object? sender, UserEventArgs args)
    {
        // Handle authentication state changes
        if (args.User != null)
        {
            Console.WriteLine($"User authenticated: {args.User.Info.Email}");
            // You could trigger an event here that other services can listen to
        }
        else
        {
            Console.WriteLine("User signed out");
        }
    }

    public Task ClearUserAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<bool> LoadSavedUserAsync()
    {
        try
        {
            var email = await SecureStorage.GetAsync("user_email");
            var password = await SecureStorage.GetAsync("user_password");

            if (!string.IsNullOrEmpty(email) && !string.IsNullOrEmpty(password))
            {
                await _firebaseAuthClient.SignInWithEmailAndPasswordAsync(email, password);
                return true;
            }

            return false;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error loading saved user: {ex.Message}");
            return false;
        }
    }

    public async Task SaveUserAsync(Models.User user)
    {
        try
        {
            // Note: Storing password in secure storage is generally not recommended
            // Consider using a refresh token or other authentication method instead
            // This is a simplified example for demonstration purposes

            // Store minimal user info in secure storage
            await SecureStorage.SetAsync("user_id", user.Id);
            await SecureStorage.SetAsync("user_email", user.Email);

            // You could store a JWT token instead of password
            // Or use the Firebase token
            var firebaseUser = _firebaseAuthClient.User;
            if (firebaseUser != null)
            {
                var token = await firebaseUser.GetIdTokenAsync();
                await SecureStorage.SetAsync("user_token", token);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error saving user: {ex.Message}");
        }
    }

    public async Task<bool> RefreshUserTokenAsync()
    {
        try
        {
            if (_firebaseAuthClient.User == null) return false;

            // Force token refresh
            await _firebaseAuthClient.User.GetIdTokenAsync(true);
            return true;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error refreshing token: {ex.Message}");
            return false;
        }
    }

    // Add this implementation to your UserService class
    public async Task<string> GetAuthToken()
    {
        if (_firebaseAuthClient.User == null)
            return string.Empty;

        try
        {
            return await _firebaseAuthClient.User.GetIdTokenAsync();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error getting auth token: {ex.Message}");
            return string.Empty;
        }
    }
}