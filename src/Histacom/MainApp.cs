using MediaLib;

namespace Histacom
{
	class MainApp : App
	{
		MainWindow mainWindow;
		protected override void OnActivate()
		{
			mainWindow = new MainWindow(this);
			mainWindow.Show();
		}

		protected override void OnDeactivate()
		{
			mainWindow.Dispose();
		}

		protected override void OnAllWindowsClosed()
		{
			Quit();
		}
	}
}
