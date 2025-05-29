using BudgetPro.ViewModels;

namespace BudgetPro.Pages;

public partial class EditBudgetPage : ContentPage
{
    public EditBudgetPage(EditBudgetViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }
}