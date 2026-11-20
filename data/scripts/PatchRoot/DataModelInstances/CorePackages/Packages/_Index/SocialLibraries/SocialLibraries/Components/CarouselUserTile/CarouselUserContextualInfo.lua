-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local llama = dependencies.llama

local UIBlox = dependencies.UIBlox
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Style = UIBlox.Style
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize

local _StyleTypes = require(script.Parent.StyleTypes)
local Constants = require(script.Parent.Constants)

local tbl1 = {
    maxNumberOfLines = Constants.LINES_MAX,
    lineWidth = Constants.TILE_SIZE
}

return function(tbl2)
    local var1 = llama.Dictionary.join(tbl1, tbl2)
    local icon = var1.icon
    local label = var1.label

    return Style.withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font
        local fontStyle = label.font or font.CaptionBody
        local text = label.text

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            LayoutOrder = var1.layoutOrder,
            BackgroundTransparency = 1
        }
        local tbl4 = {
            UIListLayout = Roact.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 2)
                }
            ),
            IconFrame = 0,
            ContextualText = 0
        }
        local element

        if icon and icon.path then
            element = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.fromOffset(IconSize.Small, IconSize.Small),
                    BackgroundTransparency = 1
                },
                {
                    layout = Roact.createElement(
                        "UIListLayout",
                        {
                            VerticalAlignment = Enum.VerticalAlignment.Top,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center
                        }
                    ),
                    ImageLabel = Roact.createElement(ImageSetLabel, {
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        Image = Images[icon.path],
                        ImageColor3 = icon.color or theme.IconDefault.Color,
                        ImageTransparency = icon.transparency or theme.IconDefault.Transparency,
                        Size = icon.size or UDim2.fromOffset(IconSize.Small, IconSize.Small),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5)
                    })
                }
            )
        else
            element = nil
        end

        tbl4.IconFrame = element
        local element2

        if text then
            element2 = Roact.createElement(StyledTextLabel, {
                layoutOrder = 2,
                size = UDim2.fromOffset(
                    icon and var1.lineWidth - (IconSize.Small + 2) or var1.lineWidth,
                    font.BaseSize * fontStyle.RelativeSize * var1.maxNumberOfLines
                ),
                lineHeight = 1,
                text = text,
                textXAlignment = Enum.TextXAlignment.Left,
                textYAlignment = Enum.TextYAlignment.Top,
                textTruncate = Enum.TextTruncate.AtEnd,
                fontStyle = fontStyle,
                colorStyle = label.colorStyle or theme.SecondaryContent,
                fluidSizing = false,
                richText = false
            })
        else
            element2 = nil
        end

        tbl4.ContextualText = element2
        return createElement(str1, tbl3, tbl4)
    end)
end
