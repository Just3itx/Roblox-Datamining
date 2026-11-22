-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function requestGalleryPermission(tbl1): boolean
    local var1 = tbl1 or game:GetService("CaptureService")

    local success, result = pcall(function()
        return var1:PromptCaptureGalleryPermissionAsync(Enum.CaptureGalleryPermission.ReadAndUpload)
    end)

    return success and result == true
end

return requestGalleryPermission
