-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagEditProfileImageV2Enabled = require(script.Parent.FFlagEditProfileImageV2Enabled)

return game:DefineFastFlag("EditProfileFramesEnabled2", false)
    and FFlagEditProfileImageV2Enabled
    and game:GetEngineFeature("FrameAssetInProfileConfigurationEnabled")
