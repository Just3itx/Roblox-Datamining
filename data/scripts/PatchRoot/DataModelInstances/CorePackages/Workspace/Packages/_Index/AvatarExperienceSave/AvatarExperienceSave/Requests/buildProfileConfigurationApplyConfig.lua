-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function buildProfileConfigurationApplyConfig(arg1)
    if arg1.BackgroundAssetId == nil and arg1.FrameAssetId == nil then
        error("ProfileConfiguration apply config must include BackgroundAssetId or FrameAssetId")
    end

    local profileConfigurationApplyConfig = {}

    if arg1.BackgroundAssetId ~= nil then
        profileConfigurationApplyConfig.BackgroundAssetId = arg1.BackgroundAssetId
    end

    if arg1.FrameAssetId ~= nil then
        profileConfigurationApplyConfig.FrameAssetId = arg1.FrameAssetId
    end

    return profileConfigurationApplyConfig
end

return buildProfileConfigurationApplyConfig
