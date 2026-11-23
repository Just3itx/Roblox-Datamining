-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)

local useTokens = Foundation.Hooks.useTokens

local useLocalization = require(AvatarExperienceCommonParent.Localization).Hooks.useLocalization

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXCategoryPillColorAnimation = AvatarExperienceFlags.FFlagAXCategoryPillColorAnimation
local FFlagAXCategoryPillPositionAnimation = AvatarExperienceFlags.FFlagAXCategoryPillPositionAnimation
local FFlagAXDisableHiddenCatalogCategoryPills = AvatarExperienceFlags.FFlagAXDisableHiddenCatalogCategoryPills
local FFlagAXCatalogCategoriesSDUI = AvatarExperienceFlags.FFlagAXCatalogCategoriesSDUI

local useCategoryPillColorAnimation = require(AvatarExperienceCommon.Hooks.useCategoryPillColorAnimation)

local function CategoryPill(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({ title = if FFlagAXCatalogCategoriesSDUI and tbl1.localizedTitle then nil else tbl1.title })

    local pillIndex = tbl1.pillIndex
    local navButtonRefs = tbl1.navButtonRefs
    local categories = tbl1.categories

    local var3 = React.useRef(nil)
    if tbl1.pillRef then
        var3 = tbl1.pillRef
    end

    local var4 = if FFlagAXCategoryPillColorAnimation then useCategoryPillColorAnimation(tbl1.isChecked) else nil

    React.useEffect(function()
        if var3.current then
            tbl1.categoryButtonRefs[tbl1.id] = var3
            tbl1.navButtonRefs[pillIndex] = var3
        end
    end, {})

    local actionStandard = var1.Color.ActionStandard
    if tbl1.isChecked and not tbl1.isSubcategory then
        actionStandard = var1.Color.ActionSubEmphasis
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "auto-xy radius-circle padding-small align-x-center align-y-center",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, var1.Size.Size_800),
        backgroundStyle = if FFlagAXCategoryPillColorAnimation and not tbl1.isSubcategory and var4 ~= nil then var4.animatedBackgroundStyle else actionStandard.Background,
        onActivated = tbl1.onActivated,
        LayoutOrder = tbl1.layoutOrder or nil,
        ref = var3,
        NextSelectionLeft = if FFlagAXCategoryPillPositionAnimation or not (pillIndex > 1) then nil else navButtonRefs[pillIndex - 1] or nil,
        NextSelectionRight = if FFlagAXCategoryPillPositionAnimation or not (pillIndex < #categories) then nil else navButtonRefs[pillIndex + 1] or nil,
        isDisabled = if FFlagAXDisableHiddenCatalogCategoryPills then not tbl1.isSelectable else nil,
        selection = FFlagAXCategoryPillPositionAnimation and {
            Selectable = tbl1.isSelectable
        } or nil,
        stroke = tbl1.isSubcategory
            and tbl1.isChecked
            and {
                Color = var1.Color.System.Contrast.Color3,
                Transparency = var1.Color.System.Contrast.Transparency,
                Thickness = 1
            }
            or nil
    }

    local tbl3 = {
        PillText = React.createElement(Foundation.Text, {
            Text = if FFlagAXCatalogCategoriesSDUI and tbl1.localizedTitle then tbl1.localizedTitle else var2.title,
            textStyle = if FFlagAXCategoryPillColorAnimation and not tbl1.isSubcategory and var4 ~= nil then var4.animatedTextStyle else actionStandard.Foreground,
            fontStyle = var1.Typography.CaptionLarge,
            tag = "auto-xy text-align-x-center text-align-y-center text-no-wrap padding-x-xsmall text-truncate-end"
        })
    }
    return createElement(view, tbl2, tbl3)
end

return CategoryPill
