local function getGitSoundId(GithubSoundPath: string, AssetName: string): Sound
    local Url = GithubSoundPath
    if not isfile(AssetName .. ".mp3") then
        writefile(AssetName .. ".mp3", game:HttpGet(Url))
    end
    local Sound = Instance.new("Sound")
    Sound.SoundId = getcustomasset(AssetName .. ".mp3", true)
    return Sound
end

local ExplodingHotel = getGitSoundId("https://raw.githubusercontent.com/Teilsthebfdifan/Guiding-modhub/main/FNF%20Indie%20Cross%20V1%20OST%20-%20Last%20Reel%20Instrumental.mp3", "ExplodingHotel")
ExplodingHotel.Parent = game.SoundService
ExplodingHotel.Looped = true
ExplodingHotel:Play()

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local cooldown = false

local function modifyNearbyParts(position, radius)
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and (part.Position - position).Magnitude <= radius then
            part.Material = Enum.Material.Foil
            part.Color = Color3.new(0, 0, 0)
        end
    end
end

local function createExplosion()
    if cooldown then return end
    cooldown = true

    local parts = workspace:GetDescendants()
    local randomPart = parts[math.random(1, #parts)]

    if randomPart:IsA("BasePart") then
        local explosion = Instance.new("Explosion")
        explosion.Position = randomPart.Position
        explosion.BlastRadius = 10
        explosion.BlastPressure = 500
        explosion.Parent = workspace

        modifyNearbyParts(randomPart.Position, 10)

        for _, player in pairs(Players:GetPlayers()) do
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") and character.PrimaryPart then
                local distance = (character.PrimaryPart.Position - explosion.Position).Magnitude
                if distance <= 10 then
                    character.Humanoid:TakeDamage(100)
                    if character.Humanoid.Health <= 0 then
                        local playerStats = ReplicatedStorage:FindFirstChild("GameStats")
                        if playerStats and playerStats:FindFirstChild("Player_" .. player.Name) then
                            playerStats["Player_" .. player.Name].Total.DeathCause.Value = "Explosion"
                        end
                    end
                end
            end
        end

        if math.random() < 0.3 then
            task.wait(0.1)
            local secondExplosion = Instance.new("Explosion")
            secondExplosion.Position = randomPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
            secondExplosion.BlastRadius = 10
            secondExplosion.BlastPressure = 500
            secondExplosion.Parent = workspace
            modifyNearbyParts(secondExplosion.Position, 10)
        end
    end

    task.wait(1)
    cooldown = false
end

workspace.DescendantAdded:Connect(function(part)
    if part:IsA("BasePart") then
        task.spawn(function()
            task.wait(math.random(1, 2))
            createExplosion()
        end)
    end
end)

while true do
    task.wait(math.random(1, 2))
    createExplosion()
end
