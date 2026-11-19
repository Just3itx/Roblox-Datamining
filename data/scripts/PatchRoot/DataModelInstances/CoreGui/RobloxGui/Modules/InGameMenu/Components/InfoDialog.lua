-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local scriptParentParent = script.Parent.Parent
local Assets = require(scriptParentParent.Resources.Assets)

local ThemedTextLabel = require(script.Parent.ThemedTextLabel)
local Divider = require(script.Parent.Divider)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local var1 = Roact.PureComponent:extend("InfoDialog")

var1.validateProps = t.strictInterface({
    bodyText = t.string,
    dismissText = t.string,
    titleText = t.string,
    iconImage = t.union(t.string, t.table),
    onDismiss = t.callback,
    visible = t.boolean,
    buttonRef = t.optional(t.table)
})

function var1.render(arg1)
    local props = arg1.props

    return withFoundationOrUIBloxStyle(function(tokens)
        return {
            Tokens = tokens,
            Theme = {
                Overlay = {
                    Color = tokens.Color.Common.Scrim.Color3,
                    Transparency = tokens.Color.Common.Scrim.Transparency
                },
                BackgroundUIDefault = {
                    Color = tokens.Color.Surface.Surface_300.Color3,
                    Transparency = tokens.Color.Surface.Surface_300.Transparency
                }
            },
            Font = {
                BaseSize = 1,
                Body = {
                    Font = tokens.Typography.BodyLarge.Font,
                    RelativeSize = tokens.Typography.BodyLarge.FontSize
                }
            }
        }
    end, function(arg2)
        local var2 = arg2.Font.Body.RelativeSize * arg2.Font.BaseSize
        local bodyText = props.bodyText
        local yOffset = math.max(
            GetTextSize(
                bodyText,
                var2,
                arg2.Tokens.Typography.BodyLarge.Font,
                Vector2.new(264, math.huge),
                { addTemporaryPadding = false }
            ).Y,
            var2 * 2
        ) + 48

        local createElement = Roact.createElement
        local tbl1 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 8,
            Visible = props.visible
        }
        local tbl2 = {
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

        local createElement2 = Roact.createElement
        local var3 = ImageSetLabel
        local tbl3 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = Assets.Images.RoundedRect.Image,
            ImageColor3 = arg2.Theme.BackgroundUIDefault.Color,
            ImageTransparency = arg2.Theme.BackgroundUIDefault.Transparency,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            ScaleType = Assets.Images.RoundedRect.ScaleType,
            Size = UDim2.new(0, 312, 0, yOffset + 49 + 36 + 36 + 24 + 10),
            SliceCenter = Assets.Images.RoundedRect.SliceCenter
        }
        local tbl4 = {
            Padding = Roact.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 24),
                PaddingLeft = UDim.new(0, 24),
                PaddingRight = UDim.new(0, 24)
            }),
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Icon = Roact.createElement(
                ImageSetLabel,
                {
                    Size = UDim2.new(0, 36, 0, 36),
                    BackgroundTransparency = 1,
                    Image = arg1.props.iconImage,
                    LayoutOrder = 1
                }
            ),
            Title = Roact.createElement(ThemedTextLabel, {
                fontKey = "Header1",
                themeKey = "TextEmphasis",
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 48),
                Text = props.titleText
            }),
            Divider = Roact.createElement(Divider, { LayoutOrder = 3 }),
            BodyTextContainer = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 4,
                    Size = UDim2.new(1, 0, 0, yOffset)
                },
                {
                    BodyText = Roact.createElement(ThemedTextLabel, { Size = UDim2.new(1, 0, 1, 0), Text = props.bodyText, TextWrapped = true })
                }
            ),
            ConfirmButton = Roact.createElement(Button, {
                buttonType = ButtonType.PrimarySystem,
                layoutOrder = 5,
                size = UDim2.new(1, 0, 0, 36),
                onActivated = props.onDismiss,
                text = props.dismissText,
                [Roact.Ref] = arg1.props.buttonRef
            })
        }
        tbl2.DialogMainFrame = createElement2(var3, tbl3, tbl4)
        return createElement("Frame", tbl1, tbl2)
    end)
end

function var1.bindActions(arg1)
    ContextActionService:BindCoreAction("InGameMenuModalDismiss", function(_, userInputState, _) -- name: dismissFunc
        if userInputState == Enum.UserInputState.Begin then
            arg1.props.onDismiss()
        end
    end, false, Enum.KeyCode.Escape)
end

function var1.unbindActions(_)
    ContextActionService:UnbindCoreAction("InGameMenuModalDismiss")
end

function var1.didMount(arg1)
    if arg1.props.visible then
        arg1:bindActions()
    end
end

function var1.didUpdate(arg1)
    if arg1.props.visible then
        arg1:bindActions()
        return
    end
    arg1:unbindActions()
end

function var1.willUnmount(arg1)
    arg1:unbindActions()
end

return var1
