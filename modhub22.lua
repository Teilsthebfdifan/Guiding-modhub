local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Guiding Modhub V2.2",
   Icon = 139708924790241, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "GUIDING",
   LoadingSubtitle = "MODHUB",
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "GuidingModhubV21", -- Custom folder name
      FileName = "GMH21"
   }
})

local MC = Window:CreateTab("Map Configurations", 139708924790241) -- Title, Image

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
            -- Change material to DiamondPlate and color to gray
            part.Material = Enum.Material.DiamondPlate
            part.Color = Color3.fromRGB(47, 47, 47)  -- Gray color
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
            -- Apply the blue explosion effect
            local explosion = Instance.new("Explosion")
            explosion.Position = part.Position
            explosion.BlastRadius = 5
            explosion.BlastPressure = 1000
            explosion.ExplosionType = Enum.ExplosionType.NoCraters
            explosion.Parent = game.Workspace

            -- Add a blue particle effect for the explosion
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
            electricSound.SoundId = "rbxassetid://92630376907021"  -- The sound ID for electricity
            electricSound.Parent = part
            electricSound:Play()

            -- Destroy shock and sound after a short time
            Debris:AddItem(shock, 1)
            Debris:AddItem(electricSound, 1)

            -- Apply 1.5 damage to any player near the electric shock
            local playersInRange = {}
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character and character:FindFirstChild("Humanoid") then
                    if (character.PrimaryPart.Position - part.Position).Magnitude < 10 then
                        table.insert(playersInRange, player)
                    end
                end
            end
            -- Apply damage to players in range
            for _, player in pairs(playersInRange) do
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:TakeDamage(1.5)  -- Apply 1.5 damage
                end
            end
         end
      end

      -- Randomly electrocute parts in the game
      RunService.Heartbeat:Connect(function()
         if math.random() < 0.01 then
            local randomPart = game.Workspace:GetDescendants()[math.random(1, #game.Workspace:GetDescendants())]
            applyElectricShock(randomPart)
         end
      end)

      -- Walking sound effect
      local function playWalkingSound(player)
         local character = player.Character
         if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
               -- Create and play walking sound if player is moving
               local walkingSound = Instance.new("Sound")
               walkingSound.SoundId = "rbxassetid://3477114901"  -- Walking sound ID
               walkingSound.Parent = character:FindFirstChild("HumanoidRootPart")
               walkingSound.Looped = true
               walkingSound.Volume = 0.5  -- Adjust the volume if needed
               
               humanoid.Running:Connect(function(speed)
                  if speed > 0 then
                     if not walkingSound.IsPlaying then
                        walkingSound:Play()  -- Play walking sound
                     end
                  else
                     if walkingSound.IsPlaying then
                        walkingSound:Stop()  -- Stop walking sound when standing still
                     end
                  end
               end)
            end
         end
      end

      -- Apply walking sound effect to all players immediately
      for _, player in pairs(Players:GetPlayers()) do
         -- Directly apply walking sound if the player is already in the game
         if player.Character then
            playWalkingSound(player)
         end
         player.CharacterAdded:Connect(function()
            playWalkingSound(player)  -- Apply walking sound when the character is added
         end)
      end

      -- Also apply walking sound for new players who join
      Players.PlayerAdded:Connect(function(player)
         player.CharacterAdded:Connect(function()
            playWalkingSound(player)
         end)
      end)

      -- Make sure to also check new parts added
      game.Workspace.DescendantAdded:Connect(function(v)
         modifyPartToGray(v)
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
local Eatall = Items:CreateButton({
   Name = "Eat Everything",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JohnyGamingLUA/EatEverythingDOORS/main/obfuscated.lua"))()
   end,
})
local SeekGun = Items:CreateButton({
   Name = "Seek Gun",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/main/seekgun.lua"))()
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
local Bottles = Items:CreateButton({
   Name = "Bottles of",
   Callback = function()
   loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/04d7dd5e02688624b958b8c2604b924c/raw/9e86b34249f44ed2dd433176e67daaf3db30cde8/MoonBottle'))()
loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/8b05c837bea9effac2554340465b4be1/raw/3f3be0ee72e7f153db39a16a40fa63dce6cde72d/SpiralBottle'))()
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
local Trollface = Entities:CreateButton({
   Name = "TrollFace",
   Callback = function()
   loadstring(game:HttpGet("https://api.hugebonus.xyz/scripts/TrollFaceSpawner.lua"))()
   end,
})
Rayfield:Notify({
   Title = "Hey!",
   Content = "We do not support doxxing scripts!",
   Duration = 6.5,
   Image = 4483362458,
})
Rayfield:Notify({
   Title = "If you ask for ip or real name..",
   Content = "We will find your address.",
   Duration = 6.5,
   Image = 4483362458,
})
Rayfield:Notify({
   Title = "Credits",
   Content = "Made by teilsthebfdifan",
   Duration = 10,
   Image = 4483362458,
})