-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local SduiCapabilities = require(ServerTriggeredModalsParent.SduiSharedUtilities).SduiCapabilities

local function isPinShortcutAvailable()
    return SduiCapabilities.isEnabled("CAPABILITY_SUPPORTS_PIN_SHORTCUT_ACTION")
end

return isPinShortcutAvailable
