local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/Sn00Ze07/RobloxScript/refs/heads/main/blox_loot.lua'))()
-- local url = "https://raw.githubusercontent.com/Sn00Ze07/RobloxScript/refs/heads/main/blox_loot.lua"
-- local url = "https://raw.githubusercontent.com/Sn00Ze07/RobloxScript/main/blox_loot.lua"
--local script = loadstring(game:HttpGet(url))()

-- local url = "https://raw.githubusercontent.com/Sn00Ze07/RobloxScript/refs/heads/main/blox_loot.lua"
--loadstring(syn.request({ Url = url }).Body)()
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

local Zakladka_main = Window:CreateTab("🏠 Home 🏠", nil) -- Title, Image
local Sekcja_main = Zakladka_main:CreateSection("Main") -- zakładka main w home


Rayfield:Notify({
   Title = "Loaded Blox Loot 1.05",
   Content = "By Sn00Ze",
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

-- VirtualUser auto-click example (integracja z Twoim Rayfield toggle)
local VirtualUser = game:GetService("VirtualUser")
local attackEnabled = false
local BASE_INTERVAL = 0.18   -- minimalny odstęp (sekundy)
local lastSent = 0

-- helper: bezpieczne "kliknięcie" z jitterem
local function safeClick()
    local now = tick()
    if now - lastSent < BASE_INTERVAL then return end
    lastSent = now

    -- drobny jitter żeby nie klikać idealnie regularnie
    local jitter = math.random() * 0.06
    task.delay(jitter, function()
        pcall(function()
            -- CaptureController() czasem pomaga upewnić się, że VirtualUser ma kontekst
            VirtualUser:CaptureController()
            VirtualUser:Button1Down(Vector2.new(0,0)) -- symuluje naciśnięcie LPM
            task.wait(0.03)                            -- krótki czas trzymania przycisku
            VirtualUser:Button1Up(Vector2.new(0,0))   -- puszczenie LPM
        end)
    end)
end

-- start/stop loop (uruchamiane po toggle)
local function startAutoClick()
    spawn(function()
        while attackEnabled do
            safeClick()
            task.wait(0.04) -- mała pauza w pętli, pętla nie jest "uncapped"
        end
    end)
end


local toggle_autoattack = Zakladka_main:CreateToggle({
   Name = "Auto Attack",
   CurrentValue = false,
   Flag = "autoattack",
   Callback = function(Value)
    -- Value = true jeśli włączony, false jeśli wyłączony
        if Value then
            Rayfield:Notify({
                Title = "Auto Attack",
                Content = "Auto Attack ON ✅",
                Duration = 3, -- czas wyświetlania w sekundach
                Image = 13047715178, -- opcjonalnie, ID obrazka z Roblox
                Actions = {} -- możesz dodać przyciski do powiadomienia, ale można zostawić puste
            })
        else
            Rayfield:Notify({
                Title = "Auto Attack",
                Content = "Auto Attack OFF ❌",
                Duration = 3,
                Image = 13047715178,
                Actions = {}
            })
        end
       attackEnabled = Value
       if Value then
           startAutoClick()
       else
           attackEnabled = false
       end
   end
})

local OtherSection = Zakladka_main:CreateSection("Inne")


local Zakladka_teleportow = Window:CreateTab("🏝 Teleports 🏝", nil) -- Title, Image
local Sekcja_teleportow = Zakladka_teleportow:CreateSection("Teleports") -- zakładka main w home


local tp_button1 = Zakladka_teleportow:CreateButton({
   Name = "Starter World",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Teleport gracza
        humanoidRootPart.CFrame = CFrame.new(-67, 113, -142)
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

                    --ZAKŁADKA FARM
local Zakladka_farm = Window:CreateTab("⚔️ Farm ⚔️", nil) -- Title, Image
local Sekcja_farm1 = Zakladka_farm:CreateSection("Mobs") -- zakladka mobilefly

-- == Ustawienia i zmienne ==
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local attackEnabled = false
local autofarmEnabled = false
local BASE_INTERVAL = 0.18
local lastSent = 0

-- Lista mobów
local all_mobs = {
    { Id = "1_1_1", Name = "Chicken" },
    { Id = "1_1_2", Name = "Pig" },
    { Id = "1_1_4", Name = "Llama" },
    { Id = "1_1_5", Name = "Zombie" },
}
local selectedMob = all_mobs[1]

-- Cache mobów
local searchFolder = workspace:FindFirstChild("Mobs") or workspace
local cachedMobs = {}
local cacheRefreshTime = 5
local lastCacheUpdate = 0

-- Odświeżanie cache mobów
local function refreshMobCache()
    cachedMobs = {}
    for _, obj in ipairs(searchFolder:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChildWhichIsA("Humanoid") then
            table.insert(cachedMobs, obj)
        end
    end
    lastCacheUpdate = tick()
end

-- Znajdowanie mobów po ID
local function findMobById(id)
    for _, mob in ipairs(cachedMobs) do
        if string.find(mob.Name, id) then
            return mob
        end
    end
    refreshMobCache()
    for _, mob in ipairs(cachedMobs) do
        if string.find(mob.Name, id) then
            return mob
        end
    end
    return nil
end

refreshMobCache()

-- == Obsługa Character i HRP ==
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(char)
    character = char
    hrp = character:WaitForChild("HumanoidRootPart")
end)

-- == AutoClick ==
local function safeClick()
    local now = tick()
    if now - lastSent < BASE_INTERVAL then return end
    lastSent = now

    local jitter = math.random() * 0.06
    task.delay(jitter, function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:Button1Down(Vector2.new(0,0))
            task.wait(0.03)
            VirtualUser:Button1Up(Vector2.new(0,0))
        end)
    end)
end

local function startAutoClick()
    spawn(function()
        while attackEnabled do
            safeClick()
            task.wait(0.04)
        end
    end)
end

-- == Teleport do mobów ==
local function moveToModelSlow(model, speed)
    if not model or not model.Parent then return end
    if not hrp or not hrp.Parent then return end

    local targetPart = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
    if not targetPart then return end

    local targetPosition = targetPart.Position + Vector3.new(0, 3, 0)
    while (hrp.Position - targetPosition).Magnitude > 0.5 do
        local direction = (targetPosition - hrp.Position).Unit
        hrp.CFrame = hrp.CFrame + direction * speed * task.wait()
        task.wait(0.03)
    end
end

-- == Autofarm ==
local function startAutoFarm()
   spawn(function()
        while autofarmEnabled do
            -- odśwież cache mobów
            if tick() - lastCacheUpdate > cacheRefreshTime then
                refreshMobCache()
            end

            -- znajdź wszystkie moby pasujące do ID
            local targetMobs = {}
            for _, mob in ipairs(cachedMobs) do
                if string.find(mob.Name, selectedMob.Id) then
                    table.insert(targetMobs, mob)
                end
            end

            -- jeśli są moby
            if #targetMobs > 0 then
                for _, mob in ipairs(targetMobs) do
                    if not autofarmEnabled then break end -- zatrzymaj jeśli toggle wyłączony
                    teleportToModel(mob)
                    task.wait(2.0) -- mała przerwa przed kolejnym mobem
                end
            else
                task.wait(1) -- brak mobów, poczekaj chwilę
            end
        end
    end)
end

-- == Toggle autofarm ==
local function toggleAutoFarm(state)
    autofarmEnabled = state
    if state then
        attackEnabled = true
        startAutoClick()
        startAutoFarm()
        print("Auto Farm ON ✅")
    else
        attackEnabled = false
        print("Auto Farm OFF ❌")
    end
end

-- == Dropdown wybór mobów ==
local function selectMobByName(name)
    for _, mob in ipairs(all_mobs) do
        if mob.Name == name then
            selectedMob = mob
            print("Wybrano mob:", selectedMob.Name, "ID:", selectedMob.Id)
            break
        end
    end
end

-- Dropdown do wyboru mobów
local mobNames = {}
for _, mob in ipairs(all_mobs) do
    table.insert(mobNames, mob.Name)
end

local mobDropdown = Zakladka_farm:CreateDropdown({
    Name = "Wybierz potwora",
    Options = mobNames,
    CurrentOption = {mobNames[1]},
    MultipleOptions = false,
    Flag = "mobDropdown",
    Callback = function(Option)
        selectMobByName(Option[1])
        Rayfield:Notify({
            Title = "Wybrano potwora",
            Content = "Cel: "..selectedMob.Name,
            Duration = 3,
            Image = 13047715178
        })
    end,
})

-- Toggle autofarm
local toggle_autofarm = Zakladka_farm:CreateToggle({
    Name = "Auto Farm Mobs",
    CurrentValue = false,
    Flag = "autofarm_mobs",
    Callback = function(Value)
        toggleAutoFarm(Value)
        Rayfield:Notify({
            Title = "Auto Farm",
            Content = Value and "Farmienie włączone ✅" or "Farmienie wyłączone ❌",
            Duration = 3,
            Image = 13047715178
        })
    end
})


local Sekcja_farm2 = Zakladka_farm:CreateSection("Bosses") -- zakładka bossy


local Zakladka_misc = Window:CreateTab("🎲 Misc 🎲", nil) -- Title, Image
local Sekcja_misc = Zakladka_misc:CreateSection("Misc") -- zakładka main w home

local Pasek_speeda = Zakladka_misc:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 75},
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
   Range = {1, 75},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderjp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})

