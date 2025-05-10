using BudgetPro.Models.Enums;

namespace BudgetPro.Models;

public class BudgetItem : BaseModel
{
    public int Quantity { get; set; }
    public decimal Amount { get; set; }
    public Category Category { get; set; }
    
    // Budget Navigation
    public string BudgetId { get; set; }
    public Budget Budget { get; set; }
}