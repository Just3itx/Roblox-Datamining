-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent
local React = require(StreamNotificationsParent.React)

local useTCStreamNotificationEventHandler = require(StreamNotificationsParent.TrustedContacts).EventHandlers.useTCStreamNotificationEventHandler

local function useClientTriggerEventHandler()
    local var1 = useTCStreamNotificationEventHandler()

    return (React.useCallback(function(str1: string?, arg1)
        if str1 == "TrustedContactsDoubleOptInModal" then
            var1({ clientEventsPayload = arg1.clientEventsPayload, callback = arg1.callback })
        end
    end, { var1 }))
end

return useClientTriggerEventHandler
