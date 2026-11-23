-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")

local GetFFlagEnableVPCUpsellFoundationDialogHardening = require(AmpUpsell.Flags.GetFFlagEnableVPCUpsellFoundationDialogHardening)

local GetFFlagEnableFoundationUIVPCUpsellForInExperience = require(AmpUpsell.Flags.GetFFlagEnableFoundationUIVPCUpsellForInExperience)

return function(bool1: boolean)
    return GetFFlagEnableVPCUpsellFoundationDialogHardening() or GetFFlagEnableFoundationUIVPCUpsellForInExperience() and bool1
end
