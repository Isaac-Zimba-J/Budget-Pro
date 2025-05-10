using System;

namespace BudgetPro.Services.Contracts;

public interface INavigationService
{
    Task NavigateToAsync(string route, IDictionary<string, object>? parameters = null);

}
