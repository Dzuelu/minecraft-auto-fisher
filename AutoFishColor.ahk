SetWorkingDir %A_ScriptDir%
#SingleInstance Force
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
bobColor:= 0x821A1A
dist:= 150
return

F8::
isLooping:= 1
CreateBox("SearchArea")
CreateBox("FoundArea")
WinGetPos, mineX, mineY, mineW, mineH, Minecraft
searchX:= mineX+(mineW/2)-dist
searchY:= mineY+(mineH/2)-dist
searchDist:= dist*2
DrawBox("SearchArea", searchX, searchY, searchDist, searchDist)
loop {
	PixelSearch, outx, outy, searchX, searchY, searchX+searchDist, searchY+searchDist, bobColor, 20, Fast RGB
	If (ErrorLevel == 1) {
		Sleep, 500
		Click, right
		Sleep, 1000
	} else {
		DrawBox("FoundArea", outx-2, outy-2, 4, 4)
	}
	Sleep, 100
}
RemoveBox("SearchArea")
RemoveBox("FoundArea")
return

F7::
isLooping:= 0
RemoveBox("SearchArea")
RemoveBox("FoundArea")
Reload
return



CreateBox(name, Color="FF0000") {
	Gui %name%1:color, %Color%
	Gui %name%1:+ToolWindow -SysMenu -Caption +AlwaysOnTop +Disabled
	Gui %name%2:color, %Color%
	Gui %name%2:+ToolWindow -SysMenu -Caption +AlwaysOnTop +Disabled
	Gui %name%3:color, %Color%
	Gui %name%3:+ToolWindow -SysMenu -Caption +AlwaysOnTop +Disabled
	Gui %name%4:color, %Color%
	Gui %name%4:+ToolWindow -SysMenu -Caption +AlwaysOnTop +Disabled
}

DrawBox(name, X, Y, W, H, T="1", O="O") {
	If(W < 0)
		X += W, W *= -1
	If(H < 0)
		Y += H, H *= -1
	If(T >= 2) {
		If(O == "O")
			X -= T, Y -= T, W += T, H += T
		If(O == "C")
			X -= T / 2, Y -= T / 2
		If(O == "I")
			W -= T, H -= T
	}
	Gui, %name%1:Show, % "x" X " y" Y " w" W " h" T " NA", Horizontal 1
	Gui, %name%2:Show, % "x" X " y" Y + H " w" W " h" T " NA", Horizontal 2
	Gui, %name%3:Show, % "x" X " y" Y " w" T " h" H " NA", Vertical 1
	Gui, %name%4:Show, % "x" X + W " y" Y " w" T " h" H " NA", Vertical 2
}

RemoveBox(name) {
	Gui %name%1:Destroy
	Gui %name%2:Destroy
	Gui %name%3:Destroy
	Gui %name%4:Destroy
}
