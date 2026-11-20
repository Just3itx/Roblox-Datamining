-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)

local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParent.ImageSet.getIconSize)
local Images = require(scriptParentParentParent.ImageSet.Images)

local Core = scriptParentParentParentParent.Core
local Interactable = require(Core.Control.Interactable)
local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)

local iconsNavigationPushRight_small = Images["icons/navigation/pushRight_small"]

local var1 = Roact.PureComponent:extend("CarouselHeader")

var1.validateProps = t.strictInterface({
    headerText = t.optional(t.string),
    onSeeAll = t.optional(t.callback),
    carouselMargin = t.optional(t.number),
    layoutOrder = t.optional(t.number)
})

var1.defaultProps = { headerText = "", carouselMargin = 0 }

function var1.render(arg1)
    local headerText = arg1.props.headerText
    local onSeeAll = arg1.props.onSeeAll

    local layoutOrder = arg1.props.layoutOrder
    local carouselMargin = arg1.props.carouselMargin

    return withStyle(function(arg2)
        local header1 = arg2.Font.Header1
        local baseSize = arg2.Font.BaseSize
        local var2 = header1.RelativeSize * baseSize
        local fontFromFontStyle = GetFontFromFontStyle(header1)

        local textSize = GetTextSize(headerText, var2, fontFromFontStyle, Vector2.new(10000, 10000))

        local uDim2 = UDim2.fromOffset(textSize.X + 4 + getIconSize(IconSize.Small), textSize.Y)

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            Size = UDim2.new(1, 0, 0, textSize.Y),
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        }
        local tbl2 = { CarouselHeaderButton = 0 }
        local createElement2 = Roact.createElement
        local var3 = Interactable
        local tbl3 = {
            Position = UDim2.fromOffset(carouselMargin, 0),
            Size = uDim2,
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            [Roact.Event.Activated] = onSeeAll
        }
        function tbl3.onStateChanged() end
        local tbl4 = {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            }),
            HeaderText = Roact.createElement(GenericTextLabel, {
                Text = headerText,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                LayoutOrder = 1,
                fontStyle = header1,
                colorStyle = arg2.Theme.TextEmphasis
            }),
            SeeAllArrow = 0
        }
        local element

        if onSeeAll then
            element = Roact.createElement(ImageSetComponent.Label, {
                Size = UDim2.fromOffset(getIconSize(IconSize.Small), getIconSize(IconSize.Small)),
                BackgroundTransparency = 1,
                Image = iconsNavigationPushRight_small,
                ImageColor3 = arg2.Theme.TextEmphasis.Color,
                ImageTransparency = arg2.Theme.TextEmphasis.Transparency,
                LayoutOrder = 2
            })
                or nil
        else
            element = nil
        end

        tbl4.SeeAllArrow = element
        tbl2.CarouselHeaderButton = createElement2(var3, tbl3, tbl4)
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
