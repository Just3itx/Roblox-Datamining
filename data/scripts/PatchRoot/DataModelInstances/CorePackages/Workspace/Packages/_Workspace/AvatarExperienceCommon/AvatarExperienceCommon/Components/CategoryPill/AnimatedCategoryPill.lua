-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local ReactOtter = require(AvatarExperienceCommonParent.ReactOtter)
local AnimationConstants = require(AvatarExperienceCommon.AnimationConstants)

local function useCategoryPillAnimation(targetX: number, isSelected: boolean, shouldShowSubcategories: boolean)
    local bool1 = shouldShowSubcategories and not isSelected
    local num1 = if bool1 then 1 else 0

    local var1, var2 = ReactOtter.useAnimatedBinding(targetX)
    local var3, var4 = ReactOtter.useAnimatedBinding(num1)

    React.useEffect(function()
        var2(
            ReactOtter.spring(targetX, {
                frequency = AnimationConstants.FIntAXCategoryPillPositionAnimationFrequency,
                dampingRatio = AnimationConstants.FIntAXCategoryPillPositionAnimationDampingRatio
            })
        )
    end, { targetX, var2 })

    React.useEffect(function()
        if num1 == 1 then
            var4(ReactOtter.instant(num1))
            return
        end
        var4(
            (ReactOtter.spring(num1, {
                frequency = AnimationConstants.FIntAXCategoryPillTransparencyAnimationFrequency,
                dampingRatio = AnimationConstants.FIntAXCategoryPillTransparencyAnimationDampingRatio
            }))
        )
    end, { num1 })

    return var1, var3, bool1
end

local function AnimatedCategoryPill(tbl1)
    local catInfo = tbl1.catInfo
    local pillIndex = tbl1.pillIndex
    local isSelected = tbl1.isSelected
    local shouldShowSubcategories = tbl1.shouldShowSubcategories
    local targetX = tbl1.targetX
    local renderCategoryPill = tbl1.renderCategoryPill
    local onRef = tbl1.onRef

    local var1, groupTransparency, bool1 = useCategoryPillAnimation(targetX, isSelected, shouldShowSubcategories)
    local pill = renderCategoryPill(catInfo, pillIndex, not bool1)

    local var4 = var1:map(function(xOffset: number?): UDim2
        return UDim2.new(0, xOffset, 0.5, 0)
    end)

    return React.createElement(Foundation.View, {
        tag = "auto-xy anchor-center-left padding-x-xxsmall",
        Position = var4,
        BackgroundTransparency = 1,
        GroupTransparency = groupTransparency,
        Size = UDim2.new(0, 0, 1, 0),
        ref = onRef
    }, { Pill = pill })
end

return AnimatedCategoryPill
