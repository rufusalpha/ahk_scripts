#SingleInstance, Force
CoordMode, Pixel, Screen
SetKeyDelay, , 100,

; global variables ;

RecordingTime := 10000
RetryDelay := 10000

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

WinActivate ahk_exe obs64.exe
WinMaximize ahk_exe obs64.exe

WinActivate ahk_exe Discord.exe
WinMaximize ahk_exe Discord.exe

MsgBox, 0, INIT, Automatic discord recording script. Looking For Stream, 2
Sleep, 2000

; MAIN LOOP ;

Loop{
    WinActivate ahk_exe Discord.exe

    FindAndClick( Success, 80, 80, 250, 1000, "images\LiveButton.png")
    if (Success){
        MsgBox, 0, Success, Someone is streaming rn :D . Recording now, 3
        
        FindAndClick(Stream, 310, 150, 650, 1000, "images\StreamButton.png")
        if (Stream){
            MouseMove, 960, 540
            Sleep, 200

            FindAndClick( FullScreen, 1700, 900, 1920, 1080, "images\FullScreenButton.png")
            if (FullScreen){
                WinActivate, ahk_exe obs64.exe
                Sleep, 200
                SendInput, {home}

                Sleep, 200
                WinActivate, ahk_exe Discord.exe
                Sleep, %RecordingTime%

                WinActivate, ahk_exe obs64.exe
                Sleep, 200
                SendInput, {end}

                Sleep, 200
                WinActivate, ahk_exe Discord.exe

                Sleep, 200
                SendInput, {esc}
                MouseMove, 960, 540
                Sleep, 200
                FindAndClick( discon, 930, 950, 1700, 1020, "images\LiveButton.png")
                if( discon = 0 ){
                    MsgBox, error disconnection
                }

            }
            else{
                MsgBox, 0, Fullscreen, FullScreen Failed, 2
                Continue
            }
        }
        else{
            MsgBox, 0, Fullscreen, Stream Failed, 2

            MouseMove, 960, 540
            Sleep, 200
            FindAndClick( discon, 930, 950, 1700, 1020, "images\LiveButton.png")
                if( discon = 0 ){
                    MsgBox, error disconnection
                }
        }
        
        MouseClick, Left, 380, 45 ; center cursor
        
    }
    else{
        MsgBox, 0, Not Success, No one is streaming rn :(, 3
        MouseClick, Left, 380, 45 ; center cursor

        WinActivate, ahk_exe Discord.exe
        Sleep, 200
        SendInput, {esc}

        Sleep, %RetryDelay%
    }
}

; POOL NIAM ;

; emergency stop ctrl+esc
^Esc::
    MsgBox, Emergency Exit Combination Pressed
    WinActivate ahk_exe obs64.exe
    SendInput, {End}
    ExitApp
Return