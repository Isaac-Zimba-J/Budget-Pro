using System.ComponentModel.DataAnnotations;

namespace BudgetPro.Models;

public class ChatMessage :BaseModel
{
    [Required]
    [StringLength(1000)]
    public string Text { get; set; }

    // Foreign key
    [Required]
    public Guid UserId { get; set; }

    // Navigation property
    public User User { get; set; }
    
}