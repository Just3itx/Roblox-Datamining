-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CaptureService = require(scriptParentParentParent.Services.CaptureService)

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local ReactUtils = require(scriptParentParentParentParent.ReactUtils)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEventConnection = ReactUtils.useEventConnection

local CapturesPolicy = require(scriptParentParentParent.App.CapturesPolicy)
local PromptTriggered = require(scriptParentParentParent.Actions.PromptTriggered)
local PromptType = require(scriptParentParentParent.Enums.PromptType)
local _Types = require(scriptParentParentParent.Types)
local ToastTriggered = require(scriptParentParentParent.Actions.ToastTriggered)
local CapturesToastType = require(scriptParentParentParent.Enums.CapturesToastType)
local CaptureType = require(scriptParentParentParent.Enums.CaptureType)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local FFlagCapturesEnableDownloadPromptForU13 = require(scriptParentParentParent.Flags.FFlagCapturesEnableDownloadPromptForU13)

return (CapturesPolicy.connect(function(arg1)
    return {
        enableShareCaptureCTA = arg1.enableShareCaptureCTA()
    }
end)(function(tbl1)
    local var1 = useDispatch()

    local var2 = React.useCallback(function(num1: number, contents)
        var1(PromptTriggered(num1, PromptType.SaveCaptures, { contents = contents }))
    end, {})

    useEventConnection(CaptureService.OpenSaveCapturesPrompt, var2)

    local var3 = React.useCallback(function(num1: number, content, launchData: string)
        local tbl2 = {
            content = content,
            isU13LocalSavePrompt = FFlagCapturesEnableDownloadPromptForU13 and not tbl1.enableShareCaptureCTA,
            launchData = launchData
        }

        local connection = nil
        if FFlagCapturesEnableDownloadPromptForU13 or tbl1.enableShareCaptureCTA then
            var1(PromptTriggered(num1, PromptType.ShareCapture, tbl2))
            return
        end
        connection = CaptureService.CaptureSavedInternal:Connect(function(arg1)
            if content.Object ~= nil then
                if FFlagEnableCapturesGalleryRetrievalCoreScript then
                    if arg1.CaptureTime ~= content.Object.CaptureTime then
                        return
                    end
                elseif arg1.type == CaptureType.Video and arg1.videoCapture.CaptureTime ~= content.Object.CaptureTime then
                    return
                end
            end

            if not FFlagEnableCapturesGalleryRetrievalCoreScript then
                if arg1.type == CaptureType.Video then
                    arg1 = arg1.videoCapture
                else
                    arg1 = arg1.filePath
                end
            end

            if connection then
                connection:Disconnect()
            end

            CaptureService:SaveCapturesToExternalStorageAsync({ arg1 })
            var1(ToastTriggered(CapturesToastType.CaptureSavedToDevice, { captureInfo = arg1 }))
        end)

        CaptureService:GetCaptureFilePathAsync(content)
    end, { tbl1.enableShareCaptureCTA })

    useEventConnection(CaptureService.OpenShareCapturePrompt, var3)

    local var4 = React.useCallback(function(arg1, _)
        var1(PromptTriggered(arg1, PromptType.CapturePermissions, {}))
    end, {})

    if game:GetEngineFeature("CaptureServiceGalleryPermissionPrompt") then
        useEventConnection(CaptureService.OpenCapturePermissionsPrompt, var4)
    end

    return React.createElement(React.Fragment, {}, {})
end))
