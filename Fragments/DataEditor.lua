lp = game.Players.LocalPlayer
UIS = game:GetService("UserInputService")
local Icons = T.GetLibrary("Icons")

local ST

local WhiteL = false
local list = {}

for i,v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "TableEditor" then
	    v:Destroy()
	end
end

local IsPhone = T.IsPhone
downsize = function(descendant)
    if IsPhone() then
    	descendant.Size = UDim2.new(
            descendant.Size.X.Scale,
        	descendant.Size.X.Offset / 1.5, 
        	descendant.Size.Y.Scale, 
      	    descendant.Size.Y.Offset / 1.5
       	)
     	descendant.Position = UDim2.new(
            descendant.Position.X.Scale, 
            descendant.Position.X.Offset / 1.5, 
            descendant.Position.Y.Scale, 
            descendant.Position.Y.Offset / 1.5
        )
        if descendant:IsA("TextButton") or descendant:IsA("TextLabel") then
            descendant.TextSize = descendant.TextSize /1.5
        end
    end
end

local G = Instance.new("ScreenGui", game.CoreGui)
G.ResetOnSpawn = false
G.Name = "TableEditor"
G.Enabled = false

local Data = T.GetTheme()

local MainFrame = Instance.new("ScrollingFrame", G)

MainFrame.Size = UDim2.new(0,585,0,600)
MainFrame.Position = UDim2.new(0.5,0,0.5,0)
MainFrame.BackgroundColor3 = Data.BgC
MainFrame.BorderColor3 = Data.DarkerC
MainFrame.ScrollBarImageTransparency = 0
MainFrame.CanvasSize = UDim2.new(0,0,0,0)
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)

downsize(MainFrame)

local TitleLabel = Instance.new("TextButton", MainFrame)

