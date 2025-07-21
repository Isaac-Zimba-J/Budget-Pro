using System;

namespace BudgetPro.Services.Contracts;

public interface IFirestoreService
{
    Task<T> GetByIdAsync<T>(string collectionPath, string documentId);
    Task<List<T>> GetAllAsync<T>(string collectionPath);
    Task InsertData<T>(string collectionPath, string documentId, T data);
    Task UpdateData<T>(string collectionPath, string documentId, T data);
    Task DeleteData(string collectionPath, string documentId);

    // Subcollection support
    Task<List<T>> GetSubcollectionAsync<T>(string parentCollection, string parentId, string subcollection);
    Task<T> GetSubcollectionItemAsync<T>(string parentCollection, string parentId, string subcollection, string itemId);
    Task InsertSubcollectionItemAsync<T>(string parentCollection, string parentId, string subcollection, string itemId, T data);
    Task UpdateSubcollectionItemAsync<T>(string parentCollection, string parentId, string subcollection, string itemId, T data);
    Task DeleteSubcollectionItemAsync(string parentCollection, string parentId, string subcollection, string itemId);
}
