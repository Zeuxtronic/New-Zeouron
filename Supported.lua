return {
    {
        Type = "GameSupport",
        ID = 6933626061,
        GOTOID = 6933626061,
        GameName = "Tlk Prison",
        Script = function() 
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Fragments/Tlk%20prison.lua'))()
        end
    },
	{
     	Type = "GameSupport",
        ID = 6312903733,
        GOTOID = 5561268850,
        GameName = "Randomly Generated Droids",
        Script = function() 
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Fragments/RGD.txt'))()
        end
    },
	{
     	Type = "Engine",
        EngineMain = 5561268850,
        EngineName = "Robot 64",
        Script = function() 
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Fragments/Robot64.lua'))()
        end,
    	EngineDetectionMethod = function()
         	local isengine = false
          	if game:GetService("Workspace").Name == "stinky" then
               isengine = true
            end
        	return isengine
        end
    }
}