-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)

local Checkbox = Foundation.Checkbox
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images

local var1 = Roact.PureComponent:extend("CheckboxRow")

var1.defaultProps = {
    height = 28,
    image = "icons/controls/microphone",
    descriptionText = "Description Text",
    checkboxSelected = false,
    actionDisabled = false,
    onCheckboxActivated = function() end,
    LayoutOrder = 1
}

var1.validateProps = t.interface({
    height = t.number,
    image = t.string,
    descriptionText = t.string,
    checkboxSelected = t.boolean,
    actionDisabled = t.boolean,
    onCheckboxActivated = t.callback,
    LayoutOrder = t.optional(t.number)
})

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(tokens)
        return {
            Tokens = tokens,
            Theme = {
                IconDefault = {
                    Color = tokens.Color.Content.Default.Color3,
                    Transparency = tokens.Color.Content.Default.Transparency
                },
                IconEmphasis = {
                    Color = tokens.Color.Content.Emphasis.Color3,
                    Transparency = tokens.Color.Content.Emphasis.Transparency
                },
                TextEmphasis = {
                    Color = tokens.Color.Content.Emphasis.Color3,
                    Transparency = tokens.Color.Content.Emphasis.Transparency
                },
                TextMuted = {
                    Color = tokens.Color.Content.Muted.Color3,
                    Transparency = tokens.Color.Content.Muted.Transparency
                }
            },
            Font = {
                BaseSize = 1,
                Header2 = {
                    Font = tokens.Typography.TitleLarge.Font,
                    RelativeSize = tokens.Typography.TitleLarge.FontSize
                }
            }
        }
    end, function(arg2)
        local baseSize = arg2.Font.BaseSize
        local var2, var3

        if arg1.props.actionDisabled then
            var2 = arg2.Theme.TextMuted
            var3 = arg2.Theme.IconDefault
        else
            var2 = arg2.Theme.TextEmphasis
            var3 = arg2.Theme.IconEmphasis
        end

        local element

        if FFlagCoreUiMigrateUIBloxToFoundation then
            element = Roact.createElement(Foundation.Icon, {
                name = arg1.props.image,
                size = Foundation.Enums.IconSize.Medium,
                style = {
                    Color3 = var3.Color,
                    Transparency = var3.Transparency
                },
                LayoutOrder = 1
            })
        else
            element = Roact.createElement(ImageSetLabel, {
                Size = UDim2.fromOffset(arg1.props.height, arg1.props.height),
                Image = Images[arg1.props.image],
                ImageColor3 = var3.Color,
                ImageTransparency = var3.Transparency,
                BackgroundTransparency = 1,
                LayoutOrder = 1
            })
        end

        return Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, arg1.props.height),
                BackgroundTransparency = 1,
                LayoutOrder = arg1.props.LayoutOrder
            },
            {
                layout = Roact.createElement("UIListLayout", {
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, 12),
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                image = element,
                text = Roact.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -(arg1.props.height + 12) * 4, 1, 0),
                    Text = arg1.props.descriptionText,
                    TextColor3 = var2.Color,
                    TextTransparency = var2.Transparency,
                    TextSize = arg2.Font.Header2.RelativeSize * baseSize,
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.TitleLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = 2
                }),
                checkbox = Roact.createElement(Checkbox, {
                    isDisabled = arg1.props.actionDisabled,
                    isChecked = arg1.props.checkboxSelected,
                    onActivated = arg1.props.onCheckboxActivated,
                    label = "",
                    LayoutOrder = 3
                })
            }
        )
    end)
end

return var1
