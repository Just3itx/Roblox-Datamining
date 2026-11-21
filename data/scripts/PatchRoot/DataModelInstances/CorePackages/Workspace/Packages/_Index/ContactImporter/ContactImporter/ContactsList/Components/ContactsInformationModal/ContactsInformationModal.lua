-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)

local t = dependencies.t
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local withStyle = UIBlox.Style.withStyle

local var1 = Roact.PureComponent:extend("ContactsInformationModal")

var1.validateProps = t.strictInterface({ text = t.string, image = t.table, layoutOrder = t.optional(t.number) })

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font
        local props = arg1.props
        return Roact.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = props.layoutOrder
        }, {
            UIListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 12),
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            UIPadding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 36) }),
            IconContainer = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(120, 132),
                    LayoutOrder = 1
                },
                {
                    Icon = Roact.createElement(ImageSetLabel, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        ImageColor3 = arg2.Theme.IconEmphasis.Color,
                        ImageTransparency = arg2.Theme.IconEmphasis.Transparency,
                        Image = props.image,
                        Size = UDim2.fromOffset(IconSize.XLarge, IconSize.XLarge),
                        Position = UDim2.fromScale(0.5, 0.5),
                        LayoutOrder = 1
                    })
                }
            ),
            Description = Roact.createElement(StyledTextLabel, {
                text = props.text,
                fontStyle = font.CaptionBody,
                colorStyle = theme.TextEmphasis,
                lineHeight = 1.2,
                size = UDim2.fromScale(1, 0),
                automaticSize = Enum.AutomaticSize.Y,
                textTruncate = Enum.TextTruncate.AtEnd,
                textXAlignment = Enum.TextXAlignment.Center,
                textYAlignment = Enum.TextYAlignment.Top,
                layoutOrder = 2
            })
        })
    end)
end

return var1
