-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local yieldInterval = game:DefineFastInt("LuaAppSchedulerYieldInterval", -1)
local num1 = game:DefineFastInt("LuaAppSchedulerDeferredWork", -1)
local num2 = game:DefineFastInt("LuaAppSchedulerHeartbeatFrameMarker", -1)
local num3 = game:DefineFastInt("LuaAppSchedulerTargetMsByHeartbeatDelta", -1)
local numberOfLookbackFrames = game:DefineFastInt("LuaAppSchedulerNumberOfLookbackFrames", -1)
local num4 = game:DefineFastInt("LuaAppSchedulerLookbackUseRingBuffer", -1)
local desiredFrameRate = game:DefineFastInt("LuaAppSchedulerDesiredFrameRate", -1)
local minimumFrameRate = game:DefineFastInt("LuaAppSchedulerMinimumFrameRate", -1)

local yieldInterval2 = game:DefineFastInt("LuaInExpSchedulerYieldInterval", -1)
local num5 = game:DefineFastInt("LuaInExpSchedulerDeferredWork", -1)
local num6 = game:DefineFastInt("LuaInExpSchedulerHeartbeatFrameMarker", -1)

local num7 = game:DefineFastInt("LuaInExpSchedulerTargetMsByHeartbeatDelta", -1)
local numberOfLookbackFrames2 = game:DefineFastInt("LuaInExpSchedulerNumberOfLookbackFrames", -1)
local num8 = game:DefineFastInt("LuaInExpSchedulerLookbackUseRingBuffer", -1)
local desiredFrameRate2 = game:DefineFastInt("LuaInExpSchedulerDesiredFrameRate", -1)
local minimumFrameRate2 = game:DefineFastInt("LuaInExpSchedulerMinimumFrameRate", -1)

local function buildFlags(yieldInterval3: number, num9: number, num10: number, num11: number, numberOfLookbackFrames3: number, num12: number, desiredFrameRate3: number, minimumFrameRate3: number): {[any]: any}?
    local tbl1 = {}
    local bool1

    if yieldInterval3 == -1 then
        bool1 = false
    else
        tbl1.yieldInterval = yieldInterval3
        bool1 = true
    end

    if num9 ~= -1 then
        tbl1.deferredWork = num9 == 1
        bool1 = true
    end

    if num10 ~= -1 then
        tbl1.heartbeatFrameMarker = num10 == 1
        bool1 = true
    end

    if num11 ~= -1 then
        tbl1.targetMsByHeartbeatDelta = num11 == 1
        bool1 = true
    end

    if numberOfLookbackFrames3 ~= -1 then
        tbl1.numberOfLookbackFrames = numberOfLookbackFrames3
        bool1 = true
    end

    if num12 ~= -1 then
        tbl1.lookbackUseRingBuffer = num12 == 1
        bool1 = true
    end

    if desiredFrameRate3 ~= -1 then
        tbl1.desiredFrameRate = desiredFrameRate3
        bool1 = true
    end

    if minimumFrameRate3 ~= -1 then
        tbl1.minimumFrameRate = minimumFrameRate3
        bool1 = true
    end

    return if bool1 then tbl1 else nil
end

return {
    getApp = function()
        return (buildFlags(yieldInterval, num1, num2, num3, numberOfLookbackFrames, num4, desiredFrameRate, minimumFrameRate))
    end,
    getInExp = function()
        return (buildFlags(yieldInterval2, num5, num6, num7, numberOfLookbackFrames2, num8, desiredFrameRate2, minimumFrameRate2))
    end
}
