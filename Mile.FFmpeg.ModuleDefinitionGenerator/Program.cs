using System.Diagnostics;
using System.Text;

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

        const int ImageArchiveStartSize = 8;
        const string ImageArchiveStart = "!<arch>\n";
        const string ImageArchiveEnd = "`\n";
        const string ImageArchivePad = "\n";
        const string ImageArchiveLinkerMember = "/               ";
        const string ImageArchiveLongnamesMember = "//              ";
        const string ImageArchiveHybridmapMember = "/<HYBRIDMAP>/   ";

        const int ImageArchiveMemberHeaderNameSize = 16;
        const int ImageArchiveMemberHeaderDateSize = 12;
        const int ImageArchiveMemberHeaderUserIDSize = 6;
        const int ImageArchiveMemberHeaderGroupIDSize = 6;
        const int ImageArchiveMemberHeaderModeSize = 8;
        const int ImageArchiveMemberHeaderSizeSize = 10;
        const int ImageArchiveMemberHeaderEndHeaderSize = 2;

        static void GetAllSymbolsFromStaticLibraryFile(
            string FilePath,
            string Filters,
            ref List<string> Symbols)
        {
            string[] ConvertedFilters = Filters.Split(';');

            byte[] Content = File.ReadAllBytes(FilePath);

            int CurrentOffset = 0;

            string CurrentImageArchiveStart = Encoding.ASCII.GetString(
                Content,
                CurrentOffset,
                ImageArchiveStartSize);
            if (CurrentImageArchiveStart != ImageArchiveStart)
            {
                return;
            }

            CurrentOffset += ImageArchiveStartSize;
            string CurrentImageArchiveLinkerMember = Encoding.ASCII.GetString(
                Content,
                CurrentOffset,
                ImageArchiveMemberHeaderNameSize);
            if (CurrentImageArchiveLinkerMember != ImageArchiveLinkerMember)
            {
                return;
            }

            CurrentOffset += ImageArchiveMemberHeaderNameSize;
            CurrentOffset += ImageArchiveMemberHeaderDateSize;
            CurrentOffset += ImageArchiveMemberHeaderUserIDSize;
            CurrentOffset += ImageArchiveMemberHeaderGroupIDSize;
            CurrentOffset += ImageArchiveMemberHeaderModeSize;
            CurrentOffset += ImageArchiveMemberHeaderSizeSize;
            string CurrentImageArchiveMemberHeaderEndHeader =
                Encoding.ASCII.GetString(
                    Content,
                    CurrentOffset,
                    ImageArchiveMemberHeaderEndHeaderSize);
            if (CurrentImageArchiveMemberHeaderEndHeader != ImageArchiveEnd)
            {
                return;
            }

            CurrentOffset += ImageArchiveMemberHeaderEndHeaderSize;
            int SymbolsCount = 0;
            {
                byte[] RawBytes = new Span<byte>(
                    Content,
                    CurrentOffset,
                    4).ToArray();
                if (BitConverter.IsLittleEndian)
                {
                    Array.Reverse(RawBytes);
                }

                SymbolsCount = BitConverter.ToInt32(
                    RawBytes);
            }
            if (SymbolsCount == 0)
            {
                return;
            }

            CurrentOffset += sizeof(uint);
            CurrentOffset += sizeof(uint) * SymbolsCount;
            {
                string[] RawStrings = Encoding.ASCII.GetString(
                    Content,
                    CurrentOffset,
                    Content.Length - CurrentOffset).Split('\0');

                for (int i = 0; i < SymbolsCount; ++i)
                {
                    bool Excluded = true;
                    foreach (string Filter in ConvertedFilters)
                    {
                        if (RawStrings[i].StartsWith(Filter) ||
                            RawStrings[i].StartsWith("_" + Filter))
                        {
                            Excluded = false;
                            break;
                        }
                    }
                    if (Excluded)
                    {
                        continue;
                    }

                    Symbols.Add(
                        RawStrings[i].StartsWith("_")
                        ? RawStrings[i].Substring(1)
                        : RawStrings[i]);
                }
            }
        }

        static void Main(string[] args)
        {
            string ProjectRootPath = GetRepositoryRoot();

            Console.WriteLine(ProjectRootPath);

            List<KeyValuePair<string, string>> RootPaths = new List<KeyValuePair<string, string>>
            {
                new KeyValuePair<string, string>(
                     ProjectRootPath + @"\Mile.FFmpeg.Vcpkg\packages\ffmpeg_arm-windows-static-release\lib\",
                     ProjectRootPath + @"\Mile.FFmpeg\Mile.FFmpeg.ARM.def"),
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
                    GetAllSymbolsFromStaticLibraryFile(
                        File.Key,
                        File.Value,
                        ref Symbols);
                }

                Console.WriteLine(Symbols.Count);

                string Result = "LIBRARY\r\n\r\nEXPORTS\r\n\r\n";

                foreach (string Symbol in Symbols)
                {
                    Result += Symbol + "\r\n";
                }

                File.WriteAllText(
                    RootPath.Value,
                    Result,
                    Encoding.UTF8);
            }

            Console.WriteLine("Hello World!");

            Console.ReadKey();
        }
    }
}