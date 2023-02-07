#SingleInstance, Force

; global variables ;

VarArr := [ 1408, 1440, 1471, 1502, 1533, 1564, 1595, 1626, 1657, 1688 ]
VarOff := 30
VarDens := 10

; subroutines ;
return

GoThroughVariants: 
    CoordMode, Mouse, Client
    InputBox, CellCount, How many cells?, How many cells? (row has 10)
    if (CellCount < 1 ){
        MsgBox, Error - CellCount can't be less than 0
        return
    }
     Sleep, 1500
    Click, Left
     Sleep, 500
    Click, Left
     Sleep, 500

    MouseGetPos, X, Y
    loop{
        index := 0
        loop, %VarDens% {
            index += 1
             Sleep, 150 
            
            MouseMove, VarArr[index], Y
             Sleep, 150
            Click, Left

            CellCount -= 1
            if(CellCount = 0){
                return
            }
            ; MouseGetPos X, Y
        }
        Y := Y + VarOff
    }
return

;
; keybinds;
;

; select defaultTesting Layout
^Esc::
    MsgBox, reloading test_variants script
    Reload
Return


; set defaultTesting layout
^t::
    CoordMode, Mouse, Screen
    MouseMove, 2950, 750
     Sleep, 100
    Click, left
    MouseMove, 2850, 890
     Sleep, 100
    Click, left

return


; click on every variant
^y::
    VarArr := [ 1408, 1440, 1471, 1502, 1533, 1564, 1595, 1626, 1657, 1688 ]
    VarOff := 30
    VarDens := 10
    Gosub, GoThroughVariants
return


; click on wider variants
^!y::
    VarArr := [ 1411, 1454, 1493, 1535, 1576, 1617, 1658, 1699 ]
    VarOff := 45
    VarDens := 8
    Gosub, GoThroughVariants
return


