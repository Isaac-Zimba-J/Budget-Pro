using BudgetPro.Models.Enums;
using Google.Cloud.Firestore;

namespace BudgetPro.Models;

[FirestoreData]
public class BudgetItem : BaseModel
{

    [FirestoreProperty]
    public string BudgetId { get; set; } // Reference to budget
    [FirestoreProperty]

    public int Quantity { get; set; }
    [FirestoreProperty]

    public decimal Amount { get; set; }
    [FirestoreProperty]

    public string Category { get; set; } // Store enum as string
    [FirestoreProperty]

    public bool IsPurchase { get; set; } // Indicates if this item is a purchase or income
}