-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent
local Signals = require(StreamNotificationsParent.Signals)

local getStreamPresented, setStreamPresented = Signals.createSignal(false)

local getActiveBellId, setActiveBellId = Signals.createSignal(nil)

return {
    setStreamPresented = setStreamPresented,
    getStreamPresented = getStreamPresented,
    getActiveBellId = getActiveBellId,
    setActiveBellId = setActiveBellId,
    PrimaryBellId = "StreamNotificationPrimaryBell",
    isBellActive = function(bool1: boolean, str1: string?, str2: string?, bool2: boolean?, bool3: boolean?): boolean
        if not bool1 or bool3 == false then
            return false
        end
        if str1 == "StreamNotificationPrimaryBell" then
            return bool2 == true
        end
        if str1 == str2 then
            return true
        end

        return str1 == nil and bool2 == true
    end
}
