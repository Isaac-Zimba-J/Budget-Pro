using Firebase.Auth;
using Google.Cloud.Firestore;
using System;
using System.IO;
using System.Reflection;

namespace BudgetPro.Helpers
{
    public static class FirebaseHelper
    {
        private static string _projectId = "budgetpro-33542";
        
        public static FirestoreDb GetFirestoreDb()
        {
            try
            {
                // For development with emulator
                string emulatorHost = Environment.GetEnvironmentVariable("FIRESTORE_EMULATOR_HOST");
                if (!string.IsNullOrEmpty(emulatorHost))
                {
                    Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", null);
                    return FirestoreDb.Create(_projectId);
                }

                // The correct path to the credentials file in your resources
                string credentialsJson = "google-services.json";
                string credentialsPath = Path.Combine(FileSystem.AppDataDirectory, credentialsJson);
                
                // If credentials file doesn't exist locally, extract it from embedded resources
                if (!File.Exists(credentialsPath))
                {
                    try
                    {
                        // Get the embedded resource and write it to a file
                        // Note the correct resource path based on your project structure
                        using var resourceStream = Assembly.GetExecutingAssembly()
                            .GetManifestResourceStream("BudgetPro.Resources.Raw.credentials.google-services.json");
                        
                        if (resourceStream != null)
                        {
                            using var fileStream = File.Create(credentialsPath);
                            resourceStream.CopyTo(fileStream);
                            Console.WriteLine($"Credentials file extracted to {credentialsPath}");
                        }
                        else
                        {
                            Console.WriteLine("Credentials file not found in embedded resources. Searching for resource...");
                            
                            // List available resources for debugging
                            var assembly = Assembly.GetExecutingAssembly();
                            var resourceNames = assembly.GetManifestResourceNames();
                            foreach (var name in resourceNames)
                            {
                                Console.WriteLine($"Found resource: {name}");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error extracting credentials: {ex.Message}");
                    }
                }

                // Set the credentials environment variable if the file exists
                if (File.Exists(credentialsPath))
                {
                    Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", credentialsPath);
                    Console.WriteLine("Set GOOGLE_APPLICATION_CREDENTIALS environment variable");
                }
                else
                {
                    Console.WriteLine("Warning: Credentials file not available, authentication may fail");
                }

                // Create and return the FirestoreDb instance
                return FirestoreDb.Create(_projectId);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error initializing Firestore: {ex.Message}");
                throw;
            }
        }
    }
}