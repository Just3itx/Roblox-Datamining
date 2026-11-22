-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerContextualMenu = script:FindFirstAncestor("PlayerContextualMenu")
local PlayerContextualMenuParent = PlayerContextualMenu.Parent
local Rodux = require(PlayerContextualMenuParent.Rodux)
local UserBlocking = require(PlayerContextualMenu.Rodux.UserBlocking)

local FFlagUserBlockingApiPlayerContextMenuEnabled = require(PlayerContextualMenu.Flags.FFlagUserBlockingApiPlayerContextMenuEnabled)

return function()
    return Rodux.combineReducers({
        IsBlockedByMe = if FFlagUserBlockingApiPlayerContextMenuEnabled then nil else require(script.Parent.IsBlockedByMe),
        UserBlocking = if FFlagUserBlockingApiPlayerContextMenuEnabled then UserBlocking.installReducer() else nil
    })
end
