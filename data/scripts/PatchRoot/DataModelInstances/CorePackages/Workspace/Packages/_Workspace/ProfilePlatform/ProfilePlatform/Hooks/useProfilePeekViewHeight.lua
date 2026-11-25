-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local useTokens = require(ProfilePlatformParent.Foundation).Hooks.useTokens

local Constants = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)
local useAboutSectionHeight = require(ProfilePlatform.Hooks.useAboutSectionHeight)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)
local useCurrentlyPlayingSectionHeight = require(ProfilePlatform.Hooks.useCurrentlyPlayingSectionHeight)

local FFlagProfilePlatformAddCurrentlyPlaying = require(ProfilePlatform.Flags.FFlagProfilePlatformAddCurrentlyPlaying)

return function(num1: number, bool1: boolean)
    local var1 = useTokens()
    local var2, _ = useDynamicSizeMargin()

    local var3 = useProfileJsonComponent(Enums.Components.About)
    local var4 = React.useMemo(function()
        return var3.description
    end, { var3, var3.description })

    local var5, _ = useAboutSectionHeight(var4, num1, var2)

    local var6 = nil
    if FFlagProfilePlatformAddCurrentlyPlaying then
        local var7 = useProfileJsonComponent(Enums.Components.CurrentlyPlaying)
        var6 = useCurrentlyPlayingSectionHeight(var7)
    end

    return (React.useMemo(function()
        local var7 = Constants.AVATAR_HEADSHOT_HEIGHT / 2 + var1.Gap.Large
        local var8 = if bool1 then Constants.CONTEXTUAL_INFORMATION_HEIGHT + var1.Gap.XXLarge else 0

        local socialRowHeight = Constants.SOCIAL_ROW_HEIGHT
        local ctaButtonHeight = Constants.CTA_BUTTON_HEIGHT
        local var9 = (if var5 == 0 then 0 else var1.Gap.XXLarge) + 10
        if FFlagProfilePlatformAddCurrentlyPlaying then
            var9 += if var6 == 0 then 0 else var1.Gap.XXLarge
        end
        return num1 * 0.75 + var7 + var8 + socialRowHeight + var5 + ctaButtonHeight + var9 + (if FFlagProfilePlatformAddCurrentlyPlaying then var6 else 0)
    end, {
        num1,
        bool1,
        var5,
        var6 or 0
    }))
end
