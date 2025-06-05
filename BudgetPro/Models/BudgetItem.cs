using BudgetPro.Models.Enums;
using Google.Cloud.Firestore;
using System;

namespace BudgetPro.Models;

[FirestoreData]
public class BudgetItem : BaseModel
{
    [FirestoreProperty]
    public string Id { get; set; } = string.Empty;

    [FirestoreProperty]
    public string Name { get; set; } = string.Empty;

    [FirestoreProperty]
    public double Price { get; set; }

    [FirestoreProperty]
    public int Quantity { get; set; } = 1;

    [FirestoreProperty]
    public string BudgetId { get; set; } = string.Empty;

    [FirestoreProperty]
    public DateTime Created { get; set; } = DateTime.UtcNow;

    [FirestoreProperty]
    public DateTime Updated { get; set; } = DateTime.UtcNow;

    [FirestoreProperty]
    public bool IsDeleted { get; set; } = false;

    // Calculated properties (not stored in Firestore)
    public string PriceFormatted => $"${Price:F2} × {Quantity} = ${Price * Quantity:F2}";

    public double TotalPrice => Price * Quantity;
}