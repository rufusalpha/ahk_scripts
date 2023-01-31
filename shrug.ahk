#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
setBranch = ""
setCommit = ""

varPathToRepoC = C:\HF-Repo\HouseFlipperRelease
varPathToRepoE = E:\HF-Repo\HouseFlipperRelease

ReadRepository( pathToRepo, byref outputBranch, byref outputCommit ){
	FileReadLine, temp, %pathToRepo%\.git\HEAD, 1
	outputBranch := SubStr(temp, 17)
	FileReadLine, tempCommit, %pathToRepo%\.git\FETCH_HEAD, 1
	StringLeft, outputCommit, tempCommit, 8
}
	
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

^0::
	InputBox, setBranch, Branch:, Brnach:
	InputBox, setCommit, Commit:, Commit: 
Return

^1::
	ReadRepository( varPathToRepoC, setBranch, setCommit )
Return

^2::
	ReadRepository( varPathToRepoE, setBranch, setCommit )
Return

:b0:`:branch::
    if (A_EndCHar == ":") {
        SendInput, {BS 8}Branch: %setBranch%{Enter}Commit: %setCommit%{Enter}
    }

return

:b0:`:branchc::
	ReadRepository( varPathToRepoC, setBranch, setCommit )
    if (A_EndCHar == ":") {
        SendInput, {BS 8}Branch: %setBranch%{Enter}Commit: %setCommit%{Enter}
    }

return

:b0:`:standup::
	if( A_EndChar == ":"){
		SendInput,	{BS 9}**Artur**{Shift Down}{enter}{Shift Up}
		SendInput,	Ostatnio:{Shift Down}{enter}{Shift Up}
		SendInput,	Dziś:{Shift Down}{enter}{Shift Up}
		SendInput,	{Shift Down}{enter}{Shift Up}**DrMan**{Shift Down}{enter}{Shift Up}
		SendInput,	Ostatnio:{Shift Down}{enter}{Shift Up}
		SendInput,	Dziś:{Shift Down}{enter}{Shift Up}
		SendInput,	{Shift Down}{enter}{Shift Up}**Klima**{Shift Down}{enter}{Shift Up}
		SendInput,	Ostatnio:{Shift Down}{enter}{Shift Up}
		SendInput,	Dziś:{Shift Down}{enter}{Shift Up}
		SendInput,	{Shift Down}{enter}{Shift Up}**Wierzbd**{Shift Down}{enter}{Shift Up}
		SendInput,	Ostatnio:{Shift Down}{enter}{Shift Up}
		SendInput,	Dziś:
	}
return

^!b::
	MsgBox, Branch: %setBranch% `nCommit: %setCommit%
return

^!s::
	Run, explore "%appdata%/../locallow"
return