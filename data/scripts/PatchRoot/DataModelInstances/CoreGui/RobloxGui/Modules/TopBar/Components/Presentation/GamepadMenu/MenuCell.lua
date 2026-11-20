-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace

local withStyle = UIBlox.Core.Style.withStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local var1 = Roact.PureComponent:extend("MenuCell")

var1.validateProps = t.strictInterface({
    layoutOrder = t.integer,
    icon = t.optional(t.union(t.table, t.string)),
    iconComponent = t.optional(t.table),
    localizationKey = t.string,
    height = t.numberPositive,
    hasDivider = t.boolean,
    isSelected = t.boolean
})

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local var2 = RobloxTranslator:FormatByKey(arg1.props.localizationKey)

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            LayoutOrder = arg1.props.layoutOrder,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, arg1.props.height)
        }
        local tbl2 = {
            SelectedFrame = arg1.props.isSelected
                and Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 4, 1, 4),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }, {
                    TopBorder = Roact.createElement("Frame", {
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 2),
                        BackgroundTransparency = theme.SystemPrimaryOnHover.Transparency,
                        BackgroundColor3 = theme.SystemPrimaryOnHover.Color
                    }),
                    LeftBorder = Roact.createElement("Frame", {
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, 2, 1, 0),
                        BackgroundTransparency = theme.SystemPrimaryOnHover.Transparency,
                        BackgroundColor3 = theme.SystemPrimaryOnHover.Color
                    }),
                    RightBorder = Roact.createElement("Frame", {
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, 2, 1, 0),
                        Position = UDim2.fromScale(1, 0),
                        AnchorPoint = Vector2.new(1, 0),
                        BackgroundTransparency = theme.SystemPrimaryOnHover.Transparency,
                        BackgroundColor3 = theme.SystemPrimaryOnHover.Color
                    }),
                    BottomBorder = Roact.createElement("Frame", {
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 2),
                        Position = UDim2.fromScale(0, 1),
                        AnchorPoint = Vector2.new(0, 1),
                        BackgroundTransparency = theme.SystemPrimaryOnHover.Transparency,
                        BackgroundColor3 = theme.SystemPrimaryOnHover.Color
                    })
                }),
            CellContents = 0,
            Divider = 0
        }

        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl3 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1)
        }
        local tbl4 = {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 12)
            }),
            Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }),
            IconFrame = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Size = UDim2.fromOffset(36, 36)
                },
                {
                    IconLabel = not (arg1.props.icon == nil)
                        and Roact.createElement(ImageSetLabel, {
                            BackgroundTransparency = 1,
                            Image = arg1.props.icon,
                            Size = UDim2.fromScale(1, 1),
                            ImageTransparency = theme.IconEmphasis.Transparency,
                            ImageColor3 = theme.IconEmphasis.Color
                        }),
                    IconComponent = not (arg1.props.iconComponent == nil) and Roact.createElement(arg1.props.iconComponent)
                }
            ),
            Text = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, -48, 1, 0),
                Text = var2,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.TitleLarge.Font),
                TextSize = font.BaseSize * font.Header2.RelativeSize,
                TextColor3 = theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.TextTransparency,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
        }
        tbl2.CellContents = createElement2(str2, tbl3, tbl4)

        tbl2.Divider = arg1.props.hasDivider
            and Roact.createElement("Frame", {
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.fromScale(0, 1),
                AnchorPoint = Vector2.new(0, 1),
                BackgroundTransparency = theme.Divider.Transparency,
                BackgroundColor3 = theme.Divider.Color
            })
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
