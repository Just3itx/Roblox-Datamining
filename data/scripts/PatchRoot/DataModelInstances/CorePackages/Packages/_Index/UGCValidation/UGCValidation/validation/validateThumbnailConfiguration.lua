-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local bool1 = game:DefineFastFlag("UGCValidationAddThumbnailFrustumCheckingv2", false)

local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local Analytics = require(scriptParentParent.Analytics)

local function validateThumbnailConfiguration(arg1, arg2, arg3, vec1: vector, arg4)
    local thumbnailConfiguration = arg1:FindFirstChild("ThumbnailConfiguration")

    if thumbnailConfiguration then
        local thumbnailCameraTarget = thumbnailConfiguration:FindFirstChild("ThumbnailCameraTarget")
        if thumbnailCameraTarget.Value ~= arg2 then
            Analytics.reportFailure(Analytics.ErrorType.validateThumbnailConfiguration_InvalidTarget, nil, arg4)

            return false, { string.format("Invalid target asset for thumbnail generation. Expected it to be '%s'.", arg2:GetFullName()) }
        end

        if game:GetEngineFeature("EngineUGCValidateThumbnailerMeshInFrustum") and bool1 then
            local thumbnailCameraTargetValueCFrame = thumbnailCameraTarget.Value.CFrame
            local var1 = thumbnailCameraTargetValueCFrame * thumbnailConfiguration:FindFirstChild("ThumbnailCameraValue").Value

            if UGCValidationService:CheckEditableMeshInCameraFrustum(arg3.editableMesh, vec1, thumbnailCameraTargetValueCFrame, var1) == false then
                Analytics.reportFailure(Analytics.ErrorType.validateThumbnailConfiguration_OutsideView, nil, arg4)

                return false, { string.format(
                        "Asset '%s' is positioned outside the thumbnail camera view. You need to reposition the asset at the center of the camera view and try again.",
                        arg3.fullName
                    ) }
            end
        end
    end

    return true
end

return validateThumbnailConfiguration
