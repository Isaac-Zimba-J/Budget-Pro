using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BudgetPro.Models;

public class Budget :BaseModel
{

    public string Description { get; set; }

    [Required]
    public decimal TotalAmount { get; set; }

    [Required]
    public Guid UserId { get; set; }
        
    public User User { get; set; }
    

    // Navigation property
    public virtual ICollection<BudgetItem> Items { get; set; } = new List<BudgetItem>();

    [NotMapped]
    public decimal SpentAmount => Items.Sum(i => i.Amount);

    [NotMapped]
    public decimal RemainingAmount => TotalAmount - SpentAmount;

    [NotMapped]
    public decimal SpentPercentage => TotalAmount > 0 ? Math.Round((SpentAmount / TotalAmount) * 100, 2) : 0;
}