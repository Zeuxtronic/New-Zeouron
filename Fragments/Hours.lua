lp = game.Players.LocalPlayer

local Mem = getsenv(game.Players.LocalPlayer.PlayerScripts.CoreScript)._G
local TalentConfig -- fuck you mours devs
if RST:FindFirstChild("TalentConfig") then
	TalentConfig = require(RST.TalentConfig)
end
local MenuConfig = require(game:GetService("ReplicatedStorage").MenuConfig)

local ES = T.GetFragment("EntitySpawner")

if Mem.Testers then
    table.insert(Mem.Testers,lp.Name)
end

local SimpleTab = loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Library/UI%20library.lua'))()

local Host = SimpleTab.NewTab("Game")
local Stats = SimpleTab.NewTab("Stats")
local Admin = SimpleTab.NewTab("Admin")
local Other = SimpleTab.NewTab("Other")

SimpleTab.GuiChanged = function(enabled)
    if not Mem.AllGui.Menu.Visible then
    	Mem.SetCameraLock(enabled)
   	 	Mem.Pause = enabled
    end
end

Other.NewSwitch("DLC", function(bool)
    Mem.Premium = bool
end)

Other.NewTextBox("Arena Stage", function(str)
    if Mem.ArenaMode then
        Mem.ArenaStage = tonumber(str) -1
        Mem.NextStage()
    end
end)

local speedslider = Stats.NewSlider("Speed",{0,100},16,function(val)
    Mem.Entities[1].Stats.Speed[1], Mem.Entities[1].Stats.Speed[2] = val, val
end)

local defenseslider = Stats.NewSlider("Defense",{0,500},100,function(val)
    Mem.Entities[1].Stats.Defense[1], Mem.Entities[1].Stats.Defense[2] = val, val
end)

local powerslider = Stats.NewSlider("Power",{0,500},100,function(val)
    Mem.Entities[1].Stats.Power[1], Mem.Entities[1].Stats.Power[2] = val, val
end)

local maxhealthslider = Stats.NewSlider("MaxHealth",{0,500},100,function(val)
    Mem.Entities[1].Stats.MaxHealth[1], Mem.Entities[1].Stats.MaxHealth[2] = val, val
end)

local healthslider = Stats.NewSlider("Health",{0,500},100,function(val)
    Mem.Entities[1].Resources.Health = val
end)

Admin.NewButton("Spawn Entity",function()
    ES.Enabled = not ES.Enabled
end)

GetHosts = function()
    local tble = {}
    for _,v in pairs(game:GetService("ReplicatedStorage").Creatures.Host:GetChildren()) do
        if require(v).IsHost then
            table.insert(tble,v.Name)
        end
    end
	return tble
end

GetHostNames = function()
    local tble = {}
    for _,v in pairs(game:GetService("ReplicatedStorage").Creatures.Host:GetChildren()) do
        if require(v).IsHost then
            table.insert(tble,MenuConfig.Title[v.Name] or v.Name)
        end
    end
	return tble
end

GetHostFromName = function(name)
    for _,v in pairs(GetHosts()) do
        if MenuConfig.Title[v] == name or v == name then
            return v
        end
    end
end

Admin.NewSelector("Become Host",GetHostNames,function(d)
	Mem.Class = GetHostFromName(d)
end)

NoCooldowns = false
GodMode = false

Host.NewButton("Next stage",function()
    Mem.NextStage()
end)

--[[
Host.NewSelector("Load stage",function()
    Mem.NextStage()
end)
]]

Host.NewButton("All talents",function()
    if TalentConfig[Mem.Class] then
        for i,v in pairs(TalentConfig[Mem.Class]) do
            Mem.AddTalent(i)
        end
    end
end)

Host.NewButton("Kill all",function()
    if TalentConfig[Mem.Class] then
        for i,v in pairs(TalentConfig[Mem.Class]) do
            Mem.AddTalent(i)
        end
    end
end)

Host.NewSwitch("No Cooldown",function(bool)
    NoCooldowns = bool
end)

Host.NewSwitch("Invincibillity",function(bool)
    GodMode = bool
end)

Host.NewSwitch("Fast Tempo",function(bool)
    FastTempo = bool
end)

