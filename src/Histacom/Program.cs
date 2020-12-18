using MediaLib;
using System;

namespace Histacom
{
    class Program
    {
        static void Main(string[] args)
        {
#if DEBUG
            App.LogDebug = true;
#endif

            using var mainApp = new MainApp();
            var exitCode = mainApp.Run();

            Environment.Exit(exitCode);
        }
    }
}
