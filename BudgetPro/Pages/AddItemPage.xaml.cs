using CommunityToolkit.Maui.Views;

namespace BudgetPro.Pages;

public partial class AddItemPage : Popup
{

	private int value = 1;
	public AddItemPage()
	{
		InitializeComponent();
	}


	private void IncreaseValue(object sender, EventArgs args)
	{
		value++;
		StepperValue.Text = value.ToString();
	}

	private void DecreaseValue(object sender, EventArgs args)
	{

		if (value < 1) value = 1; // Set minimum value to 1
		StepperValue.Text = value.ToString();

	}

	private void CancelButtonClicked(object sender, EventArgs e)
	{
		// Close the popup
		this.Close();
	}

	private void SaveButtonClicked(object sender, EventArgs e)
	{
		// Save the data and close the popup
		// Implement your save logic here
		this.Close();
	}

}