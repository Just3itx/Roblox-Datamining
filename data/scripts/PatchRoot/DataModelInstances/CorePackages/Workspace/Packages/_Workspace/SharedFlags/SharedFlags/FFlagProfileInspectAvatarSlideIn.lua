-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T02:11:02Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagSocialEnableProfileInspectAndBuy = require(script.Parent.FFlagSocialEnableProfileInspectAndBuy)
local FFlagProfileInspectAvatarSpin = require(script.Parent.FFlagProfileInspectAvatarSpin)

return game:DefineFastFlag("ProfileInspectAvatarSlideIn", false)
    and FFlagProfileInspectAvatarSpin
    and FFlagSocialEnableProfileInspectAndBuy
