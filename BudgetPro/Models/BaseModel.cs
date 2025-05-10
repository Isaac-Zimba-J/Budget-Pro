using System.ComponentModel.DataAnnotations;

namespace BudgetPro.Models;

public class BaseModel
{
    [Key]
    public Guid Id { get; set; }
    public string Name { get; set; }
    public DateTime Created { get; set; } = DateTime.Now;
    public DateTime Updated { get; set; }
    public bool IsDeleted { get; set; }
}