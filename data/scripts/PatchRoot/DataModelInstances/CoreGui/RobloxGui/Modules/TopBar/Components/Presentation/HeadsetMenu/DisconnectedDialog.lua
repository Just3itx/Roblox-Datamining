-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)

local FitFrame = require(CorePackages.Packages.FitFrame)
local FitFrameVertical = FitFrame.FitFrameVertical
local FitTextLabel = FitFrame.FitTextLabel

local UIBlox = require(CorePackages.Packages.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local withStyle = UIBlox.Core.Style.withStyle
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Modules = CoreGui.RobloxGui.Modules
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local InGameMenuConstants = require(Modules.InGameMenuConstants)

local iconsStatusAlert = Images["icons/status/alert"]

local var1 = Roact.PureComponent:extend("DisconnectedDialog")

var1.validateProps = t.strictInterface({
    visible = t.boolean,
    onConfirm = t.callback,
    screenSize = t.Vector2,
    guiService = t.optional(t.union(t.instanceOf("GuiService"), t.table))
})

var1.defaultProps = { guiService = GuiService }

function var1.init(arg1)
    arg1.guiService = arg1.props.guiService

    function arg1.onConfirmBindingAction(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        arg1.props.onConfirm()

        return Enum.ContextActionResult.Sink
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local title = RobloxTranslator:FormatByKey("InGame.ConnectionError.Heading.VRDisconnected")
        local var3 = RobloxTranslator:FormatByKey("InGame.ConnectionError.Message.RestartApp")
        local text = RobloxTranslator:FormatByKey("InGame.ConnectionError.Action.Restart")

        local alert = Roact.createElement(InteractiveAlert, {
            title = title,
            middleContent = function()
                return Roact.createElement(FitFrameVertical, {
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 24)
                }, {
                    Icon = Roact.createElement(ImageSetLabel, {
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 0, 5),
                        Size = UDim2.fromOffset(40, 40),
                        Image = iconsStatusAlert,
                        ImageTransparency = 0
                    }),
                    BodyText = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        Font = font.Body.Font,
                        Text = var3,
                        TextSize = font.BaseSize * font.Body.RelativeSize,
                        TextColor3 = theme.TextDefault.Color
                    })
                })
            end,
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = arg1.props.onConfirm,
                        text = text
                    }
                }}
            },
            screenSize = arg1.props.screenSize
        })

        return Roact.createElement(Roact.Portal, { target = CoreGui }, {
            HeadsetDisconnectedDialog = Roact.createElement("ScreenGui", {
                DisplayOrder = InGameMenuConstants.DisplayOrder.HeadsetDisconnectedDialog,
                IgnoreGuiInset = true,
                OnTopOfCoreBlur = true,
                Enabled = arg1.props.visible,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            }, {
                Overlay = Roact.createElement("Frame", {
                    Active = true,
                    BackgroundColor3 = theme.Overlay.Color,
                    BackgroundTransparency = theme.Overlay.Transparency,
                    BorderSizePixel = 0,
                    Size = UDim2.fromScale(1, 1)
                }, { Alert = alert })
            })
        })
    end)
end

function var1.bindActions(arg1)
    ContextActionService:BindCoreAction("TopBarGamepadDisableMenuShortcut", function() end, false, Enum.KeyCode.ButtonStart, Enum.KeyCode.Escape)

    ContextActionService:BindCoreAction(
        "TopBarDialogConfirm",
        arg1.onConfirmBindingAction,
        false,
        Enum.KeyCode.Return,
        Enum.KeyCode.ButtonA
    )
end

function var1.unbindActions(_)
    ContextActionService:UnbindCoreAction("TopBarGamepadDisableMenuShortcut")
    ContextActionService:UnbindCoreAction("TopBarDialogConfirm")
end

function var1.didMount(arg1)
    if arg1.props.visible then
        arg1:bindActions()
        arg1.guiService:SetMenuIsOpen(true, "HeadsetDisconnectedDialog")
    end
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.props.visible == arg2.visible then
        return
    end

    if arg1.props.visible then
        arg1:bindActions()
        arg1.guiService:SetMenuIsOpen(true, "HeadsetDisconnectedDialog")
        return
    end
    arg1:unbindActions()
    arg1.guiService:SetMenuIsOpen(false, "HeadsetDisconnectedDialog")
end

function var1.willUnmount(arg1)
    arg1:unbindActions()
    arg1.guiService:SetMenuIsOpen(false, "HeadsetDisconnectedDialog")
end

return var1
