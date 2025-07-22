using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BudgetPro.ViewModels;

namespace BudgetPro.Pages;

public partial class ChatPage : ContentPage
{
    public ChatPage(ChatPageViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }
}