-- =============================================
-- JARVIS HUB - LIGHTWEIGHT EDITION
-- All Functions | Small UI | No Lag
-- =============================================

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local API_URL = "https://leah-nonsequacious-unobviously.ngrok-free.dev/serverhop?limit=25"

-- ========== STATE ==========
local autoHopActive = false
local mirageActive = false
local fruitSniperActive = false
local autoHopLoop = nil
local mirageLoop = nil
local sniperLoop = nil

-- ========== FRUIT SNIPER ==========
local SNIPER_CONFIG = {
    SnipeRange = 100000,
    TeleportHeight = 8,
    DelayBetweenSnipes = 0.6,
    AutoStoreAfter = true,
    PriorityOnly = false,
}

local PRIORITY_FRUITS = {
    "Dragon", "Kitsune", "Dough", "Mammoth", "T-Rex", "Yeti",
    "Venom", "Gas", "Spirit", "Portal", "Control", "Shadow", "Phoenix"
}

-- ========== WARNING MESSAGES ==========
local warnings = {
    "⚠️ USE AT YOUR OWN RISK",
    "⚠️ NOT RESPONSIBLE FOR BANS",
    "⚠️ RESPECT OTHER PLAYERS",
    "⚠️ DON'T ABUSE THE SCRIPT",
}

-- ========== CREATE GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Jarvis"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ JARVIS HUB ⚡"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Warning Area
local warningFrame = Instance.new("Frame")
warningFrame.Size = UDim2.new(0.9, 0, 0, 35)
warningFrame.Position = UDim2.new(0.05, 0, 0, 48)
warningFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
warningFrame.BackgroundTransparency = 0.3
warningFrame.BorderSizePixel = 0
warningFrame.Parent = mainFrame

local warningCorner = Instance.new("UICorner")
warningCorner.CornerRadius = UDim.new(0, 6)
warningCorner.Parent = warningFrame

local warningText = Instance.new("TextLabel")
warningText.Size = UDim2.new(1, 0, 1, 0)
warningText.BackgroundTransparency = 1
warningText.Text = "⚠️ USE AT YOUR OWN RISK"
warningText.TextColor3 = Color3.fromRGB(255, 150, 100)
warningText.TextSize = 10
warningText.Font = Enum.Font.GothamBold
warningText.Parent = warningFrame

-- Rotate warnings
local warningIndex = 1
task.spawn(function()
    while true do
        task.wait(5)
        warningIndex = warningIndex % #warnings + 1
        warningText.Text = warnings[warningIndex]
    end
end)

-- Product Text (Scrolling)
local productText = Instance.new("TextLabel")
productText.Size = UDim2.new(0.9, 0, 0, 18)
productText.Position = UDim2.new(0.05, 0, 0, 88)
productText.BackgroundTransparency = 1
productText.Text = "◈ A PRODUCT OF JARVIS SCRIPT ◈"
productText.TextColor3 = Color3.fromRGB(0, 200, 255)
productText.TextSize = 8
productText.Font = Enum.Font.Gotham
productText.Parent = mainFrame

-- Scroll product text
task.spawn(function()
    local chars = {}
    for i = 1, #productText.Text do
        chars[i] = string.sub(productText.Text, i, i)
    end
    while true do
        table.insert(chars, 1, table.remove(chars))
        productText.Text = table.concat(chars)
        task.wait(0.12)
    end
end)

-- Status Bar
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(0.9, 0, 0, 28)
statusFrame.Position = UDim2.new(0.05, 0, 0, 112)
statusFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
statusFrame.BackgroundTransparency = 0.3
statusFrame.BorderSizePixel = 0
statusFrame.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 1, 0)
statusLabel.Position = UDim2.new(0, 5, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "STATUS: READY"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = statusFrame

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 8, 0, 8)
statusDot.Position = UDim2.new(1, -15, 0.5, -4)
statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
statusDot.BorderSizePixel = 0
statusDot.Parent = statusFrame

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = statusDot

task.spawn(function()
    while true do
        statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(0.5)
        statusDot.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
        task.wait(0.5)
    end
end)

-- ========== BUTTONS ==========
local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(0.9, 0, 0, 200)
buttonFrame.Position = UDim2.new(0.05, 0, 0, 150)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = mainFrame

