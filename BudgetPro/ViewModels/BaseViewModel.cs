using System;
using CommunityToolkit.Mvvm.ComponentModel;

namespace BudgetPro.ViewModels;

public partial class BaseViewModel : ObservableObject
{
    // properties    
    [ObservableProperty]
    [NotifyPropertyChangedFor(nameof(IsNotBusy))]
    private bool isBusy;

    public bool IsNotBusy => !IsBusy;

    [ObservableProperty]
    private string title = string.Empty;




}
