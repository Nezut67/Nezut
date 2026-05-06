--// 🔥 NEZUT HUB v6 ULTRA UI (FINAL STABLE)

if game.CoreGui:FindFirstChild("NezutHub") then
	game.CoreGui.NezutHub:Destroy()
end

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--------------------------------------------------
-- SAFE CHARACTER FUNCTION
--------------------------------------------------
local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

local function hum()
	return getChar():WaitForChild("Humanoid")
end

--------------------------------------------------
-- GLOBAL STATE (fix respawn bugs)
--------------------------------------------------
local flying=false
local flyConnection=nil
local spinning=false
local spinConn=nil
local infJump=false

--------------------------------------------------
-- FULL RESPAWN FIX
--------------------------------------------------
player.CharacterAdded:Connect(function(char)
	task.wait(1)

	workspace.CurrentCamera.CameraSubject = hum()

	if flyConnection then flyConnection:Disconnect() flyConnection=nil end
	if spinConn then spinConn:Disconnect() spinConn=nil end

	flying=false
	spinning=false
end)

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui",game.CoreGui)
gui.Name="NezutHub"
gui.ResetOnSpawn=false

--------------------------------------------------
-- BLUR
--------------------------------------------------
if not Lighting:FindFirstChild("NezutBlur") then
	local blur = Instance.new("BlurEffect",Lighting)
	blur.Name="NezutBlur"
	blur.Size=12
end

--------------------------------------------------
-- FLOAT BUTTON
--------------------------------------------------
local Toggle = Instance.new("ImageButton",gui)
Toggle.Size=UDim2.new(0,65,0,65)
Toggle.Position=UDim2.new(0,20,0.5,-32)
Toggle.BackgroundTransparency=1
Toggle.Image="rbxassetid://109893731370623"
Toggle.Draggable=true
Instance.new("UICorner",Toggle).CornerRadius=UDim.new(0,12)

--------------------------------------------------
-- MAIN WINDOW
--------------------------------------------------
local Main = Instance.new("Frame",gui)
Main.Size=UDim2.new(0,0,0,0)
Main.Position=UDim2.new(0.5,-275,0.5,-190)
Main.BackgroundColor3=Color3.fromRGB(30,30,30)
Main.Visible=false
Main.Active=true
Main.Draggable=true
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,14)

Toggle.MouseButton1Click:Connect(function()
	if Main.Visible then
		TweenService:Create(Main,TweenInfo.new(0.25),{Size=UDim2.new(0,0,0,0)}):Play()
		task.wait(0.25)
		Main.Visible=false
	else
		Main.Visible=true
		TweenService:Create(Main,TweenInfo.new(0.45,Enum.EasingStyle.Back),{Size=UDim2.new(0,550,0,380)}):Play()
	end
end)

--------------------------------------------------
-- TAB SYSTEM
--------------------------------------------------
local Tabs=Instance.new("Frame",Main)
Tabs.Size=UDim2.new(0,120,1,-40)
Tabs.Position=UDim2.new(0,0,0,40)
Tabs.BackgroundColor3=Color3.fromRGB(45,45,45)

local Pages=Instance.new("Frame",Main)
Pages.Size=UDim2.new(1,-120,1,-40)
Pages.Position=UDim2.new(0,120,0,40)
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
	b.TextColor3=Color3.fromRGB(200,120,255)
	b.MouseButton1Click:Connect(function()
		for _,v in pairs(Pages:GetChildren()) do v.Visible=false end
		page.Visible=true
	end)
end

local Home=newPage()
local Player=newPage()
local World=newPage()
local Admin=newPage()

newTab("Home",0,Home)
newTab("Player",1,Player)
newTab("World",2,World)
newTab("Admin",3,Admin)
Home.Visible=true

--------------------------------------------------
-- BUTTON MAKER
--------------------------------------------------
local function makeBtn(parent,text,y,func)
	local b=Instance.new("TextButton",parent)
	b.Size=UDim2.new(0,200,0,40)
	b.Position=UDim2.new(0,20,0,y)
	b.Text=text
	b.BackgroundColor3=Color3.fromRGB(80,80,80)
	b.TextColor3=Color3.new(1,1,1)
	Instance.new("UICorner",b)
	b.MouseButton1Click:Connect(func)
end

--------------------------------------------------
-- PLAYER
--------------------------------------------------
makeBtn(Player,"Speed x2",20,function() hum().WalkSpeed=32 end)
makeBtn(Player,"Reset Speed",70,function() hum().WalkSpeed=16 end)
makeBtn(Player,"Jump Boost",120,function() hum().JumpPower=100 end)

