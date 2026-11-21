-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent

local React = require(FlyoutSidePanelParent.React)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local ThemeName = Foundation.Enums.ThemeName
local Images = require(FlyoutSidePanelParent.FoundationImages).Images

local Constants = require(script.Parent.Parent.Constants)

local var1 = Images["icons/logo/letterform_classic"].ImageRectSize.X / Images["icons/logo/letterform_classic"].ImageRectSize.Y

local function HeaderLogo()
    local var2 = useTokens()
    local bool1 = var2.Config.Theme.Name == ThemeName.Classic
    local str1 = if bool1 then "icons/logo/letterform_classic" else "icons/logo/letterform"
    local var3 = if bool1 then Images[str1] else nil
    local size500 = var2.Size.Size_500
    local vector2 = if bool1 then Vector2.new(30 * var2.Config.UI.Scale * var1, 30 * var2.Config.UI.Scale) else Vector2.new(size500 * Constants.ROBLOX_LOGO_ASPECT_RATIO, size500)
    local createElement = React.createElement
    local fragment = React.Fragment
    local var4 = nil
    local tbl1 = { TitleOrRobloxLogoFrame = 0 }
    local createElement2 = React.createElement
    local image = Foundation.Image
    local tbl2 = {
        AnchorPoint = Vector2.zero,
        LayoutOrder = 2,
        tag = "size-full-full",
        Image = 0,
        imageRect = 0,
        imageStyle = 0,
        ScaleType = 0,
        Size = 0
    }

    if var3 then
        str1 = var3.Image
    end

    tbl2.Image = str1
    tbl2.imageRect = var3 and {
        offset = var3.ImageRectOffset,
        size = var3.ImageRectSize
    } or nil

    tbl2.imageStyle = if bool1 then nil else var2.Color.Content.Emphasis
    tbl2.ScaleType = Enum.ScaleType.Fit
    tbl2.Size = UDim2.fromOffset(vector2.X, vector2.Y)
    tbl1.TitleOrRobloxLogoFrame = createElement2(image, tbl2)
    return createElement(fragment, var4, tbl1)
end

return HeaderLogo
