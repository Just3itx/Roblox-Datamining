-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagBuildExperienceMonetizationMultiKind = require(script.Parent.FFlagBuildExperienceMonetizationMultiKind)
local FFlagBuildExperienceMonetizationNativeUI = require(script.Parent.FFlagBuildExperienceMonetizationNativeUI)

local FFlagBuildExperienceMonetizationProductEditing = require(script.Parent.FFlagBuildExperienceMonetizationProductEditing)

return game:DefineFastFlag("BuildExperienceMonetizationManageKinds", false)
    and FFlagBuildExperienceMonetizationMultiKind
    and FFlagBuildExperienceMonetizationNativeUI
    and FFlagBuildExperienceMonetizationProductEditing
