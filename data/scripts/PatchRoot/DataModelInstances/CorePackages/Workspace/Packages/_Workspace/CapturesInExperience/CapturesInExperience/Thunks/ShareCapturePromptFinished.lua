-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = require(scriptParentParent.Services.CaptureService)

local ExternalShareSourceType = require(scriptParentParent.Enums.ExternalShareSourceType)
local PromptDismissed = require(scriptParentParent.Actions.PromptDismissed)
local ShareCapture = require(scriptParentParent.Thunks.ShareCapture)
local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)

local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local CaptureType = require(scriptParentParent.Enums.CaptureType)
local _Types = require(scriptParentParent.Types)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

return function(arg1, arg2, bool1: boolean)
    return function(arg3)
        arg3:dispatch(PromptDismissed(arg1))

        if bool1 then
            if arg2.isU13LocalSavePrompt then
                task.spawn(function()
                    local content = arg2.content
                    local connection = nil

                    connection = CaptureService.CaptureSavedInternal:Connect(function(arg4)
                        if content.Object ~= nil then
                            if FFlagEnableCapturesGalleryRetrievalCoreScript then
                                if arg4.CaptureTime ~= content.Object.CaptureTime then
                                    return
                                end
                            elseif arg4.type == CaptureType.Video and arg4.videoCapture.CaptureTime ~= content.Object.CaptureTime then
                                return
                            end
                        end

                        if not FFlagEnableCapturesGalleryRetrievalCoreScript then
                            if arg4.type == CaptureType.Video then
                                arg4 = arg4.videoCapture
                            else
                                arg4 = arg4.filePath
                            end
                        end

                        if connection then
                            connection:Disconnect()
                        end

                        CaptureService:SaveCapturesToExternalStorageAsync({ arg4 })
                        arg3:dispatch(ToastTriggered(CapturesToastType.CaptureSavedToDevice, { captureInfo = arg4 }))
                    end)

                    CaptureService:GetCaptureFilePathAsync(arg2.content)
                end)
            else
                task.spawn(function()
                    local captureFilePathAsync = CaptureService:GetCaptureFilePathAsync(arg2.content)

                    local content = arg2.content
                    local isVideoCapture = not (content.Object == nil) and content.Object:IsA("VideoCapture")
                    local object = if FFlagEnableCapturesGalleryRetrievalCoreScript and content.Object ~= nil then content.Object else {
                        contentId = content.Uri or "rbxtemp://0",
                        filePath = if isVideoCapture then "" else captureFilePathAsync,
                        type = if isVideoCapture then CaptureType.Video else CaptureType.Screenshot,
                        videoCapture = if isVideoCapture then content.Object else nil
                    }
                    arg3:dispatch(ShareCapture(object, ExternalShareSourceType.Prompt, arg2.launchData))
                end)
            end
        end

        CaptureService:OnSharePromptFinished(arg1, bool1)
    end
end
