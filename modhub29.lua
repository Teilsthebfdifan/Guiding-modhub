local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Guiding Modhub V2.9",
    Icon = 139708924790241, -- Icon in Topbar. Use Roblox Image ID or Lucide Icons (string). Use 0 for no icon.
    LoadingTitle = "GUIDING",
    LoadingSubtitle = "MODHUB",
    Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes for available themes.

    DisableRayfieldPrompts = false, -- Set to true to disable Rayfield notifications/prompts.
    DisableBuildWarnings = false, -- Prevents Rayfield from warning about version mismatches.

    ConfigurationSaving = {
        Enabled = true, -- Enables saving settings/configuration to local storage.
        FolderName = "GuidingModhub", -- Folder name where configuration will be saved.
        FileName = "GMH" -- File name for the configuration file.
    },
    
    Discord = {
        Enabled = true, -- Enables the Discord integration feature.
        Invite = "fDKHZxGuuT", -- The Discord invite code (omit "discord.gg/").
        RememberJoins = true -- Set to false to prompt users to join the Discord every time.
    },

    KeySystem = true, -- Enables the key system.
    KeySettings = {
        Title = "Guiding Modhub Key System", -- Title of the key system prompt.
        Subtitle = "This function can be removed if you want! This function can get removed soon.", -- Subtitle for additional context.
        Note = "Go to our Discord or ask your friend if they got it.", -- Note to inform users how to acquire the key.
        FileName = "GuidingKey", -- Unique file name to save the key locally.
        SaveKey = true, -- Allows the script to save the key locally for future use.
        GrabKeyFromSite = false, -- Set to true to fetch the key from a remote source.
        Key = {"ILOVELITHUB", "GUIDINGLIGHT", "browhat"} -- List of valid keys.
    }
})

local MC = Window:CreateTab("Map Configurations", 139708924790241) -- Title, Image

-- Create the button
local ExplodingHotelButton = MC:CreateButton({
    Name = "Exploding Hotel",
    Callback = function()
    local function getGitSoundId(GithubSoundPath: string, AssetName: string): Sound
    local Url = GithubSoundPath

    if not isfile(AssetName..".mp3") then 
        writefile(AssetName..".mp3", game:HttpGet(Url)) 
    end

    local Sound = Instance.new("Sound")
    Sound.SoundId = getcustomasset(AssetName..".mp3", true)
    return Sound 
end

local ExplodingHotel = getGitSoundId("https://raw.githubusercontent.com/Teilsthebfdifan/Guiding-modhub/main/FNF%20Indie%20Cross%20V1%20OST%20-%20Last%20Reel%20Instrumental.mp3", "ExplodingHotel")
ExplodingHotel.Parent = game.SoundService
ExplodingHotel.Looped = true
ExplodingHotel:Play()

        local Players = game:GetService("Players")
        local Debris = game:GetService("Debris")
        local RunService = game:GetService("RunService")
        local cooldown = false

-- Function to modify parts near the explosion (without unanchoring)
local function modifyNearbyParts(position, radius)
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and (part.Position - position).Magnitude <= radius then
            part.Material = Enum.Material.Foil
            part.Color = Color3.new(0, 0, 0) -- Black
            -- Removed unanchoring behavior
        end
    end
end

        -- Function to handle explosions
        local function createExplosion()
            if cooldown then return end
            cooldown = true
            
            -- Get random part in the workspace
            local parts = workspace:GetDescendants()
            local randomPart = parts[math.random(1, #parts)]

            if randomPart:IsA("BasePart") then
                local explosion = Instance.new("Explosion")
                explosion.Position = randomPart.Position
                explosion.BlastRadius = 10
                explosion.BlastPressure = 500
                explosion.Parent = workspace

                -- Modify nearby parts
                modifyNearbyParts(randomPart.Position, 10)

                -- Damage nearby players
                for _, player in pairs(Players:GetPlayers()) do
                    local character = player.Character
                    if character and character:FindFirstChild("Humanoid") and character.PrimaryPart then
                        local distance = (character.PrimaryPart.Position - explosion.Position).Magnitude
                        if distance <= 10 then
                            character.Humanoid:TakeDamage(1000)
                        end
                    end
                end

                -- Sometimes create a second explosion
                if math.random() < 0.3 then
                    task.wait(0.1) -- Short delay for the second explosion
                    local secondExplosion = Instance.new("Explosion")
                    secondExplosion.Position = randomPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
                    secondExplosion.BlastRadius = 10
                    secondExplosion.BlastPressure = 500
                    secondExplosion.Parent = workspace

                    -- Modify nearby parts
                    modifyNearbyParts(secondExplosion.Position, 10)
                end
            end

            -- Cooldown
            task.wait(1)
            cooldown = false
        end

        -- Apply explosions to newly added parts
        workspace.DescendantAdded:Connect(function(part)
            if part:IsA("BasePart") then
                task.spawn(function()
                    task.wait(math.random(1, 2)) -- Random delay for new explosions
                    createExplosion()
                end)
            end
        end)

        -- Run explosions at random intervals
        while true do
            task.wait(math.random(1, 2)) -- Random delay for explosions
            createExplosion()
        end
        
Rayfield:Notify({
   Title = "Map Configuration",
   Content = "Exploding hotel has been intiated successfully! Now playing : Indie cross : Last Reel",
   Duration = 6.5,
   Image = 94901032618035,
})
    end,
})

-- Create the button
local SeekInfectionButton = MC:CreateButton({
    Name = "Seek Infection",
    Callback = function()
        local Workspace = game:GetService("Workspace")
        local Debris = game:GetService("Debris")

        -- Z to modify parts
        local function modifyPart(part)
            if part:IsA("BasePart") then
                -- Change material and color
                part.Material = Enum.Material.Foil
                part.Color = Color3.new(0, 0, 0) -- Pure black

                -- Apply texture to all faces
                for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                    local texture = Instance.new("Texture")
                    texture.Texture = "rbxassetid://96553580060421"
                    texture.Face = face
                    texture.StudsPerTileU = 5  -- Adjust tile size
                    texture.StudsPerTileV = 5
                    texture.Parent = part
                end
            end
        end

        -- Apply to all current parts in Workspace
        for _, part in ipairs(Workspace:GetDescendants()) do
            modifyPart(part)
        end

        -- Apply to any newly added parts
        Workspace.DescendantAdded:Connect(function(part)
            modifyPart(part)
        end)
    end,
})

local DreamscapeHotel = MC:CreateButton({
    Name = "Dreamscape Hotel (LAG AND FLASHBANG)",
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local TweenService = game:GetService("TweenService")
        local Debris = game:GetService("Debris")

        local function modifyPartToDream(part)
            if part:IsA("BasePart") then
                if math.random() < 0.1 then
                    part.Color = Color3.fromRGB(0, 0, 0)
                else
                    part.Color = Color3.fromRGB(math.random(200, 255), math.random(200, 255), math.random(200, 255))
                end
                
                part.Material = Enum.Material.Neon
                part.Transparency = 0.3

                local dreamParticles = Instance.new("ParticleEmitter")
                dreamParticles.Texture = "rbxassetid://139681984012530"
                dreamParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), part.Color)
                dreamParticles.Lifetime = NumberRange.new(1, 2)
                dreamParticles.Rate = 3
                dreamParticles.Speed = NumberRange.new(2, 5)
                dreamParticles.Parent = part

                Debris:AddItem(dreamParticles, 5)
            end
        end

        for _, part in pairs(workspace:GetDescendants()) do
            modifyPartToDream(part)
        end

        workspace.DescendantAdded:Connect(function(part)
            modifyPartToDream(part)
        end)

        local dreamSound = Instance.new("Sound")
        dreamSound.SoundId = "rbxassetid://9047050075"
        dreamSound.Volume = 0.5
        dreamSound.Looped = true
        dreamSound.Parent = workspace
        dreamSound:Play()

        local function applyGlowEffect(player)
            if player.Character then
                local glow = Instance.new("PointLight")
                glow.Color = Color3.fromRGB(255, 255, 255)
                glow.Brightness = 2
                glow.Range = 10
                glow.Parent = player.Character:FindFirstChild("HumanoidRootPart")
            end
        end

        for _, player in pairs(Players:GetPlayers()) do
            applyGlowEffect(player)
            player.CharacterAdded:Connect(function()
                applyGlowEffect(player)
            end)
        end

        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                applyGlowEffect(player)
            end)
        end)
    end,
})

