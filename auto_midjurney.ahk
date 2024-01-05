#SingleInstance, Force
CoordMode, Pixel, Screen
SendMode, Input
SetDefaultMouseSpeed, 5

; GLOBAL VARIABLES ;

RetryDelay := 4000                              ; main loop delay    
LongDelay  := 1000                              ; delay used on waiting for longer animations to finish
ShortDelay := 500                               ; delay used on kepresses or waiting on time-sensitive functions to execute
FormatTime, CurrentDateTime,, dd-MM-yy HH:mm    ; store date and time at start of the script

; SUBROUTINES ;

; find image on screen and click it
FindAndClick( ByRef Success, X1, Y1, X2, Y2, image ){
    WinActivate, ahk_exe Discord.exe
    ImageSearch, OutX, OutY, X1, Y1, X2, Y2, %image%
    if (ErrorLevel = 2){
        MsgBox, 0, Error, Could not conduct the search, 1 
        log( "CRITICAL - FindAndClick - Could not conduct the search - " . image ) ; PRODUCTION LOG - DO NOT DISABLE
        ExitApp
    }
    else if (ErrorLevel = 1){
        log( "WARNING - Image: " . image . "- Not Found" ) ; DEBUG LOG - disable before deployment
        Success := 0
    }
    else{
        CoordMode, Mouse

        MouseMove, OutX+5, OutY+5
        Sleep, %ShortDelay%

        Click, Left
        Sleep, %ShortDelay%
        
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
    Sleep, %RetryDelay%
    SendInput, {Down Up}
}

; try and find templates for upscaling/version generation area 480 70 1470 950
SearchVersionAndUpscale( image_unticked, image_button ){
    WinActivate, ahk_exe Discord.exe
    FindAndClick( Success, 480, 70, 1470, 950, image_unticked )
    if( Success ){
        CoordMode, Mouse
        MouseGetPos, OutX, OutY

        Sleep, %ShortDelay%
        MouseMove, OutX+145, OutY-285
        Click, Left

        MouseMove, OutX+95, OutY-25
        Sleep, %ShortDelay%
        Click, Right

        FindAndClick( Success, 400, 510, 1660, 950, "images\copy-button.png")
        if ( Success ){
            log( "PROMPT - upscale/version procedure in progress"  ) ; PRODUCTION LOG - DO NOT DISABLE

            FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-output-disabled.png")
            if( Success = 0 ){
                FindAndClick( Success, 80, 60, 250, 1000, "images\midjourney-output-messaged.png")
                if( Success = 0 ){
                    log( "ERROR - couldn't find output channel - abandoning attempt") ; PRODUCTION LOG - DO NOT DISABLE
                    FindAndClick(Success, 330, 900, 700, 1000, "images\confirmed-button.png")                            
                    return
                }
            }
            CoordMode, Mouse

            SendInput, {Ctrl Down}{F Down}
            Sleep, %ShortDelay%
            SendInput, od:andrzej99{space}{Ctrl Down}{V Down}{V Up}{Ctrl Up}
            Sleep, %ShortDelay%
            SendInput, {Enter} 

            Sleep, %LongDelay%
            MouseMove, 1555, 200
            Sleep, %ShortDelay%
            MouseClick, Left

            SendInput, {esc}
            Sleep, %ShortDelay%

            MouseMove, 1200, 520
            MouseClick, Left
            Sleep, %ShortDelay%
            Index := 0
            Loop, 5{
                log( "PROMPT - loop itteration " . %A_Index% ) ; DEBUG LOG - disable before deployment
                Index := %Index% + 1
                SendInput, {Down down}{Down up}
                Sleep, %ShortDelay%
                SendInput, {Down down}{Down up}
                Sleep, %ShortDelay%
                SendInput, {Down down}{Down up}
                Sleep, %ShortDelay%

                FindAndClick( Success, 310, 460, 850, 960, image_button ) ; search lower part of a screen for version/upscale buttons
                if( Success ){
                    log( "PROMPT - upscale/version reaction sent successfuly" )
                    break
                }
            }
            
            MsgBox, stopped at searching for button
            log( "PROMPT - upscale/version procedure end" )
        }
    }
}

; INIT ;

Process, Exist, Discord.exe
if (ErrorLevel = 0){
    MsgBox, Discord is not active
    ExitApp
}

if (FileExist("Event.log") != ""){
    FileMove, Event.log, Event.prev, 1    
}

WinActivate ahk_exe Discord.exe
WinMaximize ahk_exe Discord.exe

log( "MESSAGE - script init done" ) ; 

MsgBox, 0, INIT, Discord midjurney request monitoring script. Looking For Messages, 3
Sleep, %RetryDelay%

; MAIN LOOP ;

Loop{
    Sleep, %LongDelay%
    CoordMode, Pixel
    WinActivate ahk_exe Discord.exe

    FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-input-enabled.png")
    if( Success ){
        ; log( "switch to input channel from enabled" ) ; DEBUG LOG - disable before deployment
        CoordMode, Mouse
        WaitForIt()

        ImageSearch, OutX, OutY, 330, 900, 700, 1000, images\process-button.png
        if (ErrorLevel = 2){
            log( "CRITICAL - Could not conduct the search - process-button.png" ) ; PRODUCTION LOG - DO NOT DISABLE
            MsgBox, 0, Error, Could not conduct the search
            ExitApp
        }
        else if( ErrorLevel = 0 ){
            ; MsgBox, 0, Success, The icon was found at %OutX%x%OutY%. process-button.png, 1 ; DEBUG LOG - disable before deployment
            MouseMove, OutX+5, OutY+5
            Sleep, %LongDelay%

            ImageSearch,,, 330, 900, 700, 1000, images\confirmed-button.png
            if ( ErrorLevel = 0 ){
                ; MsgBox, 0, done,  Already done this command, 1 ; DEBUG LOG - disable before deployment
                log( "FLOW - Already done this command" ) ; PRODUCTION LOG - DO NOT DISABLE

                continue
            }
            else if ( ErrorLevel = 1 ){
                log( "WARNING - Image: confirmed-button.png - Not Found" ) ; DEBUG LOG - disable before deployment
            }
            else if ( ErrorLevel = 2 ){
                log( "CRITICAL - Could not conduct the search - confirmed-button.png" ) 
                MsgBox, 0, Error, Could not conduct the search
                ExitApp
            }

            FindAndClick( Success1, OutX-10, OutY-10, OutX+100, OutY+30, "images\reaction-button.png")
            FindAndClick( Success2, OutX-10, OutY-10, OutX+100, OutY+30, "images\reaction-button-blackbar.png")
            if ( Success1 or Success2  ){
                log( "PROMPT -  Found new prompt" ) ; PRODUCTION LOG - DO NOT DISABLE
                CoordMode, Mouse

                Sleep, %ShortDelay%
                MouseMove, OutX+150, OutY-280
                Click, Left

                MouseMove, OutX+100, OutY-20
                Sleep, %ShortDelay%
                Click, Right

                FindAndClick( Success, 400, 510, 1660, 950, "images\copy-button.png")
                if ( Success ){
                    log( "PROMPT - copied" ) ; PRODUCTION LOG - DO NOT DISABLE

                    FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-output-disabled.png")
                    if( Success = 0 ){
                        FindAndClick( Success, 80, 60, 250, 1000, "images\midjourney-output-messaged.png")
                        if( Success = 0 ){
                            log( "ERROR - couldn't find output channel - abandoning attempt") ; PRODUCTION LOG - DO NOT DISABLE
                            FindAndClick(Success, 330, 900, 700, 1000, "images\confirmed-button.png")                            
                            continue
                        }
                    }
                    CoordMode, Mouse
                    MouseMove, 390, 985
                    Sleep, %ShortDelay%
                    Click, Left
                    SendInput, prompt{Space}{Ctrl Down}{V Down}{V Up}{Ctrl Up}
                    Sleep, %ShortDelay%
                    SendInput, {Enter}
                    Sleep, %ShortDelay%
                    SendInput, /imagine{Space}{Ctrl Down}{V Down}{V Up}{Ctrl Up}
                    Sleep, %ShortDelay%
                    SendInput, {Enter}
                    log( "PROMPT - Sent successfuly" )
                }
            }
        }
    }
    else{
        FindAndClick( Success, 80, 80, 250, 1000, "images\midjourney-input-disabled.png")
        ; log( "switch to input channel from diabled" ) ; DEBUG LOG - disable before deployment
    }

    SearchVersionAndUpscale("images\upscale-unticked-1.png", "images\buttons-upscale-1.png")
    ; SearchVersionAndUpscale("images\upscale-unticked-2.png", "images\buttons-upscale-2.png")
    ; SearchVersionAndUpscale("images\upscale-unticked-3.png", "images\buttons-upscale-3.png")
    ; SearchVersionAndUpscale("images\upscale-unticked-4.png", "images\buttons-upscale-4.png")
}

; POOL NIAM ;

; emergency stop ctrl+esc
^Esc::
    MsgBox, 0, EXIT, Emergency Exit Combination Pressed, 2
    log( "MESSAGE - force stop")
    ExitApp
Return