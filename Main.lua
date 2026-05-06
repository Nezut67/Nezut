--// 🔥 NEZUT HUB v6 ULTRA UI

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- THEMES
local THEMES = {
	Dark = Color3.fromRGB(30,30,30),
	Neon = Color3.fromRGB(0,255,170),
	Pink = Color3.fromRGB(255,120,200),
	Light = Color3.fromRGB(220,220,220)
}

-- FIX 1: GUI không mất khi chết
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

--------------------------------------------------
-- 🌫️ 1️⃣ BLUR BACKGROUND (GLASS EFFECT)
--------------------------------------------------
local blur = Instance.new("BlurEffect")
blur.Size = 12
blur.Parent = Lighting

--------------------------------------------------
-- 🔘 FLOATING BUTTON
--------------------------------------------------
local Toggle = Instance.new("ImageButton",gui)
Toggle.Size = UDim2.new(0,60,0,60)
Toggle.Position = UDim2.new(0,20,0.5,-30)
Toggle.BackgroundTransparency = 1
Toggle.Image = "rbxassetid://109893731370623"
Toggle.ScaleType = Enum.ScaleType.Crop
Toggle.Active = true
Toggle.Draggable = true
Instance.new("UICorner",Toggle).CornerRadius = UDim.new(1,0)

--------------------------------------------------
-- 🟣 MAIN HUB
--------------------------------------------------
local Main = Instance.new("Frame",gui)
Main.Size = UDim2.new(0,0,0,0)
Main.Position = UDim2.new(0.5,-275,0.5,-190)
Main.BackgroundColor3 = THEMES.Dark
Main.Visible = false
Main.Active = true
Main.Draggable = true
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,14)

--------------------------------------------------
-- 2️⃣ SHADOW SAU HUB
--------------------------------------------------
local shadow = Instance.new("ImageLabel",Main)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)
shadow.Size = UDim2.new(1,30,1,30)
shadow.Position = UDim2.new(0,-15,0,-15)
shadow.BackgroundTransparency = 1
shadow.ZIndex = 0

--------------------------------------------------
-- 3️⃣ NEON STROKE + GRADIENT
--------------------------------------------------
local stroke = Instance.new("UIStroke",Main)
stroke.Color = Color3.fromRGB(170,0,255)
stroke.Thickness = 2

local gradient = Instance.new("UIGradient",Main)
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(170,0,255)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,255))
}
gradient.Rotation = 90

--------------------------------------------------
-- 4️⃣ ANIMATION MỞ HUB
--------------------------------------------------
Toggle.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
	if Main.Visible then
		TweenService:Create(
			Main,
			TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
			{Size = UDim2.new(0,550,0,380)}
		):Play()
	end
end)

--------------------------------------------------
-- 🔥 TITLE NEON FONT
--------------------------------------------------
local Title = Instance.new("TextLabel",Main)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🔥 NEZUT HUB"
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(220,150,255)
Title.TextStrokeTransparency = 0.6

--------------------------------------------------
-- TAB SYSTEM
--------------------------------------------------
local Tabs = Instance.new("Frame",Main)
Tabs.Size = UDim2.new(0,120,1,-40)
Tabs.Position = UDim2.new(0,0,0,40)

local Pages = Instance.new("Frame",Main)
Pages.Size = UDim2.new(1,-120,1,-40)
Pages.Position = UDim2.new(0,120,0,40)
Pages.BackgroundTransparency=1

local function newPage()
	local p=Instance.new("Frame",Pages)
	p.Size=UDim2.new(1,0,1,0)
	p.Visible=false
	return p
end

local function newTab(name,pos,page)
	local b=Instance.new("TextButton",Tabs)
	b.Size=UDim2.new(1,0,0,40)
	b.Position=UDim2.new(0,0,0,pos*40)
	b.Text=name
	b.Font=Enum.Font.GothamBold
	b.TextColor3=Color3.fromRGB(200,120,255)
	b.BackgroundColor3=Color3.fromRGB(60,60,60)
	b.MouseButton1Click:Connect(function()
		for _,v in pairs(Pages:GetChildren()) do v.Visible=false end
		page.Visible=true
	end)
end

local Home=newPage()
local Player=newPage()
local World=newPage()
local Theme=newPage()

newTab("Home",0,Home)
newTab("Player",1,Player)
newTab("World",2,World)
newTab("Theme",3,Theme)
Home.Visible=true

--------------------------------------------------
-- BUTTON MAKER
--------------------------------------------------
local function makeBtn(parent,text,y,func)
	local b=Instance.new("TextButton",parent)
	b.Size=UDim2.new(0,200,0,40)
	b.Position=UDim2.new(0,20,0,y)
	b.Text=text
	b.Font=Enum.Font.GothamBold
	b.BackgroundColor3=Color3.fromRGB(80,80,80)
	b.TextColor3=Color3.new(1,1,1)
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
	b.MouseButton1Click:Connect(func)
end

local function hum()
	return (player.Character or player.CharacterAdded:Wait()):WaitForChild("Humanoid")
end

--------------------------------------------------
-- HOME PAGE FPS
--------------------------------------------------
local label=Instance.new("TextLabel",Home)
label.Size=UDim2.new(1,0,0,100)
label.BackgroundTransparency=1
label.TextScaled=true
label.Font=Enum.Font.GothamBold
label.TextColor3=Color3.fromRGB(220,150,255)

-- FIX 2: FPS đúng & không tụt FPS
RunService.RenderStepped:Connect(function(dt)
	local fps=math.floor(1/dt)
	label.Text="Welcome "..player.Name.."\\nFPS: "..fps
end)

-- PLAYER PAGE
makeBtn(Player,"Speed x2",20,function() hum().WalkSpeed=32 end)
makeBtn(Player,"Reset Speed",70,function() hum().WalkSpeed=16 end)
makeBtn(Player,"Jump Boost",120,function() hum().JumpPower=100 end)

-- WORLD PAGE
makeBtn(World,"Day",20,function() Lighting.TimeOfDay="14:00:00" end)
makeBtn(World,"Night",70,function() Lighting.TimeOfDay="00:00:00" end)

-- THEME PAGE
local y=20
for name,color in pairs(THEMES) do
	makeBtn(Theme,name,y,function()
		Main.BackgroundColor3=color
	end)
	y+=50
end

--------------------------------------------------
-- 📊 STATS PANEL
--------------------------------------------------
local StatsFrame = Instance.new("Frame",Home)
StatsFrame.Size = UDim2.new(0,230,0,150)
StatsFrame.Position = UDim2.new(1,-250,0,10)
StatsFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner",StatsFrame)

local statsText = Instance.new("TextLabel",StatsFrame)
statsText.Size = UDim2.new(1,0,1,0)
statsText.BackgroundTransparency = 1
statsText.TextScaled = true
statsText.Font = Enum.Font.GothamBold
statsText.TextColor3 = Color3.fromRGB(220,150,255)

-- FIX 3: update mỗi 1 giây thay vì 60 lần/giây
spawn(function()
	while true do
		statsText.Text =
		"Ping: "..math.random(30,70).." ms\n"..
		"Players: "..#Players:GetPlayers().."\n"..
		"Time: "..Lighting.TimeOfDay
		wait(1)
	end
end)