local function createBtn(text, yPos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = color or Color3.fromRGB(40, 40, 60)
    btn.BackgroundTransparency = 0.2
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = buttonFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    return btn
end

local hopBtn = createBtn("🚀 HOP NOW", 0, Color3.fromRGB(0, 120, 200))
local autoBtn = createBtn("🔄 AUTO HOP: OFF", 39, Color3.fromRGB(60, 60, 100))
local mirageBtn = createBtn("🔍 MIRAGE HUNTER: OFF", 78, Color3.fromRGB(60, 60, 100))
local fruitBtn = createBtn("🍎 FRUIT SNIPER: OFF", 117, Color3.fromRGB(60, 60, 100))
local priorityBtn = createBtn("⭐ PRIORITY MODE: OFF", 156, Color3.fromRGB(60, 60, 100))

-- Binary Display
local binaryFrame = Instance.new("Frame")
binaryFrame.Size = UDim2.new(0.9, 0, 0, 20)
binaryFrame.Position = UDim2.new(0.05, 0, 0, 360)
binaryFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
binaryFrame.BackgroundTransparency = 0.3
binaryFrame.BorderSizePixel = 0
binaryFrame.Parent = mainFrame

local binaryCorner = Instance.new("UICorner")
binaryCorner.CornerRadius = UDim.new(0, 5)
binaryCorner.Parent = binaryFrame

local binaryText = Instance.new("TextLabel")
binaryText.Size = UDim2.new(1, -10, 1, 0)
binaryText.Position = UDim2.new(0, 5, 0, 0)
binaryText.BackgroundTransparency = 1
binaryText.Text = "BIN: 10101010 | HEX: 0xAA"
binaryText.TextColor3 = Color3.fromRGB(0, 200, 100)
binaryText.TextSize = 9
binaryText.Font = Enum.Font.Gotham
binaryText.TextXAlignment = Enum.TextXAlignment.Left
binaryText.Parent = binaryFrame

task.spawn(function()
    while true do
        local bin = ""
        for i = 1, 8 do bin = bin .. math.random(0, 1) end
        binaryText.Text = "BIN: " .. bin .. " | HEX: 0x" .. string.format("%02X", math.random(0, 255))
        task.wait(0.8)
    end
end)

-- ========== CORE FUNCTIONS ==========
local function updateStatus(msg, isError)
    statusLabel.Text = "STATUS: " .. msg
    if isError then
        statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        statusDot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    end
    task.wait(0.1)
    if not isError and not autoHopActive and not mirageActive and not fruitSniperActive then
        statusLabel.Text = "STATUS: READY"
    end
end

-- SERVER HOP
local function serverHop()
    updateStatus("FETCHING SERVERS...")
    
    local success, response = pcall(function()
        return game:HttpGet(API_URL)
    end)
    
    if not success then
        updateStatus("API ERROR", true)
        return
    end
    
    local success2, data = pcall(function()
        return HttpService:JSONDecode(response)
    end)
    
    if not success2 or not data.success then
        updateStatus("API ERROR", true)
        return
    end

    local best = nil
    for _, s in ipairs(data.servers or {}) do
        if s.players and s.players > 0 and s.players < 12 then
            best = s
            break
        end
    end
    if not best and data.servers and data.servers[1] then best = data.servers[1] end

    if best then
        updateStatus("HOPPING TO " .. best.players .. " PLAYERS")
        task.wait(0.3)
        TeleportService:TeleportToPlaceInstance(2753915549, best.jobId)
    else
        updateStatus("NO SERVERS", true)
        task.wait(1)
        updateStatus("READY")
    end
end

-- MIRAGE
local function checkMirage()
    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj.Name:lower():find("mirage") then
            updateStatus("MIRAGE FOUND!")
            for i = 1, 3 do
                mainFrame.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
                task.wait(0.1)
                mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                task.wait(0.1)
            end
            return true
        end
    end
    return false
end

-- FRUIT SNIPER
local function isPriorityFruit(name)
    if SNIPER_CONFIG.PriorityOnly then
        for _, p in ipairs(PRIORITY_FRUITS) do
            if name:lower():find(p:lower()) then return true end
        end
        return false
    end
    return true
end

local function findFruits()
    local fruits = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("fruit") then
            local root = obj:FindFirstChild("Handle") or obj.PrimaryPart
            if root then
                table.insert(fruits, {root = root, name = obj.Name})
            end
        end
    end
    return fruits
end

local function snipeFruit(fruit)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    updateStatus("SNIPING: " .. fruit.name)
    hrp.CFrame = fruit.root.CFrame * CFrame.new(0, 8, 0)
    task.wait(0.3)
    
    local prompt = fruit.root:FindFirstChildWhichIsA("ProximityPrompt")
    if prompt then pcall(function() fireproximityprompt(prompt) end) end
    
    if SNIPER_CONFIG.AutoStoreAfter then
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "All") end)
    end
