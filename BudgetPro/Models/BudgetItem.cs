using BudgetPro.Models.Enums;
using Google.Cloud.Firestore;
using System;
using CommunityToolkit.Mvvm.ComponentModel;

namespace BudgetPro.Models;

[FirestoreData]
public class BudgetItem : ObservableObject
{
    private string id = string.Empty;
    private string name = string.Empty;
    private double price;
    private int quantity = 1;
    private string budgetId = string.Empty;
    private DateTime created = DateTime.UtcNow;
    private DateTime updated = DateTime.UtcNow;
    private bool isDeleted = false;

    [FirestoreProperty]
    public string Id
    {
        get => id;
        set => SetProperty(ref id, value);
    }

    [FirestoreProperty]
    public string Name
    {
        get => name;
        set => SetProperty(ref name, value);
    }

    [FirestoreProperty]
    public double Price
    {
        get => price;
        set => SetProperty(ref price, value);
    }

    [FirestoreProperty]
    public int Quantity
    {
        get => quantity;
        set => SetProperty(ref quantity, value);
    }

    [FirestoreProperty]
    public string BudgetId
    {
        get => budgetId;
        set => SetProperty(ref budgetId, value);
    }

    [FirestoreProperty]
    public DateTime Created
    {
        get => created;
        set => SetProperty(ref created, value);
    }

    [FirestoreProperty]
    public DateTime Updated
    {
        get => updated;
        set => SetProperty(ref updated, value);
    }

    [FirestoreProperty]
    public bool IsDeleted
    {
        get => isDeleted;
        set => SetProperty(ref isDeleted, value);
    }

    // Calculated properties (not stored in Firestore)
    public string PriceFormatted => $"K{Price:F2} × {Quantity} = K{Price * Quantity:F2}";
    public double TotalPrice => Price * Quantity;
}