local toggle_noclip = Zakladka_misc:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "noclip", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
 Callback = function(Value)
       -- Value = true jeśli włączony, false jeśli wyłączony
        if Value then
            Rayfield:Notify({
                Title = "Noclip",
                Content = "Noclip włączony ✅",
                Duration = 3, -- czas wyświetlania w sekundach
                Image = 13047715178, -- opcjonalnie, ID obrazka z Roblox
                Actions = {} -- możesz dodać przyciski do powiadomienia, ale można zostawić puste
            })
        else
            Rayfield:Notify({
                Title = "Noclip",
                Content = "Noclip wyłączony ❌",
                Duration = 3,
                Image = 13047715178,
                Actions = {}
            })
        end
       
			end
})

local toggle_nieskonczony_skok = Zakladka_misc:CreateToggle({
   Name = "Nieskończony skok",
   CurrentValue = false,
   Flag = "infinityjump", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
 Callback = function(Value)
       -- Value = true jeśli włączony, false jeśli wyłączony
        if Value then
            Rayfield:Notify({
                Title = "Infinity Jump",
                Content = "Infinity Jump włączony ✅",
                Duration = 3, -- czas wyświetlania w sekundach
                Image = 13047715178, -- opcjonalnie, ID obrazka z Roblox
                Actions = {} -- możesz dodać przyciski do powiadomienia, ale można zostawić puste
            })
        else
            Rayfield:Notify({
                Title = "Infinity Jump",
                Content = "Infinity Jump wyłączony ❌",
                Duration = 3,
                Image = 13047715178,
                Actions = {}
            })
        end
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



local Sekcja_pomocne = Zakladka_misc:CreateSection("Pomocne") -- zakładka Pomocne


local button_ketamine = Zakladka_misc:CreateButton({
   Name = "Ketamine SPY",
   Callback = function()
      Rayfield:Notify({
                Title = "Ketamine SPY",
                Content = "Ketamine SPY włączony ✅",
                Duration = 3, -- czas wyświetlania w sekundach
                Image = 13047715178, -- opcjonalnie, ID obrazka z Roblox
                Actions = {} -- możesz dodać przyciski do powiadomienia, ale można zostawić puste
            })
         loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua"))()
   end,
})
local button_infiniteyield = Zakladka_misc:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      Rayfield:Notify({
                Title = "Infinity Yield",
                Content = "Infinity Yield włączony ✅",
                Duration = 3, -- czas wyświetlania w sekundach
                Image = 13047715178, -- opcjonalnie, ID obrazka z Roblox
                Actions = {} -- możesz dodać przyciski do powiadomienia, ale można zostawić puste
            })
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/refs/heads/master/source'))()
   end,
})



