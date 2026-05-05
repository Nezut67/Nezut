-- NEZUT HUB v3 🔥
local player = game.Players.LocalPlayer

-- GUI chính
local gui = Instance.new("ScreenGui")
gui.Name = "NezutHub"
gui.Parent = player.PlayerGui

-- NÚT OPEN (hiện khi hub đóng)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,100,0,35)
openBtn.Position = UDim2.new(0,10,0,200)
openBtn.Text = "OPEN HUB"
openBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Parent = gui

-- KHUNG HUB
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,300,0,220)
frame.Position = UDim2.new(0.5,-150,0.5,-110)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- TIÊU ĐỀ
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Text = "🔥 NEZUT HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Parent = frame

-- NÚT CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,40,0,30)
closeBtn.Position = UDim2.new(1,-45,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = frame

-- NÚT THÔNG BÁO
local btn1 = Instance.new("TextButton")
btn1.Size = UDim2.new(0.8,0,0,40)
btn1.Position = UDim2.new(0.1,0,0.35,0)
btn1.Text = "Thông báo"
btn1.Parent = frame

btn1.MouseButton1Click:Connect(function()
    game.StarterGui:SetCore("SendNotification",{
        Title="Nezut Hub",
        Text="Hub đã chạy 😎",
        Duration=5
    })
end)

-- NÚT SPEED
local btn2 = Instance.new("TextButton")
btn2.Size = UDim2.new(0.8,0,0,40)
btn2.Position = UDim2.new(0.1,0,0.65,0)
btn2.Text = "Speed x2"
btn2.Parent = frame

btn2.MouseButton1Click:Connect(function()
    player.Character.Humanoid.WalkSpeed = 32
end)

-- CHỨC NĂNG ĐÓNG/MỞ
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
end)
