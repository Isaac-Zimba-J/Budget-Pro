using System.ComponentModel.DataAnnotations;

namespace BudgetPro.Models;

public class User : BaseModel
{

    [Required]
    [StringLength(100)]
    [EmailAddress]
    public string Email { get; set; }

    [StringLength(255)]
    public string AvatarUrl { get; set; }

    [StringLength(100)]
    public string FirstName { get; set; }

    [StringLength(100)]
    public string LastName { get; set; }

    public DateTime? LastLoginAt { get; set; }

    // Navigation properties
    public virtual ICollection<Budget> Budgets { get; set; } = new List<Budget>();
        
    public virtual ICollection<ChatMessage> SentMessages { get; set; } = new List<ChatMessage>();
}