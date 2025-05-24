using System.ComponentModel.DataAnnotations;
using Google.Cloud.Firestore;

namespace BudgetPro.Models;

[FirestoreData]
public class BaseModel
{
    [FirestoreProperty]
    public string Id { get; set; }
    [FirestoreProperty]
    public string Name { get; set; }
    [FirestoreProperty]
    public DateTime Created { get; set; } = DateTime.Now;
    [FirestoreProperty]
    public DateTime Updated { get; set; }
    [FirestoreProperty]
    public bool IsDeleted { get; set; }
}