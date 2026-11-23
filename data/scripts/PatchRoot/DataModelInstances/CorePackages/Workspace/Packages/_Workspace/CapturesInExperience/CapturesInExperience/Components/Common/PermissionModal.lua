-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Localization = require(scriptParentParentParentParent.Localization)
local default = require(scriptParentParentParentParent.PermissionsProtocol).PermissionsProtocol.default
local React = require(scriptParentParentParentParent.React)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local UIBlox = require(scriptParentParentParentParent.UIBlox)

local useCallback = React.useCallback
local useLocalization = Localization.Hooks.useLocalization
local useScreenSize = RobloxAppHooks.useScreenSize
local useStyle = UIBlox.Core.Style.useStyle

local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

return function(tbl1)
    local screenSize = useScreenSize()
    local var2 = useStyle()

    local var3 = useAnalytics()

    local var4 = useLocalization({
        alertBody = "Feature.Captures.Description.AllowPhotoAccessInfo",
        alertTitle = "Feature.Captures.Title.AllowPhotoAccessInfo",
        accessDeniedCTA = "Feature.Captures.Action.AllowPhotoAccessDeclined",
        accessAllowedCTA = "Feature.Captures.Action.AllowPhotoAccessAccepted"
    })

    local theme = var2.Theme

    local onActivated = useCallback(function()
        default:requestPermissions({ default.Permissions.WRITE_MEDIA_STORAGE })
        var3.fireEvent(EventNames.CapturesSavePermissionModalAllowPressed)
        tbl1.closeModal()
    end, { tbl1.closeModal })

    local var1 = useCallback(function()
        var3.fireEvent(EventNames.CapturesSavePermissionModalCancelPressed)
        tbl1.closeModal()
    end, { tbl1.closeModal })

    return React.createElement("Frame", {
        Active = true,
        BackgroundColor3 = theme.Overlay.Color,
        BackgroundTransparency = theme.Overlay.Transparency,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex
    }, {
        Alert = React.createElement(InteractiveAlert, {
            bodyText = var4.alertBody,
            buttonStackInfo = {
                buttons = {
                    {
                        buttonType = ButtonType.Secondary,
                        props = {
                            onActivated = var1,
                            text = var4.accessDeniedCTA
                        }
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = onActivated,
                            text = var4.accessAllowedCTA
                        }
                    }
                }
            },
            isMiddleContentFocusable = false,
            position = UDim2.fromScale(0.5, 0.5),
            screenSize = screenSize,
            title = var4.alertTitle
        })
    })
end
