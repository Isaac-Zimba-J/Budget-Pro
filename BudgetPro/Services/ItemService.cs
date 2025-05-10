using BudgetPro.Models;
using BudgetPro.Services.Contracts;

namespace BudgetPro.Services;

public class ItemService : IBaseService<BudgetItem, string>
{
    public async Task<BudgetItem> GetByIdAsync(string id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<BudgetItem>> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<BudgetItem> CreateAsync(BudgetItem entity)
    {
        throw new NotImplementedException();
    }

    public async Task<BudgetItem> UpdateAsync(BudgetItem entity)
    {
        throw new NotImplementedException();
    }

    public async Task DeleteAsync(BudgetItem entity)
    {
        throw new NotImplementedException();
    }
}