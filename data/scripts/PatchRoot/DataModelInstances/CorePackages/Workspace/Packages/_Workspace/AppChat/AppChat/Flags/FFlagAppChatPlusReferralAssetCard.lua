-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local FFlagAppChatResolveShareLinkV2 = require(script.Parent.FFlagAppChatResolveShareLinkV2)
local FFlagEnablePlusReferralLandingSheet = require(AppChatParent.SharedFlags).FFlagEnablePlusReferralLandingSheet

return game:DefineFastFlag("AppChatPlusReferralAssetCard", false)
    and FFlagAppChatResolveShareLinkV2
    and FFlagEnablePlusReferralLandingSheet
