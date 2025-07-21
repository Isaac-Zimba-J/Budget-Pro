using System.ComponentModel.DataAnnotations;
using Google.Cloud.Firestore;

namespace BudgetPro.Models;

[FirestoreData]
public abstract class BaseModel
{
    [FirestoreProperty]
    public string Id { get; set; } = string.Empty;
    [FirestoreProperty]
    public string Name { get; set; } = string.Empty;
    [FirestoreProperty]
    public DateTime Created { get; set; } = DateTime.UtcNow;
    [FirestoreProperty]
    public DateTime Updated { get; set; } = DateTime.UtcNow;
    [FirestoreProperty]
    public bool IsDeleted { get; set; } = false;
}