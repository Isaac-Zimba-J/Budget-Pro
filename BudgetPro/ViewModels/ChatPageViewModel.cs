using BudgetPro.Models;
using BudgetPro.Services.Contracts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Google.Cloud.Firestore;
using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System;

namespace BudgetPro.ViewModels;

public partial class ChatPageViewModel : ObservableObject
{
    private readonly IFirestoreService _firestoreService;
    private readonly IUserService _userService;
    private Google.Cloud.Firestore.FirestoreChangeListener _listener;
    private FirestoreDb _db;

    [ObservableProperty]
    private string messageText;

    [ObservableProperty]
    private ObservableCollection<ChatMessage> messages = new();

    public ChatPageViewModel(IFirestoreService firestoreService, IUserService userService)
    {
        _firestoreService = firestoreService;
        _userService = userService;
        _db = (firestoreService as BudgetPro.Services.FirestoreService)?.GetDbInstance();
        ListenForMessages();
    }

    private void ListenForMessages()
    {
        _listener = _db.Collection("messages")
            .OrderBy("Created")
            .Listen(snapshot =>
            {
                App.Current?.Dispatcher.Dispatch(() =>
                {
                    Messages.Clear();
                    foreach (var doc in snapshot.Documents)
                    {
                        var msg = doc.ConvertTo<ChatMessage>();
                        Messages.Add(msg);
                    }
                });
            });
    }

    [RelayCommand]
    public async Task SendMessage()
    {
        if (string.IsNullOrWhiteSpace(MessageText)) return;
        var user = _userService.CurrentUser;
        var msg = new ChatMessage
        {
            Text = MessageText,
            UserId = _userService.CurrentUserId,
            UserName = user?.Email ?? _userService.CurrentUserId,
            Created = DateTime.UtcNow
        };
        await _firestoreService.InsertData("messages", Guid.NewGuid().ToString(), msg);
        MessageText = string.Empty;
    }
}