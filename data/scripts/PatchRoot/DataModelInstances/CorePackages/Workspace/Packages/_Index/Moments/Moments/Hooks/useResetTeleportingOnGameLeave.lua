-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local MessageBus = require(MomentsParent.MessageBus).MessageBus

local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)

local function gameLeaveMessageValidator(arg1): boolean
    return typeof(arg1) == "table"
end

local function useResetTeleportingOnGameLeave()
    React.useEffect(function()
        local subscriber = MessageBus.Subscriber.new()
        local mid = MessageBus.getMessageId("Game", "onGameLeave")
        subscriber:subscribe({ mid = mid, validateParams = gameLeaveMessageValidator }, function(_)
            GetMomentsPreferencesStore(false).setTeleporting(false)
        end)

        return function()
            subscriber:unsubscribeWithMsgId(mid)
        end
    end, {})
end

return useResetTeleportingOnGameLeave
