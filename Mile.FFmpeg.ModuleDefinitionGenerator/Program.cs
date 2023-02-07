using System.Diagnostics;

namespace Mile.FFmpeg.ModuleDefinitionGenerator
{
    internal class Program
    {
        public static string GetRepositoryRoot()
        {
            Process process = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    CreateNoWindow = true,
                    UseShellExecute = false,
                    RedirectStandardOutput = true,
                    FileName = "git.exe",
                    Arguments = "rev-parse --show-toplevel"
                }
            };

            if (process.Start())
            {
                process.WaitForExit();
                if (process.ExitCode == 0)
                {
                    string? result = process.StandardOutput.ReadLine();
                    if (result != null)
                    {
                        return Path.GetFullPath(result);
                    }
                }
            }

            return string.Empty;
        }

        static void Main(string[] args)
        {
            string Root = GetRepositoryRoot();

            Console.WriteLine(Root);

            Console.WriteLine("Hello, World!");

            Console.ReadKey();
        }
    }
}