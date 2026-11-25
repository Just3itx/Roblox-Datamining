-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MemoryTracker = require(script.Common.MemoryTracker)
local MemoryScope = require(script.Common.MemoryScope)
local MemoryShell = require(script.Profiling.MemoryShell)
local FFlagEnableMemoryShell = require(script.Flags.FFlagEnableMemoryShell)

local module = {
    ["jest.config"] = script["jest.config"],
    MemoryTracker = MemoryTracker,
    MemoryScope = MemoryScope
}

function module.start(bool1: boolean?, str1: string?, arg1)
    if bool1 then
        local var1 = MemoryTracker(str1, arg1)
        if var1 then
            var1:start()
        end
    end

    if FFlagEnableMemoryShell then
        MemoryShell.start(str1 or "app")
    end
end

return module
