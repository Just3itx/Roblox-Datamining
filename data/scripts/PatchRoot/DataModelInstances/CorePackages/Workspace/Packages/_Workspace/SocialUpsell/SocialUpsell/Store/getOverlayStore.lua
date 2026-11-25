-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialUpsellParent = script:FindFirstAncestor("SocialUpsell").Parent
local Signals = require(SocialUpsellParent.Signals)

local createOverlayStore = require(script.Parent.createOverlayStore)

return Signals.createComputed(createOverlayStore)
