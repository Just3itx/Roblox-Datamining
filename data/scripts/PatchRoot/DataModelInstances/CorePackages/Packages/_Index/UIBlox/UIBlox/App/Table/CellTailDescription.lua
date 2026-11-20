-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Core = scriptParentParentParent.Core
local scriptParentParentParentParent = scriptParentParentParent.Parent

local t = require(scriptParentParentParentParent.t)
local validateColorInfo = require(Core.Style.Validator.validateColorInfo)
local validateFontInfo = require(Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(Core.Style.Validator.validateTypographyInfo)

local Roact = require(scriptParentParentParentParent.Roact)
local React = require(scriptParentParentParentParent.React)
local withStyle = require(Core.Style.withStyle)
local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local IconSize = require(scriptParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParent.ImageSet.getIconSize)
local Images = require(scriptParentParent.ImageSet.Images)
local UIBloxConfig = require(scriptParentParentParent.UIBloxConfig)

local var1 = Roact.PureComponent:extend("CellTailDescription")

var1.validateProps = t.strictInterface({
    text = t.optional(t.string),
    textColor = t.optional(validateColorInfo),
    textFont = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
    renderTextOverride = t.optional(t.callback),
    showArrow = t.optional(t.boolean),
    infoIcon = t.optional(t.string),
    testId = t.optional(t.string)
})

var1.defaultProps = { showArrow = false, infoIcon = nil, testId = "--uiblox-cell-tail-description" }

function var1.init(arg1)
    function arg1.getDescription(text, colorStyle, fontStyle, layoutOrder, arg2)
        local var2 = nil

        if text then
            if arg2 then
                var2 = arg2()
            end

            var2 = var2
                or Roact.createElement(GenericTextLabel, {
                    LayoutOrder = layoutOrder,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Text = text,
                    colorStyle = colorStyle,
                    fontStyle = fontStyle,
                    BackgroundTransparency = 1
                })
        end

        return var2
    end
end

function var1.render(arg1)
    local text = arg1.props.text
    local renderTextOverride = arg1.props.renderTextOverride
    local showArrow = arg1.props.showArrow
    local bool1 = arg1.props.infoIcon ~= nil

    if not (text or showArrow or bool1) then
        return nil
    end

    return withStyle(function(arg2)
        local var2 = arg1.props.textColor or arg2.Theme.TextDefault
        local var3 = arg1.props.textFont or arg2.Font.Body

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            [React.Tag] = if arg1.props.testId then `data-testid={arg1.props.testId}` else nil
        }
        local tbl2 = {
            ListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 8)
            }),
            Description = arg1.getDescription(text, var2, var3, 1, renderTextOverride),
            RightArrow = 0,
            InfoIcon = 0
        }
        local element

        if showArrow then
            element = Roact.createElement(ImageSetComponent.Label, {
                LayoutOrder = 2,
                Size = if UIBloxConfig.enableScalingForSomeEdpIcons then UDim2.fromOffset(getIconSize(IconSize.Small, arg2), getIconSize(IconSize.Small, arg2)) else UDim2.fromOffset(getIconSize(IconSize.Small), getIconSize(IconSize.Small)),
                BackgroundTransparency = 1,
                Image = Images["icons/navigation/pushRight_small"],
                ImageColor3 = arg2.Theme.TextEmphasis.Color,
                ImageTransparency = arg2.Theme.TextEmphasis.Transparency
            })
                or nil
        else
            element = nil
        end

        tbl2.RightArrow = element
        local element2

        if bool1 then
            element2 = Roact.createElement(ImageSetComponent.Label, {
                LayoutOrder = 2,
                Size = if UIBloxConfig.enableScalingForSomeEdpIcons then UDim2.fromOffset(getIconSize(IconSize.Small, arg2), getIconSize(IconSize.Small, arg2)) else UDim2.fromOffset(getIconSize(IconSize.Small), getIconSize(IconSize.Small)),
                Image = arg1.props.infoIcon,
                ImageColor3 = arg2.Theme.IconEmphasis.Color,
                ImageTransparency = arg2.Theme.IconEmphasis.Transparency,
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            })
                or nil
        else
            element2 = nil
        end

        tbl2.InfoIcon = element2
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
