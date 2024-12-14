local function getGitSoundId(GithubSoundPath: string, AssetName: string): Sound
    local Url = GithubSoundPath

    if not isfile(AssetName..".mp3") then 
        writefile(AssetName..".mp3", game:HttpGet(Url)) 
    end

    local Sound = Instance.new("Sound")
    Sound.SoundId = getcustomasset(AssetName..".mp3", true)
    return Sound 
end

local FrozenHotelV3 = getGitSoundId("https://raw.githubusercontent.com/Teilsthebfdifan/Guiding-modhub/main/Decreased%20Temperature%20%20Guiding%20Modhub%20OST.mp3", "FrozenHotel")
FrozenHotelV3.Parent = game.SoundService
FrozenHotelV3.Looped = true
FrozenHotelV3:Play()