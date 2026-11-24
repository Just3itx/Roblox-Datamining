-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local FriendsChatFocus = require(ExpChatParent.FriendsChat.FriendsChatFocus)
local GetFocusNavigationStore = require(ExpChat.Stores.GetFocusNavigationStore)
local TabTypes = ExpChatShared.TabTypes

local tbl1 = {
    canOpenChat = function(): boolean -- name: neverOpen
        return false
    end,
    focus = function(_): Enum.ContextActionResult
        GetFocusNavigationStore(false).requestChatInputBarFocus()
        return Enum.ContextActionResult.Sink
    end
}

local tbl2 = {
    canOpenChat = FriendsChatFocus.canFocus,
    focus = function(tbl2)
        return FriendsChatFocus.focus(tbl2.keyCode)
    end
}

local function getTabShortcutBehavior(arg1)
    if arg1 == "FriendsChat" then
        return tbl2
    elseif arg1 == "TextChat" or arg1 == "UniverseChat" then
        return tbl1
    end

    return TabTypes.unreachable(arg1)
end

return getTabShortcutBehavior
