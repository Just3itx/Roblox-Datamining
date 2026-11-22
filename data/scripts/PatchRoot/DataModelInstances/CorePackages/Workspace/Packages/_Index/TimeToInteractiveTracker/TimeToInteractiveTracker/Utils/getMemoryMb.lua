-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTrackerParent = script:FindFirstAncestor("TimeToInteractiveTracker").Parent

local MemoryTracker = require(TimeToInteractiveTrackerParent.Memory).MemoryTracker

local function getMemoryMb()
    local var1 = MemoryTracker()
    if not var1 then
        return {}
    end

    local snapshot = var1.getSnapshot()
    local tbl1 = {
        totalMemoryMB = if snapshot.totalMemory then tonumber(snapshot.totalMemory) else nil,
        luaHeapMB = tonumber(snapshot.luaHeapMb)
    }
    return tbl1
end

return getMemoryMb
