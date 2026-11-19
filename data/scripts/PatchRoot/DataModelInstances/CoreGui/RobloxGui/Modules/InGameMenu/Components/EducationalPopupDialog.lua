-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local EducationalModal = InGameMenuDependencies.UIBlox.App.Dialog.Modal.EducationalModal
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local var1 = Roact.PureComponent:extend("EducationalPopupDialog")

var1.validateProps = t.strictInterface({
    bodyContents = t.array(
        t.strictInterface({
            icon = t.optional(t.union(t.string, t.table)),
            text = t.string,
            layoutOrder = t.optional(t.integer),
            isSystemMenuIcon = t.optional(t.boolean)
        })
    ),
    cancelText = t.string,
    confirmText = t.string,
    titleText = t.optional(t.string),
    titleBackgroundImageProps = t.strictInterface({ image = t.string, imageHeight = t.number, text = t.optional(t.string) }),
    screenSize = t.Vector2,
    onDismiss = t.callback,
    onCancel = t.callback,
    onConfirm = t.callback,
    blurBackground = t.boolean,
    visible = t.boolean
})

var1.defaultProps = { blurBackground = false }

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
        return Roact.createElement(Roact.Portal, { target = CoreGui }, {
            InGameMenuEducationalPopupDialog = Roact.createElement("ScreenGui", {
                IgnoreGuiInset = true,
                OnTopOfCoreBlur = arg1.props.blurBackground,
                Enabled = arg1.props.visible,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            }, {
                Overlay = Roact.createElement("TextButton", {
                    AutoButtonColor = false,
                    BackgroundColor3 = arg2.Theme.Overlay.Color,
                    BackgroundTransparency = arg2.Theme.Overlay.Transparency,
                    BorderSizePixel = 0,
                    Size = UDim2.fromScale(1, 1),
                    Text = ""
                }),
                Popup = Roact.createElement(EducationalModal, {
                    bodyContents = arg1.props.bodyContents,
                    cancelText = arg1.props.cancelText,
                    confirmText = arg1.props.confirmText,
                    titleText = arg1.props.titleText,
                    titleBackgroundImageProps = arg1.props.titleBackgroundImageProps,
                    screenSize = arg1.props.screenSize,
                    onDismiss = arg1.props.onDismiss,
                    onCancel = arg1.props.onCancel,
                    onConfirm = arg1.props.onConfirm
                })
            })
        })
    end)
end

function var1.bindActions(arg1)
    ContextActionService:BindCoreAction("EducationalPopupConfirm", function(_, userInputState, _) -- name: dismissFunc
        if userInputState == Enum.UserInputState.Begin then
            arg1.props.onDismiss()
        end
    end, false, Enum.KeyCode.Escape)
end

function var1.unbindActions(_)
    ContextActionService:UnbindCoreAction("EducationalPopupConfirm")
end

function var1.updateBlur(arg1)
    local focus = arg1.props.blurBackground and arg1.props.visible and not game:GetService("VRService").VREnabled
    RunService:SetRobloxGuiFocused(focus)
end

function var1.didMount(arg1)
    arg1:updateBlur()

    if arg1.props.visible then
        arg1:bindActions()
    end
end

function var1.didUpdate(arg1)
    arg1:updateBlur()

    if arg1.props.visible then
        arg1:bindActions()
        return
    end
    arg1:unbindActions()
end

function var1.willUnmount(arg1)
    if arg1.props.blurBackground then
        RunService:SetRobloxGuiFocused(false)
    end

    arg1:unbindActions()
end

return var1
