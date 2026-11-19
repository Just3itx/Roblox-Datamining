-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")

local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection

local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local Toast = UIBlox.App.Dialog.Toast
local Images = UIBlox.App.ImageSet.Images

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local shouldSaveScreenshotToAlbum = require(RobloxGui.Modules.shouldSaveScreenshotToAlbum)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local var1 = Roact.PureComponent:extend("CaptureNotification")

var1.validateProps = t.strictInterface(
    {
        forceDismissToast = t.optional(t.table),
        permissionEvent = t.optional(t.instanceOf("BindableEvent"))
    }
)
function var1.init(arg1)
    arg1.state = {
        screenSize = Vector2.new(0, 0),
        dismissedPermission = false,
        notificationType = "None",
        toastContent = nil
    }

    function arg1.onScreenSizeChanged(arg2)
        if arg1.state.screenSize ~= arg2.AbsoluteSize then
            arg1:setState({ screenSize = arg2.AbsoluteSize })
        end
    end

    function arg1.getToastContent(arg2)
        if arg2 ~= "Success" and arg2 ~= "Fail" then
            return Roact.None
        end

        local bool1 = arg2 == "Success"
        return {
            iconImage = bool1 and Images["icons/status/success"] or Images["icons/status/alert"],
            iconColorStyle = not bool1 and {
                Color = Color3.fromRGB(247, 75, 82),
                Transparency = 0
            } or nil,
            toastTitle = bool1 and RobloxTranslator:FormatByKey("InGame.NotificationScript2.Capture.Success.ToastText")
                or RobloxTranslator:FormatByKey("InGame.NotificationScript2.Capture.Fail.ToastText"),
            onDismissed = function()
                arg1:setState({ notificationType = "None", toastContent = Roact.None })

                if arg1.props.forceDismissToast and arg1.props.forceDismissToast.onDismissed then
                    arg1.props.forceDismissToast.onDismissed()
                end
            end
        }
    end

    function arg1.dismissPermissionAlert()
        arg1:setState({ dismissedPermission = true, notificationType = "Fail", toastContent = arg1.getToastContent("Fail") })
    end

    function arg1.screenshotSavedToAlbumCallback(_, arg2, arg3)
        local notificationType = if arg2 then "Success" elseif arg1.state.dismissedPermission
            or not (arg3:find("Domain=ALAssetsLibraryErrorDomain") and arg3:find("Data unavailable")) then "Fail" else "Permission"

        arg1:setState({ notificationType = notificationType, toastContent = arg1.getToastContent(notificationType) })
    end

    function arg1.permissionEventCallback()
        arg1:setState({ notificationType = "Permission", toastContent = arg1.getToastContent("Permission") })
    end

    function arg1.getPermissionAlertBodyText()
        if UserInputService:GetPlatform() == Enum.Platform.IOS then
            return RobloxTranslator:FormatByKey("InGame.NotificationScript2.Capture.Permission.AlertTextIOS")
        elseif UserInputService:GetPlatform() == Enum.Platform.Android then
            return RobloxTranslator:FormatByKey("InGame.NotificationScript2.Capture.Permission.AlertTextAndroid")
        end
        return RobloxTranslator:FormatByKey("InGame.NotificationScript2.Capture.Permission.AlertText")
    end
end

function var1.renderWithStyle(_, arg1)
    return renderWithCoreScriptsStyleProvider(arg1)
end

function var1.render(arg1)
    local notificationType = arg1.state.notificationType
    local toastContent = notificationType == "Success" and arg1.state.toastContent
    local toastContent2 = notificationType == "Fail" and arg1.state.toastContent
    local tbl1 = { RobloxCaptureNotificationGui = 0 }
    local createElement = Roact.createElement
    local tbl2 = {
        AutoLocalize = false,
        DisplayOrder = 9,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local tbl3 = {
        Content = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                [Roact.Change.AbsoluteSize] = arg1.onScreenSizeChanged
            },
            {
                SuccessToast = toastContent
                    and Roact.createElement(
                        Toast,
                        {
                            duration = 3,
                            show = not arg1.props.forceDismissToast,
                            toastContent = arg1.state.toastContent
                        }
                    ),
                FailToast = toastContent2
                    and Roact.createElement(
                        Toast,
                        {
                            duration = 3,
                            show = not arg1.props.forceDismissToast,
                            toastContent = arg1.state.toastContent
                        }
                    ),
                PermissionAlertOverlay = notificationType == "Permission"
                    and Roact.createElement(
                        "Frame",
                        {
                            Active = true,
                            BackgroundColor3 = Color3.new(0, 0, 0),
                            BackgroundTransparency = 0.5,
                            Size = UDim2.new(1, 0, 1, 0)
                        },
                        {
                            PermissionAlert = Roact.createElement(InteractiveAlert, {
                                title = RobloxTranslator:FormatByKey("InGame.NotificationScript2.Capture.Permission.AlertTitle"),
                                bodyText = arg1.getPermissionAlertBodyText(),
                                buttonStackInfo = {
                                    buttons = {{
                                        buttonType = ButtonType.PrimarySystem,
                                        props = {
                                            onActivated = arg1.dismissPermissionAlert,
                                            text = RobloxTranslator:FormatByKey("InGame.NotificationScript2.Capture.Permission.AlertButtonText")
                                        }
                                    }}
                                },
                                position = UDim2.fromScale(0.5, 0.5),
                                screenSize = arg1.state.screenSize
                            })
                        }
                    ),
                ScreenshotSavedToAlbumConnection = shouldSaveScreenshotToAlbum()
                    and Roact.createElement(
                        ExternalEventConnection,
                        {
                            event = game.ScreenshotSavedToAlbum,
                            callback = arg1.screenshotSavedToAlbumCallback
                        }
                    ),
                PermissionEventConnection = arg1.props.permissionEvent
                    and Roact.createElement(
                        ExternalEventConnection,
                        {
                            event = arg1.props.permissionEvent.Event,
                            callback = arg1.permissionEventCallback
                        }
                    )
            }
        )
    }
    tbl1.RobloxCaptureNotificationGui = createElement("ScreenGui", tbl2, tbl3)
    return arg1:renderWithStyle(tbl1)
end

function var1.didUpdate(arg1, arg2)
    local forceDismissToast = arg1.props.forceDismissToast
    if arg2.forceDismissToast == forceDismissToast then
        return
    end

    local toastContent = (arg1.state.notificationType == "Success" or arg1.state.notificationType == "Fail") and arg1.state.toastContent

    if not toastContent and forceDismissToast and forceDismissToast.onDismissed then
        forceDismissToast.onDismissed()
    end
end

return var1