local GalaxyHotel = MC:CreateButton({
    Name = "Galaxy Hotel (Space Gravity and Purple Parts)",
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Debris = game:GetService("Debris")
        local Lighting = game:GetService("Lighting")

        -- Function to create star effects randomly appearing around parts
        local function createStarsAroundObjects()
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    local starChance = math.random()
                    if starChance < 0.1 then -- 10% chance to add stars to this part
                        local star = Instance.new("Part")
                        star.Shape = Enum.PartType.Ball
                        star.Size = Vector3.new(0.2, 0.2, 0.2)
                        star.Position = part.Position + Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
                        star.Anchored = true
                        star.CanCollide = false
                        star.Color = Color3.fromRGB(255, 255, 255)
                        star.Material = Enum.Material.Neon
                        local starDecal = Instance.new("Decal")
                        starDecal.Texture = "rbxassetid://110655154102380" -- The star texture ID
                        starDecal.Parent = star
                        star.Parent = workspace
                        Debris:AddItem(star, 10) -- Remove the star after 10 seconds
                    end
                end
            end
        end

        -- Function to change the environment to a galaxy look
        local function createGalaxyEnvironment()
            Lighting.Ambient = Color3.fromRGB(0, 0, 0) -- Dark ambient for space look
            Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 100) -- Faint galaxy background
            game.Lighting.TimeOfDay = "00:00:00" -- Set it to night for the stars to show better
        end

        -- Space gravity effect: sliding movement without changing walk speed
        local function applySpaceGravity(player)
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.UseJumpPower = false -- Disable default jump mechanics for space movement
                    humanoid.JumpHeight = 0 -- No jumping in space

                    -- Apply custom gravity-like effect
                    RunService.Heartbeat:Connect(function()
                        -- Make the character slide based on movement direction
                        local moveDirection = humanoid.MoveDirection
                        local slideFactor = 0.15  -- How much they slide per movement (adjust for more/less sliding)
                        
                        -- Slide the character's position along with the move direction
                        character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.new(moveDirection * slideFactor))
                    end)
                end
            end
        end

        -- Apply galaxy environment and space gravity effect to all players
        createGalaxyEnvironment()
        for _, player in pairs(Players:GetPlayers()) do
            createStarsAroundObjects()
            applySpaceGravity(player)
            player.CharacterAdded:Connect(function()
                createStarsAroundObjects()
                applySpaceGravity(player)
            end)
        end

        -- Apply effects to new players
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                createStarsAroundObjects()
                applySpaceGravity(player)
            end)
        end)

        -- Function to make parts purple and transparent
        local function modifyPartsForGalaxyEffect(part)
            -- Exclude parts with star decals from the effect
            if part:IsA("BasePart") and not part:FindFirstChildOfClass("Decal") then
                part.Color = Color3.fromRGB(128, 0, 128) -- Purple color
            end
        end

        -- Loop through all parts and apply purple and transparent effect
        for _, part in pairs(workspace:GetDescendants()) do
            modifyPartsForGalaxyEffect(part)
        end

        -- Apply purple and transparent effect to new parts as they are added
        workspace.DescendantAdded:Connect(function(part)
            modifyPartsForGalaxyEffect(part)
        end)

        -- Periodically create stars around parts
        RunService.Heartbeat:Connect(function()
            createStarsAroundObjects()
        end)
    end,
})

local OG_RobloxHotel = MC:CreateButton({
    Name = "OG Roblox Hotel (2016 Graphics and Studded Parts)",
    Callback = function()
        local Players = game:GetService("Players")
        local Lighting = game:GetService("Lighting")

        -- Function to change environment to 2016 Roblox style
        local function applyOGEnvironment()
            Lighting.Ambient = Color3.fromRGB(100, 100, 100)
            Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
            Lighting.TimeOfDay = "12:00:00" -- Noon for the classic lighting
            Lighting.ShadowSoftness = 1
            Lighting.FogEnd = 100
            Lighting.Brightness = 2
        end

        -- Function to add a studded texture to all parts
        local function applyStudsTexture(part)
            if part:IsA("BasePart") then
                -- Create a Texture instance for each face
                for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                    local studsTexture = Instance.new("Texture")
                    studsTexture.Texture = "rbxassetid://120052148024636" -- Studs texture
                    studsTexture.Face = face
                    studsTexture.StudsPerTileU = 5
                    studsTexture.StudsPerTileV = 5
                    studsTexture.Parent = part
                end
                part.Material = Enum.Material.SmoothPlastic -- Classic material
                -- Do not change part color, retain the original
            end
        end

        -- Function to apply OG Roblox style to all parts
        local function applyOGRobloxStyle()
            for _, part in pairs(workspace:GetDescendants()) do
                applyStudsTexture(part)
            end

            workspace.DescendantAdded:Connect(function(part)
                applyStudsTexture(part)
            end)
        end

        -- Apply 2016 Roblox environment and studded parts
        applyOGEnvironment()
        applyOGRobloxStyle()
    end,
})

local UnderwaterHotel = MC:CreateButton({
    Name = "Underwater Hotel",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")
        local Debris = game:GetService("Debris")

        -- Function to create underwater visual effects
        local function applyUnderwaterEffects()
            Lighting.Ambient = Color3.fromRGB(0, 70, 130) -- Blueish ambient
            Lighting.OutdoorAmbient = Color3.fromRGB(0, 60, 120) -- Deep blue tones
            Lighting.Brightness = 0.5
            Lighting.FogEnd = 100 -- Add fog for underwater visibility
            Lighting.FogColor = Color3.fromRGB(0, 90, 150) -- Deep ocean fog
            Lighting.EnvironmentSpecularScale = 0.2 -- Dim lighting reflections
        end

        -- Function to add underwater decor
        local function addUnderwaterDecor()
            for i = 1, 20 do
                local bubble = Instance.new("Part")
                bubble.Size = Vector3.new(math.random(1, 3), math.random(1, 3), math.random(1, 3))
                bubble.Shape = Enum.PartType.Ball
                bubble.Position = Vector3.new(math.random(-50, 50), math.random(1, 10), math.random(-50, 50))
                bubble.Anchored = true
                bubble.Material = Enum.Material.SmoothPlastic
                bubble.Color = Color3.fromRGB(180, 220, 255) -- Light blue bubble color
                
                -- Bubble particle effect
                local bubbleParticles = Instance.new("ParticleEmitter")
                bubbleParticles.Texture = "rbxassetid://243660364" -- Bubble texture ID
                bubbleParticles.Size = NumberSequence.new(0.5, 1)
                bubbleParticles.Lifetime = NumberRange.new(2, 5)
                bubbleParticles.Rate = 5
                bubbleParticles.VelocitySpread = 360
                bubbleParticles.Speed = NumberRange.new(2, 5)
                bubbleParticles.Parent = bubble
                
                bubble.Parent = workspace
                Debris:AddItem(bubble, 20) -- Remove after 20 seconds
            end
        end

        -- Function to make parts look submerged
        local function modifyPartsForUnderwaterEffect(part)
            if part:IsA("BasePart") then
                part.Color = Color3.fromRGB(0, 100, 150) -- Watery blue
                part.Transparency = 0.4 -- Semi-transparent
                part.Material = Enum.Material.Glass -- Glassy, submerged effect
            end
        end

        -- Apply underwater effect to existing parts
        for _, part in pairs(workspace:GetDescendants()) do
            modifyPartsForUnderwaterEffect(part)
        end

        -- Apply underwater effect to new parts
        workspace.DescendantAdded:Connect(function(part)
            modifyPartsForUnderwaterEffect(part)
        end)

        -- Create underwater visuals
        applyUnderwaterEffects()

        -- Periodically add underwater decor
        RunService.Heartbeat:Connect(function()
            addUnderwaterDecor()
        end)
    end,
})

local CandylandHotel = MC:CreateButton({
    Name = "Candyland Hotel (Sugary Wonderland)",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        local Debris = game:GetService("Debris")

        -- Function to apply Candyland visuals
        local function transformToCandyland()
            Lighting.Ambient = Color3.fromRGB(255, 200, 200)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 180, 200)
            Lighting.Brightness = 2
            Lighting.ClockTime = 12

            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    local textureChance = math.random()
                    if textureChance < 0.2 then
                        local decal = Instance.new("Decal")
                        decal.Texture = "rbxassetid://7097204363"
                        decal.Face = Enum.NormalId.Top
                        decal.Parent = part
                    elseif textureChance < 0.4 then
                        local decal = Instance.new("Decal")
                        decal.Texture = "rbxassetid://7097202918"
                        decal.Face = Enum.NormalId.Front
                        decal.Parent = part
                    elseif textureChance < 0.6 then
                        part.Color = Color3.fromRGB(math.random(200, 255), math.random(100, 255), math.random(200, 255))
                        part.Material = Enum.Material.SmoothPlastic
                    end
                end
            end
        end

        -- Function to add candy decor
        local function addCandyDecor()
            for i = 1, 20 do
                local candy = Instance.new("Part")
                candy.Size = Vector3.new(math.random(2, 5), math.random(2, 5), math.random(2, 5))
                candy.Shape = Enum.PartType.Ball
                candy.Position = Vector3.new(math.random(-100, 100), math.random(5, 20), math.random(-100, 100))
                candy.Anchored = true
                candy.Material = Enum.Material.Neon
                candy.Color = Color3.fromRGB(math.random(200, 255), math.random(100, 255), math.random(200, 255))

                local candyTypeChance = math.random()
                if candyTypeChance < 0.5 then
                    local decal = Instance.new("Decal")
                    decal.Texture = "rbxassetid://7097205403"
                    decal.Face = Enum.NormalId.Top
                    decal.Parent = candy
                end

                candy.Parent = workspace
                Debris:AddItem(candy, 60)
            end
        end

        -- Transform the map and players
        transformToCandyland()
        addCandyDecor()
    end,
})

local NightmareHotel = MC:CreateButton({
    Name = "Nightmare Hotel",
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/umRteEPy"))()
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")
        local Debris = game:GetService("Debris")
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        -- Function to create fog and dark environment (Less thick fog)
        local function applyNightmareEnvironment()
            Lighting.Ambient = Color3.fromRGB(5, 5, 5) -- Very dark ambient
            Lighting.OutdoorAmbient = Color3.fromRGB(5, 5, 5) -- Darker outdoor ambient
            Lighting.Brightness = 0 -- Set brightness to minimum
            Lighting.FogEnd = 100 -- Reduced fog thickness (can see more)
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

        -- Wait for 240 seconds (4 minutes)
        wait(240)

        -- Load the Pandemonium Spawn Script
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/refs/heads/main/PandemoniumProtected.lua"))()
    end,
})

