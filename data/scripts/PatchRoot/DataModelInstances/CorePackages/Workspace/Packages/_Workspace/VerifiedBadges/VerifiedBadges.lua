-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
local constants = require(script.constants)

return {
    EmojiWrapper = require(script.Components.EmojiWrapper),
    AboutVerifiedBadgeModal = require(script.Components.AboutVerifiedBadgeModal),
    installReducer = require(script.installReducer),
    emoji = {
        verified = constants.VERIFIED_EMOJI,
        premium = constants.PREMIUM_EMOJI
    },
    appendVerifiedBadge = require(script.Utils.appendVerifiedBadge),
    appendPremiumBadge = require(script.Utils.appendPremiumBadge),
    isCreatorOfGameVerified = require(script.Utils.isCreatorOfGameVerified)
}
