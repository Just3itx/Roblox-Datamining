-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

return game:DefineFastFlag("MomentsTextOverlayTopNav", false) and MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign
