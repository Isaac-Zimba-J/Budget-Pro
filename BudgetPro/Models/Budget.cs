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

    // Returns the percentage of items with quantity zero (done)
    public double Progress
    {
        get
        {
            if (BudgetItems == null || BudgetItems.Count == 0)
                return 1.0;
            int done = BudgetItems.Count(i => i.Quantity == 0);
            return (double)done / BudgetItems.Count;
        }
    }
}