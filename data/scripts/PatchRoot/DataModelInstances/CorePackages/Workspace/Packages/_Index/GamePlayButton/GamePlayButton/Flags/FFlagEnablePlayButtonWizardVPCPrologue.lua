-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local AmpUpsell = require(GamePlayButtonParent.AmpUpsell)

return game:DefineFastFlag("EnablePlayButtonWizardVPCPrologue", false)
    and AmpUpsell.GetFFlagEnableAmpVPCPrologue()
    and AmpUpsell.GetFFlagEnableReusableVPCPrologue()
    and AmpUpsell.GetFFlagEnableAmpWizardVPCNavigationFix()
