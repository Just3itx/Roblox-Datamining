-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent

local canViewBuild = require(SocialCarouselParent.BuildExperiencePlaytestLaunch.canViewBuild)
local DataHydration = require(SocialCarouselParent.DataHydration)
local Foundation = require(SocialCarouselParent.Foundation)
local GameJoinCard = require(SocialCarouselParent.GameJoinCard)
local React = require(SocialCarouselParent.React)
local Responsive = require(SocialCarouselParent.Responsive)
local useLocalization = require(SocialCarouselParent.Localization).Hooks.useLocalization
local useNavigation = require(SocialCarouselParent.Navigation).useNavigation
local useAppPolicy = require(SocialCarouselParent.UniversalAppPolicy).useAppPolicy
local AppPage = require(SocialCarouselParent.RobloxAppEnums).AppPage
local FFlagMobileGameJoinCardGamepadSupport = require(SocialCarouselParent.SharedFlags).FFlagMobileGameJoinCardGamepadSupport

local useSocialCarouselContext = require(SocialCarousel.Contexts.useSocialCarouselContext)

local isPresenceInBuild = DataHydration.Presence.isPresenceInBuild

local function useBuildCard(tbl1)
    local var1 = useNavigation()
    local var2 = useSocialCarouselContext()
    local openBuildCardUserId = var2.openBuildCardUserId
    local setOpenBuildCardUserId = var2.setOpenBuildCardUserId
    local setOpenGameJoinCardUserId = var2.setOpenGameJoinCardUserId
    local bool1 = var2.openGameJoinCardUserId ~= nil
    local userId = tbl1.userId
    local isInBuild = useAppPolicy(canViewBuild) and isPresenceInBuild(tbl1.presence)
    local var4 = useLocalization({ build = "CommonUI.Features.NavBar.Build" })

    local var5 = tbl1.preferredInput == Responsive.Input.Touch or FFlagMobileGameJoinCardGamepadSupport and tbl1.isPhoneOrTablet
    local canOpen = var5 or tbl1.preferredInput ~= Responsive.Input.Directional

    local onClose = React.useCallback(function()
        setOpenBuildCardUserId(function(str1: string?): string?
            return if str1 == userId then nil else str1
        end)
    end, { userId, setOpenBuildCardUserId })

    local bool2 = openBuildCardUserId == userId and (not isInBuild or bool1)

    React.useEffect(function()
        if bool2 then
            onClose()
        end
    end, { bool2, onClose })

    local isOpen = isInBuild and openBuildCardUserId == userId and not bool1

    local onActivated = React.useCallback(function()
        if var5 then
            var1.navigate(AppPage.BuildJoinCard, { userId = userId })
            return
        end
        setOpenBuildCardUserId(if isOpen then nil else userId)
        if setOpenGameJoinCardUserId then
            setOpenGameJoinCardUserId(nil)
        end
    end, {
        var1,
        userId,
        var5,
        isOpen,
        setOpenBuildCardUserId,
        setOpenGameJoinCardUserId
    })

    return React.useMemo(function()
        return {
            isInBuild = isInBuild,
            canOpen = canOpen,
            onActivated = onActivated,
            contextualInfo = isInBuild and {
                text = var4.build,
                icon = Foundation.Enums.IconName.Nebula
            } or nil,
            popover = if isInBuild then React.createElement(
                GameJoinCard.BuildJoinCardPopover,
                {
                    userId = userId,
                    isOpen = isOpen,
                    anchorRef = tbl1.anchorRef,
                    onClose = onClose,
                    playerName = tbl1.playerName
                }
            ) else nil
        }
    end, {
        isInBuild,
        canOpen,
        onActivated,
        var4.build,
        userId,
        isOpen,
        tbl1.anchorRef,
        onClose,
        tbl1.playerName
    })
end

return useBuildCard
