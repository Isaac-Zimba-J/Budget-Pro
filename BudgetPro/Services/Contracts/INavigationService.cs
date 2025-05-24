using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BudgetPro.Services.Contracts;

public interface INavigationService
{
    //navigate to a specific route
    Task NavigateToAsync(string route, IDictionary<string, object>? parameters = null);

    //go back to the previous page
    Task GoBackAsync();
}
