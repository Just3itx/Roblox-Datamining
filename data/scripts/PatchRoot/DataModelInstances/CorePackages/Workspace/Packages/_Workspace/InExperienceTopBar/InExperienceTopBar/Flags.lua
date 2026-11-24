-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceTopBarParent = script:FindFirstAncestor("InExperienceTopBar").Parent

local ChromeEnabled = require(InExperienceTopBarParent.Chrome).Enabled
local SharedFlags = require(InExperienceTopBarParent.SharedFlags)

local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagAddUILessMode = SharedFlags.FFlagAddUILessMode
local FFlagFixBulkPurchaseTopBarObfuscation = SharedFlags.FFlagFixBulkPurchaseTopBarObfuscation

local CoreGuiCommon = require(InExperienceTopBarParent.CoreGuiCommon)
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas
local FFlagTopBarSignalizeMenuOpen = CoreGuiCommon.Flags.FFlagTopBarSignalizeMenuOpen
local FFlagTopBarSignalizeScreenSize = CoreGuiCommon.Flags.FFlagTopBarSignalizeScreenSize

local FFlagTopBarSignalizeSetCores = game:DefineFastFlag("TopBarSignalizeSetCores", false)
local bool2 = game:DefineFastFlag("TopBarRefactor2", false)
return {
    FFlagExperienceAgeRatingBadge = game:DefineFastFlag("ExperienceAgeRatingBadge2", false),
    FFlagTopBarSignalizeSetCores = FFlagTopBarSignalizeSetCores,
    FFlagTopBarRefactor = bool2
        and FFlagFixBulkPurchaseTopBarObfuscation
        and ChromeEnabled()
        and FFlagTopBarSignalizeKeepOutAreas
        and FFlagTopBarSignalizeMenuOpen
        and FFlagTopBarSignalizeScreenSize
        and FFlagEnableConsoleExpControls
        and not FFlagAddUILessMode
}
