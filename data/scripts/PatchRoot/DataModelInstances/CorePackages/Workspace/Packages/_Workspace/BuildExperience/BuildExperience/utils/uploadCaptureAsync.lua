-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Promise = require(BuildExperienceParent.Promise)

local debug2 = require(BuildExperienceParent.DataHydration.CreatorAgentChat).debug

local CaptureService = game:GetService("CaptureService")

local tbl1 = ({})

local function uploadCaptureAsync(capture: Capture)
    local success, result = pcall(function(): boolean
        return game:GetEngineFeature("CaptureServiceStartUploadCoreScriptBypass")
    end)
    if not success or result ~= true then
        return Promise.reject("Capture upload is not supported on this platform")
    end

    local assetId = tbl1[capture]
    if assetId then
        return Promise.resolve({ assetId = assetId })
    end

    debug2.log("info", "capture_upload starting")

    return Promise.new(function(callback, callback2)
        local success2, result2, result2_2 = pcall(function()
            return CaptureService:StartUploadCaptureAsync(capture)
        end)

        if not success2 then
            debug2.log("warn", "capture_upload start failed", { error = tostring(result2) })
            callback2(`Failed to start capture upload: {result2}`)
            return
        end

        if result2 ~= Enum.UploadCaptureResult.Success then
            debug2.log("warn", "capture_upload rejected", { status = tostring(result2) })
            callback2(`Upload rejected: {tostring(result2)}`)
            return
        end

        for _ = 1, 30 do
            task.wait(2)

            local success3, result3, result2_3 = pcall(function()
                return CaptureService:CheckUploadCaptureStatusAsync(result2_2)
            end)

            if not success3 then
                debug2.log("warn", "capture_upload poll error", { error = tostring(result3) })
                callback2(`Upload poll error: {result3}`)
                return
            end

            if result3 == Enum.UploadCaptureResult.Success then
                debug2.log("info", "capture_upload succeeded", { assetId = result2_3 })
                tbl1[capture] = result2_3
                callback({ assetId = result2_3 })
                return
            end

            if result3 == Enum.UploadCaptureResult.UploadPending then
                continue
            end

            debug2.log("warn", "capture_upload failed", { status = tostring(result3) })
            callback2(`Upload failed: {tostring(result3)}`)
            return
        end

        callback2("Upload timed out")
    end)
end

return uploadCaptureAsync
