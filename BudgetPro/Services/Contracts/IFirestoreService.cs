using System;

namespace BudgetPro.Services.Contracts;

public interface IFirestoreService
{
    Task<T> GetByIdAsync<T>(string collectionPath, string documentId);
    Task<List<T>> GetAllAsync<T>(string collectionPath);
    Task InsertData<T>(string collectionPath, string documentId, T data);
    Task UpdateData<T>(string collectionPath, string documentId, T data);
    Task DeleteData(string collectionPath, string documentId);

}
