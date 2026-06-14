-- ============================================
-- JARVIS HUB | POWERED BY NEXUS HUB
-- SELL LEMONS - AUTO COLLECT CASH
-- ============================================

local player = game.Players.LocalPlayer
local root = player.Character and player.Character:WaitForChild("HumanoidRootPart")

local autoCashEnabled = true

-- ========== JARVIS HUB UI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Name = "JarvisHub"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 180)
mainFrame.Position = UDim2.new(0, 10, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Glowing border
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 0, 1, 0)
border.BackgroundTransparency = 1
border.BorderSizePixel = 2
border.BorderColor3 = Color3.fromRGB(0, 255, 100)
border.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.BackgroundTransparency = 0.3
title.Text = "> JARVIS_HUB.EXE"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.Font = Enum.Font.Code
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Nexus Label
local nexusLabel = Instance.new("TextLabel")
nexusLabel.Size = UDim2.new(1, 0, 0, 18)
nexusLabel.Position = UDim2.new(0, 0, 0, 40)
nexusLabel.BackgroundTransparency = 1
nexusLabel.Text = "└─ POWERED BY NEXUS HUB v2.7"
nexusLabel.TextColor3 = Color3.fromRGB(100, 200, 150)
nexusLabel.Font = Enum.Font.Code
nexusLabel.TextSize = 9
nexusLabel.TextXAlignment = Enum.TextXAlignment.Left
nexusLabel.Parent = mainFrame

-- Line
local line = Instance.new("Frame")
line.Size = UDim2.new(1, -20, 0, 1)
line.Position = UDim2.new(0, 10, 0, 62)
line.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
line.BackgroundTransparency = 0.5
line.Parent = mainFrame

-- Module Label
local moduleLabel = Instance.new("TextLabel")
moduleLabel.Size = UDim2.new(1, 0, 0, 22)
moduleLabel.Position = UDim2.new(0, 10, 0, 70)
moduleLabel.BackgroundTransparency = 1
moduleLabel.Text = "> ACTIVE_MODULES"
moduleLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
moduleLabel.Font = Enum.Font.Code
moduleLabel.TextSize = 11
moduleLabel.TextXAlignment = Enum.TextXAlignment.Left
moduleLabel.Parent = mainFrame

-- Auto Cash Module
local cashFrame = Instance.new("Frame")
cashFrame.Size = UDim2.new(1, -20, 0, 35)
cashFrame.Position = UDim2.new(0, 10, 0, 95)
cashFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
cashFrame.BackgroundTransparency = 0.3
cashFrame.BorderSizePixel = 0
cashFrame.Parent = mainFrame

local cashBracket = Instance.new("TextLabel")
cashBracket.Size = UDim2.new(0, 20, 1, 0)
cashBracket.BackgroundTransparency = 1
cashBracket.Text = "["
cashBracket.TextColor3 = Color3.fromRGB(0, 255, 100)
cashBracket.Font = Enum.Font.Code
cashBracket.TextSize = 14
cashBracket.TextXAlignment = Enum.TextXAlignment.Center
cashBracket.Parent = cashFrame

local cashLabel = Instance.new("TextLabel")
cashLabel.Size = UDim2.new(0.6, 0, 1, 0)
cashLabel.Position = UDim2.new(0, 22, 0, 0)
cashLabel.BackgroundTransparency = 1
cashLabel.Text = "> AUTO_CASH_COLLECT"
cashLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
cashLabel.Font = Enum.Font.Code
cashLabel.TextSize = 11
cashLabel.TextXAlignment = Enum.TextXAlignment.Left
cashLabel.Parent = cashFrame

-- Toggle Button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 65, 0, 28)
toggleBtn.Position = UDim2.new(1, -75, 0.5, -14)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 50)
toggleBtn.Text = "[ON]"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.Code
toggleBtn.TextSize = 11
toggleBtn.Parent = cashFrame

