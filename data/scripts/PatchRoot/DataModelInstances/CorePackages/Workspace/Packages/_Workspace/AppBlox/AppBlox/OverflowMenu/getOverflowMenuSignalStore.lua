-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppBlox = script:FindFirstAncestor("AppBlox")
local createOverflowMenuSignalStore = require(AppBlox.OverflowMenu.createOverflowMenuSignalStore)

local var1 = nil

local function getOverflowMenuSignalStore()
    if var1 == nil then
        var1 = createOverflowMenuSignalStore()
    end
    return var1
end

return getOverflowMenuSignalStore
