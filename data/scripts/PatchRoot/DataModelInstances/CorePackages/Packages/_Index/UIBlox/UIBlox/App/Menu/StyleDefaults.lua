-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _StyleTypes = require(scriptParentParentParent.App.Style.StyleTypes)

return {
    getBaseMenuDefaultTokens = function(arg1)
        assert(arg1.Tokens ~= nil, "Design token support is not enabled!")
        return {
            elementHeight = arg1.Tokens.Size.Size_1400,
            borderCornerRadius = arg1.Tokens.Radius.Medium,
            background = {
                Color = arg1.Tokens.Color.Surface.Surface_300.Color3,
                Transparency = arg1.Tokens.Color.Surface.Surface_300.Transparency
            }
        }
    end,
    getCellDefaultTokens = function(arg1)
        assert(arg1.Tokens ~= nil, "Design token support is not enabled!")
        return {
            iconSize = arg1.Tokens.Size.Size_800,
            selectedIconSize = arg1.Tokens.Size.Size_800,
            iconPaddingLeft = arg1.Tokens.Size.Size_300,
            textPadding = {
                left = arg1.Tokens.Size.Size_300,
                right = arg1.Tokens.Size.Size_300
            },
            fontStyle = {
                Font = arg1.Tokens.Typography.TitleLarge.Font,
                RelativeSize = arg1.Tokens.Typography.TitleLarge.FontSize / arg1.Font.BaseSize,
                RelativeMinSize = arg1.Tokens.Typography.TitleLarge.FontSize / arg1.Font.BaseSize
            },
            dividerSize = arg1.Tokens.Stroke.Standard,
            selectedIconPaddingRight = arg1.Tokens.Size.Size_300
        }
    end,
    getDropdownMenuCellDefaultTokens = function(arg1)
        return {
            iconSize = arg1.Tokens.Size.Size_900,
            containerPadding = {
                left = arg1.Tokens.Size.Size_400,
                right = arg1.Tokens.Size.Size_600
            },
            textFont = arg1.Tokens.Typography.TitleLarge,
            iconTextSpacing = arg1.Tokens.Size.Size_400,
            border = {
                cornerRadius = arg1.Tokens.Radius.Medium,
                size = arg1.Tokens.Stroke.Standard
            }
        }
    end,
    getDropdownMenuDefaultTokens = function(arg1)
        return {
            height = UDim.new(0, arg1.Tokens.Size.Size_1200),
            menuStateColors = {
                buttonDefault = {
                    Color = arg1.Tokens.Color.ActionSubtle.Border.Color3,
                    Transparency = arg1.Tokens.Color.ActionSubtle.Border.Transparency
                },
                contentDefault = {
                    Color = arg1.Tokens.Color.Content.Default.Color3,
                    Transparency = arg1.Tokens.Color.Content.Default.Transparency
                },
                alert = {
                    Color = arg1.Tokens.Color.ActionAlert.Border.Color3,
                    Transparency = arg1.Tokens.Color.ActionAlert.Border.Transparency
                }
            }
        }
    end
}
