#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
setBranch = ""
setCommit = ""

; :shrug: ¯\_(ツ)_/¯
:B0:`:shrug::
	if (A_EndChar == ":") {
		shrug: 
		SendInput, {BS 7}¯\_(ツ)_/¯
	}
return


; :whatever: ◔_◔
:B0:`:whatever::
	if (A_EndChar == ":") {
		SendInput, {BS 10}◔_◔
	}
return


; :whyy: щ(ºДºщ)
:B0:`:whyy::
	if (A_EndChar == ":") {
		SendInput, {BS 6}щ(ºДºщ)
	}
return


; :happy: (ﾟヮﾟ)
:B0:`:happy::
	if (A_EndChar == ":") {
		SendInput, {BS 7}(ﾟヮﾟ)
	}
return


; :flip:  (╯°□°）╯︵ ┻━┻
:B0:`:flip::
	if (A_EndChar == ":") {
		SendInput, {BS 6}(╯°□°）╯︵ ┻━┻
	}
return

^b::
	InputBox, setBranch, Branch name:, Branch name:
	InputBox, setCommit, Commit hash:, Commit hash: 
return

:b0:`:branch::
    if (A_EndCHar == ":") {
        SendInput, {BS 8}Branch: %setBranch%{Enter}Commit: %setCommit%{Enter}
    }

return