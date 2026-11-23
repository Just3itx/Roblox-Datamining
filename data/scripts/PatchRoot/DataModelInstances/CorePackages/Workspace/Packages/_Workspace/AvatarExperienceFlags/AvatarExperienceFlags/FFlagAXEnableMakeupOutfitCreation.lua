-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXOutfitPageRevamp = require(script.Parent.FFlagAXOutfitPageRevamp)

local engineFeature = game:GetEngineFeature("AvatarEditorServiceV4CreateOutfitType")

return game:DefineFastFlag("AXEnableMakeupOutfitCreation", false) and FFlagAXOutfitPageRevamp and engineFeature
