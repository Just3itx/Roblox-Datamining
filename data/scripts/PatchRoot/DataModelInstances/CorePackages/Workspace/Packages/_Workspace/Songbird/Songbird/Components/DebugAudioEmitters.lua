-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(Songbird.Parent.React)
local getFFlagDebugMusicSampleSounds = require(Songbird.Flags.getFFlagDebugMusicSampleSounds)

local useEffect = React.useEffect

local tbl1 = {
    {
        className = "Sound",
        title = "Beach Morning LoFi",
        assetId = "rbxassetid://83784623771159",
        position = Vector3.new(50, 0, 0)
    },
    {
        className = "AudioPlayer",
        title = "Mirage Portal",
        assetId = "rbxassetid://75793628822368",
        position = Vector3.new(-50, 0, 0)
    },
    {
        className = "Sound",
        title = "Altogether Elsewhere",
        assetId = "rbxassetid://73856926671353",
        position = Vector3.new(0, 0, 50)
    },
    {
        className = "Sound",
        title = "Shiawase",
        assetId = "rbxassetid://5409360995",
        position = Vector3.new(0, 0, -50)
    },
    {
        className = "Sound",
        title = "Life in an Elevator",
        assetId = "rbxassetid://1841647093",
        position = Vector3.new(100, 0, 0),
        shouldSurfaceToUser = false
    },
    {
        className = "Sound",
        title = "Explosion",
        assetId = "rbxassetid://157878578",
        position = Vector3.new(0, 0, 100),
        shouldSurfaceToUser = false
    }
}

local function spawnAudioEmitter(tbl2): Part
    local part = Instance.new("Part")
    part.Position = tbl2.position
    part.Anchored = true
    part.Name = tbl2.title

    if tbl2.className == "Sound" then
        local sound = Instance.new("Sound")
        sound.SoundId = tbl2.assetId
        sound.Looped = true
        sound.RollOffMinDistance = 10
        sound.RollOffMaxDistance = 40
        sound.Parent = part
        sound:Play()
    else
        local audioPlayer = Instance.new("AudioPlayer")

        audioPlayer.Asset = tbl2.assetId

        audioPlayer.Looping = true
        audioPlayer.Parent = part

        local audioEmitter = Instance.new("AudioEmitter")
        audioEmitter.Parent = part

        local wire = Instance.new("Wire")
        wire.SourceInstance = audioPlayer
        wire.TargetInstance = audioEmitter
        wire.Parent = audioPlayer

        audioPlayer:Play()
    end

    part.Parent = workspace

    return part
end

local function DebugAudioEmitters()
    if getFFlagDebugMusicSampleSounds() then
        useEffect(function()
            local audioListener = Instance.new("AudioListener")

            local audioDeviceOutput = Instance.new("AudioDeviceOutput")
            audioDeviceOutput.Parent = audioListener

            local wire = Instance.new("Wire")
            wire.SourceInstance = audioListener
            wire.TargetInstance = audioDeviceOutput
            wire.Parent = audioListener

            audioListener.Parent = workspace.CurrentCamera
        end, {})

        useEffect(function()
            local tbl2 = {}

            for _, value in tbl1 do
                local part = spawnAudioEmitter(value)

                local billboardGui = Instance.new("BillboardGui")
                billboardGui.ExtentsOffsetWorldSpace = Vector3.new(0, 10, 0)
                billboardGui.Size = UDim2.fromScale(10, 2)
                billboardGui.Adornee = part

                local textLabel = Instance.new("TextLabel")
                textLabel.Text = value.title
                textLabel.Size = UDim2.fromScale(1, 1)
                textLabel.Font = Enum.Font.BuilderSansBold
                textLabel.TextScaled = true
                textLabel.TextColor3 = if value.shouldSurfaceToUser == false then Color3.fromHex("#c4474f") else Color3.fromHex("#fff")

                textLabel.BackgroundTransparency = 1
                textLabel.Parent = billboardGui

                local uiStroke = Instance.new("UIStroke")
                uiStroke.Color = Color3.fromHex("#202020")
                uiStroke.Thickness = 2
                uiStroke.Parent = textLabel

                billboardGui.Parent = part

                table.insert(tbl2, part)
            end

            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://9048375035"
            sound.Volume = 0.05
            sound.Looped = true
            sound.Parent = ReplicatedStorage
            sound:Play()

            return function()
                sound:Destroy()

                for _, value in tbl2 do
                    value:Destroy()
                end
            end
        end, {})
    end

    return nil
end

return DebugAudioEmitters
