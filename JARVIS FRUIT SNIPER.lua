-- =============================================
-- JARVIS HACKER UI + NEXUSHUB FRUIT SNIPER
-- =============================================

repeat task.wait() until game:IsLoaded()

-- ==================== CONFIGURATION ====================
local API_URL = "https://leah-nonsequacious-unobviously.ngrok-free.dev/serverhop?limit=100"

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes", 9e9)
local CommF = Remotes:WaitForChild("CommF_", 9e9)
local Player = Players.LocalPlayer

-- Settings
getgenv().AutoFruitSniper = true
getgenv().AutoHop = true
getgenv().FruitESP = true
getgenv().TweenSpeed = 300
getgenv().StoreRetries = 3
getgenv().ScanInterval = 0.5

-- Fruit Data (from NexusHub)
local FRUIT_DATA = {
    ["Kitsune Fruit"] = { id = "Kitsune-Kitsune", rarity = "Mythical", color = 16711680 },
    ["Dragon Fruit"] = { id = "Dragon-Dragon", rarity = "Mythical", color = 16711680 },
    ["Leopard Fruit"] = { id = "Leopard-Leopard", rarity = "Mythical", color = 16711680 },
    ["Dough Fruit"] = { id = "Dough-Dough", rarity = "Mythical", color = 16711680 },
    ["Yeti Fruit"] = { id = "Yeti-Yeti", rarity = "Mythical", color = 16711680 },
    ["Gas Fruit"] = { id = "Gas-Gas", rarity = "Mythical", color = 16711680 },
    ["Spirit Fruit"] = { id = "Spirit-Spirit", rarity = "Mythical", color = 16711680 },
    ["Control Fruit"] = { id = "Control-Control", rarity = "Mythical", color = 16711680 },
    ["Venom Fruit"] = { id = "Venom-Venom", rarity = "Mythical", color = 16711680 },
    ["Shadow Fruit"] = { id = "Shadow-Shadow", rarity = "Mythical", color = 16711680 },
    ["Blizzard Fruit"] = { id = "Blizzard-Blizzard", rarity = "Legendary", color = 16711935 },
    ["Portal Fruit"] = { id = "Portal-Portal", rarity = "Legendary", color = 16711935 },
    ["Buddha Fruit"] = { id = "Buddha-Buddha", rarity = "Legendary", color = 16711935 },
    ["Phoenix Fruit"] = { id = "Phoenix-Phoenix", rarity = "Legendary", color = 16711935 },
    ["Magma Fruit"] = { id = "Magma-Magma", rarity = "Rare", color = 3447003 },
    ["Light Fruit"] = { id = "Light-Light", rarity = "Rare", color = 3447003 },
    ["Ice Fruit"] = { id = "Ice-Ice", rarity = "Rare", color = 3447003 },
}

-- ==================== GUI SETUP ====================
if CoreGui:FindFirstChild("JarvisFruitHopper") then CoreGui.JarvisFruitHopper:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JarvisFruitHopper"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 380, 0, 380)
Main.Position = UDim2.new(0, 20, 0, 20)
Main.BackgroundColor3 = Color3.fromRGB(3, 3, 12)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 255, 120)
Stroke.Thickness = 1.8

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(0, 25, 0)
Title.Text = "◉ JARVIS FRUIT HOPPER"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.Font = Enum.Font.Code
Title.TextSize = 14
Title.Parent = Main

-- Stats Frame
local StatsFrame = Instance.new("Frame")
StatsFrame.Size = UDim2.new(1, -12, 0, 50)
StatsFrame.Position = UDim2.new(0, 6, 0, 40)
StatsFrame.BackgroundColor3 = Color3.fromRGB(0, 8, 0)
StatsFrame.BackgroundTransparency = 0.4
StatsFrame.Parent = Main

local HopCountLabel = Instance.new("TextLabel")
HopCountLabel.Size = UDim2.new(0.5, -5, 0.5, 0)
HopCountLabel.Position = UDim2.new(0, 5, 0, 2)
HopCountLabel.BackgroundTransparency = 1
HopCountLabel.Text = "🔄 HOPS: 0"
HopCountLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
HopCountLabel.Font = Enum.Font.Code
HopCountLabel.TextSize = 11
HopCountLabel.TextXAlignment = Enum.TextXAlignment.Left
HopCountLabel.Parent = StatsFrame