local button_delete = Zakladka_misc:CreateButton({
    Name = "Usuń Sloty 1-20",
    Callback = function()
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local player = Players.LocalPlayer
        local RemoveItemWithSlotInfo = ReplicatedStorage.Runtime.Actors.Player_9131192051.Functions.RemoveItemWithSlotInfo

        -- Pobierz aktualne sloty z bag GUI
        local function getCurrentBagSlots()
            local bagSlots = {}
            local clientActor = player.PlayerScripts.Runtime.Actors.Gui_BagGui_3.ClientActor
            for _, item in pairs(clientActor:GetChildren()) do
                if item:IsA("Folder") and item:FindFirstChild("Items") then
                    for _, slot in pairs(item.Items:GetChildren()) do
                        table.insert(bagSlots, slot)
                    end
                end
            end
            return bagSlots
        end

        local bagSlots = getCurrentBagSlots()

        -- Usuń sloty 1 do 20
        for slotId = 1, 20 do
            for _, slot in pairs(bagSlots) do
                if slot:FindFirstChild("SlotId") and slot.SlotId.Value == slotId then
                    pcall(function()
                        RemoveItemWithSlotInfo:InvokeServer({
                            SlotId = slot.SlotId.Value,
                            SlotType = slot.SlotType.Value,
                            ItemId = slot.ItemId.Value,
                            ItemUid = slot.ItemUid.Value
                        })
                    end)
                    break -- przerywamy po usunięciu aktualnego slotu
                end
            end
        end

        print("Próba usunięcia slotów 1-20 zakończona.")
    end,
})


--[[
local InfiniteYield = Zakladka_misc:CreateToggle({
   Name = "InfiniteYield",
   CurrentValue = false,
   Flag = "InfiniteYield", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
 Callback = function(Value)
       -- Value = true jeśli włączony, false jeśli wyłączony
        if Value then
            Rayfield:Notify({
                Title = "InfiniteYield",
                Content = "InfiniteYield włączony ✅",
                Duration = 3, -- czas wyświetlania w sekundach
                Image = 13047715178, -- opcjonalnie, ID obrazka z Roblox
                Actions = {} -- możesz dodać przyciski do powiadomienia, ale można zostawić puste
            })
        else
            Rayfield:Notify({
                Title = "InfiniteYield",
                Content = "InfiniteYield wyłączony ❌",
                Duration = 3,
                Image = 13047715178,
                Actions = {}
            })
        end
       -- loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/refs/heads/master/source'))()
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
