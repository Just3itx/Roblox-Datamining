-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local ReactOtter = require(AvatarExperienceCommonParent.ReactOtter)
local useTokens = require(AvatarExperienceCommonParent.Foundation).Hooks.useTokens

local mutedError = require(AvatarExperienceCommonParent.Loggers).mutedError

local function interpolateColors(num1: number, arg1, arg2)
    local color3 = arg1.Color3
    local color3_2 = arg2.Color3
    local transparency = arg1.Transparency
    local transparency2 = arg2.Transparency

    if color3 ~= nil and color3_2 ~= nil and transparency ~= nil and transparency2 ~= nil then
        return {
            Color3 = color3:Lerp(color3_2, num1),
            Transparency = transparency + (transparency2 - transparency) * num1
        }
    end

    mutedError("useCategoryPillColorAnimation: ColorStyle is nil")
    return arg1
end

local function useCategoryPillColorAnimation(bool1: boolean)
    local var1 = useTokens()

    local var2, var3 = ReactOtter.useAnimatedBinding(if bool1 then 1 else 0)

    React.useEffect(function()
        local num1 = if bool1 then 1 else 0
        if not bool1 then
            var3((ReactOtter.instant(num1)))
            return
        end
        var3((ReactOtter.spring(num1, { frequency = 1.2, dampingRatio = 1 })))
    end, { bool1 })

    return {
        animatedBackgroundStyle = var2:map(function(arg1)
            return (interpolateColors(arg1, var1.Color.ActionStandard.Background, var1.Color.ActionSubEmphasis.Background))
        end),
        animatedTextStyle = var2:map(function(arg1)
            return (interpolateColors(arg1, var1.Color.ActionStandard.Foreground, var1.Color.ActionSubEmphasis.Foreground))
        end)
    }
end
return useCategoryPillColorAnimation
