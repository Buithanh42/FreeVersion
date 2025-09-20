--// Loading UI Script
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Background mờ
local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
bg.BackgroundTransparency = 0
bg.Parent = screenGui

-- Khung container
local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.fromScale(0.5, 0.5)
container.Size = UDim2.new(0, 400, 0, 100)
container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
container.Parent = bg

local corner = Instance.new("UICorner", container)
corner.CornerRadius = UDim.new(0, 12)

-- Avatar góc
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.fromOffset(64, 64)
avatar.Position = UDim2.new(0, -80, 0.5, -32)
avatar.BackgroundTransparency = 1
avatar.Image = "rbxassetid://80896980458454"
avatar.Parent = container

-- Thanh progress
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(1, -20, 0, 20)
progressBar.Position = UDim2.new(0, 10, 1, -30)
progressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
progressBar.Parent = container

local barCorner = Instance.new("UICorner", progressBar)
barCorner.CornerRadius = UDim.new(0, 6)

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
progressFill.Parent = progressBar

local fillCorner = Instance.new("UICorner", progressFill)
fillCorner.CornerRadius = UDim.new(0, 6)

-- Text %
local percentText = Instance.new("TextLabel")
percentText.AnchorPoint = Vector2.new(0.5, 0)
percentText.Position = UDim2.new(0.5, 0, 1, 0)
percentText.Size = UDim2.new(0, 200, 0, 30)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.Font = Enum.Font.GothamBold
percentText.TextSize = 20
percentText.TextColor3 = Color3.fromRGB(255, 255, 255)
percentText.Parent = container

-- Hàm update loading
local function UpdateProgress(percent)
	percent = math.clamp(percent, 0, 100)
	local targetScale = percent / 100
	TweenService:Create(progressFill, TweenInfo.new(0.2), {
		Size = UDim2.new(targetScale, 0, 1, 0)
	}):Play()
	percentText.Text = tostring(percent) .. "%"
end

-- Demo chạy loading
task.spawn(function()
	for i = 0, 100, 2 do
		UpdateProgress(i)
		task.wait(0.05)
	end
	
	-- Fade out khi xong
	TweenService:Create(container, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
	TweenService:Create(bg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
	task.wait(0.7)
	screenGui:Destroy()
end)