makeBtn(Player,"Spin Troll",170,function()
	spinning=not spinning
	if spinning then
		spinConn=RunService.RenderStepped:Connect(function()
			local root=getChar():FindFirstChild("HumanoidRootPart")
			if root then root.CFrame*=CFrame.Angles(0,math.rad(10),0) end
		end)
	else
		if spinConn then spinConn:Disconnect() spinConn=nil end
	end
end)

--------------------------------------------------
-- WORLD
--------------------------------------------------
makeBtn(World,"Day",20,function() Lighting.TimeOfDay="14:00:00" end)
makeBtn(World,"Night",70,function() Lighting.TimeOfDay="00:00:00" end)

makeBtn(World,"FPS Boost",120,function()
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then v.Material="Plastic" v.Reflectance=0 end
	end
	Lighting.GlobalShadows=false
end)

--------------------------------------------------
-- ADMIN
--------------------------------------------------
local selectedPlayer=nil

local PlayerBox=Instance.new("TextBox",Admin)
PlayerBox.Size=UDim2.new(0,200,0,35)
PlayerBox.Position=UDim2.new(0,20,0,20)
PlayerBox.PlaceholderText="Enter Player Name"
Instance.new("UICorner",PlayerBox)

PlayerBox.FocusLost:Connect(function()
	selectedPlayer=Players:FindFirstChild(PlayerBox.Text)
	if not selectedPlayer then PlayerBox.Text="Not Found" task.wait(1) PlayerBox.Text="" end
end)

makeBtn(Admin,"Teleport To Player",70,function()
	if selectedPlayer and selectedPlayer.Character then
		getChar():PivotTo(selectedPlayer.Character:GetPivot())
	end
end)

makeBtn(Admin,"Bring Player",120,function()
	if selectedPlayer and selectedPlayer.Character then
		selectedPlayer.Character:PivotTo(getChar():GetPivot())
	end
end)

makeBtn(Admin,"Spectate",170,function()
	if selectedPlayer and selectedPlayer.Character then
		workspace.CurrentCamera.CameraSubject=selectedPlayer.Character:FindFirstChildOfClass("Humanoid")
	end
end)

makeBtn(Admin,"Stop Spectate",220,function()
	workspace.CurrentCamera.CameraSubject=hum()
end)

-- Infinite Jump
if _G.NezutJump then _G.NezutJump:Disconnect() end
_G.NezutJump = UIS.JumpRequest:Connect(function()
	if infJump then hum():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

makeBtn(Admin,"Toggle Infinite Jump",270,function()
	infJump=not infJump
end)

-- Fly
makeBtn(Admin,"Toggle Fly",320,function()
	flying=not flying
	if flying then
		flyConnection=RunService.RenderStepped:Connect(function()
			getChar():TranslateBy(hum().MoveDirection*2)
		end)
	else
		if flyConnection then flyConnection:Disconnect() flyConnection=nil end
	end
end)
--------------------------------------------------
-- 🌈 RAINBOW GLOW FOR HUB BUTTON
--------------------------------------------------
spawn(function()
	while Toggle and Toggle.Parent do
		for i = 0,1,0.01 do
			Toggle.ImageColor3 = Color3.fromHSV(i,1,1)
			RunService.RenderStepped:Wait()
		end
	end
end)

--------------------------------------------------
-- 🔔 CORNER NOTIFICATION SYSTEM
--------------------------------------------------
local function NezutNotify(text)
	local notif = Instance.new("TextLabel",gui)
	notif.Size = UDim2.new(0,260,0,38)
	notif.Position = UDim2.new(1,-280,1,0)
	notif.BackgroundColor3 = Color3.fromRGB(25,25,25)
	notif.TextColor3 = Color3.new(1,1,1)
	notif.Font = Enum.Font.GothamBold
	notif.TextSize = 14
	notif.Text = "✨ "..text
	notif.BorderSizePixel = 0
	Instance.new("UICorner",notif).CornerRadius = UDim.new(0,8)

	TweenService:Create(notif,TweenInfo.new(0.4),{
		Position = UDim2.new(1,-280,1,-70)
	}):Play()

	task.wait(3)

	TweenService:Create(notif,TweenInfo.new(0.4),{
		Position = UDim2.new(1,-280,1,0)
	}):Play()

	task.wait(0.4)
	notif:Destroy()
end

-- thông báo khi load hub
NezutNotify("Nezut Hub Loaded")

--------------------------------------------------
-- 🔥 MOBILE SMOOTH DRAG SYSTEM (NO DRAGGABLE)
--------------------------------------------------
local dragToggle, dragStart, startPos

local function smoothDrag(guiObject)
	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragToggle = true
			dragStart = input.Position
			startPos = guiObject.Position
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			guiObject.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragToggle = false
		end
	end)
end

-- áp dụng drag mượt cho HUB
smoothDrag(Toggle)
smoothDrag(Main)

NezutNotify("Mobile Drag Enabled")
