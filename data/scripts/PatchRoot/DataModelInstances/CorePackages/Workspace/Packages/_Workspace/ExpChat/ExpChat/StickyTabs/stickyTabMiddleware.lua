-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local FriendsChatChannelAdded = require(ExpChat.Actions.FriendsChatChannelAdded)
local LocalTextChannelParticipantAdded = require(ExpChat.Actions.LocalTextChannelParticipantAdded)
local UniverseChatChannelAdded = require(ExpChat.Actions.UniverseChatChannelAdded)
local StickyTabObserver = require(script.Parent.StickyTabObserver)
local _StickyTabsStore = require(script.Parent.StickyTabsStore)

local tbl1 = {}
tbl1[LocalTextChannelParticipantAdded.name] = function(arg1)
    return arg1.textChannel.Name
end

tbl1[UniverseChatChannelAdded.name] = function(arg1)
    return arg1.channelName
end

tbl1[FriendsChatChannelAdded.name] = function(arg1)
    return arg1.channelName
end

local function stickyTabMiddleware(func1: (...any) -> (...any), arg1)
    return function(arg2)
        local var1 = func1(arg2)
        local type2 = if type(arg2) == "table" then arg2.type else nil
        local var2 = if type(type2) == "string" then tbl1[type2] else nil

        if var2 then
            local var3 = var2(arg2)

            local channelTabs = arg1:getState().ChannelTabs
            if channelTabs and channelTabs.allChannelTabs[var3] then
                StickyTabObserver:goToStickyTab(var3)
            end
        end

        return var1
    end
end

return stickyTabMiddleware
