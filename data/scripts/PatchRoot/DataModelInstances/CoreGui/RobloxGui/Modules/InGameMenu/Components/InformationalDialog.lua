-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local withStyle = UIBlox.Core.Style.withStyle

local scriptParentParent = script.Parent.Parent
local Flags = scriptParentParent.Flags
local GetFFlagIGMGamepadSelectionHistory = require(Flags.GetFFlagIGMGamepadSelectionHistory)
local Constants = require(scriptParentParent.Resources.Constants)
local Assets = require(scriptParentParent.Resources.Assets)

local ThemedTextLabel = require(script.Parent.ThemedTextLabel)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local FocusHandler = require(script.Parent.Connection.FocusHandler)
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize

local var1 = Roact.PureComponent:extend("InformationalDialog")

var1.validateProps = t.strictInterface({
    bodyText = t.string,
    confirmText = t.string,
    titleText = t.string,
    subBodyText = t.optional(t.string),
    iconImage = t.optional(t.union(t.table, t.string)),
    iconSize = t.number,
    onContinueFunc = t.optional(t.callback),
    bindReturnToConfirm = t.boolean,
    blurBackground = t.boolean,
    visible = t.boolean,
    inputType = t.optional(t.string)
})

var1.defaultProps = { subBodyText = nil, blurBackground = false, iconImage = nil, iconSize = 64 }

function var1.init(arg1)
    arg1.state = { isRooted = false, show = true }

    function arg1.onAncestryChanged(arg2)
        if arg2:IsDescendantOf(game) then
            arg1:setState({ isRooted = true })
        end
    end

    arg1.confirmButtonRef = Roact.createRef()
    arg1.buttonContainerRef = Roact.createRef()
end

