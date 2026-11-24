-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)

local function makeVideoCaptureStartFailedHandler(callback)
    local function videoCaptureStartFailedHandler(videoCaptureStartedResult)
        if videoCaptureStartedResult == Enum.VideoCaptureStartedResult.CapturingAlready then
            callback(ToastTriggered(CapturesToastType.VideoCaptureInitializationCapturingAlreadyError))
        elseif videoCaptureStartedResult == Enum.VideoCaptureStartedResult.NoDeviceSupport then
            callback(ToastTriggered(CapturesToastType.VideoCaptureInitializationNoDeviceSupportError))
        elseif videoCaptureStartedResult == Enum.VideoCaptureStartedResult.NoSpaceOnDevice then
            callback(ToastTriggered(CapturesToastType.VideoCaptureInitializationNoSpaceOnDeviceError))
        elseif videoCaptureStartedResult == Enum.VideoCaptureStartedResult.OtherError then
            callback(ToastTriggered(CapturesToastType.VideoCaptureInitializationOtherError))
        end
    end

    return videoCaptureStartFailedHandler
end

return makeVideoCaptureStartFailedHandler
