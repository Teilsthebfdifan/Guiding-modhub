local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local function modifyPart(part)
    if part:IsA("BasePart") and part.Parent ~= Players.LocalPlayer.Character then
        part.Material = Enum.Material.SmoothPlastic
        part.Color = Color3.fromRGB(0, 0, 0)
    end
end

for _, part in ipairs(game:GetDescendants()) do
    modifyPart(part)
end

game.DescendantAdded:Connect(function(part)
    modifyPart(part)
end)

Lighting.Ambient = Color3.fromRGB(2, 2, 2)
Lighting.OutdoorAmbient = Color3.fromRGB(2, 2, 2)
Lighting.Brightness = 0
Lighting.FogEnd = 15
Lighting.FogColor = Color3.fromRGB(0, 0, 0)
Lighting.TimeOfDay = "00:00:00"

for _, light in pairs(game:GetDescendants()) do
    if light:IsA("PointLight") or light:IsA("SpotLight") then
        light.Color = Color3.fromRGB(255, 0, 0)
        light.Brightness = math.max(0, light.Brightness - 0.1)
        light.Range = math.max(0, light.Range - 2)
    end
end

game.DescendantAdded:Connect(function(light)
    if light:IsA("PointLight") or light:IsA("SpotLight") then
        light.Color = Color3.fromRGB(255, 0, 0)
        light.Brightness = math.max(0, light.Brightness - 0.1)
        light.Range = math.max(0, light.Range - 2)
    end
end)

local function createFlashlight(player)
    local character = player.Character
    if character then
        local flashlightTool = Instance.new("Tool")
        flashlightTool.Name = "Flashlight"
        flashlightTool.RequiresHandle = true
        flashlightTool.Parent = player.Backpack

        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(1, 4, 1)
        handle.Color = Color3.fromRGB(50, 50, 50)
        handle.Anchored = false
        handle.CanCollide = false
        handle.Parent = flashlightTool

        local beam = Instance.new("SpotLight")
        beam.Parent = handle
        beam.Brightness = 8
        beam.Range = 35
        beam.Angle = 50
        beam.Color = Color3.fromRGB(255, 255, 255)
        beam.Enabled = false

        flashlightTool.Activated:Connect(function()
            beam.Enabled = true
        end)

        flashlightTool.Deactivated:Connect(function()
            beam.Enabled = false
        end)

        flashlightTool.Parent = player.Backpack
        Debris:AddItem(flashlightTool, 120)
    end
end

for _, player in pairs(Players:GetPlayers()) do
    createFlashlight(player)
    player.CharacterAdded:Connect(function()
        createFlashlight(player)
    end)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createFlashlight(player)
    end)
end)

game.DescendantAdded:Connect(function(part)
    if part:IsA("PointLight") or part:IsA("SpotLight") then
        part:Destroy()
    end
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

local NightmareHotel = getGitSoundId("https://raw.githubusercontent.com/Teilsthebfdifan/Guiding-modhub/main/Death%20is%20near%20%20Guiding%20Modhub%20OST.mp3", "DeathIsNearNightmareHotel")
NightmareHotel.Parent = game.SoundService
NightmareHotel.Looped = true
NightmareHotel:Play()
