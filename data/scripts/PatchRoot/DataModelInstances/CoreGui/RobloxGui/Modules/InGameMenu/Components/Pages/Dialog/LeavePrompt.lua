-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local GameIcon = require(scriptParentParentParent.GameIcon)

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local ThemedTextLabel = require(scriptParentParentParent.ThemedTextLabel)
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local FocusHandler = require(scriptParentParentParent.Connection.FocusHandler)
local ZonePortal = require(scriptParentParentParent.ZonePortal)

local Direction = require(scriptParentParentParentParent.Enums.Direction)

local GetFFlagEnableVRFTUXExperience = require(RobloxGui.Modules.FTUX.Flags.GetFFlagEnableVRFTUXExperience)
local IsFTUXExperience = require(RobloxGui.Modules.FTUX.Utility.IsFTUXExperience)
local PlatformEnum = require(RobloxGui.Modules.FTUX.Enums.PlatformEnum)

local var1 = Roact.PureComponent:extend("LeavePrompt")

var1.validateProps = t.strictInterface({
    titleText = t.string,
    bodyText = t.string,
    confirmText = t.string,
    cancelText = t.string,
    onConfirm = t.callback,
    onCancel = t.callback,
    canGamepadCaptureFocus = t.boolean,
    canKeyboardCaptureFocus = t.boolean
})

var1.defaultProps = { canGamepadCaptureFocus = false, canKeyboardCaptureFocus = false }

function var1.init(arg1)
    arg1.leaveButtonRef = Roact.createRef()
end

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                BackgroundDefault = {
                    Color = arg2.Color.Surface.Surface_0.Color3,
                    Transparency = arg2.Color.Surface.Surface_0.Transparency
                }
            },
            Font = {
                BaseSize = 1,
                Header1 = {
                    Font = arg2.Typography.HeadingSmall.Font,
                    RelativeSize = arg2.Typography.HeadingSmall.FontSize
                },
                Body = {
                    Font = arg2.Typography.BodyLarge.Font,
                    RelativeSize = arg2.Typography.BodyLarge.FontSize
                }
            }
        }
    end, function(arg2)
        local font = arg2.Font

        local tbl1 = {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 24),
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            GameThumbnail = Roact.createElement(GameIcon, { gameId = game.GameId, iconSize = 100, layoutOrder = 1 }),
            TitleText = Roact.createElement(ThemedTextLabel, {
                fontKey = "Header1",
                themeKey = "TextEmphasis",
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, font.Header1.RelativeSize * font.BaseSize + 4),
                Text = arg1.props.titleText
            }),
            BodyText = 0,
            ButtonGroup = 0
        }
        local createElement = Roact.createElement
        local var2 = ThemedTextLabel
        local tbl2 = {
            fontKey = "Body",
            themeKey = "TextDefault",
            LayoutOrder = 3,
            Size = 0,
            Text = 0,
            TextWrapped = true
        }
        local offset

        if GetFFlagEnableVRFTUXExperience() and IsFTUXExperience(PlatformEnum.QuestVR) then
            offset = UDim2.fromOffset(353, 4 * (font.Body.RelativeSize * font.BaseSize + 4))
        else
            offset = UDim2.fromOffset(353, 2 * (font.Body.RelativeSize * font.BaseSize + 4))
        end

        tbl2.Size = offset

        tbl2.Text = arg1.props.bodyText
        tbl1.BodyText = createElement(var2, tbl2)

        tbl1.ButtonGroup = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(353, 84),
                LayoutOrder = 4
            },
            {
                ConfirmButton = Roact.createElement(Button, {
                    buttonType = ButtonType.PrimarySystem,
                    layoutOrder = 4,
                    position = UDim2.fromOffset(0, 0),
                    size = UDim2.fromOffset(353, 36),
                    onActivated = arg1.props.onConfirm,
                    text = arg1.props.confirmText,
                    buttonRef = arg1.leaveButtonRef
                }),
                CancelButton = Roact.createElement(Button, {
                    buttonType = ButtonType.Secondary,
                    layoutOrder = 5,
                    position = UDim2.fromOffset(0, 48),
                    size = UDim2.fromOffset(353, 36),
                    onActivated = arg1.props.onCancel,
                    text = arg1.props.cancelText
                })
            }
        )

        local tbl3 = {
            Content = Roact.createElement("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Selectable = false }, tbl1),
            FocusHandler = Roact.createElement(FocusHandler, {
                isFocused = arg1.props.canGamepadCaptureFocus,
                didFocus = function()
                    GuiService.SelectedCoreObject = arg1.leaveButtonRef.current
                end
            }),
            ZonePortal = Roact.createElement(ZonePortal, { targetZone = 0, direction = Direction.Left }),
            KeyboardFocusHandler = Roact.createElement(FocusHandler, {
                isFocused = arg1.props.canKeyboardCaptureFocus,
                didFocus = function()
                    ContextActionService:BindCoreAction("LeavePromptConfirm", function(_, userInputState)
                        if userInputState ~= Enum.UserInputState.End then
                            return Enum.ContextActionResult.Pass
                        end

                        arg1.props.onConfirm()
                        return Enum.ContextActionResult.Sink
                    end, false, Enum.KeyCode.Return)
                end,
                didBlur = function()
                    ContextActionService:UnbindCoreAction("LeavePromptConfirm")
                end
            }) or nil
        }

        return Roact.createElement("ImageButton", {
            Size = UDim2.fromScale(1, 1),
            AutoButtonColor = false,
            BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
            BackgroundTransparency = arg2.Theme.BackgroundDefault.Transparency,
            Selectable = false
        }, tbl3)
    end)
end

return var1
