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
