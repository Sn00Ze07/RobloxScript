local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/Sn00Ze07/RobloxScript/refs/heads/main/blox_loot.lua'))()
-- local url = "https://raw.githubusercontent.com/Sn00Ze07/RobloxScript/refs/heads/main/blox_loot.lua"
-- local url = "https://raw.githubusercontent.com/Sn00Ze07/RobloxScript/main/blox_loot.lua"
--local script = loadstring(game:HttpGet(url))()
local Window = Rayfield:CreateWindow({
   Name = "Blox loot by Sn00Ze",
   LoadingTitle = "Blox loot by Sn00Ze",
   LoadingSubtitle = "by Sn00Ze",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Sn00Ze Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key System | Blox loot by Sn00Ze",
      Subtitle = "Key System",
      Note = "Key In Discord Server",
      FileName = "keytest", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://raw.githubusercontent.com/Sn00Ze07/RobloxScript/refs/heads/main/keytest"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Zakladka_main = Window:CreateTab("🏠 Home", nil) -- Title, Image
local Sekcja_main = Zakladka_main:CreateSection("Główne") -- zakładka main w home


Rayfield:Notify({
   Title = "Załadowano Blox Loot 1.01",
   Content = "Very cool gui",
   Duration = 5,
   Image = 13047715178,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Okay!",
         Callback = function()
         print("The user tapped Okay!")
      end
   },
},
})

local OtherSection = Zakladka_main:CreateSection("Inne")


local Zakladka_teleportow = Window:CreateTab("🏝 Teleports", nil) -- Title, Image
local Sekcja_teleportow = Zakladka_teleportow:CreateSection("Teleports") -- zakładka main w home


local tp_button1 = Zakladka_teleportow:CreateButton({
   Name = "Wyspa 1",
   Callback = function()
        --Teleport1
   end,
})

local tp_button2 = Zakladka_teleportow:CreateButton({
   Name = "Wyspa 2",
   Callback = function()
        --Teleport2
   end,
})

local tp_button3 = Zakladka_teleportow:CreateButton({
   Name = "Wyspa 3",
   Callback = function()
        --Teleport3
   end,
})

local Zakladka_misc = Window:CreateTab("🎲 Misc", nil) -- Title, Image
local Sekcja_misc = Zakladka_misc:CreateSection("Misc") -- zakładka main w home

local Pasek_speeda = Zakladka_misc:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderws", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Pasek_skoku = Zakladka_misc:CreateSlider({
   Name = "JumpPower Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderjp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})

local toggle_nieskonczony_skok = Zakladka_misc:CreateToggle({
   Name = "Nieskończony skok",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function()
       --Toggles the infinite jump between on or off on every script run
_G.infinjump = not _G.infinjump

if _G.infinJumpStarted == nil then
	--Ensures this only runs once to save resources
	_G.infinJumpStarted = true
	
	--Notifies readiness
	game.StarterGui:SetCore("SendNotification", {Title="Youtube Hub"; Text="Infinite Jump Activated!"; Duration=5;})

	--The actual infinite jump
	local plr = game:GetService('Players').LocalPlayer
	local m = plr:GetMouse()
	m.KeyDown:connect(function(k)
		if _G.infinjump then
			if k:byte() == 32 then
			humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
			humanoid:ChangeState('Jumping')
			wait()
			humanoid:ChangeState('Seated')
			end
		end
	end)
end
   end,
})


--[[ Dodatkowe funkcje do rozwijania w przyszłości

//Pasek wyboru 
local Dropdown = MainTab:CreateDropdown({
   Name = "Select Area",
   Options = {"Starter World","Pirate Island","Pineapple Paradise"},
   CurrentOption = {"Starter World"},
   MultipleOptions = false,
   Flag = "dropdownarea", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
        print(Option)
   end,
})

 //Przycisk zielony wlaczony-wylaczony
local Toggle = Zakladka_main:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        print("FARMING")
   end,
})

//Wpisywanie wartosci od do 1-500
local Input = Zakladka_main:CreateInput({
   Name = "Walkspeed",
   PlaceholderText = "1-500",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Text)
   end,
})


--]]
