-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local UIBlox = require(AppBloxParent.UIBlox)

local withStyle = UIBlox.Core.Style.withStyle

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local Roact = require(AppBloxParent.Roact)
local t = require(AppBloxParent.t)
local GetTextSize = require(AppBloxParent.Style).GetTextSize

local var1 = Roact.PureComponent:extend("DetailsPageTitleContent")

var1.validateProps = t.strictInterface({
    titleText = t.optional(t.string),
    subTitleText = t.optional(t.string),
    renderInfoContent = t.optional(t.callback),
    layoutOrder = t.optional(t.number),
    verticalAlignment = t.optional(t.enum(Enum.VerticalAlignment))
})

function var1.init(arg1)
    arg1.state = { containerWidth = nil }

    function arg1.onContainerSizeChange(arg2)
        arg1:setState(function(_, _)
            return {
                containerWidth = arg2.AbsoluteSize.X
            }
        end)
    end
    function arg1.getTextSize(arg2, arg3, arg4)
        local baseSize = arg4.Font.BaseSize
        local var2 = arg3.RelativeSize * baseSize
        local vector2 = Vector2.new(10000, 10000)
        return GetTextSize(arg2, var2, arg3.Font, vector2)
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font
        local uDim2 = UDim2.new(0, 0, 1, 0)
        if arg1.props.titleText then
            local textSize = arg1.getTextSize(arg1.props.titleText, font.Title, arg2)
            local yOffset = textSize.Y * 1
            if arg1.state.containerWidth ~= nil and textSize.X >= arg1.state.containerWidth then
                uDim2 = UDim2.new(0, 0, 0, yOffset * 2)
            else
                uDim2 = UDim2.new(0, 0, 0, yOffset)
            end
        end
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            Size = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1,
            [Roact.Change.AbsoluteSize] = arg1.onContainerSizeChange,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = arg1.props.layoutOrder
        }
        local tbl2 = {
            ListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = arg1.props.verticalAlignment
            }),
            Title = 0,
            SubTitle = 0,
            CustomContentComponentFrame = 0
        }
        local element

        if arg1.props.titleText then
            element = Roact.createElement(StyledTextLabel, {
                text = arg1.props.titleText,
                size = uDim2,
                automaticSize = Enum.AutomaticSize.X,
                fontStyle = font.Title,
                colorStyle = theme.TextEmphasis,
                textTruncate = Enum.TextTruncate.AtEnd,
                lineHeight = 1,
                fluidSizing = false,
                layoutOrder = 1,
                richText = false
            })
                or nil
        else
            element = nil
        end

        tbl2.Title = element

        tbl2.SubTitle = arg1.props.subTitleText
            and Roact.createElement(StyledTextLabel, {
                text = arg1.props.subTitleText,
                fontStyle = font.Header2,
                colorStyle = theme.TextMuted,
                automaticSize = Enum.AutomaticSize.XY,
                layoutOrder = 2,
                richText = false
            })
            or nil

        tbl2.CustomContentComponentFrame = arg1.props.renderInfoContent
            and Roact.createElement(
                "Frame",
                {
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    LayoutOrder = 3
                },
                {
                    CustomContent = arg1.props.renderInfoContent()
                }
            )
            or nil
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
