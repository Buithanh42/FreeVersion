--// Dịch vụ
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart") or player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")

--// UI Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

--// Window UI
local Window = Fluent:CreateWindow({
    Title = "LH-HUB | ITEMS",
    SubTitle = "by havanlong_",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local tab = Window:AddTab({ Title = "Main", Icon = "📍" })
local section = tab:AddSection("Điều khiển")

-- Toggle 1: Teleport đến 1 điểm cố định
local teleportPosition = Vector3.new(1.579, 17.093, 183.593)
_G.TeleportOne = false

local function teleportSingle()
    while _G.TeleportOne do
        hrp.CFrame = CFrame.new(teleportPosition)
        print("Tele đến:", teleportPosition)
        task.wait(0.5)
    end
end

section:AddToggle("SingleTeleport", {
    Title = "item can cau",
    Default = false,
    Callback = function(value)
        _G.TeleportOne = value
        if value then
            teleportSingle()
        end
    end
})

-- Toggle 2: Teleport tuần tự đến nhiều tọa độ và ấn E
_G.TeleportSequence = false

local positions = {
    Vector3.new(0.298, 19.516, 166.106),    -- A
    Vector3.new(198.199, 31.235, 95.160),   -- B
    Vector3.new(143.453, 25.021, -154.782), -- C
    Vector3.new(360.584, 51.135, -282.870), -- D
    Vector3.new(77.681, 67.028, -565.773),  -- E
    Vector3.new(-245.045, 67.512, -442.425),-- F
    Vector3.new(-287.766, 48.158, -240.570),-- G
    Vector3.new(-260.206, 67.654, -87.532)  -- Y
}

local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    print("Đã nhấn E")
end

local function teleportSequence()
    while _G.TeleportSequence do
        for _, pos in ipairs(positions) do
            if not _G.TeleportSequence then break end
            hrp.CFrame = CFrame.new(pos)
            print("Tele đến:", pos)
            task.wait(0.5) -- đợi ổn định vị trí
            pressE()
            task.wait(2) -- Delay 2 giây trước khi đến điểm tiếp theo
        end
        task.wait(2)
    end
end

section:AddToggle("SequenceTeleport", {
    Title = "item canhs",
    Default = false,
    Callback = function(value)
        _G.TeleportSequence = value
        if value then
            teleportSequence()
        end
    end
})

-- Nút Rejoin ngay lập tức
section:AddButton({
    Title = "item 3",
    Callback = function()
        local placeId = game.PlaceId
        local jobId = game.JobId
        if #jobId > 0 then
            TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
        else
            TeleportService:Teleport(placeId, player)
        end
    end
})

_G.VotingAll = false

local function doVotingAll()
    local Voting = game:GetService("ReplicatedStorage")
        :WaitForChild("Systems")
        :WaitForChild("Voting")
        :WaitForChild("SubmitRiaVote")

    -- Base 1
    hrp.CFrame = CFrame.new(56.156, 21.811, -317.432)
    task.wait(1)
    local votesBase1 = {
        {"Best New Experience", "Grow A Garden"},
        {"People's Choice", "RIVALS"},
        {"Best UGC Creator", "Yourius"},
        {"Best Video Star", "Vindooly"},
    }
    for _, args in ipairs(votesBase1) do
        Voting:InvokeServer(unpack(args))
        task.wait(0.2)
    end

    -- Base 2
    hrp.CFrame = CFrame.new(67.178, 21.811, -372.871)
    task.wait(1)
    local votesBase2 = {
        {"Best Roleplay & Avatar Sim Experience", "a dusty trip"},
        {"Best Action Experience", "Blox Fruits"},
        {"Best Shooter Experience", "Gunfight Arena"},
        {"Best RPG Experience", "Dungeon Heroes"},
        {"Best Horror Experience", "99 Nights in the Forest"},
    }
    for _, args in ipairs(votesBase2) do
        Voting:InvokeServer(unpack(args))
        task.wait(0.2)
    end

    -- Base 3
    hrp.CFrame = CFrame.new(-63.968, 21.811, -314.848)
    task.wait(1)
    local votesBase3 = {
        {"Best Adventure Experience", "Expedition Antarctica"},
        {"Best Obby & Platformer Experience", "Slap Tower"},
        {"Best Party & Casual Experience", "Blade Ball"},
        {"Best Survival Experience", "Creatures of Sonaria"},
    }
    for _, args in ipairs(votesBase3) do
        Voting:InvokeServer(unpack(args))
        task.wait(0.2)
    end

    -- Base 4
    hrp.CFrame = CFrame.new(-67.387, 21.811, -369.959)
    task.wait(1)
    local votesBase4 = {
        {"Best Sports Experience", "Volleyball Legend"},
        {"Best Simulation Experience", "Emergency Response: Liberty County"},
        {"Best Puzzle Experience", "PIG 64"},
        {"Best Racing Experience", "Drive World"},
        {"Best Strategy Experience", "Conquer The World"},
    }
    for _, args in ipairs(votesBase4) do
        Voting:InvokeServer(unpack(args))
        task.wait(0.2)
    end

    print("ok all")

    -- Rejoin server
    local placeId = game.PlaceId
    local jobId = game.JobId
    if #jobId > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, jobId, player)
    else
        game:GetService("TeleportService"):Teleport(placeId, player)
    end
end

section:AddToggle("VotingAllToggle", {
    Title = "Item 4",
    Default = false,
    Callback = function(value)
        _G.VotingAll = value
        if value then
            task.spawn(doVotingAll)
        end
    end
})

-- Save config
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:BuildConfigSection(tab)
SaveManager:LoadAutoloadConfig()