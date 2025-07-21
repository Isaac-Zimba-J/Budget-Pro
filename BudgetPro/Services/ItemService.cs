using BudgetPro.Models;
using BudgetPro.Services.Contracts;

namespace BudgetPro.Services;

public class ItemService : IBaseService<BudgetItem, string>
{
    private readonly IFirestoreService _firestoreService;
    private const string BudgetsCollection = "budgets";
    private const string ItemsSubcollection = "items";

    public ItemService(IFirestoreService firestoreService)
    {
        _firestoreService = firestoreService;
    }

    // Interface compliance: throw for base interface methods
    public Task<BudgetItem> GetByIdAsync(string id) => throw new NotImplementedException();
    public Task<List<BudgetItem>> GetAllAsync() => throw new NotImplementedException();
    public Task<BudgetItem> CreateAsync(BudgetItem entity) => throw new NotImplementedException();
    public Task<BudgetItem> UpdateAsync(BudgetItem entity) => throw new NotImplementedException();
    public Task DeleteAsync(BudgetItem entity) => throw new NotImplementedException();

    public async Task<BudgetItem> GetByIdAsync(string budgetId, string itemId)
    {
        return await _firestoreService.GetSubcollectionItemAsync<BudgetItem>(BudgetsCollection, budgetId, ItemsSubcollection, itemId);
    }

    public async Task<List<BudgetItem>> GetAllAsync(string budgetId)
    {
        return await _firestoreService.GetSubcollectionAsync<BudgetItem>(BudgetsCollection, budgetId, ItemsSubcollection);
    }

    public async Task<BudgetItem> CreateAsync(string budgetId, BudgetItem entity)
    {
        await _firestoreService.InsertSubcollectionItemAsync(BudgetsCollection, budgetId, ItemsSubcollection, entity.Id, entity);
        return entity;
    }

    public async Task<BudgetItem> UpdateAsync(string budgetId, BudgetItem entity)
    {
        await _firestoreService.UpdateSubcollectionItemAsync(BudgetsCollection, budgetId, ItemsSubcollection, entity.Id, entity);
        return entity;
    }

    public async Task DeleteAsync(string budgetId, BudgetItem entity)
    {
        await _firestoreService.DeleteSubcollectionItemAsync(BudgetsCollection, budgetId, ItemsSubcollection, entity.Id);
    }
}