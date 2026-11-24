-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local _ExpChatShared = require(ExpChatParent.ExpChatShared)
local React = require(ExpChatParent.React)
local RoactUtils = require(ExpChatParent.RoactUtils)
local Signals = require(ExpChatParent.Signals)
local SignalsReact = require(ExpChatParent.SignalsReact)
local SharedFlags = require(ExpChatParent.SharedFlags)

local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useSignalState = SignalsReact.useSignalState

local function selectRoduxTabType(arg1)
    local channelTabs = arg1.ChannelTabs
    if channelTabs == nil or channelTabs.allChannelTabs == nil or channelTabs.selectedTabName == nil then
        return nil
    end
    local allChannelTab = channelTabs.allChannelTabs[channelTabs.selectedTabName]
    return allChannelTab and allChannelTab.Type or nil
end

return if SharedFlags.FFlagExpChatUseChannelTabsStore then function() -- name: useSelectedTabTypeFromSignals
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var1 = GetChannelTabsStore(false).getChannelTabsState(arg1)
            local selectedTabName = var1.selectedTabName
            if selectedTabName == nil then
                return nil
            end
            local allChannelTab = var1.allChannelTabs[selectedTabName]
            return allChannelTab and allChannelTab.type or nil
        end)
    end, {})

    return useSignalState(var1)
end else function() -- name: useSelectedTabTypeFromRodux
    return useSelector(selectRoduxTabType)
end
