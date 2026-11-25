-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local useTopBarHeight = require(ProfilePlatformParent.RobloxAppHooks).useTopBarHeight

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local FFlagFixCommunityProfileWideCoverLayout = require(ProfilePlatform.Flags.FFlagFixCommunityProfileWideCoverLayout)
local FFlagProfileInspectAvatarSlideIn = require(ProfilePlatformParent.SharedFlags).FFlagProfileInspectAvatarSlideIn
local FFlagProfileInspectAvatarShopChip = require(ProfilePlatformParent.SharedFlags).FFlagProfileInspectAvatarShopChip

local ProfileScrollContext = require(script.Parent.ProfileScrollContext)

return function(tbl1)
    local var1 = useProfileFormFactor()

    local peekViewOpenPercent, setPeekViewOpenPercent = React.useState(if var1.formFactor == Enums.ProfileFormFactor.PeekView then 0 else 1)
    local var4 = nil
    local var5 = nil
    if FFlagProfileInspectAvatarSlideIn or FFlagProfileInspectAvatarShopChip then
        local var6, var7 = React.useState(false)
        var5 = var7

        var4 = var1.formFactor ~= Enums.ProfileFormFactor.PeekView or var1.isFullView or var6
    end
    local var6, setAbsoluteYPosition = React.useState(0)
    local var8 = useTopBarHeight()

    local scrollY = React.useMemo(function(): number
        local var9 = if FFlagFixCommunityProfileWideCoverLayout then if var1.isFullView or var1.formFactor == Enums.ProfileFormFactor.Wide then 0 else var8 elseif var1.isFullView then 0 else var8

        if var1.formFactor == Enums.ProfileFormFactor.PeekView and not var1.isFullView then
            var9 += 25
        end
        return math.max(var9 - var6, 0)
    end, { var8, var6, var1 })

    local value = React.useMemo(function()
        return {
            scrollY = scrollY,
            setAbsoluteYPosition = setAbsoluteYPosition,
            peekViewOpenPercent = peekViewOpenPercent,
            setPeekViewOpenPercent = setPeekViewOpenPercent,
            isPeekViewFullyOpen = if FFlagProfileInspectAvatarSlideIn or FFlagProfileInspectAvatarShopChip then var4 else nil,
            setIsPeekViewFullyOpen = if FFlagProfileInspectAvatarSlideIn or FFlagProfileInspectAvatarShopChip then var5 else nil
        }
    end, {
        scrollY,
        setAbsoluteYPosition,
        peekViewOpenPercent,
        setPeekViewOpenPercent,
        var4,
        var5
    })

    return React.createElement(ProfileScrollContext.Provider, { value = value }, tbl1.children)
end
