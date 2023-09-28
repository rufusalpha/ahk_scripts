#SingleInstance, Force
CoordMode, Pixel, Screen
SendMode, Input
SetDefaultMouseSpeed, 5

; global variables ;

RecordingTime := 6000 ; 10 minutes
RetryDelay := 10000 ; 10 seconds
FormatTime, CurrentDateTime,, dd-MM-yy HH:mm
KeypressTime := 200

; subroutines ;

; find image on screen and click it
FindAndClick( ByRef Success, X1, Y1, X2, Y2, image ){
    WinActivate, ahk_exe Discord.exe
    ImageSearch, OutX, OutY, X1, Y1, X2, Y2, %image%
    if (ErrorLevel = 2){
        MsgBox, 0, Error, Could not conduct the search, 1
        log( "Could not conduct the search" )
        ExitApp
    }
    else if (ErrorLevel = 1){
        ;MsgBox, 0, Error, Icon could not be found on the screen. %image%, 1
        Success := 0
    }
    else{
        ;MsgBox The icon was found at %OutX%x%OutY%. 
        CoordMode, Mouse
        MouseMove, OutX-10, OutY
        Sleep, 350
        Click, Left
        Sleep, 350
        
        CoordMode, Pixel
        Success := 1
    }
}

log( string ){
    FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm:ss
    FileAppend, %CurrentDateTime% - %string% `n, C:\Users\fuchs\Videos\Nagrania_Playtest\Event.log
}

; init ;

Process, Exist, Discord.exe
if (ErrorLevel = 0){
    MsgBox, Discord is not active
    ExitApp
}

Process, Exist, obs64.exe
if (ErrorLevel = 0){
    MsgBox, OBS is not active
    ExitApp
}

WinActivate ahk_exe obs64.exe
WinMaximize ahk_exe obs64.exe

WinActivate ahk_exe Discord.exe
WinMaximize ahk_exe Discord.exe

log( "script init" )

MsgBox, 0, INIT, Automatic discord recording script. Looking For Stream, 2
Sleep, 3500

; MAIN LOOP ;

Loop{
    WinActivate ahk_exe Discord.exe

    FindAndClick( Success, 80, 80, 250, 1000, "images\LiveButton.png")
    if (Success){
        MsgBox, 0, Success, Someone is streaming rn :D . Recording now, 3
        log( "found stream" )

        FindAndClick(Stream, 310, 150, 650, 1000, "images\StreamButton.png")
        if (Stream){
            MouseMove, 960, 540
            Sleep, 350

            FindAndClick( FullScreen, 1700, 900, 1920, 1080, "images\FullScreenButton.png")
            if (FullScreen){
                
                Sleep, 350
                Send, {home down}
                Sleep, 350
                Send, {home up}
                Sleep, 350
                
                log("recording start")
                WinShow, ahk_exe Discord.exe
                Sleep, %RecordingTime%
                log( "recording end" )

                Sleep, 350
                Send, {end down}
                Sleep, 350
                Send, {end up} 
                Sleep, 350

                WinActivate, ahk_exe Discord.exe
				
				Send, {esc down}
                Sleep, 350
                Send, {esc up}
                Sleep, 500
                MouseMove, 1700, 1020, 5
                Sleep, 350
                FindAndClick( discon, 930, 950, 1700, 1020, "images\LiveButton.png")
                if( discon = 0 ){
                    MsgBox, 0, Error, Error disconnection, 2
                    log( "Error disconnection 1" )
                }

            }
            else{
                MsgBox, 0, Fullscreen, FullScreen Failed, 2
                log( "FullScreen Failed" )
                Continue
            }
        }
        else{
            MsgBox, 0, Fullscreen, Stream Failed, 2

            MouseMove, 960, 540, 5
            Sleep, 350
            FindAndClick( discon, 930, 950, 1700, 1020, "images\LiveButton.png")
                if( discon = 0 ){
                    MsgBox, 0, Error, error disconnection, 2
                    log( "Error disconnection 2" )
                }
        }
        
        MouseClick, Left, 380, 45 ; center cursor        
    }
    else{
        MsgBox, 0, Not Success, No one is streaming rn :(, 3
        MouseClick, Left, 380, 45 ; center cursor

        WinActivate, ahk_exe Discord.exe
		Send, {esc down}
        Sleep, 350
        Send, {esc up}
        Sleep, %RetryDelay%
    }
}

; POOL NIAM ;

; emergency stop ctrl+esc
^Esc::
    MsgBox, Emergency Exit Combination Pressed
    Send, {End down}
    Sleep, 100
    Send, {End up}
    log( "force stop")
    ExitApp
Return