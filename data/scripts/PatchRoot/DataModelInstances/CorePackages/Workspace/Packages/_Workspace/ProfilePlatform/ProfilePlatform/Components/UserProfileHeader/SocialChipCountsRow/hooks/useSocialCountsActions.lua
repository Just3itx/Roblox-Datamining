-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)

local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local Url = require(ProfilePlatformParent.Http).Url
local UrlBuilder = require(ProfilePlatformParent.UrlBuilder).UrlBuilder

local NavigateDown = NavigationRodux.Thunks.NavigateDown
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation

local FFlagCreateConnectionsHub = require(ProfilePlatformParent.SharedFlags).FFlagCreateConnectionsHub
local FFlagEnableSocialTabsPage = require(ProfilePlatformParent.SharedFlags).FFlagEnableSocialTabsPage
local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local FFlagSocialTabsPageIxpEnabled = require(ProfilePlatform.Flags.FFlagSocialTabsPageIxpEnabled)
local FStringSocialTabsPageIxpLayer = require(ProfilePlatform.Flags.FStringSocialTabsPageIxpLayer)
local IXPServiceWrapper = if FFlagSocialTabsPageIxpEnabled then require(ProfilePlatformParent.IXPServiceWrapper).IXPServiceWrapper else nil

local function useSocialCountsActions(str1: string, bool1: boolean, arg1, mutualFriendIds, title: string?, bool2: boolean?)
    local var1 = useDispatch()
    local var2 = useNavigation()
    local dockToProfilePanel = if FFlagEnableSocialTabsPage then not useProfileFormFactor().isFullView else nil
    local useMemo = React.useMemo
    local function func1()
        local function buildTabConfig()
            local tabConfig = {}
            if mutualFriendIds and #mutualFriendIds > 0 then
                table.insert(tabConfig, { id = AppPage.SocialTabsMutuals, tabLabelKey = "Feature.Friends.Mutuals" })
            end
            table.insert(tabConfig, { id = AppPage.SocialTabsFriends, tabLabelKey = "CommonUI.Features.Label.Friends" })

            return tabConfig
        end

        return {
            mutualFriendsCount = function()
                arg1.fireAnalyticsEvent(EventNames.MutualFriendsButton)

                if FFlagSocialTabsPageIxpEnabled then
                    IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringSocialTabsPageIxpLayer)
                end

                if not FFlagEnableSocialTabsPage or bool1 then
                    local tbl2 = {
                        name = AppPage.MutualConnectionList,
                        extraProps = { mutualFriendIds = mutualFriendIds }
                    }

                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
                        return
                    end
                    var1(NavigateDown(tbl2))

                    return
                end

                local tbl2 = {
                    name = AppPage.SocialTabsPage,
                    extraProps = {
                        profileId = str1,
                        title = title,
                        initialTabId = AppPage.SocialTabsMutuals,
                        tabConfig = buildTabConfig(),
                        source = "ProfilePage",
                        dockToProfilePanel = dockToProfilePanel
                    }
                }
                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
                    return
                end
                var1(NavigateDown(tbl2))
            end,
            followersCount = function()
                arg1.fireAnalyticsEvent(EventNames.FollowersButton)
                local tbl2 = {
                    name = AppPage.GenericWebPage,
                    detail = `{Url.BASE_URL}users/{str1}/friends#!/followers`,
                    extraProps = {
                        titleKey = TextKeys.Followers
                    }
                }
                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
                    return
                end
                var1(NavigateDown(tbl2))
            end,
            followingsCount = function()
                arg1.fireAnalyticsEvent(EventNames.FollowingsButton)
                local tbl2 = {
                    name = AppPage.GenericWebPage,
                    detail = `{Url.BASE_URL}users/{str1}/friends#!/following`,
                    extraProps = {
                        titleKey = TextKeys.Following
                    }
                }
                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
                    return
                end
                var1(NavigateDown(tbl2))
            end,
            friendsCount = function()
                arg1.fireAnalyticsEvent(EventNames.FriendsButton)

                if FFlagSocialTabsPageIxpEnabled and not bool1 and bool2 then
                    IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringSocialTabsPageIxpLayer)
                end

                if bool1 then
                    if FFlagCreateConnectionsHub then
                        var2.navigate(AppPage.CoHubMyConnections)
                        return
                    end
                    local tbl2 = {
                        name = AppPage.ViewFriends,
                        extraProps = {
                            navigateToFriendsLandingEventStart = {
                                startPage = AppPage.ProfilePlatform,
                                startTime = os.clock()
                            }
                        }
                    }
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
                        return
                    end
                    var1(NavigateDown(tbl2))
                    return
                end

                if FFlagEnableSocialTabsPage then
                    local tbl2 = {
                        name = AppPage.SocialTabsPage,
                        extraProps = {
                            profileId = str1,
                            title = title,
                            initialTabId = AppPage.SocialTabsFriends,
                            tabConfig = buildTabConfig(),
                            source = "ProfilePage",
                            dockToProfilePanel = dockToProfilePanel
                        }
                    }
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
                        return
                    end
                    var1(NavigateDown(tbl2))
                else
                    local tbl2 = {
                        name = AppPage.GenericWebPage,
                        detail = UrlBuilder.user.friends({ userId = str1 }),
                        extraProps = {
                            titleKey = TextKeys.Friends
                        }
                    }
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
                        return
                    end
                    var1(NavigateDown(tbl2))
                end
            end
        }
    end

    local var3 = FFlagEnableSocialTabsPage and (title or "") or nil
    local var4 = if FFlagEnableSocialTabsPage then dockToProfilePanel else nil
    local var5 = if FFlagEnableSocialTabsPage then var2 else nil
    local var6 = if FFlagSocialTabsPageIxpEnabled then bool2 else nil
    return useMemo(func1, { str1, bool1, arg1, var1, mutualFriendIds, var3, var4, var5, var6 })
end

return useSocialCountsActions
