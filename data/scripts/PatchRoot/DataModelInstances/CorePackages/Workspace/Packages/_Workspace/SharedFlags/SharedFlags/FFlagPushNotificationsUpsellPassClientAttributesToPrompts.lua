-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T02:20:32Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagHomepagePromptsHandlerPassClientAttributes = require(script.Parent.FFlagHomepagePromptsHandlerPassClientAttributes)
local GetFFlagEnablePushNotificationsUpsellModal = require(script.Parent.GetFFlagEnablePushNotificationsUpsellModal)

return game:DefineFastFlag("PushNotificationsUpsellPassClientAttributesToPrompts", false)
    and FFlagHomepagePromptsHandlerPassClientAttributes
    and GetFFlagEnablePushNotificationsUpsellModal()
