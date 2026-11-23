-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local ReactOtter = require(AvatarExperienceCommonParent.ReactOtter)
local AnimationConstants = require(AvatarExperienceCommon.AnimationConstants)

local FFlagAXDisableHiddenCatalogCategoryPills = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXDisableHiddenCatalogCategoryPills

local function AnimatedSubcategoryPill(tbl1)
    local subcategory = tbl1.subcategory
    local pillIndex = tbl1.pillIndex
    local renderCategoryPill = tbl1.renderCategoryPill
    local isFadingOut = tbl1.isFadingOut

    local var1, var2 = ReactOtter.useAnimatedBinding(0)

    React.useEffect(function()
        var2(
            ReactOtter.spring(1, {
                frequency = AnimationConstants.FIntAXSubcategoryPillFadeAnimationFrequency,
                dampingRatio = AnimationConstants.FIntAXSubcategoryPillFadeAnimationDampingRatio
            })
        )
    end, {})

    React.useEffect(function()
        if isFadingOut then
            var2((ReactOtter.instant(0)))
        end
    end, { isFadingOut })

    local pill = renderCategoryPill(subcategory, pillIndex, if FFlagAXDisableHiddenCatalogCategoryPills then not isFadingOut else nil)

    local groupTransparency = var1:map(function(arg1): number
        return 1 - arg1
    end)

    return React.createElement(Foundation.View, {
        tag = "auto-xy anchor-center-left padding-x-xxsmall",
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundTransparency = 1,
        GroupTransparency = groupTransparency,
        LayoutOrder = pillIndex
    }, { Pill = pill })
end

return AnimatedSubcategoryPill
