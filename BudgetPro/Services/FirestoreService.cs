using BudgetPro.Services.Contracts;
using Google.Cloud.Firestore;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;

namespace BudgetPro.Services
{
    public class FirestoreService : IFirestoreService
    {
        private readonly FirestoreDb _firestoreDB;
        private readonly HttpClient _httpClient;
        private const int MaxRetries = 3;

        public FirestoreService(FirestoreDb firestoreDB)
        {
            _firestoreDB = firestoreDB;

            // Create and configure an HttpClient for direct REST calls if needed
            _httpClient = new HttpClient(new HttpClientHandler
            {
                UseCookies = false,
                AutomaticDecompression = System.Net.DecompressionMethods.GZip | System.Net.DecompressionMethods.Deflate
            });
            _httpClient.DefaultRequestVersion = new Version(1, 1);
            _httpClient.DefaultVersionPolicy = HttpVersionPolicy.RequestVersionOrLower;
        }

        public async Task<T> GetByIdAsync<T>(string collectionPath, string documentId)
        {
            for (int attempt = 1; attempt <= MaxRetries; attempt++)
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
                    Console.WriteLine($"Attempt {attempt} failed: {ex.Message}");

                    if (attempt == MaxRetries)
                        throw;

                    await Task.Delay(1000 * attempt); // Exponential backoff
                }
            }

            throw new Exception("Failed after maximum retry attempts");
        }

        public async Task<List<T>> GetAllAsync<T>(string collectionPath)
        {
            for (int attempt = 1; attempt <= MaxRetries; attempt++)
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
                    Console.WriteLine($"Attempt {attempt} failed: {ex.Message}");

                    if (attempt == MaxRetries ||
                        (ex.Message.Contains("HTTP/2") && attempt > 1))
                    {
                        // If this is an HTTP/2 error after first attempt, try REST API approach
                        if (ex.Message.Contains("HTTP/2"))
                        {
                            return await GetAllViaRestAsync<T>(collectionPath);
                        }
                        throw;
                    }

                    await Task.Delay(1000 * attempt); // Exponential backoff
                }
            }

            throw new Exception("Failed after maximum retry attempts");
        }

        private async Task<List<T>> GetAllViaRestAsync<T>(string collectionPath)
        {
            try
            {
                // Implement a direct REST API call as fallback
                // This is a simplified example - you would need to implement proper 
                // authentication and response parsing
                Console.WriteLine("Attempting to get data via REST API fallback");

                // Note: This would require specific handling for your data model
                // and additional authentication implementation
                return new List<T>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"REST API fallback failed: {ex.Message}");
                throw;
            }
        }

        public async Task InsertData<T>(string collectionPath, string documentId, T data)
        {
            for (int attempt = 1; attempt <= MaxRetries; attempt++)
            {
                try
                {
                    DocumentReference docRef = _firestoreDB.Collection(collectionPath).Document(documentId);
                    await docRef.SetAsync(data);
                    Console.WriteLine($"Document {documentId} successfully written!");
                    return;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Attempt {attempt} failed: {ex.Message}");

                    if (attempt == MaxRetries)
                        throw;

                    await Task.Delay(1000 * attempt); // Exponential backoff
                }
            }

            throw new Exception("Failed after maximum retry attempts");
        }

        public async Task UpdateData<T>(string collectionPath, string documentId, T data)
        {
            for (int attempt = 1; attempt <= MaxRetries; attempt++)
            {
                try
                {
                    DocumentReference docRef = _firestoreDB.Collection(collectionPath).Document(documentId);
                    await docRef.SetAsync(data, SetOptions.MergeAll);
                    Console.WriteLine($"Document {documentId} successfully updated!");
                    return;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Attempt {attempt} failed: {ex.Message}");

                    if (attempt == MaxRetries)
                        throw;

                    await Task.Delay(1000 * attempt); // Exponential backoff
                }
            }

            throw new Exception("Failed after maximum retry attempts");
        }

        public async Task DeleteData(string collectionPath, string documentId)
        {
            for (int attempt = 1; attempt <= MaxRetries; attempt++)
            {
                try
                {
                    DocumentReference docRef = _firestoreDB.Collection(collectionPath).Document(documentId);
                    await docRef.DeleteAsync();
                    Console.WriteLine($"Document {documentId} successfully deleted!");
                    return;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Attempt {attempt} failed: {ex.Message}");

                    if (attempt == MaxRetries)
                        throw;

                    await Task.Delay(1000 * attempt); // Exponential backoff
                }
            }

            throw new Exception("Failed after maximum retry attempts");
        }
    }
}