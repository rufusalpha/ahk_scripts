; select defaultTesting Layout
^t::
    CoordMode, Mouse, Screen
    MouseMove, 2950, 750
    Click, left
    MouseMove, 2850, 890
    Click, left

return


; click on every variant
^y::
    CoordMode, Mouse, Screen
    InputBox, CellCount, How many cells?, How many cells? (row has 10)
     Sleep, 1500
    Click, Left
     Sleep, 500
    Click, Left
     Sleep, 500

    MouseGetPos, X, Y
    arr := [ 2486, 2518, 2550, 2581, 2614, 2644, 2675, 2706, 2737, 2769 ]
    loop{
        index := 0
        loop, 10 {
            index += 1
             Sleep, 150 
            MouseMove, arr[index], Y   
             Sleep, 150
            Click, Left
            CellCount -= 1
            if(CellCount = 0)
                return
        }
        Y := Y+30
    }
return

^!y::
    CoordMode, Mouse, Screen
    InputBox, CellCount, How many cells?, How many cells? (row has 10)
     Sleep, 1500
    Click, Left
     Sleep, 500
    Click, Left
     Sleep, 500

    MouseGetPos, X, Y
    arr := [ 2489, 2532, 2571, 2613, 2654, 2696, 2738 ]
    index := 0
    loop, 10 {
        index += 1
         Sleep, 150 
        MouseMove, arr[index], Y   
         Sleep, 150
        Click, Left       
    }
Return
