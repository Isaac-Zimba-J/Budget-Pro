using BudgetPro.Services.Contracts;
using System;
using System.Net.Http;
using System.Threading.Tasks;

namespace BudgetPro.Services
{
    public class ConnectivityService : IConnectivityService
    {
        private readonly HttpClient _httpClient;

        public ConnectivityService()
        {
            _httpClient = new HttpClient();
            _httpClient.DefaultRequestVersion = new Version(1, 1);
            _httpClient.Timeout = TimeSpan.FromSeconds(5);
        }

        public bool IsConnected => Connectivity.NetworkAccess == NetworkAccess.Internet;

        public async Task<bool> CheckFirestoreReachable()
        {
            if (!IsConnected)
                return false;

            try
            {
                // Try to reach Firestore endpoint
                var response = await _httpClient.GetAsync("https://firestore.googleapis.com/v1/projects");
                return response.IsSuccessStatusCode;
            }
            catch
            {
                return false;
            }
        }
    }
}