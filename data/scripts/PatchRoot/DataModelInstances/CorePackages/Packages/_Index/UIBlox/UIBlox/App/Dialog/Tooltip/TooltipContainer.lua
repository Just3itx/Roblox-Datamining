-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Otter = require(scriptParentParentParentParentParent.Otter)

local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local Images = require(scriptParentParentParent.ImageSet.Images)
local Label = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent).Label
local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetTextHeight = require(scriptParentParentParentParent.Core.Text.GetTextHeight)

local divideTransparency = require(scriptParentParentParentParent.Utility.divideTransparency)
local lerp = require(scriptParentParentParentParent.Utility.lerp)

local TooltipOrientation = require(scriptParent.Enum.TooltipOrientation)
local getPositionInfo = require(scriptParent.getPositionInfo)

local tbl1 = {
    [TooltipOrientation.Bottom] = Images["component_assets/triangleUp_16"],
    [TooltipOrientation.Top] = Images["component_assets/triangleDown_16"],
    [TooltipOrientation.Right] = Images["component_assets/triangleLeft_16"],
    [TooltipOrientation.Left] = Images["component_assets/triangleRight_16"]
}

local tbl2 = { frequency = 50, dampingRatio = 1 }

local var1 = Roact.PureComponent:extend("TooltipContainer")

var1.validateProps = t.strictInterface({
    triggerPosition = t.Vector2,
    triggerSize = t.Vector2,
    bodyText = t.string,
    headerText = t.optional(t.string),
    screenSize = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    orientation = t.optional(TooltipOrientation.isEnumValue),
    isDirectChild = t.optional(t.boolean)
})

var1.defaultProps = {
    screenSize = Vector2.new(10000, 10000),
    orientation = TooltipOrientation.Bottom,
    isDirectChild = false
}

function var1.init(arg1)
    arg1.visible = true

    local progress, var3 = Roact.createBinding(0)
    arg1.progress = progress

    arg1.progressMotor = Otter.createSingleMotor(0)
    arg1.progressMotor:onStep(var3)
    arg1.progressMotor:setGoal(Otter.spring(1, tbl2))
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local font = arg2.Font
        local theme = arg2.Theme

        local captionHeader = font.CaptionHeader
        local captionBody = font.CaptionBody

        local var2 = font.BaseSize * font.CaptionBody.RelativeSize

        local textSizeX = GetTextSize(arg1.props.bodyText, var2, captionBody.Font, Vector2.new()).X
        if arg1.props.headerText then
            textSizeX = math.max(
                textSizeX,
                GetTextSize(arg1.props.headerText, font.BaseSize * captionHeader.RelativeSize, captionHeader.Font, Vector2.new()).X
            )
        end

        local num1 = math.min(textSizeX, 216)
        local xOffset = num1 + 24

        local textHeight = GetTextHeight(arg1.props.bodyText, captionBody.Font, var2, num1)
        local textHeight2 = arg1.props.headerText and GetTextHeight(arg1.props.headerText, captionHeader.Font, var2, num1) or 0

        local yOffset = arg1.props.headerText and textHeight2 + textHeight + 24 + 4 or textHeight + 24

        local positionInfo = getPositionInfo(
            xOffset,
            yOffset,
            arg1.props.orientation,
            arg1.props.triggerPosition,
            arg1.props.triggerSize,
            arg1.props.screenSize,
            arg1.props.position
        )

        local var3 = arg1.progress:map(function(arg3)
            local var3 = if arg1.props.position then arg1.props.position else arg1.props.isDirectChild and positionInfo.position or positionInfo.absolutePosition
            return var3:lerp(var3 + positionInfo.animatedDistance, arg3)
        end)

        local var4 = arg1.progress:map(function(arg3)
            local backgroundMutedTransparency = theme.BackgroundMuted.Transparency

            return lerp(1, divideTransparency(backgroundMutedTransparency, 1), arg3)
        end)

        local textTransparency = arg1.progress:map(function(arg3)
            local textEmphasisTransparency = theme.TextEmphasis.Transparency

            return lerp(1, divideTransparency(textEmphasisTransparency, 2), arg3)
        end)

        local createElement = Roact.createElement
        local tbl3 = {
            Visible = arg1.visible,
            Position = var3,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = positionInfo.fillDirection == Enum.FillDirection.Vertical and UDim2.fromOffset(xOffset, yOffset + 8)
                or UDim2.fromOffset(xOffset + 8, yOffset)
        }
        local tbl4 = {
            UIListLayout = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = positionInfo.fillDirection
                }
            ),
            CaretFrame = 0,
            Content = 0
        }
        local createElement2 = Roact.createElement
        local tbl5 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = positionInfo.caretFrameSize,
            LayoutOrder = positionInfo.caretLayoutOrder
        }
        local tbl6 = {
            Caret = Roact.createElement(Label, {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = positionInfo.caretPosition,
                AnchorPoint = positionInfo.caretAnchorPoint,
                Size = positionInfo.caretImageSize,
                Image = tbl1[positionInfo.updatedOrientation],
                ImageColor3 = theme.BackgroundMuted.Color,
                ImageTransparency = var4,
                [Roact.Ref] = arg1.caretRef
            })
        }
        tbl4.CaretFrame = createElement2("Frame", tbl5, tbl6)

        tbl4.Content = Roact.createElement("TextButton", {
            AutoButtonColor = false,
            Text = "",
            Selectable = false,
            Size = UDim2.fromOffset(xOffset, yOffset),
            BackgroundColor3 = theme.BackgroundMuted.Color,
            BackgroundTransparency = var4,
            BorderSizePixel = 0,
            LayoutOrder = positionInfo.contentLayoutOrder
        }, {
            VerticalLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 4),
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            Padding = Roact.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12)
            }),
            Header = arg1.props.headerText
                and Roact.createElement(GenericTextLabel, {
                    colorStyle = theme.TextEmphasis,
                    fontStyle = captionHeader,
                    LayoutOrder = 1,
                    Text = arg1.props.headerText,
                    TextTransparency = textTransparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.new(1, 0, 0, textHeight2)
                }),
            Body = Roact.createElement(GenericTextLabel, {
                colorStyle = theme.TextDefault,
                fontStyle = captionBody,
                LayoutOrder = 2,
                Text = arg1.props.bodyText,
                TextTransparency = textTransparency,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2.new(1, 0, 0, textHeight)
            })
        })
        return createElement("Frame", tbl3, tbl4)
    end)
end

function var1.didMount(arg1)
    arg1.progressMotor:start()
end

function var1.didUpdate(arg1, arg2, _)
    if arg2.triggerPosition == arg1.props.triggerPosition then
        return
    end
    if arg1.props.triggerPosition.Y < 0 or arg1.props.triggerPosition.Y + arg1.props.triggerSize.Y > arg1.props.screenSize.Y then
        arg1.visible = false
        return
    end
    arg1.visible = true
end

function var1.willUnmount(arg1)
    arg1.progressMotor:destroy()
    arg1.progressMotor = nil
end

return var1
