#SingleInstance, Force
CoordMode, Pixel, Screen
SendMode, Input
SetDefaultMouseSpeed, 5

; global variables ;

RetryDelay := 2000                             ; 10 seconds
ShortDelay := 200                               ; delay used on kepresses or waiting on time-sensitive functions to execute
FormatTime, CurrentDateTime,, dd-MM-yy HH:mm    ; store date and time at start of the script

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
        ; MsgBox, 0, Error, Icon could not be found on the screen. %image%, 1
        Success := 0
    }
    else{
        ; MsgBox, 0, Success, The icon was found at %OutX%x%OutY%. , 1

        CoordMode, Mouse
        MouseMove, OutX+5, OutY+5
        Sleep, 350
        Click, Left
        Sleep, 350
        
        CoordMode, Pixel
        Success := 1
    }
}

; send string messange into log file with current timestamp
log( string ){
    FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm:ss
    FileAppend, %CurrentDateTime% - %string% `n, Event.log
}

; scroll the input channel down with keypress for RetryDelay amount of CurrentDateTime
WaitForIt(){
    SendInput, {Down Down}
    Sleep, RetryDelay
    SendInput, {Down Up}
}

; init ;

Process, Exist, Discord.exe
if (ErrorLevel = 0){
    MsgBox, Discord is not active
    ExitApp
}

WinActivate ahk_exe Discord.exe
WinMaximize ahk_exe Discord.exe

log( "script init" )

MsgBox, 0, INIT, Discord midjurney request monitoring script. Looking For Messages, 3
Sleep, 3500

; MAIN LOOP ;

Loop{
    WinActivate ahk_exe Discord.exe

    FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-input-enabled.png")
    if( Success ){
        ; log( "switch to input channel from enabled" ) ; DEBUG LOG - disable before deployment

        WaitForIt()

        ImageSearch, OutX, OutY, 330, 880, 700, 1000, images\process-button.png
        if (ErrorLevel = 2){
            log( "Could not conduct the search - process-button.png" )
            MsgBox, 0, Error, Could not conduct the search
            ExitApp
        }
        else{
            ; MsgBox, 0, Success, The icon was found at %OutX%x%OutY%. , 1

            CoordMode, Mouse
            MouseMove, OutX+5, OutY+5
            Sleep, 1000

            ImageSearch,,, 330, 880, 700, 1000, images\confirmed-button.png
            if ( ErrorLevel = 2 ){
                log( "Could not conduct the search - confirmed-button.png" )
                MsgBox, 0, Error, Could not conduct the search
                ExitApp
            }
            else if ( ErrorLevel = 0 ){
                ; MsgBox, 0, done,  Already done this command, 1 ; DEBUG LOG - disable before deployment
                continue
            }

            FindAndClick( Success, OutX-10, OutY-10, OutX+100, OutY+30, "images\reaction-button.png")
            if ( Success ){
                Sleep, 350
                MouseMove, OutX+150, OutY-280
                Click, Left

                MouseMove, OutX+100, OutY-20
                Sleep, 100
                Click, Right

                FindAndClick( Success, 400, 510, 1660, 950, "images\copy-button.png")
                if ( Success ){
                    ; MsgBox, 0, Copied, Copied ; DEBUG LOG - disable before deployment
                    FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-output-disabled.png")
                    if( Success = 0 ){
                        FindAndClick( Success, 80, 60, 250, 1000, "images\midjourney-output-messaged.png")
                        if( Success = 0 ){
                            log( "couldn't find output channel - abandoning attempt") ; fix it so script wont abandon the prompt, and remove the checkmark if this happens
                            continue
                        }
                    }
                    MouseMove, 390, 985
                    Sleep, 100
                    Click, Left
                    SendInput, /imagine{Space}{Ctrl Down}{V Down}{V Up}{Ctrl Up}
                    Sleep, 100
                    SendInput, {Enter}
                    ; MsgBox, 0, Pasted, Pasted ; DEBUG LOG - disable before deployment
                }
            }
            CoordMode, Pixel
        }
    }
    else{
        FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-input-disabled.png")
        ; log( "switch to input channel from diabled" ) ; DEBUG LOG - disable before deployment
    }
}

; POOL NIAM ;

; emergency stop ctrl+esc
^Esc::
    MsgBox, Emergency Exit Combination Pressed, 2
    log( "force stop")
    ExitApp
Return