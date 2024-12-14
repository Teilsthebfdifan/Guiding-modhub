local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")
        local Debris = game:GetService("Debris")
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local function modifyPart(part)
    if part:IsA("BasePart") then
        if part.Material == Enum.Material.Neon then
            part.Material = Enum.Material.SmoothPlastic
            part.Color = Color3.fromRGB(0, 0, 0)  -- Black color
        end
    end
end

-- Apply to all current parts in the game
for _, part in ipairs(game:GetDescendants()) do
    modifyPart(part)
end

-- Apply to any newly added parts
game.DescendantAdded:Connect(function(part)
    modifyPart(part)
end)

        -- Function to create fog and dark environment (Less thick fog)
        local function applyNightmareEnvironment()
            Lighting.Ambient = Color3.fromRGB(3, 3, 3) -- Very dark ambient
            Lighting.OutdoorAmbient = Color3.fromRGB(3, 3, 3) -- Darker outdoor ambient
            Lighting.Brightness = 0 -- Set brightness to minimum
            Lighting.FogEnd = 20 -- Reduced fog thickness (can see more)
            Lighting.FogColor = Color3.fromRGB(0, 0, 0) -- Deep black fog
            Lighting.TimeOfDay = "00:00:00" -- Set time to midnight for the darkest atmosphere
        end

        -- Function to remove all existing lights
        local function removeExistingLights()
            for _, light in pairs(workspace:GetDescendants()) do
                if light:IsA("PointLight") or light:IsA("SpotLight") then
                    light:Destroy()
                end
            end
        end

        -- Function to create flashlight tool for players
        local function createFlashlight(player)
            local character = player.Character
            if character then
                -- Create flashlight tool
                local flashlightTool = Instance.new("Tool")
                flashlightTool.Name = "Flashlight"
                flashlightTool.RequiresHandle = true
                flashlightTool.Parent = player.Backpack

                local handle = Instance.new("Part")
                handle.Name = "Handle"
                handle.Size = Vector3.new(1, 4, 1)
                handle.Color = Color3.fromRGB(255, 255, 255) -- Flashlight handle color
                handle.Anchored = false
                handle.CanCollide = false
                handle.Parent = flashlightTool

                local beam = Instance.new("SpotLight")
                beam.Parent = handle
                beam.Brightness = 10
                beam.Range = 50
                beam.Angle = 45
                beam.Color = Color3.fromRGB(255, 255, 255) -- White light
                beam.Enabled = false -- Initially off

                -- Set flashlight to turn on when the tool is equipped
                flashlightTool.Activated:Connect(function()
                    beam.Enabled = true
                end)

                flashlightTool.Deactivated:Connect(function()
                    beam.Enabled = false
                end)

                -- Make sure the flashlight stays in the player's inventory until manually removed
                flashlightTool.Parent = player.Backpack

                Debris:AddItem(flashlightTool, 60) -- Clean up the flashlight after 60 seconds, or keep it in backpack
            end
        end

        -- Function to apply environment settings and flashlight system
        local function applyNightmareEffects()
            applyNightmareEnvironment()
            removeExistingLights()
        end

        -- Apply nightmare environment and fog
        applyNightmareEffects()

        -- Create flashlight for all players
        for _, player in pairs(Players:GetPlayers()) do
            createFlashlight(player)
            player.CharacterAdded:Connect(function()
                createFlashlight(player)
            end)
        end

        -- Apply nightmare effects to new players
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                createFlashlight(player)
            end)
        end)

        -- Make sure new lights are not generated
        workspace.DescendantAdded:Connect(function(part)
            if part:IsA("PointLight") or part:IsA("SpotLight") then
                part:Destroy() -- Remove any new lights
            end
        end)
        
        local function checkForPandemonium()
    local randomValue = math.random(50, 90)

    game.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Model") and tonumber(descendant.Name) == randomValue then
            -- Wait for 240 seconds (4 minutes)
            wait(10)

            -- Load the Pandemonium Spawn Script
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/refs/heads/main/PandemoniumProtected.lua"))()
        end
    end)
end

checkForPandemonium()

local function getGitSoundId(GithubSoundPath: string, AssetName: string): Sound
    local Url = GithubSoundPath

    if not isfile(AssetName..".mp3") then 
        writefile(AssetName..".mp3", game:HttpGet(Url)) 
    end

    local Sound = Instance.new("Sound")
    Sound.SoundId = getcustomasset(AssetName..".mp3", true)
    return Sound 
end

local NightmareHotel = getGitSoundId("https://raw.githubusercontent.com/Teilsthebfdifan/Guiding-modhub/main/Death%20is%20near%20%20Guiding%20Modhub%20OST.mp3", "DeathIsNearNightmareHotel")
NightmareHotel.Parent = game.SoundService
NightmareHotel.Looped = true
NightmareHotel:Play()