Host.NewSwitch("Spam Projectiles",function(bool,s)
    spamp = bool
   	while spamp and Mem and lp.character and lp.character:FindFirstChild("HumanoidRootPart") and Mem.Entities[1] do
        task.wait(s().cooldown)
        local lowest = math.huge
        local NearestChar = nil
        for _,char in pairs(Mem.Entities) do
            if char ~= Mem.Entities[1] and not char.Dead then
                local distance = lp:DistanceFromCharacter(char.Humanoid.Parent.HumanoidRootPart.Position)
                if distance < lowest then
                    lowest = distance
                    NearestChar = char
                end
           	end
       	end
    	if NearestChar then 
        	local pos = lp.character.HumanoidRootPart.Position
         	local look = CFrame.lookAt(pos,NearestChar.Humanoid.Parent.HumanoidRootPart.Position)
        	local direction = look.LookVector
         
    		Mem.SpawnProjectile({
				["Name"] = "Class4Barrage",
				["Source"] = Mem.Entities[1].Id,
				["Chromashift"] = true,
				["Model"] = "Class4Barrage",
				["Duration"] = 3,
				["Speed"] = s().speed,
				["Position"] = lp.character.HumanoidRootPart.Position,
				["Direction"] = direction,
				["Inaccuracy"] = s().accuracy *0.1,
				["DamageArgs"] = {
					["Amount"] = s().damage * Mem.Entities[1].Stats.Power[1],
					["Name"] = "SkillTurret",
					["Stagger"] = 0,
					["ScreenShake"] = 0
				},
				["Scripts"] = { "Class4Barrage" },
				["Interactive"] = true
			})
		end
	end
end,{
	damage = {"Damage","Slider",{0,100},1},
 	cooldown = {"Cooldown","Slider",{0,1},0.01},
  	speed = {"Speed","Slider",{0,300},150},
   	accuracy = {"Accuracy","Slider",{0,10},1},
})

Host.NewButton("Kill Entities",function(bool)
    for i,v in pairs(Mem.Entities) do
        if not v.IsPlayer then
            Mem.Entities[i].Resources.Health = 0
        end
    end
end)

Host.NewButton("Remove AI",function()
    for i,v in pairs(Mem.Entities) do
        if not v.IsPlayer then
            Mem.Entities[i].ProcessAI = function() end
        end
    end
end)

Host.NewButton("Unlock Everything",function(bool,s)
    local badgeIds = {
    	2125705092,
    	2125660193,
    	2125281456,
    	2124984207,
    	2124626062,
    	2124626061,
    	2124626060,
    	2124626059
    }
	Mem.Unlocks.HostCreator = true
	for i,v in pairs(MenuConfig.Win) do
     	Mem.Unlocks[i] = true
        Mem.Unlocks[i.."Win"] = true
      	if Mem.Buttons[i] and Mem.TimeHues[i] then
          	local color = Color3.fromHSV(Mem.TimeHues[i], 1, 1)
			Mem.Buttons[i].BorderColor3 = color
			Mem.Buttons[i].ImageColor3 = color
     	end
    end
	for i,v in pairs(badgeIds) do
		game:GetService("ReplicatedStorage"):WaitForChild("BadgeEvent"):FireServer(v)
    end
	Mem.Premium = true
 	Mem.SaveRequest()
end,{
	badges = {"Badges","Switch",true},
})

game:GetService("RunService").Stepped:Connect(function()
    Mem.NoCooldowns = NoCooldowns
    Mem.GodMode = GodMode
    Mem.FastTempo = FastTempo
    if Mem.Entities[1] then
        speedslider.Set(Mem.Entities[1].Stats.Speed[1])
        defenseslider.Set(Mem.Entities[1].Stats.Defense[1])
        powerslider.Set(Mem.Entities[1].Stats.Power[1])
        maxhealthslider.Set(Mem.Entities[1].Stats.MaxHealth[1])
        healthslider.Set(Mem.Entities[1].Resources.Health)
    end
end)

while wait(1.5) do
    if lp.PlayerScripts:FindFirstChild("CoreScript") then
        Mem = getsenv(lp.PlayerScripts.CoreScript)._G
    end
end