-- Frozen Hotel Button
local FrozenHotelButton = MC:CreateButton({
   Name = "Frozen Hotel",
   Callback = function()
      local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
      local TweenService = game:GetService("TweenService")
      local Debris = game:GetService("Debris")

      -- Function to modify material and properties
      local function modifyPart(part)
         if part:IsA('BasePart') then
            -- Change all materials to Ice (Frozen Hotel)
            part.Material = Enum.Material.Ice
            -- Change color to the icy tone
            part.Color = Color3.fromRGB(195, 185, 165) -- Example color based on image
            -- Adjust slipperiness for moderate sliding
            part.CustomPhysicalProperties = PhysicalProperties.new(0.2, 0.1, 0.2, 0, 0) -- Moderate friction
         elseif part:IsA('Decal') or part:IsA('Texture') then
            -- Change decals to match the color
            part.Color3 = Color3.fromRGB(195, 185, 165) -- Same icy color
         end
      end

      -- Function to apply enhanced cold effect
      local function applyColdEffect(player)
         if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            -- Create a more visible cold effect
            local playerGui = player:FindFirstChild("PlayerGui")
            if not playerGui then return end

            local coldEffectGui = Instance.new("ScreenGui")
            coldEffectGui.Name = "ColdEffect"
            coldEffectGui.Parent = playerGui

            local whiteFrame = Instance.new("Frame")
            whiteFrame.BackgroundColor3 = Color3.new(1, 1, 1)
            whiteFrame.BackgroundTransparency = 1
            whiteFrame.Size = UDim2.new(1.5, 0, 1.5, 0)
            whiteFrame.Position = UDim2.new(-0.25, 0, -0.25, 0)
            whiteFrame.Parent = coldEffectGui

            -- Enhanced fade-in effect
            local fadeIn = TweenService:Create(whiteFrame, TweenInfo.new(1), {BackgroundTransparency = 0.3})
            fadeIn:Play()
            fadeIn.Completed:Wait()

            -- Wait for 5 seconds
            task.delay(5, function()
               -- Gradually fade out the effect
               local fadeOut = TweenService:Create(whiteFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
               fadeOut:Play()
               fadeOut.Completed:Wait()

               coldEffectGui:Destroy() -- Remove effect
            end)
         end
      end

      -- Loop through all existing descendants in Workspace
      for _, v in pairs(game.Workspace:GetDescendants()) do
         modifyPart(v)
      end

      -- Apply changes to newly added parts
      game.Workspace.DescendantAdded:Connect(function(v)
         modifyPart(v)
      end)

      -- Freeze all players and apply cold effect randomly
      for _, player in pairs(Players:GetPlayers()) do
         -- Randomly apply the cold effect
         task.spawn(function()
            while true do
               task.wait(math.random(10, 30)) -- Random delay between 10-30 seconds
               applyColdEffect(player)
            end
         end)
      end

      -- Apply cold effect to new players who join
      Players.PlayerAdded:Connect(function(player)
         player.CharacterAdded:Connect(function()
            -- Randomly apply the cold effect
            task.spawn(function()
               while true do
                  task.wait(math.random(10, 30)) -- Random delay between 10-30 seconds
                  applyColdEffect(player)
               end
            end)
         end)
      end)
   end
})

-- Burning Hotel Button
local BurningHotelButton = MC:CreateButton({
   Name = "Burning Hotel",
   Callback = function()
        local imageId = "rbxassetid://123255108092070" -- Fire image texture ID

        local function applyFireEffect(part)
            -- Check if the part is a BasePart and not part of a player's character
            if part:IsA("BasePart") and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and not part:FindFirstChild("FireParticle") then
                local particleEmitter = Instance.new("ParticleEmitter")
                particleEmitter.Name = "FireParticle" -- Prevent duplicate emitters
                particleEmitter.Texture = imageId
                particleEmitter.Parent = part

                -- Fire particle properties (adjusted size for the video effect)
                particleEmitter.Rate = 50 -- Emit particles at a moderate rate
                particleEmitter.Lifetime = NumberRange.new(0.5, 1) -- Shorter lifespan
                particleEmitter.Speed = NumberRange.new(2, 4) -- Upward motion for flames
                particleEmitter.VelocitySpread = 180 -- Full spread
                particleEmitter.RotSpeed = NumberRange.new(50, 100) -- Rotation for dynamic flames
                particleEmitter.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.3), -- Start smaller
                    NumberSequenceKeypoint.new(0.5, 1), -- Maximum size
                    NumberSequenceKeypoint.new(1, 0.5) -- Shrink slightly before disappearing
                })
                particleEmitter.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 0.6, 0)), -- Bright orange
                    ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.2, 0)), -- Red-orange
                    ColorSequenceKeypoint.new(1, Color3.new(0.2, 0, 0)) -- Dark red
                })
                particleEmitter.LightEmission = 0.5 -- Subtle glow
                particleEmitter.Acceleration = Vector3.new(0, 3, 0) -- Upward motion
            end
        end

        -- Initial application to all existing parts
        for _, obj in ipairs(workspace:GetDescendants()) do
            applyFireEffect(obj)
        end

        -- Continuous application for new parts
        workspace.DescendantAdded:Connect(applyFireEffect)
   end,
})
local ElectricalHotel = MC:CreateButton({
   Name = "Electrical Hotel",
   Callback = function()
      local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
      local TweenService = game:GetService("TweenService")
      local Debris = game:GetService("Debris")
      local SoundService = game:GetService("SoundService")

      -- Function to modify all parts to DiamondPlate and color them gray
      local function modifyPartToGray(part)
         if part:IsA("BasePart") then
            part.Material = Enum.Material.DiamondPlate
            part.Color = Color3.fromRGB(47, 47, 47) -- Gray color
         end
      end

      -- Modify all existing parts in the workspace
      for _, v in pairs(game.Workspace:GetDescendants()) do
         modifyPartToGray(v)
      end

      -- Apply changes to newly added parts
      game.Workspace.DescendantAdded:Connect(function(v)
         modifyPartToGray(v)
      end)

      -- Electrocuting effect (blue explosion)
      local function applyElectricShock(part)
         if part:IsA("BasePart") then
            -- Create the visual effect
            local shock = Instance.new("ParticleEmitter")
            shock.Texture = "rbxassetid://110655154102380" -- The blue electric shock texture
            shock.Parent = part
            shock.Color = ColorSequence.new(Color3.fromRGB(0, 0, 255)) -- Blue color
            shock.Lifetime = NumberRange.new(0.5, 1)
            shock.Rate = 100
            shock.Speed = NumberRange.new(5, 10)
            shock.Enabled = true

            -- Play the electric sound
            local electricSound = Instance.new("Sound")
            electricSound.SoundId = "rbxassetid://92630376907021" -- Sound ID for electricity
            electricSound.Parent = part
            electricSound:Play()

            -- Destroy shock and sound after a short time
            Debris:AddItem(shock, 1)
            Debris:AddItem(electricSound, 1)

            -- Apply 1.5 damage to any player near the electric shock
            local playersInRange = {}
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character and character:FindFirstChild("Humanoid") and character.PrimaryPart then
                    if (character.PrimaryPart.Position - part.Position).Magnitude < 10 then
                        table.insert(playersInRange, player)
                    end
                end
            end

            for _, player in pairs(playersInRange) do
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:TakeDamage(1.5)
                end
            end
         end
      end

      -- Randomly electrocute parts in the game
      RunService.Heartbeat:Connect(function()
         if math.random() < 0.01 then
            local parts = game.Workspace:GetDescendants()
            local randomPart = parts[math.random(1, #parts)]
            applyElectricShock(randomPart)
         end
      end)

      -- Walking sound effect
      local function playWalkingSound(player)
         local character = player.Character
         if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
               local walkingSound = Instance.new("Sound")
               walkingSound.SoundId = "rbxassetid://3477114901" -- Walking sound ID
               walkingSound.Parent = character:FindFirstChild("HumanoidRootPart")
               walkingSound.Looped = true
               walkingSound.Volume = 0.5 -- Adjust volume if needed

               humanoid.Running:Connect(function(speed)
                  if speed > 0 then
                     if not walkingSound.IsPlaying then
                        walkingSound:Play()
                     end
                  else
                     if walkingSound.IsPlaying then
                        walkingSound:Stop()
                     end
                  end
               end)
            end
         end
      end

      -- Apply walking sound effect to all players
      for _, player in pairs(Players:GetPlayers()) do
         if player.Character then
            playWalkingSound(player)
         end
         player.CharacterAdded:Connect(function()
            playWalkingSound(player)
         end)
      end

      -- Handle new players joining
      Players.PlayerAdded:Connect(function(player)
         player.CharacterAdded:Connect(function()
            playWalkingSound(player)
         end)
      end)

   end,
})
local Items = Window:CreateTab("Items", 80766523275072) -- Title, Image
local Section = Items:CreateSection("Mods")
local MoonJug = Items:CreateButton({
    Name = "Barrel of Moonlight",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local MoonJug = game:GetObjects("rbxassetid://116205602433350")[1]
        local speedTweenValue = Instance.new("NumberValue", MoonJug)
        local durability = 10
        local debounce = false
        MoonJug:SetAttribute("Durability", durability)

        MoonJug.Parent = game.Players.LocalPlayer.Backpack

        local character = game.Players.LocalPlayer.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        local Animations = MoonJug:WaitForChild("Animations")
        local LoadedAnims = {}

        for _, anim in pairs(Animations:GetChildren()) do
            LoadedAnims[anim.Name] = humanoid:LoadAnimation(anim)

            if anim.Name == "idle" then
                LoadedAnims[anim.Name].Priority = Enum.AnimationPriority.Idle
                LoadedAnims[anim.Name].Looped = true
            end
        end

        MoonJug.Equipped:Connect(function()
            LoadedAnims["equip"]:Play()
            task.wait(LoadedAnims["equip"].Length)
            if MoonJug:IsDescendantOf(character) then
                LoadedAnims["idle"]:Play()
            end
        end)

        MoonJug.Unequipped:Connect(function()
            if LoadedAnims["idle"].IsPlaying then
                LoadedAnims["idle"]:Stop()
            end
        end)

        MoonJug.Activated:Connect(function()
            if debounce then return end
            debounce = true

            LoadedAnims["open"]:Play()

            if durability - 1 ~= 0 then
                durability = durability - 1
                MoonJug:SetAttribute("Durability", durability)
            else
                MoonJug:Destroy()
            end

            character:SetAttribute("Starlight", true)

            -- Add Moonlight icon to the screen
            local player = game.Players.LocalPlayer
            local screenGui = player:FindFirstChildOfClass("PlayerGui")
            if not screenGui then
                screenGui = Instance.new("ScreenGui")
                screenGui.Parent = player:WaitForChild("PlayerGui")
            end

            local moonlightIcon = Instance.new("ImageLabel")
            moonlightIcon.Size = UDim2.new(0, 100, 0, 100)
            moonlightIcon.Position = UDim2.new(0.5, -50, 0.9, 0)
            moonlightIcon.Image = "rbxassetid://139708924790241"  -- Your Moonlight icon image ID
            moonlightIcon.BackgroundTransparency = 1
            moonlightIcon.Parent = screenGui

            -- Light blue screen overlay
            local overlay = Instance.new("Frame")
            overlay.Size = UDim2.new(1, 0, 1, 0)
            overlay.BackgroundColor3 = Color3.fromRGB(173, 216, 230) -- Light blue color
            overlay.BackgroundTransparency = 0
            overlay.ZIndex = 10
            overlay.Parent = screenGui

            local tweenIn = TweenService:Create(overlay, TweenInfo.new(3, Enum.EasingStyle.Linear), {BackgroundTransparency = 0.8})
            tweenIn:Play()

            tweenIn.Completed:Connect(function()
                -- After 3 seconds, flash back to normal
                local tweenOut = TweenService:Create(overlay, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {BackgroundTransparency = 1})
                tweenOut:Play()

                tweenOut.Completed:Connect(function()
                    overlay:Destroy()
                end)
            end)

            -- Chance to either fly or get a speed boost
            local flyChance = math.random(1, 2) == 1 -- 50% chance to fly

            if flyChance then
                -- Enable flying for 1 minute
                character.HumanoidRootPart.Anchored = true
                task.wait(60)
                character.HumanoidRootPart.Anchored = false
            else
                -- Speed boost logic
                speedTweenValue.Value = 35
                TweenService:Create(speedTweenValue, TweenInfo.new(70, Enum.EasingStyle.Linear), {Value = 0}):Play()

                local conn
                conn = speedTweenValue:GetPropertyChangedSignal("Value"):Connect(function()
                    character:SetAttribute("SpeedBoost", speedTweenValue.Value)
                end)

                task.wait(60)
                conn:Disconnect()
                character:SetAttribute("SpeedBoost", 0)
            end

            debounce = false
        end)
    end
})
local SeekGun = Items:CreateButton({
   Name = "Seek Gun",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/main/seekgun.lua"))()
   end,
})
local GrenadeNormal = Items:CreateButton({
   Name = "GRENADEEE (OP)",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darker-TheDarkestGuy/Modes/refs/heads/main/Grenade%20On%20Anything"))()
   end,
})
local GrenadeHoly = Items:CreateButton({
   Name = "Holy Hand Grenade",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darker-TheDarkestGuy/Modes/refs/heads/main/Holy%20Hand%20Grenade%20On%20Anything"))()
   end,
})
local GuidingShakelight = Items:CreateButton({
   Name = "Guiding Shakelight",
   Callback = function()
local Curious = 'https://github.com/Matthew201322/Doors-Scriptee/blob/Shakelights/Curious%20Shakelight.rbxm?raw=true'
local Guiding = 'https://github.com/Matthew201322/Doors-Scriptee/blob/main/Guiding%20Shakelight.rbxm?raw=true'

-- the shakelights omg

_G.Model = Guiding
loadstring(game:HttpGet("https://raw.githubusercontent.com/Matthew201322/Doors-Scriptee/refs/heads/main/Shakelight.luau", true))()
   end,
})
local CuriousShakelight = Items:CreateButton({
   Name = "Curious Shakelight",
   Callback = function()
local Curious = 'https://github.com/Matthew201322/Doors-Scriptee/blob/Shakelights/Curious%20Shakelight.rbxm?raw=true'
local Guiding = 'https://github.com/Matthew201322/Doors-Scriptee/blob/main/Guiding%20Shakelight.rbxm?raw=true'

-- the shakelights omg

_G.Model = Curious
loadstring(game:HttpGet("https://raw.githubusercontent.com/Matthew201322/Doors-Scriptee/refs/heads/main/Shakelight.luau", true))()
   end,
})
local MischievousShakelight = Items:CreateButton({
   Name = "Mischievous Shakelight",
   Callback = function()
local Mischievous = 'https://github.com/Matthew201322/Doors-Scriptee/blob/Shakelights/Mischievous%20Shakelight.rbxm?raw=true'

-- the shakelights omg

_G.Model = Mischievous
loadstring(game:HttpGet("https://raw.githubusercontent.com/Matthew201322/Doors-Scriptee/refs/heads/main/Shakelight.luau", true))()
   end,
})
local Scanner = Items:CreateButton({
   Name = "Scanner",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/main/Scanner.lua"))()
   end,
})
local PinkScanner = Items:CreateButton({
   Name = "Pink Scanner",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Matthew201322/Doors-Scriptee/refs/heads/main/the%20tablet.luau"))()
   end,
})
local GrassScanner = Items:CreateButton({
   Name = "Grassful Scanner",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Matthew201322/Doors-Scriptee/refs/heads/main/grass%20tablet.lua"))()
   end,
})
local GuidingScanner = Items:CreateButton({
   Name = "Guiding Scanner",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/ta-blets/refs/heads/main/guiding%20tablet.lua.txt"))()
   end,
})
local GuidingCrucifix = Items:CreateButton({
   Name = "Guiding Crucifix",
   Callback = function()
      ---====== Load module ======---
      local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/Matthew201322/Doors-Scriptee/refs/heads/main/Crucifix%20Source.lua"))()

      ---====== Create crucifix ======---
      module.GiveCrucifix({
         Type = 1, -- Crucifix type (1 = Guiding Light)
         Uses = nil, -- nil for infinite uses
         Resist = false, -- If true, can resist certain entities
         EntitiesOnly = true, -- If true, works only on custom entities
         IgnoreList = {} -- List of entities to ignore
      })

      --[[

      CRUCIFIX TYPES:
      -> 1: Guiding Light

      COMING SOON:
      -> Curious Light crucifix type

      ]]--
   end,
})
local StarlightBarrel = Items:CreateButton({
   Name = "Barrel Of Starlight",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/refs/heads/main/StarJug.lua"))()
   end,
})
local Bottles = Items:CreateButton({
   Name = "Bottles of",
   Callback = function()
   loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/04d7dd5e02688624b958b8c2604b924c/raw/9e86b34249f44ed2dd433176e67daaf3db30cde8/MoonBottle'))()
loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/8b05c837bea9effac2554340465b4be1/raw/3f3be0ee72e7f153db39a16a40fa63dce6cde72d/SpiralBottle'))()
   end,
})
local GGummyFlashlight = Items:CreateButton({
   Name = "Golden Yummy Flashlight",
   Callback = function()
   loadstring(game:HttpGet(("https://raw.githubusercontent.com/aadyian9000/the-thing/main/GoldenGummyFlashlight.lua"),true))()
   end,
})
local GoldenTablet = Items:CreateButton({
   Name = "Golden Tablet",
   Callback = function()
   loadstring(game:HttpGet("https://pastebin.com/raw/umRteEPy"))()
   end,
})
local RocketLauncher = Items:CreateButton({
   Name = "Rocket Launcher",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/refs/heads/main/rocketLauncher.lua"))()
   end,
})
local InfiniteCrucifix = Items:CreateButton({
   Name = "Infinite Crucifix",
   Callback = function()
_G.Uses = 414141414141
_G.Range = 30
_G.OnAnything = true
_G.Fail = false
_G.Variant = "Electric"
loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
   end,
})
local MiscTablet = Items:CreateButton({
   Name = "Mischievous tablet",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/ta-blets/refs/heads/main/guiding%20tablet.lua(1).txt"))()
   end,
})
local SeekPlush = Items:CreateButton({
   Name = "Seek Plush",
   Callback = function()
local plr = game.Players.LocalPlayer
local hum = plr.Character:WaitForChild("Humanoid")

local plush = game:GetObjects("rbxassetid://13613269677")[1]
plush.Parent = plr.Backpack
local anim = hum:LoadAnimation(plush.A.Hold)

plush.Equipped:Connect(function()
  anim:Play()
end)
plush.Unequipped:Connect(function()
  anim:Stop()
end)

plush.Activated:Connect(function()
  plush.Toy:Play()
end)
   end,
})

local Shears = Items:CreateButton({
   Name = "Shears On Anything",
   Callback = function()
-- Spawner Customizations --
_G.Luck = 100 -- The chance of shears spawning in the game
_G.Spawns = false -- If the shears can spawn naturally in the game
-- Tool Customizations --
_G.Durability = 5 -- How much durability it will have until it breaks
_G.MaxDurability = 5 -- The max durability if you enable regeneration
_G.InfiniteUses = false -- If The Shears have infinite uses and cannot break
_G.DurabilityTakenEachSnip = 0.25 -- How much each snip you take with the shears takes from the durability
_G.SnipSpeed = 1.25 -- The speed of the snipping
-- Regeneration --
_G.Regens = true -- If the shears regenerate after being used
_G.RegenSpeed = 1 -- How fast the shears will regenerate after being used
_G.RegenAmount = 0.1 -- How much durability it will regenerate after the chosen amount of time
-- Loadstring --
loadstring(game:HttpGet("https://raw.githubusercontent.com/iimateiYT/Scripts/main/Buffed%20Shears%20On%20Everything.lua"))()
   end,
})
local BlackHole = Items:CreateButton({
   Name = "BlackHole",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/iimateiYT/Scripts/main/Black%20Hole.lua"))()
   end,
})
local InfiniteCrucifix = Items:CreateButton({
   Name = "Infinite Crucifix",
   Callback = function()
_G.Uses = 414141414141
_G.Range = 30
_G.OnAnything = true
_G.Fail = false
_G.Variant = "Electric"
loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
   end,
})
local Resizer = Items:CreateButton({
   Name = "Resizer (By Indexell , ty)",
   Callback = function()
loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/f0178af2301ca90c09895f10f3e7bd4b/raw/46899ccc3626f3485d85f990012f7ef37ae52e5e/resizerDoorsRemake'))()
   end,
})
local GuidingLighter = Items:CreateButton({
   Name = "Guiding Lighter (By Us)",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/Guiding-modhub/refs/heads/main/obf_tzC4VKEz8q97nq1JEmMWTW2Ke86o75zoN5gE6DOB475Gn4H99HoKS9i7sSa4zU95.lua.txt"))()
Rayfield:Notify({
   Title = "Items",
   Content = "To use the lighter , BUY A NORMAL LIGHTER , HOLD IT THEN PRESS THE BUTTON!!",
   Duration = 10,
   Image = 73291096617811,
})
   end,
})
local CuriousLighter = Items:CreateButton({
   Name = "Curious Lighter (By Us)",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/Guiding-modhub/refs/heads/main/CuriousLighterbutProtected.lua"))()
Rayfield:Notify({
   Title = "Items",
   Content = "To use the lighter , BUY A NORMAL LIGHTER , HOLD IT THEN PRESS THE BUTTON!!",
   Duration = 10,
   Image = 73291096617811,
})
   end,
})
local MischievousLighter = Items:CreateButton({
   Name = "Mischievous Lighter (By us)",
   Callback = function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local highlightColor = Color3.new(1, 0, 0)
local explosionSoundId = "rbxassetid://3802269741"
local explosionTimeLimit = 1200

local function applyToolEffects(tool)
    if tool.Name == "Lighter" then
        local handle = tool:FindFirstChild("Handle")
        if handle then
            handle.Color = Color3.new(1, 0, 0)
            local soundOpen = handle:FindFirstChild("sound_open")
            if soundOpen and soundOpen:IsA("Sound") then
                soundOpen.SoundId = explosionSoundId
            end

            for _, descendant in ipairs(handle:GetDescendants()) do
                if descendant:IsA("BasePart") or descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
                    descendant.Color = Color3.new(1, 0, 0)
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Texture = "rbxassetid://110886007258155"
                    elseif descendant:IsA("PointLight") then
                        descendant.Color = Color3.new(1, 0, 0)
                        descendant.Brightness = 1.5
                        descendant.Range = 16
                    end
                end
            end
        end

        tool.TextureId = "rbxassetid://112508503632935"

        task.spawn(function()
            local heldTime = 0
            while tool and tool.Parent and Players.LocalPlayer.Character:FindFirstChild(tool.Name) do
                task.wait(1)
                heldTime = heldTime + 1
                if heldTime >= explosionTimeLimit then
                    local explosion = Instance.new("Explosion")
                    explosion.Position = Players.LocalPlayer.Character.HumanoidRootPart.Position
                    explosion.Parent = workspace
                    local explosionSound = Instance.new("Sound")
                    explosionSound.SoundId = explosionSoundId
                    explosionSound.PlayOnRemove = true
                    explosionSound.Parent = explosion
                    explosionSound:Destroy()
                    Players.LocalPlayer.Character.Humanoid.Health = 0
                end
            end
        end)
    end
end

local function highlightFakeDoors()
    for _, model in ipairs(workspace:GetDescendants()) do
        if model:IsA("Model") and model.Name == "DoorFake" then
            for _, part in ipairs(model:GetDescendants()) do
                if part:IsA("BasePart") then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = highlightColor
                    highlight.OutlineTransparency = 1
                    highlight.Parent = part
                end
            end
        end
    end

    workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Model") and descendant.Name == "DoorFake" then
            for _, part in ipairs(descendant:GetDescendants()) do
                if part:IsA("BasePart") then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = highlightColor
                    highlight.OutlineTransparency = 1
                    highlight.Parent = part
                end
            end
        end
    end)
end

Players.LocalPlayer.Backpack.ChildAdded:Connect(applyToolEffects)
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Tool") then
        applyToolEffects(descendant)
    end
end)

highlightFakeDoors()
Rayfield:Notify({
   Title = "Items",
   Content = "To use the lighter , BUY A NORMAL LIGHTER , HOLD IT THEN PRESS THE BUTTON!!",
   Duration = 10,
   Image = 73291096617811,
})
   end,
})
local FlashlightClient = Items:CreateButton({
   Name = "Roblox Flashlight",
   Callback = function()
local fl = game:GetObjects("rbxassetid://11242492137")[1]
fl.Parent = game.Players.LocalPlayer.Backpack

loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Test/main/ScriptLoader.lua"))()(fl)
   end,
})
local Entities = Window:CreateTab("Entities", 85653583090992) -- Title, Image
local Section = Entities:CreateSection("Stolen")
local PandemoniumEntity = Entities:CreateButton({
   Name = "Pandemonium",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/refs/heads/main/PandemoniumProtected.lua"))()
   end,
})
local A60 = Entities:CreateButton({
   Name = "A-60",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Idk-lol2/a-60aa/refs/heads/main/---%3D%3D%3D%3D%3D%3D%20a-60%20agresiv%20spawner%20%3D%3D%3D%3D%3D%3D---.txt"))()
   end,
})
local ExtremeA60 = Entities:CreateButton({
   Name = "Extreme A-60",
   Callback = function()
   ---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "A-60",
		Asset = "https://github.com/Idk-lol2/a-60aa/blob/main/11379072534.rbxm?raw=true",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 50
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = true
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {25, 75, 2, 2} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 2500,
		Delay = 25,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 50,
		Max = 350,
		Delay = 0
	},
	Damage = {
		Enabled = true,
		Range = 30,
		Amount = 950
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Curious", -- "Curious"
		Hints = {"You got killed by..", "A-60.", "Get better.", "Good luck."},
		Cause = ""
	}
})

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()
Wait(105)
---====== Load achievement giver ======---
local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/Idk-lol2/a-60aa/refs/heads/main/fix%20bage.txt"))()

