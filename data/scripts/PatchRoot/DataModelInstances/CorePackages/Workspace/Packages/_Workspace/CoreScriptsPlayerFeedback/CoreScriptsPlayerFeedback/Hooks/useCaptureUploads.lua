-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)

local _CaptureTypes = require(CoreScriptsPlayerFeedback.CaptureTypes)
local getCaptureKey = require(CoreScriptsPlayerFeedback.Utils.getCaptureKey)
local uploadCaptureAsset = require(CoreScriptsPlayerFeedback.Utils.uploadCaptureAsset)

local function useCaptureUploads()
    local uploadStatuses, var2 = React.useState({})

    local var3 = React.useRef({})

    local var4 = React.useRef({})
    local var5 = React.useRef(0)

    return {
        uploadStatuses = uploadStatuses,
        anyUploading = React.useMemo(function()
            for _, value in uploadStatuses do
                if value.status == "uploading" then
                    return true
                end
            end
            return false
        end, { uploadStatuses }),
        hasNonModerationFailure = React.useMemo(function()
            for _, value in uploadStatuses do
                if value.status == "failed" and value.failureReason ~= Enum.UploadCaptureResult.CaptureModerated then
                    return true
                end
            end
            return false
        end, { uploadStatuses }),
        onCapturesAdded = React.useCallback(function(tbl1)
            local tbl2 = {}
            for _, value in tbl1 do
                tbl2[getCaptureKey(value)] = value
            end

            local tbl3 = {}
            for value, value2 in tbl2 do
                if uploadStatuses[value] == nil then
                    table.insert(tbl3, value2)
                end
            end

            var2(function(arg1)
                local result = ({})
                for value, value2 in arg1 do
                    if tbl2[value] then
                        result[value] = value2
                    end
                end
                local num1 = 0
                for _, value in arg1 do
                    if value.order and num1 < value.order then
                        num1 = value.order
                    end
                end
                for _, capture in tbl3 do
                    num1 += 1
                    local captureKey = getCaptureKey(capture)
                    local var6 = var3.current[captureKey]
                    if var6 then
                        result[captureKey] = {
                            capture = capture,
                            status = var6.status,
                            assetId = var6.assetId,
                            failureReason = var6.failureReason,
                            order = num1
                        }
                    else
                        result[captureKey] = {
                            capture = capture,
                            status = "uploading",
                            assetId = nil,
                            order = num1
                        }
                    end
                end

                return result
            end)

            for _, capture in tbl3 do
                local captureKey = getCaptureKey(capture)
                if var3.current[captureKey] or var4.current[captureKey] then
                    continue
                end

                local var6 = var5
                var6.current += 1
                local current = var5.current
                var4.current[captureKey] = current
                task.spawn(function()
                    local assetId, failureReason = uploadCaptureAsset(capture)
                    if var4.current[captureKey] ~= current then
                        return
                    end
                    var4.current[captureKey] = nil
                    local tbl4 = {
                        capture = capture,
                        status = if assetId == nil then "failed" else "succeeded",
                        failureReason = failureReason,
                        assetId = assetId,
                        order = nil
                    }

                    if assetId ~= nil or failureReason == Enum.UploadCaptureResult.CaptureModerated then
                        var3.current[captureKey] = tbl4
                    end
                    var2(function(arg1)
                        if not arg1[captureKey] then
                            return arg1
                        end
                        local var9 = table.clone(arg1)
                        var9[captureKey] = {
                            capture = capture,
                            status = tbl4.status,
                            failureReason = tbl4.failureReason,
                            assetId = tbl4.assetId,
                            order = arg1[captureKey] and arg1[captureKey].order
                        }
                        return var9
                    end)
                end)
            end
        end, { uploadStatuses }),
        onCaptureRemoved = React.useCallback(function(str1: string)
            var2(function(arg1)
                local var6 = table.clone(arg1)
                var6[str1] = nil
                return var6
            end)
        end, {})
    }
end

return useCaptureUploads
