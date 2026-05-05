-- NEZUT HUB v4 🔥 TAB MENU
local player = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "NezutHub"

-- nút mở hub
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0,110,0,35)
openBtn.Position = UDim2.new(0,10,0,200)
openBtn.Text = "OPEN HUB"
openBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
openBtn.TextColor3 = Color3.new(1,1,1)

-- khung chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,420,0,260)
frame.Position = UDim2.new(0.5,-210,0.5,-130)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,30)
close.Position = UDim2.new(1,-45,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(170,0,0)
close.TextColor3 = Color3.new(1,1,1)

close.MouseButton1Click:Connect(function() frame.Visible=false end)
openBtn.MouseButton1Click:Connect(function() frame.Visible=true end)

-- tiêu đề
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "🔥 NEZUT HUB v4"
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

-- menu tabs
local tabFrame = Instance.new("Frame", frame)
tabFrame.Size = UDim2.new(0,120,1,-40)
tabFrame.Position = UDim2.new(0,0,0,40)
tabFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)

local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1,-120,1,-40)
content.Position = UDim2.new(0,120,0,40)
content.BackgroundTransparency = 1

local function createTab(name,posY)
    local b = Instance.new("TextButton", tabFrame)
    b.Size = UDim2.new(1,0,0,40)
    b.Position = UDim2.new(0,0,0,posY)
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(50,50,50)
    return b
end

local playerTab = createTab("Player",0)
local funTab = createTab("Fun",40)
local tpTab = createTab("Teleport",80)

local function clear()
    for _,v in pairs(content:GetChildren()) do v:Destroy() end
end

-- PLAYER TAB
playerTab.MouseButton1Click:Connect(function()
    clear()
    local speed = Instance.new("TextButton", content)
    speed.Size = UDim2.new(0,150,0,40)
    speed.Position = UDim2.new(0,20,0,20)
    speed.Text = "Speed x2"
    speed.MouseButton1Click:Connect(function()
        player.Character.Humanoid.WalkSpeed = 32
    end)
end)

-- FUN TAB
funTab.MouseButton1Click:Connect(function()
    clear()
    local notif = Instance.new("TextButton", content)
    notif.Size = UDim2.new(0,150,0,40)
    notif.Position = UDim2.new(0,20,0,20)
    notif.Text = "Notification"
    notif.MouseButton1Click:Connect(function()
        game.StarterGui:SetCore("SendNotification",{
            Title="Nezut Hub",
            Text="Hello 😎",
            Duration=5
        })
    end)
end)

-- TELEPORT TAB (test)
tpTab.MouseButton1Click:Connect(function()
    clear()
    local tp = Instance.new("TextButton", content)
    tp.Size = UDim2.new(0,180,0,40)
    tp.Position = UDim2.new(0,20,0,20)
    tp.Text = "Teleport Center"
    tp.MouseButton1Click:Connect(function()
        player.Character:MoveTo(Vector3.new(0,50,0))
    end)
end)
