-- Nezut Hub 😎
local player = game.Players.LocalPlayer

-- tạo GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NezutHub"
gui.Parent = player.PlayerGui

-- khung chính
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,300,0,200)
frame.Position = UDim2.new(0.5,-150,0.5,-100)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Text = "🔥 NEZUT HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Parent = frame

-- nút thông báo
local btn1 = Instance.new("TextButton")
btn1.Size = UDim2.new(0.8,0,0,40)
btn1.Position = UDim2.new(0.1,0,0.35,0)
btn1.Text = "Thông báo"
btn1.Parent = frame

btn1.MouseButton1Click:Connect(function()
    game.StarterGui:SetCore("SendNotification",{
        Title="Nezut Hub",
        Text="Hub đã chạy thành công 😎",
        Duration=5
    })
end)

-- nút tăng tốc chạy
local btn2 = Instance.new("TextButton")
btn2.Size = UDim2.new(0.8,0,0,40)
btn2.Position = UDim2.new(0.1,0,0.65,0)
btn2.Text = "Speed x2"
btn2.Parent = frame

btn2.MouseButton1Click:Connect(function()
    player.Character.Humanoid.WalkSpeed = 32
end)