TitleLabel.Size = UDim2.new(1,0,0,30)
TitleLabel.Position = UDim2.new(0,0,0,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Data-editor"
TitleLabel.Font = Data.Font
TitleLabel.TextScaled = true
TitleLabel.TextColor3 = Data.Color

downsize(TitleLabel)

local X = Instance.new("TextButton", MainFrame)

X.Size = UDim2.new(0,30,0,30)
X.Position = UDim2.new(1,-30,0,0)
X.BackgroundTransparency = 1
X.Text = "X"
X.Font = Data.Font
X.TextScaled = true
X.TextColor3 = Data.Color
X.ZIndex = 200

X.MouseButton1Click:Connect(function()
    G.Enabled = false
    ST = nil
end)

downsize(X)

local SearchBox = Instance.new("TextBox", MainFrame)

SearchBox.Size = UDim2.new(1,-40,0,35)
SearchBox.Position = UDim2.new(0,20,0,90)
SearchBox.BorderSizePixel = 2
SearchBox.BackgroundColor3 = Data.DarkC
SearchBox.BorderColor3 = Data.Color
SearchBox.Text = ""
SearchBox.PlaceholderText = "Search"
SearchBox.PlaceholderColor3 = Data.DarkerC
SearchBox.Font = Data.Font
SearchBox.TextScaled = true
SearchBox.TextColor3 = Data.Color

downsize(SearchBox)

local ValueFrame = Instance.new("ScrollingFrame", MainFrame)

ValueFrame.Size = UDim2.new(1,-20,1,-147)
ValueFrame.Position = UDim2.new(0,20,0,147)
ValueFrame.BackgroundTransparency = 1
ValueFrame.CanvasSize = UDim2.new(0,0,0,0)
ValueFrame.ScrollBarImageColor3 = Data.Color
ValueFrame.ScrollBarImageTransparency = 1
ValueFrame.ElasticBehavior = "Never"
ValueFrame.ScrollingDirection = "Y"

downsize(ValueFrame)

local TableFrame = Instance.new("ScrollingFrame", G)

TableFrame.Size = UDim2.new(0,365,0,350)
TableFrame.BackgroundColor3 = Data.BgC
TableFrame.BorderColor3 = Data.DarkerC
TableFrame.ScrollBarImageTransparency = 0
TableFrame.CanvasSize = UDim2.new(0,0,0,0)
TableFrame.AnchorPoint = Vector2.new(0.5,0.5)
TableFrame.ZIndex = 5 *10000
TableFrame.Visible = false
downsize(TableFrame)
TableFrame.Position = UDim2.new(0.5,ValueFrame.AbsoluteSize.X,0.5,0)

local TableTitleLabel = Instance.new("TextButton", TableFrame)

TableTitleLabel.Size = UDim2.new(1,0,0,25)
TableTitleLabel.Position = UDim2.new(0,0,0,0)
TableTitleLabel.BackgroundTransparency = 1
TableTitleLabel.Text = "Table name here"
TableTitleLabel.Font = Data.Font
TableTitleLabel.TextScaled = true
TableTitleLabel.TextColor3 = Data.Color
TableTitleLabel.ZIndex = 6 *10000

downsize(TableTitleLabel)

local TableX = Instance.new("TextButton", TableFrame)

TableX.Size = UDim2.new(0,25,0,25)
TableX.Position = UDim2.new(1,-25,0,0)
TableX.BackgroundTransparency = 1
TableX.Text = "X"
TableX.Font = Data.Font
TableX.TextScaled = true
TableX.TextColor3 = Data.Color
TableX.ZIndex = 6 *10000

TableX.MouseButton1Click:Connect(function()
    TableFrame.Visible = false
end)

downsize(TableX)

local TableValueFrame = Instance.new("ScrollingFrame", TableFrame)

TableValueFrame.Size = UDim2.new(1,-20,1,-35)
TableValueFrame.Position = UDim2.new(0,20,0,35)
TableValueFrame.BackgroundTransparency = 1
TableValueFrame.CanvasSize = UDim2.new(0,0,0,0)
TableValueFrame.ScrollBarImageColor3 = Data.Color
TableValueFrame.ScrollBarImageTransparency = 1
TableValueFrame.ElasticBehavior = "Never"
TableValueFrame.ScrollingDirection = "Y"
TableValueFrame.ZIndex = 7 *10000

local UserInputService = game:GetService("UserInputService")
local runService = (game:GetService("RunService")); 
local gui = TableFrame

local dragging
local dragInput
local dragStart
local startPos
local WILLDRAG = true

function Lerp(a, b, m)
	return a + (b - a) * m
end;

local lastMousePos
local lastGoalPos
local DRAG_SPEED = (8); -- // The speed of the UI darg.
function Update(dt)
    if WILLDRAG then
	if not (startPos) then return end;
	if not (dragging) and (lastGoalPos) then
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
		return 
	end;

	local delta = (lastMousePos - UserInputService:GetMouseLocation())
	local xGoal = (startPos.X.Offset - delta.X);
	local yGoal = (startPos.Y.Offset - delta.Y);
	lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
 	end
end;

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		lastMousePos = UserInputService:GetMouseLocation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

runService.Heartbeat:Connect(Update)

round = function(num)
    return math.round(num *100) /100
end

local filters = {
    ["boolean"] = true,
    ["string"] = true,
    ["number"] = true,
    ["Instance"] = false,
    ["function"] = false,
    ["table"] = false
}

local InsertValues = function(t,frame,istable)
    local frame = frame or ValueFrame
    if not UIS:GetFocusedTextBox() or UIS:GetFocusedTextBox().Parent ~= frame then
    t = t
    for i,v in pairs(frame:GetChildren()) do
        if UIS:GetFocusedTextBox() ~= v then
        	v:Destroy()
        end
    end
    local line = 0
	for i,v in pairs(t) do
     	local ignore = false
     	if not WhiteL and not istable then
          	ignore = false
        	if list[i] then
            	ignore = true
            end
        elseif not istable then
        	ignore = true
         	if list[i] then
            	ignore = false
            end
    	end
 		if filters[typeof(v)] ~= true and not istable then
       		ignore = true
      	end
     
    	local searchstring = i..tostring(v)
     	local searchboxText = SearchBox.Text
     	if istable then
        	searchboxText = ""
        end
     	if 
      		typeof(v) == "number" and searchstring:match(searchboxText) and not ignore or 
      		typeof(v) == "boolean" and searchstring:match(searchboxText) and not ignore or
        	typeof(v) == "string" and searchstring:match(searchboxText) and not ignore or
         	typeof(v) == "Instance" and searchstring:match(searchboxText) and not ignore or
          	typeof(v) == "function" and searchstring:match(searchboxText) and not ignore or
           	typeof(v) == "table" and searchstring:match(searchboxText) and not ignore
      	then
 		line += 1
   
   		local ValueBox
   		if typeof(v) ~= "Instance" and typeof(v) ~= "function" and typeof(v) ~= "table" then
   			ValueBox = Instance.new("TextBox", frame)
      	else
       		ValueBox = Instance.new("TextLabel", frame)
       	end
    
		ValueBox.Size = UDim2.new(1,0,0,25)
		ValueBox.Position = UDim2.new(0,0,0,line *25 -25)	
	 	ValueBox.BackgroundTransparency = 1
   		if typeof(v) == "string" then
   			ValueBox.Text = i.." = \""..tostring(v).."\""
   		elseif typeof(v) == "number" then
   			ValueBox.Text = i.." = "..tostring(round(v))
   		elseif typeof(v) == "Instance" then
     		ValueBox.Text = i.." = "..v.Name
     	elseif typeof(v) == "function" then
      		ValueBox.Text = "function "..i.."()"
      	elseif typeof(v) == "table" then
       		ValueBox.Text = i.." = table:"
       	else
     		ValueBox.Text = i.." = "..tostring(v)
      	end
		ValueBox.Font = Data.Font
  		if not IsPhone() then
			ValueBox.TextSize = 30
  		else
    		ValueBox.TextSize = 30 /1.5
     	end
		ValueBox.TextColor3 = Data.Color
  		if typeof(v) ~= "Instance" and typeof(v) ~= "function" and typeof(v) ~= "table" then
  			ValueBox.ClearTextOnFocus = false
    	end
  		ValueBox.TextXAlignment = "Left"
    	if not IsPhone() then
    		frame.CanvasSize = UDim2.new(0,0,0,line *25 -25)
     	else
      		frame.CanvasSize = UDim2.new(0,0,0,line *16.66 -16.66)
     	end
    	ValueBox.Name = i
     	ValueBox.ZIndex = frame.ZIndex +10
     
     	downsize(ValueBox)
      
      	if typeof(v) == "function" or typeof(v) == "table" then
        local SecondButton = Instance.new("TextButton", frame)

		SecondButton.Size = UDim2.new(0,20,0,20)
	 	SecondButton.BackgroundColor3 = Data.DarkC
   		if typeof(v) == "function" then
   			SecondButton.Text = "R"
      	else
       		SecondButton.Text = "V"
       	end
		SecondButton.Font = Data.Font
		SecondButton.TextScaled = true
		SecondButton.TextColor3 = Data.Color
  		SecondButton.ZIndex = frame.ZIndex +110
  		downsize(SecondButton)
  		if not IsPhone() then
        	if not istable then
  				SecondButton.Position = UDim2.new(1,-67.5,0,line *25 -25 +2.5)	
      		else
        		SecondButton.Position = UDim2.new(1,-34.5,0,line *25 -25 +2.5)	
        	end
     	else
      		if not istable then
  				SecondButton.Position = UDim2.new(1,-67.5 /1.5,0,line *(25 /1.5) -(25 /1.5) +(2.5 /1.5))	
      		else
        		SecondButton.Position = UDim2.new(1,-34.5 /1.5,0,line *(25 /1.5) -(25 /1.5) +(2.5 /1.5))	
        	end
      	end
   
   		SecondButton.MouseButton1Click:Connect(function()
         	if typeof(v) == "function" then
        		t[i]()
          	else
           		ST = v
             	TableTitleLabel.Text = i
           	end
        end)
        end
     
     	if not istable then
     	local CopyButton = Instance.new("TextButton", frame)

		CopyButton.Size = UDim2.new(0,20,0,20)
	 	CopyButton.BackgroundColor3 = Data.DarkC
   		CopyButton.Text = "C"
		CopyButton.Font = Data.Font
		CopyButton.TextScaled = true
		CopyButton.TextColor3 = Data.Color
  		CopyButton.ZIndex = frame.ZIndex +110
  		downsize(CopyButton)
  		if not IsPhone() then
  			CopyButton.Position = UDim2.new(1,-42.5,0,line *25 -25 +2.5)	
     	else
      		CopyButton.Position = UDim2.new(1,-42.5 /1.5,0,line *(25 /1.5) -(25 /1.5) +(2.5 /1.5))	
      	end
       
       	CopyButton.MouseButton1Click:Connect(function()
            if typeof(v) == "number" or typeof(v) == "boolean" then
            	setclipboard(tostring("getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript)."..i.." = "..tostring(v)))
            elseif typeof(v) == "string" then
            	setclipboard(tostring("getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript)."..i.." = \""..v.."\""))
            elseif typeof(v) == "Instance" then
        		setclipboard(tostring("getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript)."..i.." = game."..v:GetFullName()))
          	elseif typeof(v) == "function" then
           		setclipboard(tostring("getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript)."..i.."()"))
         	end
        end)
    	end
    	if typeof(v) ~= "Instance" and typeof(v) ~= "function" and typeof(v) ~= "table" then
    	ValueBox.Changed:Connect(function() 
         	local MaxLength = #string.split(i,"") + 3
          	if #string.split(ValueBox.Text,"") <MaxLength then
        		ValueBox.Text = i.." = "
         	end
        end)
    	ValueBox.Focused:Connect(function()
         	if typeof(v) == "string" then
        		ValueBox.Text = i.." = "..v
         	end
        end)
    	ValueBox.FocusLost:Connect(function() 
         	if string.split(ValueBox.Text," = ")[2] == "" or string.split(ValueBox.Text," = ")[2] == nil then
              	if typeof(v) == "number" then
            		ValueBox.Text = i.." = ".."0"
              	elseif typeof(v) == "boolean" then
               		ValueBox.Text = i.." = ".."false"
               	end
            elseif typeof(v) == "number" then
            	ValueBox.Text = i.." = "..tostring(tonumber(string.split(ValueBox.Text," = ")[2]))
            end
        	if typeof(v) == "boolean" then
         		if string.split(ValueBox.Text," = ")[2] ~= "false" and string.split(ValueBox.Text," = ")[2] ~= "true" then
               		ValueBox.Text = i.." = ".."false"
               	end
         	end
      		if typeof(v) == "string" then
            	t[i] = string.split(ValueBox.Text," = ")[2]
            	ValueBox.Text = i.." = \""..string.split(ValueBox.Text," = ")[2].."\""
            end
        	if typeof(v) == "number" then
        		t[i] = tonumber(string.split(ValueBox.Text," = ")[2])
          	elseif typeof(v) == "boolean" then
           		if string.split(ValueBox.Text," = ")[2] == "true" then
                	t[i] = true
                else
                	t[i] = false
                end
            end
        end)
    	end
 		end
 	end
	end
end

update = function(t)
    InsertValues(t,ValueFrame)
    if ST then
        InsertValues(ST,TableValueFrame,true)
        TableFrame.Visible = true
  	else
  		TableFrame.Visible = false
    end
end

update(getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript))

