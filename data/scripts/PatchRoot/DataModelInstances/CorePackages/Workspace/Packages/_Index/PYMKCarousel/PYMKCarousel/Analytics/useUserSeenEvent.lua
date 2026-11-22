-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Constants = require(scriptParentParent.Common.Constants)
local dependencies = require(scriptParentParent.dependencies)

local llama = dependencies.llama
local React = dependencies.React
local useSelector = dependencies.Hooks.useSelector
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue
local EventNames = require(script.Parent.EventNames)
local getFriendStatus = require(script.Parent.getFriendStatus)
local RecommendationContextType = dependencies.RoduxFriends.Enums.RecommendationContextType
local getFFlagPYMKAddFriendsEntry = dependencies.getFFlagPYMKAddFriendsEntry

local FFlagMigrateFriendshipStatusesPYMK = require(scriptParentParent.Flags.FFlagMigrateFriendshipStatusesPYMK)
local FFlagLuaAppEnableSduiHomePage = require(scriptParentParentParent.SharedFlags).FFlagLuaAppEnableSduiHomePage
local FFlagPYMKCarouselStableSelectors = require(scriptParentParent.Flags.FFlagPYMKCarouselStableSelectors)
local FFlagPymkCarouselExtendProps = require(scriptParentParentParent.SharedFlags).FFlagPymkCarouselExtendProps

local var1 = table.freeze({})
local var2 = if FFlagMigrateFriendshipStatusesPYMK then require(scriptParentParentParent.DataHydration).Friends.FriendsStore.get() else nil

local function getHydratedFriendshipStatus(id: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local friendshipStatus = var2.GetFriendshipStatus(id, { skipFetch = true })
    if friendshipStatus then
        return (friendshipStatus.data(false))
    end

    return nil
end

return function(callback: (...any) -> (...any))
    local var3 = React.useRef({})
    local var4 = if FFlagMigrateFriendshipStatusesPYMK then nil else useSelector(function(arg1)
        local deepValue = getDeepValue(arg1, string.format("%s.Friends.friendshipStatus", Constants.RODUX_KEY))

        if not deepValue then
            if FFlagPYMKCarouselStableSelectors then
                return var1
            end

            deepValue = {}
        end

        return deepValue
    end)

    local var5 = if FFlagLuaAppEnableSduiHomePage then nil else useSelector(function(arg1)
        return getDeepValue(arg1, string.format("%s.Friends.recommendations.hasIncomingFriendRequest", Constants.RODUX_KEY))
    end) or not FFlagPYMKCarouselStableSelectors and {} or var1

    local var6 = useSelector(function(arg1)
        local deepValue = getDeepValue(arg1, "PYMKCarousel.Presence.byUserId")

        if not deepValue then
            if FFlagPYMKCarouselStableSelectors then
                return var1
            end

            deepValue = {}
        end

        return deepValue
    end)

    return React.useMemo(function()
        return {{
            viewabilityConfig = { itemVisiblePercentThreshold = 50, waitForInteraction = false },
            onViewableItemsChanged = function(arg1)
                for _, value in pairs(arg1.changed) do
                    local item = value.item
                    local current = var3.current or {}

                    local bool1 = not current[item.id]
                    if getFFlagPYMKAddFriendsEntry() then
                        bool1 = not (current[item.id] or item.isTooltip or item.isButtonTile)
                    end

                    if not bool1 then
                        continue
                    end

                    callback(EventNames.UserSeen, {
                        userId = item.id,
                        contactId = if item.recommendationContextType == RecommendationContextType.Contacts then item.id else nil,
                        friendStatus = getFriendStatus(
                            if FFlagMigrateFriendshipStatusesPYMK then getHydratedFriendshipStatus(item.id) else var4[item.id],
                            if FFlagPymkCarouselExtendProps then if FFlagLuaAppEnableSduiHomePage or item.hasIncomingFriendRequest ~= nil then item.hasIncomingFriendRequest else var5[item.id] elseif FFlagLuaAppEnableSduiHomePage then item.hasIncomingFriendRequest else var5[item.id]
                        ),
                        recommendationContextType = item.recommendationContextType,
                        recommendationRank = item.recommendationRank,
                        absolutePosition = item.absolutePosition,
                        presence = (var6[item.id] or {}).userPresenceType
                    })
                    local var7 = var3
                    var7.current = llama.Dictionary.join(var3.current, { [item.id] = true })
                end
            end
        }}
    end, FFlagPYMKCarouselStableSelectors and {
        var6,
        var4,
        var5,
        callback
    } or { var6 })
end
