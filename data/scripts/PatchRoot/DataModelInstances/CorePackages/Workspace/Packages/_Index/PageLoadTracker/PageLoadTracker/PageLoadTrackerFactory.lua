-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local createPageTracker = require(script.Parent.createPageTracker)

local function getTracker(tbl1, str1: string)
    if tbl1.trackers[str1] == nil then
        local pageTracker = createPageTracker()
        tbl1.trackers[str1] = pageTracker
    end
    return tbl1.trackers[str1]
end

local function removeTracker(tbl1, str1: string)
    local tracker = tbl1.trackers[str1]
    if tracker then
        tracker:stop()
        tbl1.trackers[str1] = nil
    end
end

local function createFactory() -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        trackers = {},
        getTracker = getTracker,
        removeTracker = removeTracker
    }
end

local var1 = nil

return {
    getInstance = function()
        var1 = var1 or createFactory()

        return var1
    end
}
