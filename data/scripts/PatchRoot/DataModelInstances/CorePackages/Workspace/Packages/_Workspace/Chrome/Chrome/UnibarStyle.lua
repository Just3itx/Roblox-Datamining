-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeParent = script:FindFirstAncestor("Chrome").Parent

local React = require(ChromeParent.React)
local useTokens = require(ChromeParent.Foundation).Hooks.useTokens

local Context = React.createContext({})

local function UnibarStyleConstants()
    local var1 = useTokens()

    return {
        ICON_CELL_WIDTH = var1.Size.Size_1100,
        ICON_SIZE = var1.Size.Size_900,
        UNIBAR_ICON_SIZE = var1.Size.Size_800,
        ICON_HIGHLIGHT_SIZE = UDim2.new(0, var1.Size.Size_900, 0, var1.Size.Size_900),
        ICON_DIVIDER_POSITION = UDim2.new(0, var1.Size.Size_50, 0.5, 0),
        ICON_BADGE_OFFSET_X = var1.Gap.XXLarge,
        ICON_BADGE_OFFSET_Y = var1.Gap.Small,
        MEDIUM_ICON_SIZE = var1.Size.Size_700,
        UNIBAR_END_PADDING = var1.Padding.XSmall,
        MENU_SUBMENU_PADDING = var1.Padding.Small,
        UNIBAR_LEFT_MARGIN = var1.Padding.Small,
        SUB_MENU_ROW_HEIGHT = var1.Size.Size_1400,
        SUBMENU_CORNER_RADIUS = var1.Radius.Medium,
        SUBMENU_PADDING_LEFT = var1.Padding.Small,
        SUBMENU_PADDING_RIGHT = var1.Padding.Small,
        SUBMENU_ROW_LABEL_FONT = var1.Typography.TitleLarge,
        SUBMENU_ROW_PADDING = var1.Padding.Small,
        SUBMENU_ROW_CORNER_RADIUS = var1.Radius.Medium,
        SUBMENU_BOTTOM_PADDING = var1.Padding.XLarge,
        CLOSE_BUTTON_FRAME = UDim2.new(0, var1.Size.Size_1100, 0, var1.Size.Size_1100),
        WINDOW_DEFAULT_PADDING = var1.Padding.Small
    }
end

return {
    Context = Context,
    Provider = function(arg1) -- name: UnibarStyleProvider
        return React.createElement(Context.Provider, { value = UnibarStyleConstants() }, arg1.children)
    end,
    use = function()
        local var1 = React.useContext(Context)

        if var1 then
            return var1
        end
        error(
            "attempt to use UnibarStyleContext with no provider. Add `UnibarStyleContext.Provider` to the React tree and try again"
        )
    end
}
