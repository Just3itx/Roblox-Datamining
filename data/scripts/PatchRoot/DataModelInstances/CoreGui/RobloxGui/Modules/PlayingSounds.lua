-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GetFFlagSoundTelemetryOsClock = require(CoreGui.RobloxGui.Modules.Flags.GetFFlagSoundTelemetryOsClock)

local module = {}
module.__index = module

function module.new(aggregatedData)
    local result = {}
    setmetatable(result, module)
    result.aggregatedData = aggregatedData
    result.sounds = {}
    return result
end

function module:addSound(str1: string, str2: string)
    local sound = self.sounds[str1]

    if sound == nil then
        if GetFFlagSoundTelemetryOsClock() then
            self.sounds[str1] = {
                count = 0,
                starttime = os.clock(),
                maxLoopCount = 1,
                instances = {}
            }
        else
            self.sounds[str1] = {
                count = 0,
                starttime = os.time(),
                maxLoopCount = 1,
                instances = {}
            }
        end

        sound = self.sounds[str1]
    end

    if sound.instances[str2] == nil then
        sound.instances[str2] = 1
        sound.count += 1
    end
end

function module:removeSound(str1: string, str2: string)
    local sound = self.sounds[str1]

    if sound == nil then
        return
    end

    if sound.instances[str2] then
        sound.instances[str2] = nil
        sound.count -= 1
    end

    if sound.count ~= 0 then
        return
    end

    if GetFFlagSoundTelemetryOsClock() then
        self.aggregatedData:addPlay(str1, math.round(os.clock() - sound.starttime), sound.maxLoopCount)
    else
        self.aggregatedData:addPlay(str1, os.time() - sound.starttime, sound.maxLoopCount)
    end

    self.sounds[str1] = nil
end

function module:loopSound(str1: string, str2: string)
    local sound = self.sounds[str1]
    if sound == nil or sound.instances[str2] == nil then
        return
    end
    local instances = sound.instances
    instances[str2] += 1
    sound.maxLoopCount = math.max(sound.maxLoopCount, sound.instances[str2])
end

return module
