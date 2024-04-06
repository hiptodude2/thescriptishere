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

-- CUSTOM UI LIBRARY WITH ENHANCED STYLING
local CustomUI = {}
CustomUI.__index = CustomUI

function CustomUI.new(name)
    local self = setmetatable({}, CustomUI)
    self.name = name
    self.tabs = {}
    self.window = Instance.new("ScreenGui", Core)
    self.window.Name = name
    self.mainFrame = Instance.new("Frame", self.window)
    self.mainFrame.Size = UDim2.new(0, 600, 0, 500) -- Increased size for enhanced UI experience
    self.mainFrame.Position = UDim2.new(0.5, -300, 0.5, -250) -- Centered with increased size
    self.mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Darker shade for a sleek modern look
    self.mainFrame.BorderSizePixel = 0 -- Border removed for a cleaner appearance

    -- Adding UI corner for smoother rounded corners
    local uiCorner = Instance.new("UICorner", self.mainFrame)
    uiCorner.CornerRadius = UDim.new(0, 12) -- Smoother rounded corners

    -- Adding drop shadow for enhanced depth perception
    local shadow = Instance.new("ImageLabel", self.mainFrame)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Image = "rbxassetid://1316045217" -- Roblox asset for soft shadow
    shadow.ImageTransparency = 0.5 -- Less transparency for a more pronounced shadow
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)

    -- Enhanced UI Control Buttons with hover effects
    local closeButton = Instance.new("TextButton", self.mainFrame)
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 10)
    closeButton.Text = "✖"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 14
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.MouseEnter:Connect(function()
        closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end)
    closeButton.MouseLeave:Connect(function()
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end)
    closeButton.MouseButton1Click:Connect(function()
        self.window:Destroy()
    end)

    local minimizeButton = Instance.new("TextButton", self.mainFrame)
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -70, 0, 10)
    minimizeButton.Text = "─"
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 14
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    minimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    minimizeButton.MouseEnter:Connect(function()
        minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 200, 0)
    end)
    minimizeButton.MouseLeave:Connect(function()
        minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    end)
    minimizeButton.MouseButton1Click:Connect(function()
        self.mainFrame.Visible = false
    end)

    local fullscreenButton = Instance.new("TextButton", self.mainFrame)
    fullscreenButton.Size = UDim2.new(0, 30, 0, 30)
    fullscreenButton.Position = UDim2.new(1, -105, 0, 10)
    fullscreenButton.Text = "☐"
    fullscreenButton.Font = Enum.Font.GothamBold
    fullscreenButton.TextSize = 14
    fullscreenButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    fullscreenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    fullscreenButton.MouseEnter:Connect(function()
        fullscreenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end)
    fullscreenButton.MouseLeave:Connect(function()
        fullscreenButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end)
    fullscreenButton.MouseButton1Click:Connect(function()
        self.mainFrame.Size = UDim2.new(1, 0, 1, 0)
        self.mainFrame.Position = UDim2.new(0, 0, 0, 0)
    end)

    -- Draggable UI with improved responsiveness
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        self.mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    self.mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    self.mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    return self
end

