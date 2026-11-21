-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Constants)

local function parseCloseupCameraConfig(arg1)
    local defaultDistanceScale = Constants.DefaultDistanceScale
    local defaultYRotDeg = Constants.DefaultYRotDeg
    local defaultFieldOfViewDeg = Constants.DefaultFieldOfViewDeg
    local var1 = nil

    local avatarThumbnailCustomizations = arg1 and arg1.avatarThumbnailCustomizations
    if avatarThumbnailCustomizations then
        for _, avatarThumbnailCustomization in avatarThumbnailCustomizations do
            if avatarThumbnailCustomization.thumbnailType ~= Constants.CloseupThumbnailTypeApi then
                continue
            end

            if avatarThumbnailCustomization.emoteAssetId and avatarThumbnailCustomization.emoteAssetId ~= 0 then
                var1 = tostring(avatarThumbnailCustomization.emoteAssetId)
            end
            local camera = avatarThumbnailCustomization.camera
            if camera then
                local distanceScale = camera.distanceScale
                if typeof(distanceScale) == "number" and distanceScale ~= -1 then
                    defaultDistanceScale = distanceScale
                end

                if typeof(camera.yRotDeg) == "number" then
                    defaultYRotDeg = camera.yRotDeg
                end
                if typeof(camera.fieldOfViewDeg) == "number" and camera.fieldOfViewDeg > 0 then
                    defaultFieldOfViewDeg = camera.fieldOfViewDeg
                end
            end

            break
        end
    end

    return {
        distanceScale = defaultDistanceScale,
        yRotDeg = defaultYRotDeg,
        fieldOfViewDeg = defaultFieldOfViewDeg,
        emoteAssetId = var1
    }
end

return parseCloseupCameraConfig
