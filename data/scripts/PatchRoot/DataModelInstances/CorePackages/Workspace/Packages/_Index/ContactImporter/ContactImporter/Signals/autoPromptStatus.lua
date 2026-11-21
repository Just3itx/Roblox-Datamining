-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent

local Signal = require(ContactImporterParent.AppCommonLib).Signal

local getStatus = nil
local signal = Signal.new()

return {
    getStatus = function()
        return getStatus
    end,
    setStatus = function(bool1: boolean?)
        getStatus = bool1
        signal:fire(bool1)
    end,
    statusChanged = signal
}
