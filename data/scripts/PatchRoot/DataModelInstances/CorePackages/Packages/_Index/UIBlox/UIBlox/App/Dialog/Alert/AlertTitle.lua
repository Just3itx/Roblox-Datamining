-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParent.Core

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParentParent.Cryo)

local FitFrameOnAxis = require(scriptParentParentParentParentParent.FitFrame).FitFrameOnAxis

local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local Images = require(scriptParentParentParent.ImageSet.Images)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local useCursor = require(scriptParentParentParentParent.App.SelectionCursor.useCursor)

local uDim = UDim.new(0, 8)

local var1 = Roact.PureComponent:extend("AlertTitle")

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.number),
    margin = t.optional(t.table),
    maxWidth = t.optional(t.number),
    minWidth = t.optional(t.number),
    screenSize = t.Vector2,
    title = t.string,
    titlePadding = t.optional(t.number),
    titleContent = t.optional(t.callback),
    onCloseClicked = t.optional(t.callback),
    closeCursor = t.optional(t.table)
})

var1.defaultProps = {
    margin = { top = 0, bottom = 24, left = 24, right = 24 },
    maxWidth = 400,
    minWidth = 272,
    titlePadding = 12
}

function var1.render(arg1)
    local x = math.clamp(
        arg1.props.screenSize.X - arg1.props.margin.left - arg1.props.margin.right,
        arg1.props.minWidth,
        arg1.props.maxWidth
    ) - arg1.props.margin.left - arg1.props.margin.right

    return withStyle(function(arg2)
        local theme = arg2.Theme

        local headingSmall = arg2.Tokens.Typography.HeadingSmall
        local fontSize = headingSmall.FontSize

        local createElement = Roact.createElement
        local var2 = FitFrameOnAxis
        local tbl1 = {
            BackgroundTransparency = 1,
            contentPadding = UDim.new(0, 8),
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            LayoutOrder = arg1.props.layoutOrder,
            margin = { top = 12, bottom = 0, left = 0, right = 0 },
            minimumSize = UDim2.new(1, 0, 0, 0)
        }
        local tbl2 = {
            TitleContent = arg1.props.titleContent
                and Roact.createElement(
                    FitFrameOnAxis,
                    {
                        BackgroundTransparency = 1,
                        LayoutOrder = 0,
                        minimumSize = UDim2.new(1, 0, 0, 0)
                    },
                    {
                        Content = arg1.props.titleContent()
                    }
                ),
            TitleArea = 0
        }
        local createElement2 = Roact.createElement
        local var3 = FitFrameOnAxis
        local tbl3 = {
            BackgroundTransparency = 1,
            contentPadding = UDim.new(0, 12),
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            LayoutOrder = 1,
            minimumSize = UDim2.new(1, 0, 0, 0)
        }
        local tbl4 = { Title = 0, Underline = 0 }
        local element

        if arg1.props.onCloseClicked then
            local createElement3 = Roact.createElement
            local tbl5 = {
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, fontSize)
            }
            local tbl6 = {
                CloseButton = Roact.createElement(ImageSetComponent.Button, {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 36, 0, 36),
                    Image = Images["icons/navigation/close"],
                    ImageColor3 = theme.IconEmphasis.Color,
                    ImageTransparency = theme.IconEmphasis.Transparency,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    [Roact.Event.Activated] = arg1.props.onCloseClicked,
                    SelectionImageObject = arg1.props.closeCursor
                }),
                TitleText = Roact.createElement(GenericTextLabel, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    colorStyle = theme.TextEmphasis,
                    fontStyle = headingSmall,
                    Size = UDim2.new(1, -(2 * (36 + arg1.props.titlePadding)), 0, fontSize * 2),
                    LayoutOrder = 1,
                    Text = arg1.props.title,
                    TextSize = fontSize,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
            }
            element = createElement3("Frame", tbl5, tbl6)
        else
            element = Roact.createElement(GenericTextLabel, {
                colorStyle = theme.TextEmphasis,
                fontStyle = headingSmall,
                maxSize = Vector2.new(x, fontSize * 2),
                LayoutOrder = 1,
                Text = arg1.props.title,
                TextSize = fontSize,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
        end

        tbl4.Title = element

        tbl4.Underline = Roact.createElement("Frame", {
            BorderSizePixel = 0,
            BackgroundColor3 = theme.Divider.Color,
            BackgroundTransparency = theme.Divider.Transparency,
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 1)
        })
        tbl2.TitleArea = createElement2(var3, tbl3, tbl4)
        return createElement(var2, tbl1, tbl2)
    end)
end

local function AlertTitleFunctionalWrapper(arg1)
    local closeCursor = useCursor(uDim)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { closeCursor = closeCursor }))
end

return AlertTitleFunctionalWrapper