local List = Instance.new("ImageButton", MainFrame)

List.Size = UDim2.new(0,30,0,30)
List.Position = UDim2.new(0,0,0,0)
List.BackgroundTransparency = 1
List.Image = "http://www.roblox.com/asset/?id=8733216068"
List.ImageColor3 = Data.Color
List.ZIndex = 20000

downsize(List)

local ListFrame = Instance.new("ScrollingFrame", List)

ListFrame.Size = UDim2.new(0,120,0,30)
ListFrame.BackgroundColor3 = Data.DarkC
ListFrame.BorderColor3 = Data.Color
ListFrame.BorderSizePixel = 2
ListFrame.ScrollBarImageTransparency = 0
ListFrame.CanvasSize = UDim2.new(0,0,0,0)
ListFrame.Visible = false
ListFrame.ZIndex = 10000
downsize(ListFrame)
if not IsPhone() then
	ListFrame.Position = UDim2.new(0,40,0,4)
else
	ListFrame.Position = UDim2.new(0,(30 /1.5) + 60,0,4)
end

ListFrameOn = false
List.MouseButton1Click:Connect(function()
    if ListFrameOn then
        ListFrameOn = false
   	else
    	ListFrameOn = true
    end
	ListFrame.Visible = ListFrameOn
end)

local index = 0
for i,f in pairs(filters) do
    index = index +1
    local filter = Instance.new("Frame", ListFrame)

	filter.Size = UDim2.new(1,0,0,30)
	filter.Position = UDim2.new(0,0,0,30 *index -30)
	filter.BackgroundTransparency = 1
	filter.ZIndex = 11000
 
 	downsize(filter)
  
  	local text = string.split(i,"")
   	text[1] = string.upper(text[1])
    
    local msg = ""
    for i,v in pairs(text) do
        msg = msg..v
    end
 
 	local filterText = Instance.new("TextLabel", filter)

	filterText.Size = UDim2.new(1,-35,0,30)
	filterText.Position = UDim2.new(0,35,0,0)
	filterText.BackgroundTransparency = 1
 	filterText.Text = msg
	filterText.Font = Data.Font
	filterText.TextScaled = true
	filterText.TextColor3 = Data.Color
	filterText.ZIndex = 12000
 
 	downsize(filterText)
 
 	local Switch = Instance.new("TextButton",filter)
    Switch.Size = UDim2.new(0,20,0,20)
   	Switch.Position = UDim2.new(0,5,0,5)
    Switch.BackgroundColor3 = Data.DarkerC
    Switch.BorderSizePixel = 0
    Switch.ZIndex = 12000
    Switch.Text = ""
    Switch.AutoButtonColor = false
    
    downsize(Switch)
    
    local onoff = false
    Switch.MouseButton1Click:Connect(function()
        if onoff then
            onoff = false
           	filters[i] = false
            Switch.BackgroundColor3 = Data.DarkerC
        else
        	onoff = true
         	filters[i] = true
         	Switch.BackgroundColor3 = Data.Color
        end
    	update(getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript))
    end)
    
    if filters[i] == true then
        onoff = true
    	Switch.BackgroundColor3 = Data.Color
    end
 
    ListFrame.Size = UDim2.new(0,120,0,30 *index)
    downsize(ListFrame)
