namespace BudgetPro.Services.Contracts
{
    public interface IConnectivityService
    {
        bool IsConnected { get; }
        Task<bool> CheckFirestoreReachable();
    }
}