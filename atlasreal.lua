local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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

-- CLASSES
local Library = {}
local Page = {}
local Section = {}
local Element = {}
local AtlasConnections = {}

local Window = Rayfield:CreateWindow({
   Name = "Duplication GUI",
   LoadingTitle = "Initializing Duplication",
   LoadingSubtitle = "Stand by...",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

local Tab = Window:CreateTab("Duplication Control")

local RealDupeSection = Tab:CreateSection("Real Duplication Glitch(data does not save)")

RealDupeSection:CreateButton({
    Name = 'Stop data(dupe)',
    Callback = function(Value)
        while true do
            RemoteEvents['SetSettings']:FireServer(Workspace)
            MakeAtlasNotification('Data Stopped', 'Drop anything you want :)', 5)
        end
    end
})

RealDupeSection:CreateButton({
    Name = 'Rejoin Current Server',
    Callback = function(Value)
        MakeAtlasNotification('Rejoining', 'Rejoining the server', 1)
        TeleportService:Teleport(game.PlaceId, player)
    end
})