---====== Display achievement ======---
achievementGiver({
    Title = "RebounDead",
    Desc = "We're cooked.",
    Reason = "Survive A-60.",
    Image = "rbxassetid://125217047990746"
})
   end,
})
local Trollface = Entities:CreateButton({
   Name = "TrollFace",
   Callback = function()
   loadstring(game:HttpGet("https://api.hugebonus.xyz/scripts/TrollFaceSpawner.lua"))()
   end,
})
local ChillSeek = Entities:CreateButton({
   Name = "Chiil Seek",
   Callback = function()
   loadstring(game:HttpGet("https://pastebin.com/raw/z6YM2gtA"))()
   end,
})
local ReboundSpawner = Entities:CreateButton({
   Name = "Rebound",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/refs/heads/main/ReboundSpawner.lua"))()
   end,
})
local PlayerScripts = Window:CreateTab("Player scripts", 112678301558765) -- Title, Image
local ThirdPerson = PlayerScripts:CreateButton({
   Name = "Third person",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/refs/heads/main/ThirdPersonHatFix.lua"))()
   Rayfield:Notify({
   Title = "Hey!",
   Content = "This can't be turned back!",
   Duration = 6.5,
   Image = 112678301558765,
})
   end,
})
local FirstPerson = PlayerScripts:CreateButton({
   Name = "First person (NOT FULLY SUPPORTED)",
   Callback = function()
game:GetService("RunService").RenderStepped:Connect(function()
game.Workspace.CurrentCamera.CFrame = (game.Players.LocalPlayer.Character.Head.CFrame)
end)
   Rayfield:Notify({
   Title = "Hey!",
   Content = "This can't be turned back!",
   Duration = 6.5,
   Image = 112678301558765,
})
   end,
})
local AbleToJump = PlayerScripts:CreateButton({
   Name = "be able to jump",
   Callback = function()
game.Players.LocalPlayer.Character:SetAttribute("CanJump",true)
   Rayfield:Notify({
   Title = "Hey!",
   Content = "This can't be turned back!",
   Duration = 6.5,
   Image = 112678301558765,
})
   end,
})
local Modes = Window:CreateTab("The modes", 73291096617811) -- Title, Image
local Section = Modes:CreateSection("Gamemodes")
local ImmortalSnail = Modes:CreateButton({
   Name = "Immortal Snail (strong)",
   Callback = function()
   Rayfield:Notify({
   Title = "Mode Notification",
   Content = "You must be in room 0 for it!",
   Duration = 6.5,
   Image = 73291096617811,
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAcceleration/Comet-Development/refs/heads/main/Doors/Game/Immortal%20Snail.lua"))()
   end,
})
local HardcoreMode = Modes:CreateButton({
   Name = "Hardcore Mode (Remake)",
   Callback = function()
   Rayfield:Notify({
   Title = "Mode Notification",
   Content = "You must be in room 0 for it!",
   Duration = 6.5,
   Image = 73291096617811,
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/refs/heads/main/HardcoreFixed.lua"))()
   end,
})
local ImpossibleMode = Modes:CreateButton({
   Name = "Impossible Mode (Remake)",
   Callback = function()
   Rayfield:Notify({
   Title = "Mode Notification",
   Content = "You must be in room 0 for it!",
   Duration = 6.5,
   Image = 73291096617811,
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/huyhoanggphuc/Doors-Mode/refs/heads/main/Impossible%20Mode.lua"))()
   end,
})
local CreepyMode = Modes:CreateButton({
   Name = "Creepy Mode",
   Callback = function()
   Rayfield:Notify({
   Title = "Mode Notification",
   Content = "You must be in room 0 for it!",
   Duration = 6.5,
   Image = 73291096617811,
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Modes/refs/heads/main/CreepyMode/ObfuscatedMain.lua"))()
   end,
})
local DistortedMode = Modes:CreateButton({
   Name = "Distorted Mode",
   Callback = function()
   Rayfield:Notify({
   Title = "Mode Notification",
   Content = "You must be in room 0 for it!",
   Duration = 6.5,
   Image = 73291096617811,
})
loadstring(game:HttpGet("https://pastefy.app/jSYoQ45C/raw"))()
   end,
})
local MayhemMode = Modes:CreateButton({
   Name = "Mayhem Mode",
   Callback = function()
   Rayfield:Notify({
   Title = "Mode Notification",
   Content = "You must be in room 0 for it!",
   Duration = 6.5,
   Image = 73291096617811,
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darker-TheDarkestGuy/Modes/refs/heads/main/Mayhem%20Mode"))()
   end,
})
local CombinedMode = Modes:CreateButton({
   Name = "Combined Mode",
   Callback = function()
   Rayfield:Notify({
   Title = "Mode Notification",
   Content = "You must be in room 0 for it!",
   Duration = 6.5,
   Image = 73291096617811,
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darker-TheDarkestGuy/Modes/refs/heads/main/Combined%20Mode"))()
   end,
})
local Lavafloor = Modes:CreateButton({
   Name = "floor is lava",
   Callback = function()
   Rayfield:Notify({
   Title = "Mode Notification",
   Content = "You must be in room 0 for it!",
   Duration = 6.5,
   Image = 73291096617811,
})
_G.DEBUG_LAVA = false
loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAcceleration/Comet-Development/refs/heads/main/Doors/Game/FloorIsLava.lua"))()
   end,
})
local Misc = Window:CreateTab("Others", 118683050042721) -- Title, Image
local Speedrun = Misc:CreateButton({
   Name = "Speedrun timer",
   Callback = function()
   Rayfield:Notify({
   Title = "Misc Notification",
   Content = "These are things idk too.",
   Duration = 6.5,
   Image = 118683050042721,
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/Iliankytb/Iliankytb/main/SpeedrunTimer"))()
   end,
})
local Spam = Misc:CreateButton({
   Name = "Spam notifications",
   Callback = function()
   while true do
   Rayfield:Notify({
   Title = "Misc Notification",
   Content = "These are things idk too.",
   Duration = 6.5,
   Image = 118683050042721,
})
wait(1)
end
   end,
})
local Remakes = Window:CreateTab("Remakes", 117067626849777) -- Title, Image
-- Burning Hotel Button
local BurningHotelButtonV2 = Remakes:CreateButton({
    Name = "Burning Hotel (V2)",
    Callback = function()
        local fireImageId = "rbxassetid://123255108092070" -- Fire image texture ID
        local smokeImageId = "rbxassetid://123305371603138" -- Smoke texture ID
        local coughingSoundId = "rbxassetid://7056720271" -- Coughing sound asset ID
        local burningSoundId = "rbxassetid://8533770574" -- Burning sound asset ID

        -- Function to apply fire and smoke effects
        local function applyFireEffect(part)
            -- Check if the part is a BasePart and not part of a player's character
            if part:IsA("BasePart") and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
                -- Fire particle
                if not part:FindFirstChild("FireParticle") then
                    local fireEmitter = Instance.new("ParticleEmitter")
                    fireEmitter.Name = "FireParticle"
                    fireEmitter.Texture = fireImageId
                    fireEmitter.Rate = 50
                    fireEmitter.Lifetime = NumberRange.new(0.5, 1)
                    fireEmitter.Speed = NumberRange.new(2, 4)
                    fireEmitter.VelocitySpread = 180
                    fireEmitter.RotSpeed = NumberRange.new(50, 100)
                    fireEmitter.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.3),
                        NumberSequenceKeypoint.new(0.5, 1),
                        NumberSequenceKeypoint.new(1, 0.5),
                    })
                    fireEmitter.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.new(1, 0.6, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.2, 0)),
                        ColorSequenceKeypoint.new(1, Color3.new(0.2, 0, 0)),
                    })
                    fireEmitter.LightEmission = 0.5
                    fireEmitter.Acceleration = Vector3.new(0, 3, 0)
                    fireEmitter.Parent = part
                end

                -- Smoke particle
                if not part:FindFirstChild("SmokeParticle") then
                    local smokeEmitter = Instance.new("ParticleEmitter")
                    smokeEmitter.Name = "SmokeParticle"
                    smokeEmitter.Texture = smokeImageId
                    smokeEmitter.Rate = 30
                    smokeEmitter.Lifetime = NumberRange.new(1, 2)
                    smokeEmitter.Speed = NumberRange.new(1, 2)
                    smokeEmitter.VelocitySpread = 180
                    smokeEmitter.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.5),
                        NumberSequenceKeypoint.new(0.5, 1.5),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    smokeEmitter.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.2, 0.2)),
                        ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.1, 0.1)),
                    })
                    smokeEmitter.LightEmission = 0.2
                    smokeEmitter.Parent = part
                end
            end
        end

        -- Function to play burning sound
        local function playBurningSound()
            local sound = Instance.new("Sound")
            sound.Name = "BurningSound"
            sound.SoundId = burningSoundId
            sound.Looped = true
            sound.Volume = 0.5
            sound.Parent = workspace
            sound:Play()
        end

        -- Function to apply damage and coughing sounds
        local function applyPlayerEffects()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChild("Humanoid")

            if humanoid then
                -- Apply damage every 60 seconds
                while true do
                    humanoid:TakeDamage(math.random(1, 3))
                    wait(60)
                end
            end

            -- Play coughing sound
            local coughingSound = Instance.new("Sound")
            coughingSound.Name = "CoughingSound"
            coughingSound.SoundId = coughingSoundId
            coughingSound.Looped = true
            coughingSound.Volume = 1
            coughingSound.Parent = character
            coughingSound:Play()
        end

        -- Initial application to all existing parts
        for _, obj in ipairs(workspace:GetDescendants()) do
            applyFireEffect(obj)
        end

        -- Continuous application for new parts
        workspace.DescendantAdded:Connect(applyFireEffect)

        -- Start burning sound
        playBurningSound()

        -- Apply player effects
        applyPlayerEffects()
    end,
})
-- Frozen Hotel Button
local FrozenHotelButtonV2 = Remakes:CreateButton({
   Name = "Frozen Hotel V2",
   Callback = function()
      local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
      local TweenService = game:GetService("TweenService")
      local Debris = game:GetService("Debris")
      local Lighting = game:GetService("Lighting")
      local SoundService = game:GetService("SoundService")

      -- Frost sound
      local frostSound = Instance.new("Sound")
      frostSound.SoundId = "rbxassetid://6860710840"  -- Replace with a valid sound ID for frost sound
      frostSound.Volume = 0.5
      frostSound.Looped = true

      -- Function to modify material and properties
      local function modifyPart(part)
         if part:IsA('BasePart') then
            -- Change all materials to Ice (Frozen Hotel)
            part.Material = Enum.Material.Ice
            -- Change color to the icy tone
            part.Color = Color3.fromRGB(195, 185, 165) -- Example color based on image
            -- Adjust slipperiness for moderate sliding
            part.CustomPhysicalProperties = PhysicalProperties.new(0.4, 0.1, 0.2, 0, 0) -- Moderate friction
         elseif part:IsA('Decal') or part:IsA('Texture') then
            -- Change decals to match the color
            part.Color3 = Color3.fromRGB(195, 185, 165) -- Same icy color
         end
      end

      -- Function to apply enhanced cold effect
      local function applyColdEffect(player)
         if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            -- Create a more visible cold effect
            local playerGui = player:FindFirstChild("PlayerGui")
            if not playerGui then return end

            local coldEffectGui = Instance.new("ScreenGui")
            coldEffectGui.Name = "ColdEffect"
            coldEffectGui.Parent = playerGui

            local whiteFrame = Instance.new("Frame")
            whiteFrame.BackgroundColor3 = Color3.new(1, 1, 1)
            whiteFrame.BackgroundTransparency = 1
            whiteFrame.Size = UDim2.new(1.5, 0, 1.5, 0)
            whiteFrame.Position = UDim2.new(-0.25, 0, -0.25, 0)
            whiteFrame.Parent = coldEffectGui

            -- Enhanced fade-in effect
            local fadeIn = TweenService:Create(whiteFrame, TweenInfo.new(1), {BackgroundTransparency = 0.3})
            fadeIn:Play()
            fadeIn.Completed:Wait()

            -- Play frost sound
            frostSound.Parent = player.Character
            frostSound:Play()

            -- Wait for 5 seconds
            task.delay(5, function()
               -- Gradually fade out the effect
               local fadeOut = TweenService:Create(whiteFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
               fadeOut:Play()
               fadeOut.Completed:Wait()

               coldEffectGui:Destroy() -- Remove effect
               frostSound:Stop()  -- Stop the frost sound after the effect
            end)
         end
      end

      -- Loop through all existing descendants in Workspace
      for _, v in pairs(game.Workspace:GetDescendants()) do
         modifyPart(v)
      end

      -- Apply changes to newly added parts
      game.Workspace.DescendantAdded:Connect(function(v)
         modifyPart(v)
      end)

      -- Freeze all players and apply cold effect randomly
      for _, player in pairs(Players:GetPlayers()) do
         -- Randomly apply the cold effect
         task.spawn(function()
            while true do
               task.wait(math.random(10, 30)) -- Random delay between 10-30 seconds
               applyColdEffect(player)
            end
         end)
      end

      -- Apply cold effect to new players who join
      Players.PlayerAdded:Connect(function(player)
         player.CharacterAdded:Connect(function()
            -- Randomly apply the cold effect
            task.spawn(function()
               while true do
                  task.wait(math.random(10, 30)) -- Random delay between 10-30 seconds
                  applyColdEffect(player)
               end
            end)
         end)
      end)

      -- Apply deep snowy fog
      Lighting.FogEnd = 50
      Lighting.FogColor = Color3.fromRGB(255, 255, 255)  -- White color for snow
      Lighting.Ambient = Color3.fromRGB(240, 240, 240)  -- Soft white ambient light
      Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200) -- Slightly dimmer outdoor ambient
      Lighting.Brightness = 0.5
      Lighting.TimeOfDay = "00:00:00"  -- Midnight for the darkest atmosphere

      -- Snowflakes effect
      local function createSnowflake()
         local snowflake = Instance.new("Part")
         snowflake.Shape = Enum.PartType.Ball
         snowflake.Size = Vector3.new(0.5, 0.5, 0.5)
         snowflake.Position = Vector3.new(math.random(-50, 50), 100, math.random(-50, 50))  -- Randomize position
         snowflake.Anchored = true
         snowflake.CanCollide = false
         snowflake.Color = Color3.fromRGB(255, 255, 255)  -- White color
         snowflake.Parent = game.Workspace

         local fall = TweenService:Create(snowflake, TweenInfo.new(math.random(10, 20), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = Vector3.new(snowflake.Position.X, -10, snowflake.Position.Z)})
         fall:Play()
         fall.Completed:Connect(function()
            snowflake:Destroy()
         end)
      end

      -- Create snowflakes at random intervals
      task.spawn(function()
         while true do
            task.wait(math.random(0.5, 2))  -- Random interval between snowflakes
            createSnowflake()
         end
      end)
   end    
})
local ElectricalHotelV2 = Remakes:CreateButton({
   Name = "Electrical Hotel V2",
   Callback = function()
      local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
      local TweenService = game:GetService("TweenService")
      local Debris = game:GetService("Debris")
      local SoundService = game:GetService("SoundService")
      local Lighting = game:GetService("Lighting")

      -- Function to modify all parts to DiamondPlate and color them gray
      local function modifyPartToGray(part)
         if part:IsA("BasePart") then
            part.Material = Enum.Material.DiamondPlate
            part.Color = Color3.fromRGB(47, 47, 47) -- Gray color
         end
      end

      -- Modify all existing parts in the workspace
      for _, v in pairs(game.Workspace:GetDescendants()) do
         modifyPartToGray(v)
      end

      -- Apply changes to newly added parts
      game.Workspace.DescendantAdded:Connect(function(v)
         modifyPartToGray(v)
      end)

      -- Electrocuting effect (blue explosion + electric shock)
      local function applyElectricShock(part)
         if part:IsA("BasePart") then
            -- Create the visual electric shock effect
            local shock = Instance.new("ParticleEmitter")
            shock.Texture = "rbxassetid://110655154102380" -- The blue electric shock texture
            shock.Parent = part
            shock.Color = ColorSequence.new(Color3.fromRGB(0, 0, 255)) -- Blue color
            shock.Lifetime = NumberRange.new(0.5, 1)
            shock.Rate = 100
            shock.Speed = NumberRange.new(5, 10)
            shock.Enabled = true

            -- Create an explosion effect
            local explosion = Instance.new("Explosion")
            explosion.Position = part.Position
            explosion.BlastRadius = 5
            explosion.BlastPressure = 1000
            explosion.ExplosionType = Enum.ExplosionType.NoCraters
            explosion.Parent = game.Workspace
            explosion:Destroy() -- Remove the explosion after it detonates

            -- Play the electric sound
            local electricSound = Instance.new("Sound")
            electricSound.SoundId = "rbxassetid://92630376907021" -- Sound ID for electricity
            electricSound.Parent = part
            electricSound:Play()

            -- Ambient electric buzzing sound to enhance the effect
            local ambientSound = Instance.new("Sound")
            ambientSound.SoundId = "rbxassetid://2337758580" -- Ambient electric sound
            ambientSound.Looped = true
            ambientSound.Parent = SoundService
            ambientSound:Play()

            -- Destroy shock, sound, and ambient sound after a short time
            Debris:AddItem(shock, 1)
            Debris:AddItem(electricSound, 1)
            Debris:AddItem(ambientSound, 3) -- Let the ambient sound play a bit longer

            -- Apply 1.5 damage to any player near the electric shock
            local playersInRange = {}
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character and character:FindFirstChild("Humanoid") and character.PrimaryPart then
                    if (character.PrimaryPart.Position - part.Position).Magnitude < 10 then
                        table.insert(playersInRange, player)
                    end
                end
            end

            -- Apply damage to nearby players
            for _, player in pairs(playersInRange) do
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:TakeDamage(2) -- Increased damage for players close to the shock
                end
            end

            -- Flash lighting effect to simulate a bright shock
            local originalLighting = Lighting.Brightness
            Lighting.Brightness = 2
            task.wait(0.2) -- Flash effect duration
            Lighting.Brightness = originalLighting
         end
      end

      -- Randomly electrocute parts in the game
      RunService.Heartbeat:Connect(function()
         if math.random() < 0.01 then
            local parts = game.Workspace:GetDescendants()
            local randomPart = parts[math.random(1, #parts)]
            applyElectricShock(randomPart)
         end
      end)

      -- Walking sound effect
      local function playWalkingSound(player)
         local character = player.Character
         if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
               local walkingSound = Instance.new("Sound")
               walkingSound.SoundId = "rbxassetid://3477114901" -- Walking sound ID
               walkingSound.Parent = character:FindFirstChild("HumanoidRootPart")
               walkingSound.Looped = true
               walkingSound.Volume = 0.5 -- Adjust volume if needed

               humanoid.Running:Connect(function(speed)
                  if speed > 0 then
                     if not walkingSound.IsPlaying then
                        walkingSound:Play()
                     end
                  else
                     if walkingSound.IsPlaying then
                        walkingSound:Stop()
                     end
                  end
               end)
            end
         end
      end

      -- Apply walking sound effect to all players
      for _, player in pairs(Players:GetPlayers()) do
         if player.Character then
            playWalkingSound(player)
         end
         player.CharacterAdded:Connect(function()
            playWalkingSound(player)
         end)
      end

      -- Handle new players joining
      Players.PlayerAdded:Connect(function(player)
         player.CharacterAdded:Connect(function()
            playWalkingSound(player)
         end)
      end)
local SoundService = game:GetService("SoundService")

-- Function to replace specific sounds with the desired sound
local function replaceSpecificSounds()
   -- Loop through all descendants of the game
   for _, obj in pairs(game:GetDescendants()) do
      -- Check if the object is a Sound and if its name is "Open", "SoundEnter", or "SoundExit"
      if obj:IsA("Sound") then
         if obj.Name == "Open" or obj.Name == "SoundEnter" or obj.Name == "SoundExit" then
            -- Replace the sound ID with the desired one
            obj.SoundId = "rbxassetid://9114149321"
         end
      end
   end
end

-- Call the function to replace sounds initially
replaceSpecificSounds()

-- Monitor for any new sounds that are added to the game
game.DescendantAdded:Connect(function(obj)
   if obj:IsA("Sound") then
      -- Replace the sound ID when a new "Open", "SoundEnter", or "SoundExit" sound is added
      if obj.Name == "Open" or obj.Name == "SoundEnter" or obj.Name == "SoundExit" then
         obj.SoundId = "rbxassetid://9114149321"
      end
   end
end)
local Workspace = game:GetService("Workspace")
   end,
})
local ElectricalHotelV3 = Remakes:CreateButton({
   Name = "Electrical Hotel V3",
   Callback = function()
      local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
      local TweenService = game:GetService("TweenService")
      local Debris = game:GetService("Debris")
      local SoundService = game:GetService("SoundService")
      local Lighting = game:GetService("Lighting")

-- Function to modify all parts to DiamondPlate and color them gray, excluding Neon parts
local function modifyPartToGray(part)
   if part:IsA("BasePart") and part.Material ~= Enum.Material.Neon then
      part.Material = Enum.Material.DiamondPlate
      part.Color = Color3.fromRGB(47, 47, 47) -- Gray color
   end
end

-- Modify all existing parts in the workspace
for _, v in pairs(game.Workspace:GetDescendants()) do
   modifyPartToGray(v)
end

-- Apply changes to newly added parts
game.Workspace.DescendantAdded:Connect(function(v)
   modifyPartToGray(v)
end)

      -- Electrocuting effect (blue explosion + electric shock)
      local function applyElectricShock(part)
         if part:IsA("BasePart") then
            -- Create the visual electric shock effect
            local shock = Instance.new("ParticleEmitter")
            shock.Texture = "rbxassetid://110655154102380" -- The blue electric shock texture
            shock.Parent = part
            shock.Color = ColorSequence.new(Color3.fromRGB(0, 0, 255)) -- Blue color
            shock.Lifetime = NumberRange.new(0.5, 1)
            shock.Rate = 100
            shock.Speed = NumberRange.new(5, 10)
            shock.Enabled = true

            -- Create an explosion effect
            local explosion = Instance.new("Explosion")
            explosion.Position = part.Position
            explosion.BlastRadius = 5
            explosion.BlastPressure = 1000
            explosion.ExplosionType = Enum.ExplosionType.NoCraters
            explosion.Parent = game.Workspace
            explosion:Destroy() -- Remove the explosion after it detonates

            -- Play the electric sound
            local electricSound = Instance.new("Sound")
            electricSound.SoundId = "rbxassetid://92630376907021" -- Sound ID for electricity
            electricSound.Parent = part
            electricSound:Play()

            -- Ambient electric buzzing sound to enhance the effect
            local ambientSound = Instance.new("Sound")
            ambientSound.SoundId = "rbxassetid://2337758580" -- Ambient electric sound
            ambientSound.Looped = true
            ambientSound.Parent = SoundService
            ambientSound:Play()

            -- Destroy shock, sound, and ambient sound after a short time
            Debris:AddItem(shock, 1)
            Debris:AddItem(electricSound, 1)
            Debris:AddItem(ambientSound, 3) -- Let the ambient sound play a bit longer

            -- Apply 1.5 damage to any player near the electric shock
            local playersInRange = {}
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character and character:FindFirstChild("Humanoid") and character.PrimaryPart then
                    if (character.PrimaryPart.Position - part.Position).Magnitude < 10 then
                        table.insert(playersInRange, player)
                    end
                end
            end

            -- Apply damage to nearby players
            for _, player in pairs(playersInRange) do
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:TakeDamage(2) -- Increased damage for players close to the shock
                end
            end

            -- Flash lighting effect to simulate a bright shock
            local originalLighting = Lighting.Brightness
            Lighting.Brightness = 2
            task.wait(0.2) -- Flash effect duration
            Lighting.Brightness = originalLighting
         end
      end

      -- Randomly electrocute parts in the game
      RunService.Heartbeat:Connect(function()
         if math.random() < 0.01 then
            local parts = game.Workspace:GetDescendants()
            local randomPart = parts[math.random(1, #parts)]
            applyElectricShock(randomPart)
         end
      end)

      -- Walking sound effect
      local function playWalkingSound(player)
         local character = player.Character
         if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
               local walkingSound = Instance.new("Sound")
               walkingSound.SoundId = "rbxassetid://3477114901" -- Walking sound ID
               walkingSound.Parent = character:FindFirstChild("HumanoidRootPart")
               walkingSound.Looped = true
               walkingSound.Volume = 0.5 -- Adjust volume if needed

               humanoid.Running:Connect(function(speed)
                  if speed > 0 then
                     if not walkingSound.IsPlaying then
                        walkingSound:Play()
                     end
                  else
                     if walkingSound.IsPlaying then
                        walkingSound:Stop()
                     end
                  end
               end)
            end
         end
      end

      -- Apply walking sound effect to all players
      for _, player in pairs(Players:GetPlayers()) do
         if player.Character then
            playWalkingSound(player)
         end
         player.CharacterAdded:Connect(function()
            playWalkingSound(player)
         end)
      end

      -- Handle new players joining
      Players.PlayerAdded:Connect(function(player)
         player.CharacterAdded:Connect(function()
            playWalkingSound(player)
         end)
      end)
local SoundService = game:GetService("SoundService")

-- Function to replace specific sounds with the desired sound
local function replaceSpecificSounds()
   -- Loop through all descendants of the game
   for _, obj in pairs(game:GetDescendants()) do
      -- Check if the object is a Sound and if its name is "Open", "SoundEnter", or "SoundExit"
      if obj:IsA("Sound") then
         if obj.Name == "Open" or obj.Name == "SoundEnter" or obj.Name == "SoundExit" then
            -- Replace the sound ID with the desired one
            obj.SoundId = "rbxassetid://9114149321"
         end
      end
   end
end

-- Call the function to replace sounds initially
replaceSpecificSounds()

-- Monitor for any new sounds that are added to the game
game.DescendantAdded:Connect(function(obj)
   if obj:IsA("Sound") then
      -- Replace the sound ID when a new "Open", "SoundEnter", or "SoundExit" sound is added
      if obj.Name == "Open" or obj.Name == "SoundEnter" or obj.Name == "SoundExit" then
         obj.SoundId = "rbxassetid://9114149321"
      end
   end
end)
local Workspace = game:GetService("Workspace")

-- Function to modify lights
local function modifyLight(light)
    if light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight") then
        light.Color = Color3.fromRGB(0, 255, 255) -- Cyan color
        light.Brightness = 1.5 -- Set brightness to 2.5
    end
end

-- Function to modify neon parts
local function modifyNeon(part)
    if part:IsA("BasePart") and part.Material == Enum.Material.Neon then
        part.Color = Color3.fromRGB(0, 255, 255) -- Blue color
    end
end

-- Modify existing lights and neon parts in the workspace
for _, obj in pairs(Workspace:GetDescendants()) do
    modifyLight(obj)
    modifyNeon(obj)
end

-- Listen for new parts added to the workspace
Workspace.DescendantAdded:Connect(function(obj)
    modifyLight(obj)
    modifyNeon(obj)
end)

local function getGitSoundId(GithubSoundPath: string, AssetName: string): Sound
    local Url = GithubSoundPath

    if not isfile(AssetName..".mp3") then 
        writefile(AssetName..".mp3", game:HttpGet(Url)) 
    end

    local Sound = Instance.new("Sound")
    Sound.SoundId = getcustomasset(AssetName..".mp3", true)
    return Sound 
end

local CustomMusic = getGitSoundId("https://raw.githubusercontent.com/Teilsthebfdifan/Guiding-modhub/main/Metallic%20Shine%20%20Guiding%20Modhub%20OST.mp3", "ElectricalHotelV3")
CustomMusic.Parent = game.SoundService
CustomMusic.Looped = true
CustomMusic:Play()

Rayfield:Notify({
   Title = "Remakes",
   Content = "Electrical Hotel V3 has been intiated successfully! Now playing : Metallic Shine | Guiding Modhub OST",
   Duration = 6.5,
   Image = 94901032618035,
})
   end,
})
Rayfield:Notify({
   Title = "Hey!",
   Content = "This is inspired by lithub.",
   Duration = 6.5,
   Image = 139708924790241,
})
Rayfield:Notify({
   Title = "idk",
   Content = "Maybe go check it out!",
   Duration = 6.5,
   Image = 110655154102380,
})
Rayfield:Notify({
   Title = "Credits",
   Content = "Made by teilsthebfdifan",
   Duration = 10,
   Image = 73291096617811,
})
-- List of supported game IDs
local supportedGameIDs = {
    6516141723,
    6839171747,
    10549820578,
    12308344607,
    110258689672367,
}

-- Function to check if the current game is supported
local function isGameSupported(gameID)
    for _, id in ipairs(supportedGameIDs) do
        if tonumber(id) == tonumber(gameID) then
            return true
        end
    end
    return false
end

-- Get the current game ID
local currentGameID = game.PlaceId -- Use `PlaceId` instead of `GameId` for specific experience place ID.

-- Notify if the game is unsupported
if not isGameSupported(currentGameID) then
    Rayfield:Notify({
        Title = "Unsupported Experience",
        Content = "The script might break, recommending to use on DOORS!",
        Duration = 10,
        Image = 139708924790241, -- Icon image ID
    })
end