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
    private int value = 1;
    public AddBudgetPage(AddBudgetViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }

    private void OnAddItemClicked(object sender, EventArgs e)
    {
        var popup = new AddItemPage();
        this.ShowPopup(popup);
    }


    private void DecreaseValue(object sender, EventArgs e)
    {
        value--;
        if (value < 1) value = 1; // Set minimum value to 1
        StepperValue.Text = value.ToString();
    }

    private void IncreaseValue(object sender, EventArgs e)
    {
        value++;
        StepperValue.Text = value.ToString();
    }


}