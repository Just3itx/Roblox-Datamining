-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CaptureService = game:GetService("CaptureService")

local function isImageAttachmentSupported(): boolean
    local success, result = pcall(function(): boolean
        local engineFeature = game:GetEngineFeature("CaptureServiceStartUploadCoreScriptBypass")
        return engineFeature
            and CaptureService.ReadCapturesFromGalleryAsync ~= nil
            and CaptureService.StartUploadCaptureAsync ~= nil
            and CaptureService.CheckUploadCaptureStatusAsync ~= nil
    end)

    return success and result == true
end

return isImageAttachmentSupported
