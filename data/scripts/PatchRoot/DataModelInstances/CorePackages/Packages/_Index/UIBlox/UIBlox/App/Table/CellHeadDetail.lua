-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Core = scriptParentParentParent.Core
local scriptParentParentParentParent = scriptParentParentParent.Parent

local t = require(scriptParentParentParentParent.t)
local validateColorInfo = require(Core.Style.Validator.validateColorInfo)
local validateFontInfo = require(Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(Core.Style.Validator.validateTypographyInfo)

local Roact = require(scriptParentParentParentParent.Roact)
local withStyle = require(Core.Style.withStyle)
local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)

local var1 = Roact.PureComponent:extend("CellHeadDetail")

var1.validateProps = t.strictInterface({
    labelText = t.string,
    labelTextColor = t.optional(validateColorInfo),
    labelTextFont = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
    subLabelText = t.optional(t.string),
    subLabelTextColor = t.optional(validateColorInfo),
    subLabelTextFont = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
    openTypeFeatures = t.optional(t.string)
})

function var1.render(arg1)
    return withStyle(function(arg2)
        local labelText = arg1.props.labelText
        local colorStyle = arg1.props.labelTextColor or arg2.Theme.TextEmphasis
        local fontStyle = arg1.props.labelTextFont or arg2.Font.Header2

        local subLabelText = arg1.props.subLabelText
        local var2 = arg1.props.subLabelTextColor or arg2.Theme.TextDefault
        local var3 = arg1.props.subLabelTextFont or arg2.Font.CaptionBody

        return Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY
            },
            {
                ListLayout = Roact.createElement(
                    "UIListLayout",
                    {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical
                    }
                ),
                Label = Roact.createElement(GenericTextLabel, {
                    LayoutOrder = 1,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Text = labelText,
                    colorStyle = colorStyle,
                    fontStyle = fontStyle,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
                SubLabel = subLabelText
                    and Roact.createElement(GenericTextLabel, {
                        LayoutOrder = 2,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        Text = subLabelText,
                        colorStyle = var2,
                        fontStyle = var3,
                        openTypeFeatures = arg1.props.openTypeFeatures,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                    or nil
            }
        )
    end)
end

return var1
