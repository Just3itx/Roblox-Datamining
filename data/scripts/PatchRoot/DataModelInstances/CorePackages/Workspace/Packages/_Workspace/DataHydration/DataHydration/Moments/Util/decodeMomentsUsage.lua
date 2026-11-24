-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)

local function toNumber(arg1, num1: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return if type(arg1) == "number" then arg1 else num1
end

local function decodeMomentsUsage(arg1)
    local var1 = type(arg1) ~= "table" and {} or arg1

    local limitSeconds = toNumber(var1.limitSeconds, -1)
    local usedSeconds = toNumber(var1.usedSeconds, 0)
    local var2

    if limitSeconds < 0 then
        var2 = -1
    else
        local remainingSeconds = var1.remainingSeconds
        local num3 = limitSeconds - usedSeconds
        var2 = toNumber(remainingSeconds, math.max(0, num3))
    end

    return {
        limitSeconds = limitSeconds,
        usedSeconds = usedSeconds,
        remainingSeconds = var2,
        resetsAt = if type(var1.resetsAt) == "string" then var1.resetsAt else nil
    }
end

return decodeMomentsUsage
