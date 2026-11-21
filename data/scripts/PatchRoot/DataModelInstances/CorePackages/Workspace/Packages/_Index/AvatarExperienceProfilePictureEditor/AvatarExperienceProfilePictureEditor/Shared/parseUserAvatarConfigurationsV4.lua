-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local parseCloseupCameraConfig = require(script.Parent.parseCloseupCameraConfig)
local parseProfileFrameAssetId = require(script.Parent.parseProfileFrameAssetId)

local function parseProfileFrameAssetIdFromV4(arg1)
    if arg1 == nil then
        return nil
    end

    local var1 = arg1.frameAsset or arg1.profileFrameAsset or arg1
    if typeof(var1) ~= "table" then
        return nil
    end

    local frameAssetId = var1.id or var1.assetId or var1.FrameAssetId
    if typeof(frameAssetId) == "number" and frameAssetId ~= 0 then
        return tostring(frameAssetId)
    end

    return parseProfileFrameAssetId({ FrameAssetId = frameAssetId })
end

return {
    parseProfileFrameAssetIdFromV4 = parseProfileFrameAssetIdFromV4,
    parseUserAvatarConfigurationsV4 = function(arg1)
        local avatarConfigurations = if typeof(arg1) == "table" then arg1.avatarConfigurations else nil
        local thumbnailCustomizations = if avatarConfigurations then avatarConfigurations.thumbnailCustomizations else nil
        return {
            closeupCameraConfig = parseCloseupCameraConfig({ avatarThumbnailCustomizations = thumbnailCustomizations }),
            profileFrameAssetId = parseProfileFrameAssetIdFromV4(if avatarConfigurations then avatarConfigurations.profileFrame else nil)
        }
    end
}
