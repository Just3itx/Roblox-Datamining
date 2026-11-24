-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local RoactUtils = require(ExpChatParent.RoactUtils)
local SharedFlags = require(ExpChatParent.SharedFlags)

local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)
local SetChannelUnreadStatus = require(ExpChat.Actions.SetChannelUnreadStatus)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

return if SharedFlags.FFlagExpChatUseChannelTabsStore then function(str1: string) -- name: useSignalsChannelTabUnreadWriter
    local channelTabsStore = GetChannelTabsStore(false)
    return React.useCallback(function(bool1: boolean)
        channelTabsStore.setChannelUnreadStatus(str1, bool1)
    end, { channelTabsStore, str1 })
end else function(str1: string) -- name: useRoduxChannelTabUnreadWriter
    local var1 = useDispatch()
    return React.useCallback(function(bool1: boolean)
        var1(SetChannelUnreadStatus(str1, bool1))
    end, { var1, str1 })
end
