#SingleInstance, Force
CoordMode, Pixel, Screen

; global variables ;

RecordingTime := 5000
RetryDelay := 5000

; subroutines ;

; find image on screen and click it
FindAndClick( ByRef Success, X1, Y1, X2, Y2, image ){
    WinActivate, ahk_exe Discord.exe
    ImageSearch, OutX, OutY, X1, Y1, X2, Y2, %image%
    if (ErrorLevel = 2){
        MsgBox, 0, Error, Could not conduct the search., 1
        ExitApp
    }
    else if (ErrorLevel = 1){
        ;MsgBox, 0, Error, Icon could not be found on the screen. %image%, 1
        Success := 0
    }
    else{
        ;MsgBox The icon was found at %OutX%x%OutY%. 
        CoordMode, Mouse
        MouseMove, OutX, OutY
        Sleep, 500
        Click, Left
        Sleep, 500
        
        CoordMode, Pixel
        Success := 1
    }
}

; init ;

Process, Exist, Discord.exe
if (ErrorLevel = 0){
    MsgBox, Discord is not active
    ExitApp
}

Process, Exist, obs64.exe
if (ErrorLevel = 0){
    MsgBox, Discord is not active
    ExitApp
}

WinActivate ahk_exe Discord.exe
WinMaximize ahk_exe Discord.exe

WinActivate ahk_exe obs64.exe
WinMaximize ahk_exe obs64.exe

; MAIN LOOP ;

Loop{
    WinActivate ahk_exe Discord.exe

    FindAndClick( Success, 80, 80, 250, 1000, "images\LiveButton.png")
    if( Success ){
        MsgBox, 0, Success, Someone is streaming rn :D . Recording now, 3

        MouseMove, 250, 320, 0, R
        Sleep, 1000

        ; WinActivate, ahk_exe obs64.exe
        ; Send, {Home}
        ; WinActivate, ahk_exe Discord.exe
        MouseClick, Left, 380, 45 ; center cursor
        Sleep, %RecordingTime%
    }
    else{
        MsgBox, 0, Not Success, No one is streaming rn :(, 3
        MouseClick, Left, 380, 45 ; center cursor
        Sleep, %RetryDelay%
    }
}

; POOL NIAM ;

; emergency stop ctrl+esc
^Esc::
    MsgBox, Emergency Exit Combination Pressed
    WinActivate ahk_exe obs64.exe
    Send, {End}
    ExitApp
Return