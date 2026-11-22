-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function hasGalleryApi(): boolean
    local success, result = pcall(function(): boolean
        local CaptureService = game:GetService("CaptureService")
        return not (CaptureService == nil) and CaptureService.PromptCaptureGalleryPermissionAsync ~= nil
    end)
    return success and result == true
end

return hasGalleryApi
