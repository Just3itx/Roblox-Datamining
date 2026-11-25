-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local RobloxGui = CoreGui.RobloxGui
local scriptParentParent = script.Parent.Parent
local Cryo = require(scriptParentParent.Cryo)
local var1 = require(scriptParentParent.Lumberyak).Logger.new(nil, "SoundManager")
local Sounds = require(script.Parent.Sounds)
local SoundEffects = require(script.Parent.SoundEffects)
local SoundGroups = require(script.Parent.SoundGroups)

local module = {}

module.__index = module

local tbl1 = {
    Looped = false,
    PlaybackSpeed = 1,
    Volume = 1,
    FadeInTime = nil,
    FadeOutTime = nil,
    SoundEffects = nil
}

local tbl2 = {}

local function fadeVolume(arg1: Instance, num1: number, volume: number, str1: string)
    if num1 < 0 then
        error(str1 .. " cannot have a negative fadeIn/fadeOut time.")
    end

    local var2 = (volume - arg1.Volume) / num1

    local function onHeartBeat(deltaTime: number)
        local var3 = var2 * deltaTime
        local var4 = arg1.Volume + var3

        if var4 <= 0 then
            arg1.Volume = 0
            arg1:Stop()
            tbl2[arg1.SoundId]:Disconnect()
        elseif volume <= var4 then
            arg1.Volume = volume
            tbl2[arg1.SoundId]:Disconnect()
        else
            arg1.Volume = var4
        end
    end

    if tbl2[arg1.SoundId] and tbl2[arg1.SoundId].Connected then
        tbl2[arg1.SoundId]:Disconnect()
    end

    tbl2[arg1.SoundId] = RunService.Heartbeat:Connect(onHeartBeat)
end

function module._createSoundEffect(_, className: string, instanceName: string, tbl3, parent)
    if not SoundEffects[className] then
        error(className .. " does not exist in list of SoundEffects")
    end

    local instance = Instance.new(className)

    for k, value in pairs(tbl3) do
        instance[k] = value
    end

    instance.Parent = parent
    instance.Name = instanceName
end

function module.PlaySound(arg1, str1: string, arg2, arg3)
    local soundManagerSounds = RobloxGui:FindFirstChild("SoundManager_Sounds")
    if not soundManagerSounds then
        error("SoundManager's Sounds folder is missing. SoundManager has not been initialized.")
    end

    local sound = Sounds[str1]
    if not sound then
        error(str1 .. " does not exist in library of Sounds")
        return
    end

    local var2 = Cryo.Dictionary.join(tbl1, sound.DefaultPlaybackProperties or {}, arg2 or {})

    local var3 = soundManagerSounds:FindFirstChild(sound.Name)
    if not var3 then
        var3 = Instance.new("Sound")
        var3.Parent = soundManagerSounds
        var3.SoundId = sound.SoundId
        var3.Name = sound.Name
    end

    for _, child in pairs(var3:GetChildren()) do
        child:Destroy()
    end

    if arg3 then
        var3.SoundGroup = RobloxGui:FindFirstChild("SoundManager_SoundGroups"):FindFirstChild(arg3.Name)
    end

    for k, value in pairs(var2) do
        if k ~= "FadeInTime" and k ~= "FadeOutTime" and k ~= "Effects" then
            var3[k] = value
        end
    end
    for _, value in ipairs(var2.SoundEffects or {}) do
        arg1:_createSoundEffect(value.Type, value.Name, value.Properties, var3)
    end

    if var2.FadeInTime then
        var3.Volume = 0

        fadeVolume(var3, var2.FadeInTime, var2.Volume, str1)
    end

    var3:Play()
end

