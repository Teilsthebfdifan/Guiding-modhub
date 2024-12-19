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
        local explosionPosition = randomPart.Position
        modifyNearbyParts(explosionPosition, 10)

        for _, player in pairs(Players:GetPlayers()) do
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") and character.PrimaryPart then
                local distance = (character.PrimaryPart.Position - explosionPosition).Magnitude
                if distance <= 10 then
                    character.Humanoid:TakeDamage(35)
                    if character.Humanoid.Health <= 0 and ReplicatedStorage:FindFirstChild("GameStats") then
                        local playerStats = ReplicatedStorage.GameStats:FindFirstChild("Player_" .. player.Name)
                        if playerStats then
                            playerStats.Total.DeathCause.Value = "Explosion"
                        end
                    end
                end
            end
        end

        if math.random() < 0.3 then
            task.wait(0.1)
            local secondExplosionPosition = explosionPosition + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
            modifyNearbyParts(secondExplosionPosition, 10)
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