-- Status Display
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(1, -20, 0, 35)
statusFrame.Position = UDim2.new(0, 10, 0, 140)
statusFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statusFrame.BackgroundTransparency = 0.4
statusFrame.BorderSizePixel = 1
statusFrame.BorderColor3 = Color3.fromRGB(0, 255, 100)
statusFrame.Parent = mainFrame

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "> AUTO_CASH: ACTIVE"
statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
statusText.Font = Enum.Font.Code
statusText.TextSize = 10
statusText.Parent = statusFrame

-- Exit Button
local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 60, 0, 22)
exitBtn.Position = UDim2.new(1, -70, 1, -28)
exitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
exitBtn.Text = "[EXIT]"
exitBtn.TextColor3 = Color3.new(1, 1, 1)
exitBtn.Font = Enum.Font.Code
exitBtn.TextSize = 10
exitBtn.Parent = mainFrame

-- ========== BUTTON FUNCTIONS ==========
toggleBtn.MouseButton1Click:Connect(function()
    autoCashEnabled = not autoCashEnabled
    toggleBtn.Text = autoCashEnabled and "[ON]" or "[OFF]"
    toggleBtn.BackgroundColor3 = autoCashEnabled and Color3.fromRGB(0, 200, 50) or Color3.fromRGB(150, 0, 0)
    statusText.Text = autoCashEnabled and "> AUTO_CASH: ACTIVE" or "> AUTO_CASH: OFF"
end)

exitBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ========== DRAG FUNCTION ==========
local dragging = false
local dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ========== HACKER DISPLAY (BOTTOM) ==========
local hackerDisplay = Instance.new("TextLabel")
hackerDisplay.Size = UDim2.new(0, 280, 0, 45)
hackerDisplay.Position = UDim2.new(0, 10, 1, -55)
hackerDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hackerDisplay.BackgroundTransparency = 0.3
hackerDisplay.Text = ""
hackerDisplay.TextColor3 = Color3.fromRGB(0, 255, 100)
hackerDisplay.Font = Enum.Font.Code
hackerDisplay.TextSize = 8
hackerDisplay.TextXAlignment = Enum.TextXAlignment.Left
hackerDisplay.TextWrapped = true
hackerDisplay.Parent = screenGui

local hackerMessages = {
    "> SYSTEM_INJECTED",
    "> JARVIS_ONLINE",
    "> NEXUS_CORE_ACTIVE",
    "> COLLECTING_CASH",
    "> ROOT_ACCESS_GRANTED",
}

local binaryChars = {"0", "1", " ", "|", "/", "\\", "-", "_", ">", "#"}

spawn(function()
    local msgIndex = 1
    while screenGui and screenGui.Parent do
        local binary = ""
        for i = 1, 45 do
            binary = binary .. binaryChars[math.random(1, #binaryChars)]
        end
        hackerDisplay.Text = binary .. "\n" .. hackerMessages[msgIndex] .. " >> " .. os.date("%H:%M:%S")
        msgIndex = msgIndex + 1
        if msgIndex > #hackerMessages then msgIndex = 1 end
        task.wait(3)
    end
end)

-- ========== AUTO CASH COLLECTION (YOUR ORIGINAL LOGIC) ==========
spawn(function()
    while screenGui and screenGui.Parent do
        if autoCashEnabled and root and root.Parent then
            pcall(function()
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        local n = v.Name:lower()
                        if n:find("cash") or n:find("money") or n:find("bag") or n:find("drop") then
                            local dist = (v.Position - root.Position).Magnitude
                            if dist < 300 then
                                v.CFrame = root.CFrame * CFrame.new(0, 4, 0)
                                task.wait(0.08)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.8)
    end
end)

-- ========== ANTI AFK ==========
spawn(function()
    while screenGui and screenGui.Parent do
        pcall(function()
            local vu = game:GetService("VirtualUser")
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(0.05)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        task.wait(55)
    end
end)

-- ========== CONSOLE PRINT ==========
print("==========================================")
print("> JARVIS_HUB v1.0 | POWERED BY NEXUS_HUB")
print("> SELL LEMONS - AUTO CASH COLLECT")
print("> STATUS: [ACTIVE]")
print("> CLICK [EXIT] TO CLOSE")
print("==========================================")