end

-- ========== TOGGLES ==========
local function toggleAutoHop()
    autoHopActive = not autoHopActive
    if autoHopActive then
        autoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        autoBtn.Text = "🔄 AUTO HOP: ON"
        updateStatus("AUTO HOP ACTIVE")
        autoHopLoop = task.spawn(function()
            while autoHopActive do
                for i = 120, 1, -1 do
                    if not autoHopActive then break end
                    autoBtn.Text = "🔄 AUTO: " .. i .. "s"
                    task.wait(1)
                end
                if autoHopActive then serverHop() end
            end
            autoBtn.Text = "🔄 AUTO HOP: OFF"
        end)
    else
        autoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
        autoBtn.Text = "🔄 AUTO HOP: OFF"
        updateStatus("READY")
        if autoHopLoop then task.cancel(autoHopLoop) end
    end
end

local function toggleMirage()
    mirageActive = not mirageActive
    if mirageActive then
        mirageBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        mirageBtn.Text = "🔍 MIRAGE: ON"
        updateStatus("MIRAGE ACTIVE")
        mirageLoop = task.spawn(function()
            while mirageActive do
                checkMirage()
                task.wait(6)
            end
        end)
    else
        mirageBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
        mirageBtn.Text = "🔍 MIRAGE: OFF"
        updateStatus("READY")
        if mirageLoop then task.cancel(mirageLoop) end
    end
end

local function toggleFruitSniper()
    fruitSniperActive = not fruitSniperActive
    if fruitSniperActive then
        fruitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        fruitBtn.Text = "🍎 FRUIT: ON"
        updateStatus("FRUIT SNIPER ACTIVE")
        sniperLoop = task.spawn(function()
            while fruitSniperActive do
                local fruits = findFruits()
                for _, fruit in ipairs(fruits) do
                    if isPriorityFruit(fruit.name) then
                        snipeFruit(fruit)
                        task.wait(SNIPER_CONFIG.DelayBetweenSnipes)
                        break
                    end
                end
                task.wait(1)
            end
        end)
    else
        fruitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
        fruitBtn.Text = "🍎 FRUIT: OFF"
        updateStatus("READY")
        if sniperLoop then task.cancel(sniperLoop) end
    end
end

local function togglePriority()
    SNIPER_CONFIG.PriorityOnly = not SNIPER_CONFIG.PriorityOnly
    if SNIPER_CONFIG.PriorityOnly then
        priorityBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        priorityBtn.Text = "⭐ PRIORITY: ON"
        updateStatus("PRIORITY MODE ON")
    else
        priorityBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
        priorityBtn.Text = "⭐ PRIORITY: OFF"
        updateStatus("PRIORITY MODE OFF")
    end
end

-- ========== CONNECT BUTTONS ==========
hopBtn.MouseButton1Click:Connect(serverHop)
autoBtn.MouseButton1Click:Connect(toggleAutoHop)
mirageBtn.MouseButton1Click:Connect(toggleMirage)
fruitBtn.MouseButton1Click:Connect(toggleFruitSniper)
priorityBtn.MouseButton1Click:Connect(togglePriority)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- ========== DRAG ==========
local dragging, dragStart, startPos = false
mainFrame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = mainFrame.Position
    end
end)
mainFrame.InputEnded:Connect(function() dragging = false end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("=========================================")
print("⚡ JARVIS HUB - LIGHTWEIGHT EDITION ⚡")
print("=========================================")
print("✅ HOP NOW - Instant server hop")
print("✅ AUTO HOP - Auto hops every 120s")
print("✅ MIRAGE HUNTER - Scans for Mirage")
print("✅ FRUIT SNIPER - Auto collects fruits")
print("✅ PRIORITY MODE - Only good fruits")
print("=========================================")
