wait()
local cam = workspace.CurrentCamera
local cam2 = game.Workspace.cam----- gets your character's camera
local player = game.Players.LocalPlayer  ---- finds a player

repeat wait() until player.Character ----- waiting until the character is found

cam.CameraType = "Scriptable" ----- makes sure that the camera is changable

cam.CFrame =  cam2.CFrame --- workspace.Cam is the location of the camera brick, your camera will be facing the front surface of the brick