Loop 
{
    WinId := WinExist("A")
    WinGetClass, class, A
    isFullScreen := isActiveWindowFullScreen(WinId, class)
    if (isFullScreen)
    {
        Process, Close, Rainmeter.exe
    }
    else if (!ProcessExist("Rainmeter.exe")) && (class == "WorkerW")
    {
        Run, C:\Program Files\Rainmeter\Rainmeter.exe, , Min
    }
    Sleep, 500
}

ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}

isActiveWindowFullScreen(WinId, class)
{
    ;checks if the specified window is full screen
    ;code from NiftyWindows source
    ;(with only slight modification)

    ;use WinExist of another means to get the Unique ID (HWND) of the desired window

    if ( !WinID )
        return false

    if ( class == "WorkerW" )
        return false

    WinGet, WinMinMax, MinMax, ahk_id %WinID%
    WinGetPos, WinX, WinY, WinW, WinH, ahk_id %WinID%

    if (WinMinMax = 0) && (WinX = 0) && (WinY = 0) && (WinW = A_ScreenWidth) && (WinH = A_ScreenHeight)
    {
        WinGetClass, WinClass, ahk_id %WinID%
        WinGet, WinProcessName, ProcessName, ahk_id %WinID%
        SplitPath, WinProcessName, , , WinProcessExt

        if (WinClass != "Progman") && (WinProcessExt != "scr")
        {
            ;program is full-screen
            return true
        }
    }
}