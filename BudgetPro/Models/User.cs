using System.ComponentModel.DataAnnotations;
using Google.Cloud.Firestore;

namespace BudgetPro.Models;

[FirestoreData]
public class User : BaseModel
{
    [FirestoreProperty]
    public string Email { get; set; }
    [FirestoreProperty]
    public List<string> BudgetIds { get; set; } = new List<string>(); // References to budgets
}