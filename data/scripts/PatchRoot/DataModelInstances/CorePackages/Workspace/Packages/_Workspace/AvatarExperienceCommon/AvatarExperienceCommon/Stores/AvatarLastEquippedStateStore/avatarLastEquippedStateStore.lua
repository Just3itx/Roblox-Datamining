-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local getAvatarLastEquippedState = nil
local getChangedLayeredMakeupSorting = false
local getShouldRevertLastEquippedState = true

return {
    getAvatarLastEquippedState = function()
        return getAvatarLastEquippedState
    end,
    setAvatarLastEquippedState = function(tbl1)
        getAvatarLastEquippedState = tbl1
    end,
    getChangedLayeredMakeupSorting = function()
        return getChangedLayeredMakeupSorting
    end,
    setChangedLayeredMakeupSorting = function(bool3: boolean)
        getChangedLayeredMakeupSorting = bool3
    end,
    getShouldRevertLastEquippedState = function()
        return getShouldRevertLastEquippedState
    end,
    setShouldRevertLastEquippedState = function(bool3: boolean)
        getShouldRevertLastEquippedState = bool3
    end
}