local FruitCountLabel = Instance.new("TextLabel")
FruitCountLabel.Size = UDim2.new(0.5, -5, 0.5, 0)
FruitCountLabel.Position = UDim2.new(0, 5, 0, 22)
FruitCountLabel.BackgroundTransparency = 1
FruitCountLabel.Text = "🍎 FRUITS: 0"
FruitCountLabel.TextColor3 = Color3.fromRGB(255, 100, 200)
FruitCountLabel.Font = Enum.Font.Code
FruitCountLabel.TextSize = 11
FruitCountLabel.TextXAlignment = Enum.TextXAlignment.Left
FruitCountLabel.Parent = StatsFrame

local ServerStatus = Instance.new("TextLabel")
ServerStatus.Size = UDim2.new(0.5, -5, 1, 0)
ServerStatus.Position = UDim2.new(0.5, 5, 0, 0)
ServerStatus.BackgroundTransparency = 1
ServerStatus.Text = "🎮 READY"
ServerStatus.TextColor3 = Color3.fromRGB(255, 200, 0)
ServerStatus.Font = Enum.Font.Code
ServerStatus.TextSize = 11
ServerStatus.TextXAlignment = Enum.TextXAlignment.Right
ServerStatus.TextWrapped = true
ServerStatus.Parent = StatsFrame

-- Toggle Buttons
local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, -12, 0, 70)
ToggleFrame.Position = UDim2.new(0, 6, 0, 95)
ToggleFrame.BackgroundColor3 = Color3.fromRGB(0, 8, 0)
ToggleFrame.BackgroundTransparency = 0.4
ToggleFrame.Parent = Main

local function CreateToggle(parent, xPos, yPos, text, settingName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.3, 0, 0, 25)
    btn.Position = UDim2.new(xPos, 0, yPos, 0)
    btn.BackgroundColor3 = getgenv()[settingName] and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(40, 0, 0)
    btn.Text = text .. ": " .. (getgenv()[settingName] and "ON" or "OFF")
    btn.TextColor3 = Color3.fromRGB(0, 255, 100)
    btn.Font = Enum.Font.Code
    btn.TextSize = 10
    btn.Parent = parent
    
    btn.MouseButton1Click:Connect(function()
        getgenv()[settingName] = not getgenv()[settingName]
        btn.BackgroundColor3 = getgenv()[settingName] and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(40, 0, 0)
        btn.Text = text .. ": " .. (getgenv()[settingName] and "ON" or "OFF")
        AddLog(settingName .. " → " .. tostring(getgenv()[settingName]), Color3.fromRGB(0, 255, 200))
    end)
end

CreateToggle(ToggleFrame, 0.02, 5, "FRUIT SNIPE", "AutoFruitSniper")
CreateToggle(ToggleFrame, 0.35, 5, "AUTO HOP", "AutoHop")
CreateToggle(ToggleFrame, 0.68, 5, "FRUIT ESP", "FruitESP")

-- Log Frame
local DebugLog = Instance.new("ScrollingFrame")
DebugLog.Size = UDim2.new(1, -12, 1, -230)
DebugLog.Position = UDim2.new(0, 6, 0, 175)
DebugLog.BackgroundColor3 = Color3.fromRGB(0, 8, 0)
DebugLog.BackgroundTransparency = 0.4
DebugLog.ScrollBarThickness = 3
DebugLog.Parent = Main

local Layout = Instance.new("UIListLayout", DebugLog)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Padding = UDim.new(0, 1)

local function AddLog(text, color)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -8, 0, 16)
    label.BackgroundTransparency = 1
    label.Text = " > " .. os.date("%H:%M:%S") .. " | " .. text
    label.TextColor3 = color or Color3.fromRGB(0, 255, 120)
    label.Font = Enum.Font.Code
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = DebugLog
    DebugLog.CanvasPosition = Vector2.new(0, DebugLog.AbsoluteCanvasSize.Y)
    
    task.delay(35, function()
        if label and label.Parent then label:Destroy() end
    end)
end

-- Draggable
local dragging = false
local dragStart, startPos

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ==================== VARIABLES ====================
local hopCount = 0
local fruitGrabbedCount = 0
local autoHopEnabled = true
local farmingPlatform = nil
local isFarming = false

