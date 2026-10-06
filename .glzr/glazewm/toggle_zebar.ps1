$source = @'
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text;

public static class ZebarWindowToggle
{
    private delegate bool EnumWindowsProc(IntPtr window, IntPtr parameter);

    [DllImport("user32.dll")]
    private static extern bool EnumWindows(EnumWindowsProc callback, IntPtr parameter);

    [DllImport("user32.dll")]
    private static extern uint GetWindowThreadProcessId(IntPtr window, out uint processId);

    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    private static extern int GetWindowText(IntPtr window, StringBuilder text, int count);

    [DllImport("user32.dll")]
    private static extern bool IsWindowVisible(IntPtr window);

    [DllImport("user32.dll")]
    private static extern bool ShowWindowAsync(IntPtr window, int command);

    public static void Toggle()
    {
        var processIds = new HashSet<int>();
        foreach (var process in Process.GetProcessesByName("zebar"))
        {
            processIds.Add(process.Id);
        }

        var windows = new List<IntPtr>();
        EnumWindows((window, parameter) =>
        {
            uint processId;
            GetWindowThreadProcessId(window, out processId);
            if (processIds.Contains((int)processId))
            {
                var title = new StringBuilder(512);
                GetWindowText(window, title, title.Capacity);
                if (title.ToString().EndsWith(" / bar", StringComparison.OrdinalIgnoreCase))
                {
                    windows.Add(window);
                }
            }

            return true;
        }, IntPtr.Zero);

        var show = false;
        foreach (var window in windows)
        {
            if (!IsWindowVisible(window))
            {
                show = true;
                break;
            }
        }

        var command = show ? 5 : 0;
        foreach (var window in windows)
        {
            ShowWindowAsync(window, command);
        }
    }
}
'@

if (-not ([System.Management.Automation.PSTypeName]'ZebarWindowToggle').Type) {
    Add-Type -TypeDefinition $source
}
[ZebarWindowToggle]::Toggle()
