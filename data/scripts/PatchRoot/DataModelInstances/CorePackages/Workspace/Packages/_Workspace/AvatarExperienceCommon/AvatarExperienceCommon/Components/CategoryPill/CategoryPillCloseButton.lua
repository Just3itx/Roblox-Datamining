-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)

local Foundation = require(AvatarExperienceCommonParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local Icon = Foundation.Icon
local Enums = Foundation.Enums

local FFlagAXCategoryPillPositionAnimation = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXCategoryPillPositionAnimation

local function CategoryPillCloseButton(tbl1)
    local actionStandard = useTokens().Color.ActionStandard

    local ref = React.useRef(nil)

    React.useEffect(function()
        if ref.current then
            tbl1.categoryButtonRefs["X-Button"] = ref
            tbl1.navButtonRefs[tbl1.pillIndex] = ref
        end
    end, {})

    return React.createElement(Foundation.View, {
        tag = "auto-xy radius-circle padding-small align-x-center align-y-center",
        backgroundStyle = actionStandard.Background,
        onActivated = tbl1.onActivated,
        LayoutOrder = if FFlagAXCategoryPillPositionAnimation then nil else tbl1.layoutOrder,
        ref = ref
    }, {
        CloseIcon = React.createElement(Icon, { name = "x-small", size = Enums.IconSize.Medium, style = actionStandard.Foreground })
    })
end

return CategoryPillCloseButton
