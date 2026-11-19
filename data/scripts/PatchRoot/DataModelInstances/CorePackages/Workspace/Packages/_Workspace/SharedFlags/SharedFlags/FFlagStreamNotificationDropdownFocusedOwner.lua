-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T02:31:18Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagAppChatRemoveNotifications = require(script.Parent.FFlagAppChatRemoveNotifications)
local FFlagStreamNotificationDropdownSingleOwner = require(script.Parent.FFlagStreamNotificationDropdownSingleOwner)

return game:DefineFastFlag("StreamNotificationDropdownFocusedOwner", false)
    and FFlagAppChatRemoveNotifications
    and FFlagStreamNotificationDropdownSingleOwner