function var1.render(arg1)
    local props = arg1.props

    return withStyle(function(arg2)
        local var2 = arg2.Font.Body.RelativeSize * arg2.Font.BaseSize
        local bodyText = props.bodyText
        local textSizeY = GetTextSize(
            bodyText,
            var2,
            arg2.Tokens.Typography.BodyLarge.Font,
            Vector2.new(295, math.huge),
            { addTemporaryPadding = false }
        ).Y
        local textSizeY2 = GetTextSize(
            props.subBodyText,
            var2,
            arg2.Tokens.Typography.BodyLarge.Font,
            Vector2.new(295, math.huge),
            { addTemporaryPadding = false }
        ).Y

        local yOffset = math.max(textSizeY, var2 * 2) + 20
        local yOffset2 = math.max(textSizeY2, var2 * 2) + 20
        local shouldForgetPreviousSelection = if GetFFlagIGMGamepadSelectionHistory() then not arg1.props.visible else nil
        local createElement = Roact.createElement
        local portal = Roact.Portal
        local tbl1 = { target = CoreGui }
        local tbl2 = { InGameMenuInformationalDialog = 0, FocusHandler = 0 }
        local createElement2 = Roact.createElement
        local tbl3 = {
            DisplayOrder = 8,
            IgnoreGuiInset = true,
            OnTopOfCoreBlur = props.blurBackground,
            Enabled = props.visible and arg1.state.show,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        }
        local tbl4 = {
            Overlay = Roact.createElement("TextButton", {
                AutoButtonColor = false,
                BackgroundColor3 = arg2.Theme.Overlay.Color,
                BackgroundTransparency = arg2.Theme.Overlay.Transparency,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Text = ""
            }),
            DialogMainFrame = 0
        }

        local createElement3 = Roact.createElement
        local var3 = ImageSetLabel
        local tbl5 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = Assets.Images.RoundedRect.Image,
            ImageColor3 = arg2.Theme.BackgroundUIDefault.Color,
            ImageTransparency = arg2.Theme.BackgroundUIDefault.Transparency,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            ScaleType = Assets.Images.RoundedRect.ScaleType,
            Size = UDim2.new(0, 335, 0, yOffset + 49 + yOffset2 + 36 + 70 + props.iconSize),
            SliceCenter = Assets.Images.RoundedRect.SliceCenter
        }
        local tbl6 = {
            Padding = Roact.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 20),
                PaddingBottom = UDim.new(0, 20),
                PaddingLeft = UDim.new(0, 20),
                PaddingRight = UDim.new(0, 20)
            }),
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Icon = Roact.createElement(ImageSetLabel, {
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Image = props.iconImage,
                Size = UDim2.new(0, props.iconSize, 0, props.iconSize),
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }),
            Title = Roact.createElement(ThemedTextLabel, {
                fontKey = "Header1",
                themeKey = "TextEmphasis",
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 48),
                Text = props.titleText
            }),
            Divider = Roact.createElement("Frame", {
                BackgroundColor3 = arg2.Theme.Divider.Color,
                BackgroundTransparency = arg2.Theme.Divider.Transparency,
                BorderSizePixel = 0,
                LayoutOrder = 3,
                Size = UDim2.new(0.8, 0, 0, 1)
            }),
            SpaceContainer = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 4, Size = UDim2.new(1, 0, 0, 10) }),
            BodyTextContainer = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 5,
                    Size = UDim2.new(1, 0, 0, yOffset)
                },
                {
                    BodyText = Roact.createElement(ThemedTextLabel, { Size = UDim2.new(1, 0, 1, 0), Text = props.bodyText, TextWrapped = true })
                }
            ),
            SubBodyTextContainer = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 6,
                    Size = UDim2.new(1, 0, 0, yOffset2)
                },
                {
                    BodyText = Roact.createElement(ThemedTextLabel, { Size = UDim2.new(1, 0, 1, 0), Text = props.subBodyText, TextWrapped = true })
                }
            ),
            SpaceContainer2 = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 7, Size = UDim2.new(1, 0, 0, 10) }),
            ButtonContainer = 0
        }
        local createElement4 = Roact.createElement
        local tbl7 = {
            BackgroundTransparency = 1,
            LayoutOrder = 8,
            Size = UDim2.new(1, 0, 0, 36),
            [Roact.Ref] = arg1.buttonContainerRef,
            [Roact.Event.AncestryChanged] = arg1.onAncestryChanged
        }

        local tbl8 = {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 20),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            ConfirmButton = Roact.createElement(Button, {
                buttonType = ButtonType.PrimarySystem,
                layoutOrder = 1,
                size = UDim2.new(1, -5, 1, 0),
                text = props.confirmText,
                onActivated = function()
                    arg1:setState({ show = false })

                    if arg1.props.onContinueFunc then
                        arg1.props.onContinueFunc()
                    end
                    RunService:SetRobloxGuiFocused(false)
                end,
                [Roact.Ref] = arg1.confirmButtonRef
            })
        }

        tbl6.ButtonContainer = createElement4("Frame", tbl7, tbl8)
        tbl4.DialogMainFrame = createElement3(var3, tbl5, tbl6)
        tbl2.InGameMenuInformationalDialog = createElement2("ScreenGui", tbl3, tbl4)

        tbl2.FocusHandler = Roact.createElement(FocusHandler, {
            isFocused = arg1.state.isRooted and arg1.props.visible and arg1.props.inputType == Constants.InputType.Gamepad,
            shouldForgetPreviousSelection = shouldForgetPreviousSelection,
            didFocus = function()
                GuiService:RemoveSelectionGroup("InGameMenuModalButtonsSelectionParent")
                GuiService:AddSelectionParent("InGameMenuModalButtonsSelectionParent", arg1.buttonContainerRef:getValue())

                GuiService.SelectedCoreObject = arg1.confirmButtonRef:getValue()
            end
        })

        return createElement(portal, tbl1, tbl2)
    end)
end

function var1.updateBlur(arg1)
    local visible = arg1.props.blurBackground and arg1.props.visible
    RunService:SetRobloxGuiFocused(visible)
end

function var1.bindActions(arg1)
    local function confirmFunc(_, userInputState, _)
        if userInputState == Enum.UserInputState.Begin then
            arg1.props.onConfirm()
        end
    end

    if arg1.props.bindReturnToConfirm then
        ContextActionService:BindCoreAction("InGameMenuModalConfirm", confirmFunc, false, Enum.KeyCode.Return)
    end
end

function var1.unbindActions(_)
    ContextActionService:UnbindCoreAction("InGameMenuModalConfirm")
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