end

local BarFrame = Instance.new("Frame", MainFrame)

BarFrame.Size = UDim2.new(1,-40,0,35)
BarFrame.Position = UDim2.new(0,20,0,40)
BarFrame.BackgroundTransparency = 1

downsize(BarFrame)

local BarButtons = 0
NewBar = function(name,wb,setlist)
    local BarButton = Instance.new("TextButton", BarFrame)
    
	BarButton.Size = UDim2.new(0,170,1,0)
	BarButton.Position = UDim2.new(0,BarButtons *187,0,0)
 	BarButton.BorderSizePixel = 3
	BarButton.BackgroundColor3 = Data.DarkC
 	BarButton.BorderColor3 = Data.Color
  	BarButton.Text = name
	BarButton.Font = Data.Font
	BarButton.TextScaled = true
	BarButton.TextColor3 = Data.Color
 	BarButton.ZIndex = 2000
 
 	downsize(BarButton)
 
 	BarButton.MouseButton1Click:Connect(function()
    	WhiteL = wb
		list = setlist
  		update(getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript))
   	end)
 
 	BarButtons += 1
end

NewBar("All",false,{})
NewBar("Important",true,{
    candy = 0,
    icedcream = 0,
    tokens = 0,
    speed = 0,
    health = 0,
    infwater = 0,
    hasflame = 0,
    hasfly = 0,
    hasboard = 0,
    damage = 0,
    savegame = 0,
    songplay = 0
})
NewBar("Fangame",false,{typing = 0, hasfly = 0, dancerp = 0, snapshotcam = 0, polerp = 0, ms = 0, onejump = 0, roperp = 0, respawn = 0, gotice = 0, oldoldformatlevel = 0, st1 = 0, trulyconsole = 0, hasboard = 0, dir = 0, torope = 0, decodelevel = 0, particle = 0, ignore = 0, textbuttons = 0, canmove = 0, cast = 0, playsort = 0, camcf = 0, gtick = 0, mslock = 0, bdamp = 0, trsdeb = 0, rotand = 0, storeclick = 0, plam = 0, maxeggs = 0, bgm = 0, faceid = 0, flying = 0, formatlevel = 0, lvlpackssort = 0, tticket = 0, studder = 0, swip = 0, savetick = 0, anim = 0, playing = 0, bforce = 0, fallvr = 0, shared = 0, jump = 0, st2 = 0, starred = 0, damage = 0, ropeh = 0, watertick = 0, toskin = 0, trdo = 0, tojump = 0, scandy = 0, savegame = 0, pause = 0, iceguide = 0, a = 0, swiperp = 0, icedcream = 0, rg3 = 0, candab = 0, loadvis = 0, loadlevel = 0, enemies = 0, yim = 0, totext = 0, hatpage = 0, spinCF = 0, croucherp = 0, zoom = 0, cvu = 0, sticko = 0, fcrouch = 0, base64encode = 0, pound = 0, MouseMove = 0, cfro = 0, bees = 0, camtand = 0, base64decode = 0, walklerp = 0, rolling = 0, lockhats = 0, UI = 0, icebg = 0, djump = 0, wallerp = 0, lookat = 0, snapcam = 0, timeland = 0, todive = 0, scrollex = 0, tostr = 0, anidamp = 0, rollerp = 0, songplay = 0, safetick = 0, dUP = 0, toattack = 0, longerp = 0, snapto = 0, vis = 0, eggs = 0, createguide = 0, maj = 0, script = 0, lvlpacks = 0, spawnice = 0, studio = 0, flypitch = 0, todance = 0, psound = 0, mobile = 0, health = 0, fromlerp = 0, dive = 0, rendist = 0, store = 0, pst = 0, dmgtick = 0, skate = 0, icrt = 0, lp = 0, z1 = 0, stillcam = 0, nightmode = 0, speedy = 0, transition = 0, icedfound2 = 0, icedfound = 0, button = 0, attacktick = 0, lockcam = 0, ag = 0, ms2 = 0, indoors = 0, s = 0, wallnorm = 0, boarderp = 0, w = 0, d = 0, char = 0, loadmap = 0, crouchtick = 0, dLF = 0, oldolddecodelevel = 0, slowed = 0, trsing = 0, fromani = 0, flamecf = 0, dancing = 0, map = 0, safecf = 0, icr = 0, _G = 0, talktn = 0, btntick = 0, scale = 0, flameon = 0, swimerp = 0, potand = 0, ropetick = 0, hitenemy = 0, mapswitching = 0, botand = 0, sliding = 0, holderp = 0, console = 0, hasflame = 0, shrink = 0, trsCF = 0, dRT = 0, blink = 0, min = 0, skaterp = 0, mobst = 0, out = 0, prog = 0, frame = 0, rf = 0, aterp = 0, oldformatlevel = 0, olddecodelevel = 0, debounce = 0, fastmode = 0, fallerp = 0, walkfx = 0, skatestat = 0, sliderp = 0, ledgepoint = 0, tokens = 0, skin = 0, touched = 0, make = 0, anim2 = 0, pzom = 0, lederp = 0, hat = 0, lockskin = 0, speed = 0, skipped = 0, candy = 0, particles = 0, selt = 0, campitch = 0, passes = 0, showbis = 0, wt = 0, timer = 0, givedata = 0, swimming = 0, attack = 0, tocrouch = 0, dt = 0, point = 0, vcf = 0, carry = 0, uis = 0, z2 = 0, walktick = 0, MouseBehavior = 0, hpdeb = 0, limit = 0, jumping = 0, tpc = 0, v2 = 0, dDN = 0, bossfight = 0, dab = 0, flipo = 0, cvt = 0, crouch = 0, flamerp = 0, lookerp = 0, gd = 0, smoothing = 0, firstperson = 0, longjump = 0, textbox = 0, flyspeed = 0, tscale = 0, earlystart = 0, mps = 0, deadzone = 0, ledgegrab = 0,infwater = 0,paused = 0,wallrun = 0})

return {G,update}