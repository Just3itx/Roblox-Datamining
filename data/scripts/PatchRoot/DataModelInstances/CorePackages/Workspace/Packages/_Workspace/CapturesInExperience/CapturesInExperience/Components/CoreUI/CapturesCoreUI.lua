-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local ReactUtils = require(scriptParentParentParentParent.ReactUtils)

local CaptureService = game:GetService("CaptureService")

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local CaptureControlsView = require(scriptParentParentParent.Components.CoreUI.CaptureControlsView)
local Constants = require(scriptParentParentParent.Constants)
local makeVideoCaptureFailedHandler = require(scriptParentParentParent.Utils.makeVideoCaptureFailedHandler)
local makeVideoCaptureStartFailedHandler = require(scriptParentParentParent.Utils.makeVideoCaptureStartFailedHandler)
local ToastContainer = require(scriptParentParentParent.Components.Common.ToastContainer)

local useCallback = React.useCallback
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEventConnection = ReactUtils.useEventConnection
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

return function(_)
    local var1 = useDispatch()

    local var2 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Carousel.IsOpen
    end)

    local var3 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsCapturesCoreGuiEnabled
    end)

    local var4 = useCallback(makeVideoCaptureStartFailedHandler(var1), {})
    useEventConnection(CaptureService.UserVideoCaptureStartFailed, var4)

    local var5 = useCallback(makeVideoCaptureFailedHandler(var1), {})
    useEventConnection(CaptureService.UserVideoCaptureFailed, var5)

    return React.createElement(React.Fragment, {}, {
        CaptureControlsView = if var3 then React.createElement(CaptureControlsView) else nil,
        ToastsFrame = if var2 then nil else React.createElement(
            "Frame",
            {
                Active = false,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ZIndex = Constants.ZIndex.Toasts
            },
            {
                ToastContainer = React.createElement(ToastContainer)
            }
        )
    })
end
