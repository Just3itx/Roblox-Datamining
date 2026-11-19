-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T02:20:31Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagPushNotificationsUpsellPassClientAttributesToPrompts = require(script.Parent.FFlagPushNotificationsUpsellPassClientAttributesToPrompts)

return game:DefineFastFlag("PushNotificationsUpsellHomePromptsExperiment", false)
    and FFlagPushNotificationsUpsellPassClientAttributesToPrompts
