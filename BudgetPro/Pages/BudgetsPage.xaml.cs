using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BudgetPro.ViewModels;

namespace BudgetPro.Pages;

public partial class BudgetsPage : ContentPage
{
    private readonly BudgetViewModel _viewModel;
    public BudgetsPage(BudgetViewModel viewModel)
    {
        InitializeComponent();
        _viewModel = viewModel;
        BindingContext = _viewModel;
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();
        await _viewModel.OnAppearingAsync();
    }
}