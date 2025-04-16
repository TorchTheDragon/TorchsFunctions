package torchsfunctions;

import lime.app.Application;
import lime.ui.Window;

#if windows
@:buildXml('
<target id="haxe">
    <lib name="dwmapi.lib" if="windows" />
</target>
')
@:cppFileCode('
#include <Windows.h>
#include <cstdio>
#include <iostream>
#include <tchar.h>
#include <dwmapi.h>
#include <winuser.h>

bool transparencyEnabled = false;
')
#elseif linux
@:cppFileCode("#include <stdio.h>")
#end

class WindowsBackend {
    #if windows
    @:functionCode('
        HWND window = GetActiveWindow();
        int isDark = (isDarkMode ? 1 : 0);
    
        if (DwmSetWindowAttribute(window, 19, &isDark, sizeof(isDark)) != S_OK) {
            DwmSetWindowAttribute(window, 20, &isDark, sizeof(isDark));
        }
        UpdateWindow(window);
    ')
    public static function setColorMode(isDarkMode:Bool) {}
    
    @:functionCode('
        HWND window = GetActiveWindow();
        auto finalColor = RGB(color[0], color[1], color[2]);
    
        if(setHeader) DwmSetWindowAttribute(window, 35, &finalColor, sizeof(COLORREF));
        if(setBorder) DwmSetWindowAttribute(window, 34, &finalColor, sizeof(COLORREF));
    
            UpdateWindow(window);
    ')
    public static function setBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = false) {}
    
    @:functionCode('
        HWND window = GetActiveWindow();
        auto finalColor = RGB(color[0], color[1], color[2]);
    
        DwmSetWindowAttribute(window, 36, &finalColor, sizeof(COLORREF));
        UpdateWindow(window);
    ')
    public static function setTitleColor(color:Array<Int>) {}
    
    @:functionCode('
    HWND window = GetActiveWindow();

    if (transparencyEnabled) {
        SetWindowLong(window, GWL_EXSTYLE, GetWindowLong(window, GWL_EXSTYLE) ^ WS_EX_LAYERED);
        SetLayeredWindowAttributes(window, RGB(0, 0, 0), 255, LWA_COLORKEY | LWA_ALPHA);
    }
    // make window layered
    int result = SetWindowLong(window, GWL_EXSTYLE, GetWindowLong(window, GWL_EXSTYLE) | WS_EX_LAYERED);
    if (alpha > 255) alpha = 255;
    if (alpha < 0) alpha = 0;
    SetLayeredWindowAttributes(window, RGB(red, green, blue), alpha, LWA_COLORKEY | LWA_ALPHA);
    alpha = result;
    transparencyEnabled = true;
    ')
    public static function setWindowTransparencyColor(red:Int, green:Int, blue:Int, alpha:Int = 255) {return alpha;}

    @:functionCode('
        if (!transparencyEnabled) return false;
        
        HWND window = GetActiveWindow();
        SetWindowLong(window, GWL_EXSTYLE, GetWindowLong(window, GWL_EXSTYLE) ^ WS_EX_LAYERED);
        SetLayeredWindowAttributes(window, RGB(0, 0, 0), 255, LWA_COLORKEY | LWA_ALPHA);
        transparencyEnabled = false;
    ')
    public static function disableWindowTransparency(result:Bool = true) {return result;}

    @:functionCode('UpdateWindow(GetActiveWindow());')
    public static function updateWindow() {}
    #end
}