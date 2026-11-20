-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local safelyAccessProperty = require(SceneUnderstanding.safelyAccessProperty)
local getOutputWires = require(SceneUnderstanding.wiring.getOutputWires)
local _types = require(SceneUnderstanding.wiring.types)
local toWirableInstance = require(SceneUnderstanding.wiring.toWirableInstance)

local function calculateSoundPotentialAudibility(sound: Sound) -- Luacid: Inlined by compiler; 1 call site recovered
    if not sound.IsPlaying then
        return 0
    end

    local var1 = safelyAccessProperty(sound, "RollOffGain", 0)

    local num1 = if sound.SoundGroup then sound.SoundGroup.Volume else 1

    if var1 < 1 then
        var1 /= 10
    end

    return num1 * sound.Volume * var1
end

local function getOutputsOf(arg1): {Instance}
    if typeof(arg1) == "Instance" and arg1:IsA("AudioEmitter") then
        return (arg1:GetInteractingListeners())
    end

    local outputsOf = {}

    for _, value in getOutputWires(arg1) do
        local var1 = toWirableInstance(value.TargetInstance)
        if var1 then
            table.insert(outputsOf, var1)
        end
    end

    return outputsOf
end

local function getAudibilityMultiplierFor(audioEmitter: AudioEmitter) -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0
    for _, interactingListener in audioEmitter:GetInteractingListeners() do
        num1 += interactingListener:GetAudibilityFor(audioEmitter)
    end
    return num1
end

local function getAudibilityOf(arg1, tbl1)
    local tbl2 = tbl1 or {}
    if tbl2[arg1] then
        return 0
    end

    tbl2[arg1] = true
    local num1 = 1
    if typeof(arg1) == "Instance" then
        if arg1:IsA("AudioPlayer") or arg1:IsA("AudioFader") then
            num1 = arg1.Volume
        elseif arg1:IsA("AudioEmitter") then
            num1 = getAudibilityMultiplierFor(arg1)
        elseif arg1:IsA("AudioDeviceOutput") then
            return 1
        end
    end

    local num2 = 0
    for _, value in getOutputsOf(arg1) do
        num2 += num1 * getAudibilityOf(value, tbl2)
    end
    return num2
end

local function calculatePotentialAudibility(arg1)
    return safelyAccessProperty(UserGameSettings, "MasterVolume", 0) * (if arg1:IsA("Sound") then calculateSoundPotentialAudibility(arg1) else getAudibilityOf(arg1))
end

return calculatePotentialAudibility
