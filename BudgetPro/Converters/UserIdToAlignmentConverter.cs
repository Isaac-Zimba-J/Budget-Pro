using System;
using System.Globalization;
using Microsoft.Maui.Controls;
using BudgetPro.Services.Contracts;

namespace BudgetPro.Converters;

public class UserIdToAlignmentConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        var userId = value as string;
        var currentUserId = App.Current?.Handler?.MauiContext?.Services.GetService(typeof(IUserService)) is IUserService userService ? userService.CurrentUserId : null;
        return userId == currentUserId ? LayoutOptions.End : LayoutOptions.Start;
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        throw new NotImplementedException();
    }
}