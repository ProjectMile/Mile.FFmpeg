using Mile.Project.Helpers;

namespace Mile.FFmpeg.ModuleDefinitionGenerator
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string ProjectRootPath = GitRepository.GetRootPath();

            Console.WriteLine(ProjectRootPath);

            List<KeyValuePair<string, string>> RootPaths = new List<KeyValuePair<string, string>>
            {
                new KeyValuePair<string, string>(
                    ProjectRootPath + @"\Mile.FFmpeg.Vcpkg\packages\ffmpeg_arm64-windows-static-release\lib\",
                    ProjectRootPath + @"\Mile.FFmpeg\Mile.FFmpeg.ARM64.def"),
                new KeyValuePair<string, string>(
                    ProjectRootPath + @"\Mile.FFmpeg.Vcpkg\packages\ffmpeg_x64-windows-static-release\lib\",
                    ProjectRootPath + @"\Mile.FFmpeg\Mile.FFmpeg.x64.def"),
                new KeyValuePair<string, string>(
                    ProjectRootPath + @"\Mile.FFmpeg.Vcpkg\packages\ffmpeg_x86-windows-static-release\lib\",
                    ProjectRootPath + @"\Mile.FFmpeg\Mile.FFmpeg.Win32.def")
            };

            foreach (KeyValuePair<string, string> RootPath in RootPaths)
            {
                List<KeyValuePair<string, string>> Files =
                new List<KeyValuePair<string, string>>
                {
                    new KeyValuePair<string, string>(
                        RootPath.Key + "avcodec.lib",
                        "av"),
                    new KeyValuePair<string, string>(
                        RootPath.Key + "avdevice.lib",
                        "avdevice_;av_"),
                    new KeyValuePair<string, string>(
                        RootPath.Key + "avfilter.lib",
                        "avfilter_;av_"),
                    new KeyValuePair<string, string>(
                        RootPath.Key + "avformat.lib",
                        "av"),
                    new KeyValuePair<string, string>(
                        RootPath.Key + "avutil.lib",
                        "av"),
                    new KeyValuePair<string, string>(
                        RootPath.Key + "swresample.lib",
                        "swr_;swresample_"),
                    new KeyValuePair<string, string>(
                        RootPath.Key + "swscale.lib",
                        "swscale_;sws_"),
                };

                List<string> Symbols = new List<string>();

                foreach (KeyValuePair<string, string> File in Files)
                {
                    string[] ConvertedFilters = File.Value.Split(';');
                    ImageArchive.Archive Archive = ImageArchive.Parse(File.Key);
                    if (Archive.Symbols != null)
                    {
                        SortedSet<string> OriginalSymbols =
                            ImageArchive.ListSymbols(
                                Archive.Symbols,
                                File.Key.Contains("x86"));
                        foreach (string Symbol in OriginalSymbols)
                        {
                            bool Excluded = true;
                            foreach (string Filter in ConvertedFilters)
                            {
                                if (Symbol.StartsWith(Filter))
                                {
                                    Excluded = false;
                                    break;
                                }
                            }
                            if (Excluded)
                            {
                                continue;
                            }
                            Symbols.Add(Symbol);
                        }
                    }
                }

                Console.WriteLine(Symbols.Count);

                string Result = "LIBRARY\r\n\r\nEXPORTS\r\n\r\n";

                foreach (string Symbol in Symbols)
                {
                    Result += Symbol + "\r\n";
                }

                FileUtilities.SaveTextToFileAsUtf8Bom(RootPath.Value, Result);
            }

            Console.WriteLine("Hello World!");

            Console.ReadKey();
        }
    }
}
