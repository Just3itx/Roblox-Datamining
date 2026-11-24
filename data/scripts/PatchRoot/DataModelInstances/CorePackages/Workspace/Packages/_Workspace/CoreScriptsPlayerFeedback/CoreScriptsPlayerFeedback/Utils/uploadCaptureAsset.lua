-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local engineFeature = game:GetEngineFeature("EnableCaptureUploadForSupportTicket")

local engineFeature2 = game:GetEngineFeature("EnableCheckUploadCaptureStatusForSupportTicket")

local function uploadCaptureAsset(arg1, tbl1)
    if not (engineFeature and engineFeature2) then
        return nil, Enum.UploadCaptureResult.UploadFailed
    end

    local var1 = tbl1 or game:GetService("CaptureService")

    local success, uploadFailed, result2 = pcall(function()
        return var1:StartUploadCaptureForSupportTicketAsync(arg1)
    end)
    if not success or uploadFailed ~= Enum.UploadCaptureResult.Success then
        if not success or uploadFailed == nil then
            uploadFailed = Enum.UploadCaptureResult.UploadFailed
        end

        return nil, uploadFailed
    end

    for _ = 1, 120 do
        task.wait(5)

        local success2, result, result2_2 = pcall(function()
            return var1:CheckUploadCaptureStatusForSupportTicketAsync(result2)
        end)
        if not success2 then
            return nil, Enum.UploadCaptureResult.UploadFailed
        end
        if result == Enum.UploadCaptureResult.Success then
            return result2_2, nil
        end

        if result ~= Enum.UploadCaptureResult.UploadPending then
            return nil, result
        end
    end

    return nil, Enum.UploadCaptureResult.UploadFailed
end

return uploadCaptureAsset
