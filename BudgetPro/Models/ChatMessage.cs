using System.ComponentModel.DataAnnotations;
using Google.Cloud.Firestore;

namespace BudgetPro.Models;

[FirestoreData]
public class ChatMessage : BaseModel
{

    [FirestoreProperty]

    public string Text { get; set; }
    [FirestoreProperty]

    public string UserId { get; set; }

    //optional attachment
    [FirestoreProperty]
    public string AttachmentUrl { get; set; }

}