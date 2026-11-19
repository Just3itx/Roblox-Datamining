-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local FFlagAddNewPlayerListMobileFocusNav = require(CorePackages.Workspace.Packages.PlayerList).Flags.FFlagAddNewPlayerListMobileFocusNav

local var1 = Roact.PureComponent:extend("ActionModal")

var1.defaultProps = {
    screenSize = Vector2.new(1000, 1000)
}

var1.validateProps = t.interface({
    block = t.callback,
    blockText = t.string,
    blockAndReport = t.callback,
    blockAndReportText = t.string,
    cancel = t.callback,
    cancelText = t.string,
    body = t.string,
    title = t.string,
    screenSize = t.optional(t.Vector2)
})

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                Overlay = {
                    Color = arg2.Color.Common.Scrim.Color3,
                    Transparency = arg2.Color.Common.Scrim.Transparency
                }
            }
        }
    end, function(arg2)
        local createElement = Roact.createElement
        local str1 = "ImageButton"
        local tbl1 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = arg2.Theme.Overlay.Transparency,
            BackgroundColor3 = arg2.Theme.Overlay.Color,
            Active = true,
            AutoButtonColor = false,
            Selectable = false,
            Visible = arg1.props.Visible,
            [Roact.Event.Activated] = arg1.props.cancel
        }
        local tbl2 = {
            AlertModal = Roact.createElement(InteractiveAlert, {
                screenSize = arg1.props.screenSize,
                title = arg1.props.title,
                bodyText = arg1.props.body,
                richText = true,
                isRoactGamepadEnabled = not FFlagAddNewPlayerListMobileFocusNav and nil,
                buttonStackInfo = {
                    buttons = {
                        {
                            buttonType = ButtonType.Secondary,
                            props = {
                                text = arg1.props.cancelText,
                                onActivated = arg1.props.cancel
                            }
                        },
                        {
                            buttonType = ButtonType.Alert,
                            props = {
                                text = arg1.props.blockAndReportText,
                                onActivated = arg1.props.blockAndReport
                            }
                        },
                        {
                            buttonType = ButtonType.Alert,
                            props = {
                                text = arg1.props.blockText,
                                onActivated = arg1.props.block
                            }
                        }
                    }
                }
            })
        }
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
