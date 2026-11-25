-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MemoryParent = script:FindFirstAncestor("Memory").Parent

local DevShell = require(MemoryParent.DevShell)

local MemoryTracker = require(script.Parent.Parent.Common.MemoryTracker)
local GarbageCollector = require(script.Parent.Parent.Common.GarbageCollector)

local function getMemoryTracker() -- Luacid: Inlined by compiler; 2 call sites recovered
    return MemoryTracker()
end

local methods = {
    getLuaHeap = function()
        GarbageCollector.collect()
        local memoryTracker = getMemoryTracker()

        if memoryTracker then
            return memoryTracker.getLuaHeapOnly()
        end
        return { luaHeapMb = "-1" }
    end,
    getSnapshot = function()
        GarbageCollector.collect()
        local memoryTracker = getMemoryTracker()

        if memoryTracker then
            return memoryTracker.getSnapshot()
        end
        return { luaHeapMb = "-1" }
    end,
    forceGC = function(): string
        GarbageCollector.collect()
        return "ok"
    end
}

return {
    methods = methods,
    start = function(context: string)
        DevShell.registerMethods("memory", methods)
        DevShell.start({ context = context })
    end
}
