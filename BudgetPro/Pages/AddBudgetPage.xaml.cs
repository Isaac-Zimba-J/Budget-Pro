using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BudgetPro.ViewModels;

namespace BudgetPro.Pages;

public partial class AddBudgetPage : ContentPage
{
    public AddBudgetPage(AddBudgetViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }

}