-- ==================== FARMING PLATFORM ====================
local function SetupFarmingPlatform()
    if farmingPlatform and farmingPlatform.Parent then
        farmingPlatform:Destroy()
    end
    
    farmingPlatform = Instance.new("Part", workspace)
    farmingPlatform.Size = Vector3.new(1, 1, 1)
    farmingPlatform.Name = "JARVIS_Platform"
    farmingPlatform.Anchored = true
    farmingPlatform.CanCollide = false
    farmingPlatform.Transparency = 1
    farmingPlatform.Parent = workspace
end
SetupFarmingPlatform()

local function TweenToPosition(targetCFrame)
    local char = Player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local speed = getgenv().TweenSpeed or 300
    local duration = math.max(distance / speed, 0.2)
    
    farmingPlatform.CFrame = hrp.CFrame
    isFarming = true
    
    local tween = TweenService:Create(farmingPlatform, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Wait()
    return true
end

-- Movement sync
task.spawn(function()
    while true do
        task.wait()
        if isFarming and Player.Character then
            pcall(function()
                local hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and farmingPlatform and farmingPlatform.Parent then
                    hrp.CFrame = farmingPlatform.CFrame
                    hrp.Velocity = Vector3.new(0, 0, 0)
                end
                
                local stun = Player.Character:FindFirstChild("Stun")
                if stun and stun.Value ~= 0 then stun.Value = 0 end
                
                local busy = Player.Character:FindFirstChild("Busy")
                if busy and busy.Value then busy.Value = false end
            end)
        end
    end
end)

-- ==================== FRUIT ESP ====================
local function AddESP(part)
    if not getgenv().FruitESP then return end
    if not part or part:FindFirstChild("JARVIS_ESP") then return end
    
    local folder = Instance.new("Folder", part)
    folder.Name = "JARVIS_ESP"
    
    local billboard = Instance.new("BillboardGui", folder)
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    
    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 100, 255)
    label.Font = Enum.Font.Gothom
    label.TextSize = 12
    label.TextStrokeTransparency = 0.3
    
    task.spawn(function()
        while label and label.Parent and part and part.Parent do
            local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = math.floor((hrp.Position - part.Position).Magnitude)
                label.Text = "🍎 " .. (part.Parent and part.Parent.Name or "Fruit") .. " [" .. dist .. "m]"
            end
            task.wait(0.3)
        end
        if folder then folder:Destroy() end
    end)
end

-- ESP loop
task.spawn(function()
    while true do
        if getgenv().FruitESP then
            for _, obj in pairs(workspace:GetChildren()) do
                pcall(function()
                    if obj and obj.Parent and (obj:IsA("Tool") or string.find(obj.Name, "Fruit")) then
                        local handle = obj:FindFirstChild("Handle")
                        if handle and not handle:FindFirstChild("JARVIS_ESP") then
                            AddESP(handle)
                        end
                    end
                end)
            end
        end
        task.wait(1)
    end
end)

-- ==================== FRUIT SNIPER ====================
local function FindFruits()
    local fruits = {}
    for _, obj in pairs(workspace:GetChildren()) do
        if obj and obj.Parent then
            local isTool = obj:IsA("Tool")
            local hasFruitName = string.find(obj.Name, "Fruit")
            local hasHandle = obj:FindFirstChild("Handle")
            
            if (isTool or hasFruitName) and hasHandle then
                table.insert(fruits, obj)
            end
        end
    end
    return fruits
end

