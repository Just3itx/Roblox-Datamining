-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local RoactFitComponents = require(scriptParentParentParent.RoactFitComponents)
local FitFrameVertical = RoactFitComponents.FitFrameVertical
local FitTextLabel = RoactFitComponents.FitTextLabel

local UIBlox = require(scriptParentParentParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local withStyle = UIBlox.Core.Style.withStyle

local ModelViewport = require(scriptParentParent.Generic.ModelViewport)
local Constants = require(scriptParentParent.Generic.Constants)

local getEnableCondenseRobuxUpsell = require(scriptParentParent.Flags.getEnableCondenseRobuxUpsell)

local iconsCommonRobux = Images["icons/common/robux"]
local iconsStatusImageunavailable = Images["icons/status/imageunavailable"]

local var1 = Roact.Component:extend(script.Name)

function var1.init(arg1)
    arg1.contentRef = Roact.createRef()
    arg1.state = {
        contentSize = Vector2.new(0, 0)
    }

    function arg1.changeContentSize(arg2)
        if arg1.state.contentSize ~= arg2.AbsoluteSize then
            arg1:setState({ contentSize = arg2.AbsoluteSize })
        end
    end
end

function var1.render(arg1)
    local props = arg1.props

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local yOffset = props.itemIcon ~= nil and Constants.NORMAL_ICON_SIZE or IconSize.Large
        if props.model ~= nil then
            yOffset = Constants.NORMAL_ICON_SIZE
        end

        local xOffset

        if getEnableCondenseRobuxUpsell() then
            xOffset = props.itemIconWidth == nil and yOffset or props.itemIconWidth
            yOffset = props.itemIconHeight == nil and yOffset or props.itemIconHeight
        else
            xOffset = yOffset
        end

        local element

        if props.itemIcon then
            element = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 5, 0, 5),
                Size = UDim2.new(0, xOffset, 0, yOffset),
                ScaleType = Enum.ScaleType.Stretch,
                Image = props.itemIcon,
                ImageTransparency = 0
            })
        else
            element = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 5, 0, 5),
                Size = UDim2.new(0, xOffset, 0, yOffset),
                ScaleType = Enum.ScaleType.Stretch,
                Image = iconsStatusImageunavailable,
                ImageColor3 = theme.UIDefault.Color,
                ImageTransparency = theme.UIDefault.Transparency
            })
        end

        if props.model ~= nil then
            element = Roact.createElement(
                ModelViewport,
                {
                    model = props.model,
                    Position = UDim2.fromOffset(5, 5),
                    Size = UDim2.fromOffset(xOffset, yOffset)
                }
            )
        end
        local createElement = Roact.createElement
        local var2 = FitFrameVertical
        local tbl1 = {
            LayoutOrder = props.layoutOrder,
            BackgroundTransparency = 1,
            width = UDim.new(1, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            contentPadding = UDim.new(0, 6),
            [Roact.Ref] = arg1.contentRef,
            [Roact.Change.AbsoluteSize] = arg1.changeContentSize
        }
        local tbl2 = {
            ItemIconFrame = Roact.createElement(FitFrameVertical, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                width = UDim.new(0.45, 0),
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                margin = { top = 0, bottom = 0, left = 0, right = 20 }
            }, { ItemIcon = element }),
            ItemDetailsFrame = 0
        }
        local createElement2 = Roact.createElement
        local var3 = FitFrameVertical
        local tbl3 = {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            width = UDim.new(0.55, 0),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            contentPadding = UDim.new(0, 5)
        }
        local tbl4 = {
            ItemName = Roact.createElement(FitTextLabel, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                width = FitTextLabel.Width.FitToText,
                maximumWidth = arg1.state.contentSize.X * 0.55,
                Font = font.Header2.Font,
                Text = props.itemName,
                TextSize = font.BaseSize * font.Header2.RelativeSize,
                TextColor3 = theme.TextEmphasis.Color,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            ItemCostFrame = 0
        }
        local createElement3 = Roact.createElement
        local var4 = FitFrameVertical
        local tbl5 = {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            width = UDim.new(0.5, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            contentPadding = UDim.new(0, 2)
        }
        local tbl6 = {
            RobuxIcon = Roact.createElement(ImageSetLabel, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 5, 0, 5),
                Size = UDim2.new(0, 24, 0, 24),
                ScaleType = Enum.ScaleType.Stretch,
                Image = iconsCommonRobux,
                ImageColor3 = theme.IconEmphasis.Color,
                ImageTransparency = theme.IconEmphasis.Transparency
            }),
            ItemCost = Roact.createElement(FitTextLabel, {
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                TextWrapped = true,
                width = FitTextLabel.Width.FitToText,
                maximumWidth = arg1.state.contentSize.X,
                Font = font.Header2.Font,
                Text = tostring(props.itemRobuxCost),
                TextSize = font.BaseSize * font.Header2.RelativeSize,
                TextColor3 = theme.TextEmphasis.Color
            })
        }
        tbl4.ItemCostFrame = createElement3(var4, tbl5, tbl6)
        tbl2.ItemDetailsFrame = createElement2(var3, tbl3, tbl4)
        return createElement(var2, tbl1, tbl2)
    end)
end

return var1
