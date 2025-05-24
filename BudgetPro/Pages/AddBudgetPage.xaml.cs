using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BudgetPro.ViewModels;
using CommunityToolkit.Maui.Views;

namespace BudgetPro.Pages;

public partial class AddBudgetPage : ContentPage
{
    // Reference to the view model for direct access if needed
    private readonly AddBudgetViewModel _viewModel;

    public AddBudgetPage(AddBudgetViewModel viewModel)
    {
        InitializeComponent();

        // Store the view model and set as binding context
        _viewModel = viewModel;
        BindingContext = _viewModel;
    }

    // If you need to handle any page lifecycle events or UI events not handled by the ViewModel
    protected override void OnAppearing()
    {
        base.OnAppearing();
        // Any additional setup when page appears
    }

    private void OnAddItemClicked(object sender, EventArgs e)
    {
        var popup = new AddItemPage();
        this.ShowPopup(popup);
    }
}