local function GetInventoryFruit()
    for _, container in pairs({Player.Character, Player.Backpack}) do
        if container then
            for _, tool in pairs(container:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("Fruit") then
                    return tool
                end
            end
        end
    end
    return nil
end

local function StoreFruit(fruitTool)
    local fruitName = fruitTool.Name
    local fruitData = FRUIT_DATA[fruitName]
    local fruitId = fruitData and fruitData.id or fruitName:gsub(" Fruit", ""):gsub(" ", "-") .. "-" .. fruitName:gsub(" Fruit", ""):gsub(" ", "-")
    
    for attempt = 1, getgenv().StoreRetries do
        local success, result = pcall(function()
            return CommF:InvokeServer("StoreFruit", fruitId, fruitTool)
        end)
        
        if success and result == true then
            AddLog("📦 Stored: " .. fruitName .. " ✓", Color3.fromRGB(0, 255, 100))
            return true
        end
        task.wait(1)
    end
    
    AddLog("❌ Failed to store: " .. fruitName, Color3.fromRGB(255, 50, 50))
    return false
end

local function CollectFruit(fruit)
    if not fruit or not fruit.Parent then return false end
    
    local handle = fruit:FindFirstChild("Handle")
    if not handle then return false end
    
    local fruitName = fruit.Name
    local fruitData = FRUIT_DATA[fruitName] or { rarity = "Unknown", value = "?" }
    
    AddLog("🎯 Target: " .. fruitName .. " [" .. (fruitData.rarity or "Unknown") .. "]", Color3.fromRGB(255, 100, 255))
    ServerStatus.Text = "🍎 SNIPING..."
    
    -- Fly to fruit
    TweenToPosition(CFrame.new(handle.Position + Vector3.new(0, 8, 0)))
    task.wait(0.3)
    
    TweenToPosition(handle.CFrame)
    task.wait(0.5)
    
    -- Collect loop
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for i = 1, 10 do
            if not fruit.Parent then break end
            hrp.CFrame = handle.CFrame
            farmingPlatform.CFrame = handle.CFrame
            task.wait(0.15)
        end
    end
    
    task.wait(1)
    
    local collected = GetInventoryFruit()
    if collected then
        fruitGrabbedCount = fruitGrabbedCount + 1
        FruitCountLabel.Text = "🍎 FRUITS: " .. fruitGrabbedCount
        AddLog("✨ SUCCESS! Grabbed: " .. collected.Name, Color3.fromRGB(0, 255, 200))
        StoreFruit(collected)
        return true
    end
    
    AddLog("⚠️ Failed to collect fruit", Color3.fromRGB(255, 100, 0))
    return false
end

-- ==================== SERVER HOP ====================
local function ServerHop()
    if not autoHopEnabled or not getgenv().AutoHop then 
        return 
    end
    
    hopCount = hopCount + 1
    HopCountLabel.Text = "🔄 HOPS: " .. hopCount
    ServerStatus.Text = "🚀 HOPPING..."
    
    AddLog("🌐 REQUESTING SERVERS FROM API...", Color3.fromRGB(255, 255, 80))
    
    -- Try ngrok API first
    local success, response = pcall(function()
        return game:HttpGet(API_URL)
    end)
    
    local targetServer = nil
    
    if success then
        local data = HttpService:JSONDecode(response)
        
        if data and data.servers then
            local goodServers = {}
            for _, s in ipairs(data.servers) do
                if s.players and s.players < 12 and s.players > 0 then
                    table.insert(goodServers, s)
                end
            end
            
            AddLog("📡 Found " .. #goodServers .. " good servers", Color3.fromRGB(0, 255, 200))
            
            if #goodServers > 0 then
                table.sort(goodServers, function(a, b) return a.players < b.players end)
                targetServer = goodServers[1]
                AddLog("🎯 Best: " .. targetServer.players .. " players", Color3.fromRGB(0, 255, 255))
            elseif data.servers[1] then
                targetServer = data.servers[1]
                AddLog("⚠️ Random server: " .. targetServer.players .. " players", Color3.fromRGB(255, 180, 50))
            end
        end
    else
        AddLog("⚠️ API failed, using fallback", Color3.fromRGB(255, 180, 50))
    end
    
    -- Fallback: Use Roblox API
    if not targetServer then
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=50"
        local fbSuccess, fbResponse = pcall(function()
            return game:HttpGet(url)
        end)
        
        if fbSuccess then
            local fbData = HttpService:JSONDecode(fbResponse)
            if fbData and fbData.data then
                local best = nil
                for _, server in ipairs(fbData.data) do
                    if server.playing and server.playing < server.maxPlayers and server.playing > 0 then
                        if not best or server.playing < best.playing then
                            best = server
                        end
                    end
                end
                if best then
                    targetServer = {jobId = best.id, players = best.playing}
                    AddLog("📡 Fallback found: " .. best.playing .. " players", Color3.fromRGB(0, 255, 200))
                end
            end
        end
    end
    
    if targetServer then
        isFarming = false
        ServerStatus.Text = "✨ TELEPORTING..."
        AddLog("✨ HOPPING to server...", Color3.fromRGB(0, 255, 255))
        task.wait(0.5)
        TeleportService:TeleportToPlaceInstance(2753915549, targetServer.jobId)
    else
        AddLog("❌ No servers available", Color3.fromRGB(255, 60, 60))
        ServerStatus.Text = "❌ NO SERVER"
    end
end

-- ==================== BUTTONS ====================
local ManualHopBtn = Instance.new("TextButton")
ManualHopBtn.Size = UDim2.new(0.48, 0, 0, 35)
ManualHopBtn.Position = UDim2.new(0.03, 0, 1, -50)
ManualHopBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
ManualHopBtn.Text = "MANUAL HOP"
ManualHopBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
ManualHopBtn.Font = Enum.Font.Code
ManualHopBtn.TextSize = 12
ManualHopBtn.Parent = Main
ManualHopBtn.MouseButton1Click:Connect(function()
    AddLog("🔘 Manual hop triggered", Color3.fromRGB(0, 255, 200))
    ServerHop()
end)

local ResetBtn = Instance.new("TextButton")
ResetBtn.Size = UDim2.new(0.48, 0, 0, 35)
ResetBtn.Position = UDim2.new(0.52, 0, 1, -50)
ResetBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
ResetBtn.Text = "RESET STATS"
ResetBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
ResetBtn.Font = Enum.Font.Code
ResetBtn.TextSize = 12
ResetBtn.Parent = Main
ResetBtn.MouseButton1Click:Connect(function()
    hopCount = 0
    fruitGrabbedCount = 0
    HopCountLabel.Text = "🔄 HOPS: 0"
    FruitCountLabel.Text = "🍎 FRUITS: 0"
    AddLog("📊 Stats reset", Color3.fromRGB(255, 200, 0))
end)

-- ==================== MAIN LOOPS ====================
AddLog("━━━━━━━━━━━━━━━━━━━━━━━━━━", Color3.fromRGB(0, 255, 100))
AddLog("◉ JARVIS FRUIT HOPPER v3.0", Color3.fromRGB(0, 255, 255))
AddLog("━━━━━━━━━━━━━━━━━━━━━━━━━━", Color3.fromRGB(0, 255, 100))
AddLog("✅ NexusHub Fruit Sniper Integrated", Color3.fromRGB(0, 255, 120))

-- Join Marines
task.spawn(function()
    task.wait(3)
    if not Player.Team or Player.Team.Name == "Choosing" then
        AddLog("⚔️ Joining Marines...", Color3.fromRGB(255, 200, 0))
        pcall(function() CommF:InvokeServer("SetTeam", "Marines") end)
        task.wait(2)
    end
    AddLog("✅ Team: " .. (Player.Team and Player.Team.Name or "None"), Color3.fromRGB(0, 255, 100))
end)

-- Auto-hop timer
task.spawn(function()
    while true do
        task.wait(75)
        if autoHopEnabled and getgenv().AutoHop then
            ServerHop()
        end
    end
end)

-- Fruit sniper loop
task.spawn(function()
    while true do
        task.wait(getgenv().ScanInterval)
        
        if not getgenv().AutoFruitSniper then
            ServerStatus.Text = "⏸️ SNIPE OFF"
            task.wait(1)
            continue
        end
        
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
            task.wait(2)
            continue
        end
        
        ServerStatus.Text = "🔍 SCANNING..."
        
        local fruits = FindFruits()
        
        if #fruits == 0 then
            ServerStatus.Text = "❌ NO FRUIT"
            continue
        end
        
        AddLog("🎯 Found " .. #fruits .. " fruit(s)!", Color3.fromRGB(0, 255, 100))
        
        for _, fruit in ipairs(fruits) do
            if fruit and fruit.Parent then
                local collected = CollectFruit(fruit)
                if collected then
                    AddLog("✅ Collection complete!", Color3.fromRGB(0, 255, 100))
                end
                task.wait(1)
            end
        end
        
        isFarming = false
        AddLog("⏳ Waiting 3s...", Color3.fromRGB(200, 200, 0))
        task.wait(3)
    end
end)

-- Status updater
task.spawn(function()
    while true do
        if not getgenv().AutoFruitSniper then
            ServerStatus.Text = "⏸️ SNIPE OFF"
        elseif ServerStatus.Text ~= "🚀 HOPPING..." and ServerStatus.Text ~= "✨ TELEPORTING..." and ServerStatus.Text ~= "🍎 SNIPING..." then
            ServerStatus.Text = "🎮 READY"
        end
        task.wait(3)
    end
end)

AddLog("✅ JARVIS FRUIT HOPPER READY", Color3.fromRGB(0, 255, 100))
AddLog("🎯 Auto-snipe: ON | Auto-hop: ON", Color3.fromRGB(0, 255, 120))
