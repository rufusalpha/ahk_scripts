#SingleInstance, Force
CoordMode, Pixel, Screen
SendMode, Input
SetDefaultMouseSpeed, 5

; global variables ;

RetryDelay := 3000                             ; 10 seconds
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
        ; MsgBox, 0, Error, Icon could not be found on the screen. %image%, 1 ; DEBUG LOG - disable before deployment
        log( image . " Not Found" )
        Success := 0
    }
    else{
        ; MsgBox, 0, Success, The icon was found at %OutX%x%OutY%. %image%, 1 ; DEBUG LOG - disable before deployment

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
    CoordMode, Pixel
    WinActivate ahk_exe Discord.exe
    log( "loop start" )

    FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-input-enabled.png")
    if( Success ){
        ; log( "switch to input channel from enabled" ) ; DEBUG LOG - disable before deployment
        CoordMode, Mouse
        WaitForIt()

        ImageSearch, OutX, OutY, 330, 900, 700, 1000, images\process-button.png
        if (ErrorLevel = 2){
            log( "Could not conduct the search - process-button.png" )
            MsgBox, 0, Error, Could not conduct the search
            ExitApp
        }
        else if( ErrorLevel = 0 ){
            ;MsgBox, 0, Success, The icon was found at %OutX%x%OutY%. process-button.png, 1 ; DEBUG LOG - disable before deployment
            MouseMove, OutX+5, OutY+5
            Sleep, 1000

            ImageSearch,,, 330, 900, 700, 1000, images\confirmed-button.png
            if ( ErrorLevel = 0 ){
                ; MsgBox, 0, done,  Already done this command, 1 ; DEBUG LOG - disable before deployment
                log( "Already done this command" ) ; DEBUG LOG - disable before deployment
                continue
            }
            else if ( ErrorLevel = 1 ){
                log( "confirmed-button.png Not Found" ) ; DEBUG LOG - disable before deployment
            }
            else if ( ErrorLevel = 2 ){
                log( "Could not conduct the search - confirmed-button.png" ) 
                MsgBox, 0, Error, Could not conduct the search
                ExitApp
            }

            FindAndClick( Success1, OutX-10, OutY-10, OutX+100, OutY+30, "images\reaction-button.png")
            FindAndClick( Success2, OutX-10, OutY-10, OutX+100, OutY+30, "images\reaction-button-blackbar.png")
            if ( Success1 or Success2  ){
                ; MsgBox, 0, Success, Found Recation - Proceed with copying, 1
                CoordMode, Mouse

                Sleep, 350
                MouseMove, OutX+150, OutY-280
                Click, Left

                MouseMove, OutX+100, OutY-20
                Sleep, 100
                Click, Right

                FindAndClick( Success, 400, 510, 1660, 950, "images\copy-button.png")
                if ( Success ){
                    log( "message copied" ) ; DEBUG LOG - disable before deployment

                    FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-output-disabled.png")
                    if( Success = 0 ){
                        FindAndClick( Success, 80, 60, 250, 1000, "images\midjourney-output-messaged.png")
                        if( Success = 0 ){
                            log( "couldn't find output channel - abandoning attempt") ; DEBUG LOG - disable before deployment

                            FindAndClick(Success, 330, 900, 700, 1000, "images\confirmed-button.png")
                            if( Success = 0 ){
                                log( "error - confirmed button" )
                            }                            
                            continue
                        }
                    }
                    CoordMode, Mouse
                    MouseMove, 390, 985
                    Sleep, 100
                    Click, Left

                    SendInput, /imagine{Space}{Ctrl Down}{V Down}{V Up}{Ctrl Up}
                    Sleep, 100
                    SendInput, {Enter}
                    log( "message pasted" )
                }
            }
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