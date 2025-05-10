namespace BudgetPro.Services.Contracts;

public interface IBaseService<T, key>
{
    Task<T> GetByIdAsync(key id);
    Task<List<T>> GetAllAsync();
    Task<T> CreateAsync(T entity);
    Task<T> UpdateAsync(T entity);
    Task DeleteAsync(T entity);
    
}