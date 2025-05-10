using BudgetPro.Models;
using BudgetPro.Services.Contracts;

namespace BudgetPro.Services;

public class BudgetService : IBaseService<Budget, string>
{
    public async Task<Budget> GetByIdAsync(string id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Budget>> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<Budget> CreateAsync(Budget entity)
    {
        throw new NotImplementedException();
    }

    public async Task<Budget> UpdateAsync(Budget entity)
    {
        throw new NotImplementedException();
    }

    public async Task DeleteAsync(Budget entity)
    {
        throw new NotImplementedException();
    }
}