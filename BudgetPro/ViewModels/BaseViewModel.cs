using System;
using CommunityToolkit.Mvvm.ComponentModel;

namespace BudgetPro.ViewModels;

public partial class BaseViewModel : ObservableObject
{
    // properties    
    [ObservableProperty]
    [NotifyPropertyChangedFor(nameof(isNotBusy))]
    private bool isBusy;

    private bool isNotBusy => !isBusy;
    [ObservableProperty]

    private string title = string.Empty;




}
