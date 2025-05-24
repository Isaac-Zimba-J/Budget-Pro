using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Google.Cloud.Firestore;

namespace BudgetPro.Models;

[FirestoreData]
public class Budget : BaseModel
{

    [FirestoreProperty]
    public string Description { get; set; }
    [FirestoreProperty]

    public double TotalAmount { get; set; }
    [FirestoreProperty]

    public string UserId { get; set; } // Reference to a user
    [FirestoreProperty]
    public List<BudgetItem> BudgetItems { get; set; } = new List<BudgetItem>(); // References to budget items
}