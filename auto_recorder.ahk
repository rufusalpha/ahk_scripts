#SingleInstance, Force
CoordMode, Pixel, Screen

; subroutines ;

FindAndClick( X1, Y1, X2, Y2, image ){
    WinActivate, ahk_exe Discord.exe
    ImageSearch, OutX, OutY, X1, Y1, X2, Y2, %image%
    if (ErrorLevel = 2)
        MsgBox Could not conduct the search.
    else if (ErrorLevel = 1)
        MsgBox Icon could not be found on the screen. %image%
    else{
        ;MsgBox The icon was found at %OutX%x%OutY%. 
        CoordMode, Mouse
        MouseClick, Left, OutX, OutY
        CoordMode, Pixel       
    }
}

; init ;

Process, Exist, Discord.exe
if (ErrorLevel = 0){
    MsgBox, Discord is not active
}

Process, Exist, obs64.exe
if (ErrorLevel = 0){
    MsgBox, Discord is not active
}

; main loop ;

;FindAndClick( 80, 80, 250, 1000, "images\LiveButton.png")
WinActivate, ahk_exe obs64.exe
Send, {Home}

WinActivate, ahk_exe Discord.exe
Sleep, 3000

WinActivate, ahk_exe obs64.exe
Send, {End}
WinActivate, ahk_exe Discord.exe

; pool niam ;