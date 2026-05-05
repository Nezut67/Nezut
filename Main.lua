--// 🔥 NEZUT HUB v6 (Floating Toggle Button)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- THEMES
local THEMES = {
	Dark = Color3.fromRGB(30,30,30),
	Neon = Color3.fromRGB(0,255,170),
	Pink = Color3.fromRGB(255,120,200),
	Light = Color3.fromRGB(220,220,220)
}

local gui = Instance.new("ScreenGui",player.PlayerGui)

-- FLOATING BUTTON (NÚT TRÒN CÓ ẢNH)
local Toggle = Instance.new("ImageButton",gui)
Toggle.Size = UDim2.new(0,60,0,60)
Toggle.Position = UDim2.new(0,20,0.5,-30)
Toggle.BackgroundTransparency = 1
Toggle.Image = "rbxassetid://109893731370623"
Toggle.ScaleType = Enum.ScaleType.Crop
Toggle.Active = true
Toggle.Draggable = true
Instance.new("UICorner",Toggle).CornerRadius = UDim.new(1,0)

-- MAIN HUB
local Main = Instance.new("Frame",gui)
Main.Size = UDim2.new(0,550,0,380)
Main.Position = UDim2.new(0.5,-275,0.5,-190)
Main.BackgroundColor3 = THEMES.Dark
Main.Visible = false
Main.Active = true
Main.Draggable = true

Toggle.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

-- TITLE
local Title = Instance.new("TextLabel",Main)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🔥 NEZUT HUB"
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.BackgroundTransparency = 1

-- TAB SYSTEM
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
	b.BackgroundColor3=Color3.fromRGB(60,60,60)
	b.MouseButton1Click:Connect(function()
		for _,v in pairs(Pages:GetChildren()) do v.Visible=false end
		page.Visible=true
	end)
end

-- PAGES
local Home=newPage()
local Player=newPage()
local World=newPage()
local Theme=newPage()

newTab("Home",0,Home)
newTab("Player",1,Player)
newTab("World",2,World)
newTab("Theme",3,Theme)
Home.Visible=true

-- BUTTON MAKER
local function makeBtn(parent,text,y,func)
	local b=Instance.new("TextButton",parent)
	b.Size=UDim2.new(0,200,0,40)
	b.Position=UDim2.new(0,20,0,y)
	b.Text=text
	b.BackgroundColor3=Color3.fromRGB(80,80,80)
	b.TextColor3=Color3.new(1,1,1)
	b.MouseButton1Click:Connect(func)
end

local function hum()
	return (player.Character or player.CharacterAdded:Wait()):WaitForChild("Humanoid")
end

-- HOME PAGE FPS
local label=Instance.new("TextLabel",Home)
label.Size=UDim2.new(1,0,0,100)
label.BackgroundTransparency=1
label.TextScaled=true

RunService.RenderStepped:Connect(function()
	local fps=math.floor(1/RunService.RenderStepped:Wait())
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
