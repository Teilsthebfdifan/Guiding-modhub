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
