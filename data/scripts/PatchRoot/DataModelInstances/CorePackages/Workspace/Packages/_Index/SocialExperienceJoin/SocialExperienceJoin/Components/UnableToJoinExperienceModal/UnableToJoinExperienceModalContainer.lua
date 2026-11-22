-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent

local React = require(SocialExperienceJoinParent.React)
local Navigation = require(SocialExperienceJoinParent.Navigation)
local RobloxAppHooks = require(SocialExperienceJoinParent.RobloxAppHooks)
local UserProfiles = require(SocialExperienceJoinParent.UserProfiles)
local RobloxAppNavigation = require(SocialExperienceJoinParent.RobloxAppNavigation)

local initializeSocialExperienceJoinAnalytics = require(SocialExperienceJoin.Analytics.initializeSocialExperienceJoinAnalytics)
local EventNames = require(SocialExperienceJoin.Analytics.EventNames)

local useNavigation = Navigation.useNavigation
local useNavigationProps = RobloxAppNavigation.useNavigationProps
local useScreenSize = RobloxAppHooks.useScreenSize

local UnableToJoinExperienceModal = require(script.Parent.UnableToJoinExperienceModal)

return function(tbl1)
    local var1 = useNavigation()
    local var2 = useNavigationProps(function(universeId, arg1)
        return {
            universeId = universeId,
            userId = arg1.userId,
            openGameDetailsPeekViewClosed = arg1.openGameDetailsPeekViewClosed,
            analyticProps = arg1.analyticProps
        }
    end)

    local var3 = React.useMemo(function()
        return initializeSocialExperienceJoinAnalytics(var2.analyticProps)
    end, { var2.analyticProps })

    local screenSize = useScreenSize()
    local var5 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = { var2.userId },
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
        }
    )
    local userPrimaryName = if var5.data then UserProfiles.Selectors.getCombinedNameFromId(var5.data, var2.userId) else ""

    local var7 = React.useCallback(function()
        var1.pop()
    end, { var1 })

    local cancel = React.useCallback(function()
        var3.fireAnalyticsEvent(EventNames.UnableToJoinCancel, { universeId = var2.universeId, profileUserId = var2.userId })

        var7()
    end, { var7 })

    local openGameDetailsPeekView = React.useCallback(function()
        var3.fireAnalyticsEvent(
            EventNames.UnableToJoinViewDetails,
            {
                universeId = var2.universeId,
                profileUserId = var2.userId
            }
        )
        var7()

        tbl1.openGameDetailsPeekView(
            var2.universeId,
            {
                mountAsFullView = true,
                showBackButton = true,
                onPeekViewClosed = var2.openGameDetailsPeekViewClosed
            }
        )
    end, {
        var1,
        var2.universeId,
        var2.userId,
        var2.openGameDetailsPeekViewClosed,
        tbl1.openGameDetailsPeekView,
        var7
    })

    return React.createElement(UnableToJoinExperienceModal, {
        cancel = cancel,
        openGameDetailsPeekView = openGameDetailsPeekView,
        screenSize = screenSize,
        userPrimaryName = userPrimaryName
    })
end
