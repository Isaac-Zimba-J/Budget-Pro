using BudgetPro.Services.Contracts;
using Google.Cloud.Firestore;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BudgetPro.Services
{
    public class FirestoreService : IFirestoreService
    {
        private readonly FirestoreDb _firestoreDB;

        public FirestoreService(FirestoreDb firestoreDB)
        {
            _firestoreDB = firestoreDB;
        }

        public async Task<T> GetByIdAsync<T>(string collectionPath, string documentId)
        {
            try
            {
                DocumentReference docRef = _firestoreDB.Collection(collectionPath).Document(documentId);
                DocumentSnapshot snapshot = await docRef.GetSnapshotAsync();

                if (snapshot.Exists)
                {
                    return snapshot.ConvertTo<T>();
                }

                return default;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error getting document: {ex.Message}");
                throw;
            }
        }

        public async Task<List<T>> GetAllAsync<T>(string collectionPath)
        {
            try
            {
                CollectionReference collectionRef = _firestoreDB.Collection(collectionPath);
                QuerySnapshot querySnapshot = await collectionRef.GetSnapshotAsync();

                List<T> items = new List<T>();
                foreach (DocumentSnapshot documentSnapshot in querySnapshot.Documents)
                {
                    if (documentSnapshot.Exists)
                    {
                        items.Add(documentSnapshot.ConvertTo<T>());
                    }
                }

                return items;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error getting collection: {ex.Message}");
                throw;
            }
        }

        public async Task InsertData<T>(string collectionPath, string documentId, T data)
        {
            try
            {
                DocumentReference docRef = _firestoreDB.Collection(collectionPath).Document(documentId);
                await docRef.SetAsync(data);
                Console.WriteLine($"Document {documentId} successfully written!");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error inserting data: {ex.Message}");
                throw;
            }
        }

        public async Task UpdateData<T>(string collectionPath, string documentId, T data)
        {
            try
            {
                DocumentReference docRef = _firestoreDB.Collection(collectionPath).Document(documentId);
                await docRef.SetAsync(data, SetOptions.MergeAll);
                Console.WriteLine($"Document {documentId} successfully updated!");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error updating document: {ex.Message}");
                throw;
            }
        }

        public async Task DeleteData(string collectionPath, string documentId)
        {
            try
            {
                DocumentReference docRef = _firestoreDB.Collection(collectionPath).Document(documentId);
                await docRef.DeleteAsync();
                Console.WriteLine($"Document {documentId} successfully deleted!");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting document: {ex.Message}");
                throw;
            }
        }
    }
}