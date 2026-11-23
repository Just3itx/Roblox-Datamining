-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
local bool1 = game:DefineFastFlag("AXProfileConfigurationMultiFieldApply", false)

local engineFeature = game:GetEngineFeature("AvatarEditorServiceApplyProfileConfigurationEnabled")
    and game:GetEngineFeature("FrameAssetInProfileConfigurationEnabled")

return bool1 and engineFeature
