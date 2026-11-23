-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)

local AnimationConstants = require(AvatarExperienceCommon.AnimationConstants)

local function useSubcategoryPillAnimation(arg1)
    local subcategoriesState, var2 = React.useState({})
    local var3 = React.useRef(nil)
    local isFadingOut, var5 = React.useState(false)

    React.useEffect(function()
        return function()
            if var3.current then
                task.cancel(var3.current)
            end
        end
    end, {})

    React.useEffect(function()
        local var6 = not (arg1 and arg1.Subcategories) and {} or arg1.Subcategories

        if var3.current then
            task.cancel(var3.current)
        end

        if next(var6) then
            var2(var6)
            var5(false)
        else
            var5(true)
        end

        var3.current = task.delay(AnimationConstants.FIntAXSubcategoryPillFadeAnimationDurationMs / 1000, function()
            if not next(var6) then
                var2({})
            end
            var5(false)
            var3.current = nil
        end)
    end, { arg1 })

    return { subcategoriesState = subcategoriesState, isFadingOut = isFadingOut }
end

return useSubcategoryPillAnimation
