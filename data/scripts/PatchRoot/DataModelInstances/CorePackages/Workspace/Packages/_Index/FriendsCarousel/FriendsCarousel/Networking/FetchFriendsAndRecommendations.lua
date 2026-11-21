-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local dependencies = require(scriptParentParent.dependencies)
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")

local NetworkingFriends = dependencies.NetworkingFriends
local NetworkingAliases = dependencies.NetworkingAliases
local RoduxFriends = dependencies.RoduxFriends
local RoduxAnalytics = dependencies.RoduxAnalytics
local Promise = dependencies.Promise
local Dash = dependencies.Dash
local showRecommendations = require(scriptParentParent.Utils.showRecommendations)

local EventNames = require(scriptParentParent.Analytics).EventNames
local Analytics = require(scriptParentParent.Analytics).Analytics
local FetchNames = require(scriptParentParent.Analytics.FetchNames)

local RetrievalStatus = require(scriptParentParentParent.UIBlox).App.Loading.Enum.RetrievalStatus

local UserSorts = require(scriptParentParent.Common.UserSorts)
local RECOMMENDATION_SESSION_ID_KEY = require(scriptParentParent.Common.Constants).RECOMMENDATION_SESSION_ID_KEY
local SocialCommon = dependencies.SocialCommon
local RecommendationSourceEnum = SocialCommon.Enums.RecommendationSourceEnum
local ContextualInfoTypes = SocialCommon.Enums.ContextualInfoTypes

local Timers = require(scriptParentParentParent.SocialLuaAnalytics).Analytics.Timing.Timers

local var1 = dependencies.logger:new("FriendsCarousel/" .. script.Name)

local isSubjectToDesktopPolicies = dependencies.isSubjectToDesktopPolicies
local FFlagEnableRecommendationsForPCGDK = require(scriptParentParentParent.SharedFlags).FFlagEnableRecommendationsForPCGDK
local FFlagFixIsConsoleCheckForSocialCarousel = require(scriptParentParentParent.SharedFlags).FFlagFixIsConsoleCheckForSocialCarousel

local FFlagSocialCarouselMigrateRecommendations = require(scriptParentParentParent.SharedFlags).FFlagSocialCarouselMigrateRecommendations

local FFlagLuaSupportMicroGamepadPreferredInput = require(scriptParentParentParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local function func1(num1: number)
    return showRecommendations(num1) and not isSubjectToDesktopPolicies()
        or showRecommendations(num1)
            and FFlagEnableRecommendationsForPCGDK
            and ThirdPartyUserService
            and ThirdPartyUserService:HaveActiveUser()
        or showRecommendations(num1)
            and FFlagFixIsConsoleCheckForSocialCarousel
            and (UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
                or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad)
end

local num1 = 0

return function(tbl1)
    return function(arg1)
        local str1 = tostring(arg1:getState().LocalUserId)

        local fireAnalyticsEvent = Analytics({ infoForAllEvents = { uid = str1 } }).fireAnalyticsEvent

        local var2 = Timers()
        local var3 = var2.start()

        return arg1:dispatch(NetworkingFriends.GetFriendsFromUserId.API(str1, { userSort = UserSorts.StatusFrequents })):andThen(
            function(arg2)
                local data = arg2.responseBody.data
                local dataLen = data and #data or 0
                num1 = if tbl1 and tbl1.refresh then num1 + 1 else num1
                local var4 = not data and {} or Dash.map(data, function(arg3)
                    return arg3.id
                end)

                local loadingTime = var2.stop(var3)

                fireAnalyticsEvent(
                    EventNames.FriendsEndpointLoadingTime,
                    {
                        status = RetrievalStatus.Done.rawValue(),
                        loadingTime = loadingTime,
                        fetch = FetchNames.OldAllFriends
                    }
                )
                arg1:dispatch(NetworkingAliases.GetTagsFromUserIds.API(var4)):andThen(function()
                    return Promise.resolve()
                end):catch(function(arg3)
                    var1:info(`GetTagsFromUserIds failed: {arg3}`)
                end)

                if func1(dataLen) and not FFlagSocialCarouselMigrateRecommendations then
                    arg1:dispatch(NetworkingFriends.GetFriendRecommendationsFromUserId.API({ targetUserId = str1 })):andThen(function(arg3)
                        local data2 = arg3.responseBody.data
                        local recommendationIds = Dash.map(data2, function(arg4)
                            return if arg4.contextType == ContextualInfoTypes.Contacts then arg4.contactId else arg4.id
                        end)

                        arg1:dispatch(
                            RoduxFriends.Actions.RecommendationSourceCreated(
                                {
                                    source = RecommendationSourceEnum.HomepageFriendsCarousel,
                                    recommendationIds = recommendationIds
                                }
                            )
                        )
                        local recommendationRequestId = arg3.responseBody.recommendationRequestId
                        arg1:dispatch(
                            RoduxAnalytics.Actions.SessionIdUpdated(
                                {
                                    sessionKey = RECOMMENDATION_SESSION_ID_KEY,
                                    sessionId = recommendationRequestId
                                }
                            )
                        )

                        return Promise.resolve(arg3):andThen(function(arg4)
                            if not fireAnalyticsEvent then
                                return
                            end

                            local data3 = arg4.responseBody.data
                            local data3Len = data3 and #data3 or 0
                            local recommendationRequestId2 = arg4.responseBody.recommendationRequestId

                            fireAnalyticsEvent(EventNames.CarouselLoadedWithUsers, {
                                friendCount = dataLen,
                                recommendationCount = data3Len,
                                recommendationLimit = true,
                                refreshCount = num1,
                                fetchedRecommendations = true,
                                recommendationSessionId = recommendationRequestId2
                            })
                        end)
                    end):catch(
                        function(arg3)
                            var1:info(`GetFriendRecommendationsFromUserId failed: {arg3}`)
                        end
                    )
                elseif fireAnalyticsEvent then
                    fireAnalyticsEvent(EventNames.CarouselLoadedWithUsers, {
                        friendCount = dataLen,
                        recommendationCount = 0,
                        recommendationLimit = true,
                        refreshCount = num1,
                        fetchedRecommendations = false
                    })
                end

                return Promise.resolve(data)
            end
        )
    end
end
