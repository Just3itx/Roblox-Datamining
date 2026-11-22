-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local _MomentsTypes = require(MomentsParent.MomentsTypes)

return {
    LoadStatus = { Idle = "Idle", Loading = "Loading", Success = "Success", Failed = "Failed" },
    pendingSentinel = function(str1: string): string
        return `pending:{str1}`
    end,
    isPendingSentinel = function(str1: string): boolean
        return string.sub(str1, 1, 8) == "pending:"
    end
}