function module.StopSound(_, str1: string)
    local soundManagerSounds = RobloxGui:FindFirstChild("SoundManager_Sounds")
    if not soundManagerSounds then
        error("SoundManager's Sounds folder is missing. SoundManager has not been initialized.")
    end

    local sound = Sounds[str1]
    if not sound then
        error(str1 .. " does not exist in list of Sounds")
        return
    end

    local var2 = soundManagerSounds:FindFirstChild(sound.Name)
    if not var2 then
        error(str1 .. " does not exist")
        return
    end

    local defaultPlaybackProperties = sound.DefaultPlaybackProperties
    local fadeOutTime = if defaultPlaybackProperties then defaultPlaybackProperties.FadeOutTime else nil

    if fadeOutTime then
        fadeVolume(var2, fadeOutTime, 0, str1)
        return
    end
    var2:Stop()
end

function module.CreateSoundGroup(tbl3, str1: string)
    local soundGroup = SoundGroups[str1]
    if not soundGroup then
        error("SoundGroup does not exist in list of SoundGroups")
        return
    end

    local soundManagerSoundGroups = RobloxGui:FindFirstChild("SoundManager_SoundGroups")
    if not soundManagerSoundGroups then
        error("SoundManager's SoundGroups folder is missing. SoundManager has not been initialized.")
        return
    end

    if soundManagerSoundGroups:FindFirstChild(str1) then
        warn("SoundGroup already exists")
        return
    end

    local soundGroup2 = Instance.new("SoundGroup")
    soundGroup2.Name = soundGroup.Name
    soundGroup2.Parent = soundManagerSoundGroups
    soundGroup2.Volume = soundGroup.Volume

    for _, soundEffect in ipairs(soundGroup.SoundEffects) do
        tbl3:_createSoundEffect(soundEffect.Type, soundEffect.Name, soundEffect.Properties, soundGroup2)
    end
end

function module.SoundGroupAddSoundEffect(tbl3, name: string, arg1)
    if not SoundGroups[name] then
        error("SoundGroup does not exist in list of SoundGroups")
        return
    end

    local soundManagerSoundGroups = RobloxGui:FindFirstChild("SoundManager_SoundGroups")
    if not soundManagerSoundGroups then
        error("SoundManager's SoundGroups folder is missing. SoundManager has not been initialized.")
        return
    end

    local var2 = soundManagerSoundGroups:FindFirstChild(name)
    if not var2 then
        error("SoundGroup Instance not created")
        return
    end

    if var2:FindFirstChild(arg1.Name) then
        error("SoundEffect with name " .. arg1.Name .. " already exists for sound group " .. name)
    else
        tbl3:_createSoundEffect(arg1.Type, arg1.Name, arg1.Properties, var2)
    end
end

function module.SoundGroupRemoveSoundEffect(_, name: string, name2: string)
    local soundGroup = SoundGroups[name]
    if not soundGroup then
        error("SoundGroup does not exist in list of SoundGroups")
        return
    end

    local soundManagerSoundGroups = RobloxGui:FindFirstChild("SoundManager_SoundGroups")
    if not soundManagerSoundGroups then
        error("SoundManager's SoundGroups folder is missing. SoundManager has not been initialized.")
        return
    end

    local var2 = soundManagerSoundGroups:FindFirstChild(name)
    if not var2 then
        error("SoundGroup Instance not created")
        return
    end

    local var3 = var2:FindFirstChild(name2)
    if not var3 then
        error(name2 .. " not found in " .. soundGroup.Name)
    end

    var3:Destroy()
end

function module.init()
    local self = setmetatable({}, module)

    if RobloxGui:FindFirstChild("SoundManager_Sounds") then
        var1:warning("SoundManager already initialized")

        return self
    end

    local soundManagerSounds = Instance.new("Folder")
    soundManagerSounds.Name = "SoundManager_Sounds"
    soundManagerSounds.Parent = RobloxGui

    local soundManagerSoundGroups = Instance.new("Folder")
    soundManagerSoundGroups.Name = "SoundManager_SoundGroups"
    soundManagerSoundGroups.Parent = RobloxGui
    return self
end

return module
