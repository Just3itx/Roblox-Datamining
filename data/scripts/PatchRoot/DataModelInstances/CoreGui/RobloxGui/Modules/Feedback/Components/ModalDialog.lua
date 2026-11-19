-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")

local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)

local t = require(CorePackages.Packages.t)

local scriptParentParent = script.Parent.Parent
local Assets = require(scriptParentParent.Resources.Assets)
local Divider = require(scriptParentParent.Components.PortedComponents.Divider)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local withStyle = UIBlox.Core.Style.withStyle
local IconButton = UIBlox.App.Button.IconButton
local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local makeBackButton = require(CorePackages.Workspace.Packages.AppHeaderBar).makeBackButton

local var1 = Roact.Component:extend("ModalDialog")

var1.validateProps = t.strictInterface({
    visible = t.boolean,
    screenSize = t.Vector2,
    titleText = t.optional(t.string),
    showCloseButton = t.optional(t.boolean),
    headerBar = t.optional(t.table),
    contents = t.optional(t.table),
    actionButtons = t.optional(t.table),
    onDismiss = t.optional(t.callback),
    onBackButtonActivated = t.optional(t.callback),
    maxHeight = t.optional(t.number),
    maxWidth = t.optional(t.number)
})

function var1.init(arg1)
    function arg1.onOverlayActivated()
        arg1.props.onDismiss()
    end
end

function var1.renderHeaderBarLeft(arg1)
    local props = arg1.props
    if props.showCloseButton then
        return function()
            return Roact.createElement(
                IconButton,
                {
                    iconSize = IconSize.Medium,
                    icon = Images["icons/navigation/close"],
                    onActivated = props.onDismiss
                }
            )
        end
    elseif props.onBackButtonActivated ~= nil then
        return makeBackButton(props.onBackButtonActivated)
    end

    return function()
        return nil
    end
end

function var1.renderHeaderBarRight(_): () -> nil
    return function()
        return nil
    end
end

function var1.render(arg1)
    local props = arg1.props

    local y = math.min(props.screenSize.Y, 645)
    if props.maxHeight then
        y = math.min(y, props.maxHeight)
    end

    local x = math.min(props.screenSize.X, 540)
    if props.maxWidth then
        x = math.min(x, props.maxWidth)
    end

    local vector2 = Vector2.new(x, y)
    local var2, scale

    if props.screenSize.X < 540 then
        var2 = Vector2.new(0.5, 1)
        scale = UDim2.fromScale(0.5, 1)
    else
        var2 = Vector2.new(0.5, 0.5)
        scale = UDim2.fromScale(0.5, 0.5)
    end

    local yOffset = math.min(600, vector2.Y - 49 - 60)
    if not props.actionButtons then
        yOffset += 60
    end

    return withStyle(function(arg2)
        local createElement = Roact.createElement
        local tbl1 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Visible = props.visible
        }
        local tbl2 = {
            Overlay = Roact.createElement("TextButton", {
                AutoButtonColor = false,
                BackgroundColor3 = arg2.Theme.Overlay.Color,
                BackgroundTransparency = arg2.Theme.Overlay.Transparency,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                Text = "",
                [Roact.Event.Activated] = arg1.onOverlayActivated
            }),
            Dialog = Roact.createElement(ImageSetButton, {
                Active = true,
                AnchorPoint = var2,
                BackgroundTransparency = 1,
                Image = Assets.Images.RoundedRect.Image,
                ImageColor3 = arg2.Theme.BackgroundUIDefault.Color,
                ImageTransparency = arg2.Theme.BackgroundUIDefault.Transparency,
                Position = scale,
                ScaleType = Assets.Images.RoundedRect.ScaleType,
                Size = UDim2.fromOffset(vector2.X, vector2.Y),
                SliceCenter = Assets.Images.RoundedRect.SliceCenter
            }, {
                Layout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                HeaderBar = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        LayoutOrder = 1,
                        Size = UDim2.new(1, 0, 0, 48)
                    },
                    {
                        Bar = props.headerBar
                            or Roact.createElement(HeaderBar, {
                                backgroundTransparency = 1,
                                barHeight = 48,
                                renderLeft = arg1:renderHeaderBarLeft(),
                                renderRight = arg1:renderHeaderBarRight(),
                                title = props.titleText
                            })
                            or nil
                    }
                ),
                Divider = Roact.createElement(Divider, { LayoutOrder = 2 }),
                Content = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        LayoutOrder = 3,
                        Size = UDim2.new(1, 0, 0, yOffset),
                        ZIndex = 10
                    },
                    {
                        Contents = props.contents
                    }
                ),
                ActionBar = props.actionButtons
                    and Roact.createElement("Frame", {
                        BackgroundTransparency = 1,
                        LayoutOrder = 4,
                        Size = UDim2.new(1, 0, 0, 60)
                    }, {
                        Padding = Roact.createElement("UIPadding", {
                            PaddingTop = UDim.new(0, 8),
                            PaddingBottom = UDim.new(0, 2),
                            PaddingLeft = UDim.new(0, 24),
                            PaddingRight = UDim.new(0, 24)
                        }),
                        ActionButtons = props.actionButtons
                    })
                    or nil
            })
        }
        return createElement("Frame", tbl1, tbl2)
    end)
end

function var1.bindActions(arg1)
    ContextActionService:BindCoreAction("ModalDialogDismiss", function(userInputState) -- name: dismissFunc
        if userInputState == Enum.UserInputState.Begin then
            arg1.props.onDismiss()
        end
    end, false, Enum.KeyCode.Escape)
end

function var1.unbindActions(_)
    ContextActionService:UnbindCoreAction("ModalDialogDismiss")
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
