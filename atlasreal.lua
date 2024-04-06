-- SERVICES
local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local Run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Core = game:GetService("CoreGui")
local MP = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local RemoteEvents = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents")

-- VARIABLES
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Load the custom UI library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/slf0Dev/Ocerium_Project/main/Library.lua"))()
local Window = Library.Main("AtlasReal UI","LeftShift") -- Change "LeftShift" to the key you want to hide the GUI

-- Create a tab for the Dupe feature
local DupeTab = Window.NewTab("Duplication")
local DupeSection = DupeTab.NewSection("Real Duplication Glitch")

-- Add the Dupe button using the library
DupeSection:CreateButton({
    Name = 'Stop data(dupe)',
    Callback = function(Value)
        RemoteEvents['SetSettings']:FireServer(Workspace)
        Library.MakeNotification('Data Stopped', 'Drop anything you want :)', 5)
    end
})
