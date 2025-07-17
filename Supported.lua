return {
    {
        Type = "GameSupport",
        ID = 6933626061,
        GOTOID = 6933626061,
        GameName = "Tlk Prison",
        WrongSupport = "Please report this to l_l6658",
        Discontinued = true,
        Script = "https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Fragments/Tlk%20prison.lua"
        
    },
	{
     	Type = "GameSupport",
        ID = 6312903733,
        GOTOID = 5561268850,
        GameName = "Randomly Generated Droids",
        WrongSupport = "Please go into a run and execute the script, instead of the Lobby",
        Discontinued = false,
        Script = "https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Fragments/RGD.lua"
    },
	{
        Type = "GameSupport",
        ID = 5732973455,
        GOTOID = 5732973455,
        GameName = "Hours",
        WrongSupport = "yahoo Please report this to l_l6658",
        Discontinued = false,
        Script = "https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Fragments/Hours.lua"
    },
	{
        Type = "GameSupport",
        ID = 12887407169,
        GOTOID = 12887407169,
        GameName = "SROMU",
        WrongSupport = "yahoo Please report this to l_l6658",
        Discontinued = false,
        Script = "https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Fragments/Hours.lua"
    },
	{
     	Type = "Engine",
        EngineMain = 5561268850,
        EngineName = "Robot 64",
        Script = "https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Fragments/Robot64.lua",
    	EngineDetectionMethod = function()
         	local isengine = false
          	if game.Players.LocalPlayer.PlayerScripts:FindFirstChild("CharacterScript") and game:GetService("Workspace"):FindFirstChild("plam") then
               isengine = true
            end
        	return isengine
        end
    }
}