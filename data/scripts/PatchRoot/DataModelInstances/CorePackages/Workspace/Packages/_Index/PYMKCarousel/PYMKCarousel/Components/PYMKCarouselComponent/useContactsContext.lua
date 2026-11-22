-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)
local PYMKCarouselParent = PYMKCarousel.Parent

local React = require(PYMKCarouselParent.React)
local tutils = require(PYMKCarouselParent.tutils)
local useSelector = dependencies.Hooks.useSelector
local RoduxFriends = dependencies.RoduxFriends
local RecommendationContextType = RoduxFriends.Enums.RecommendationContextType
local _DirectRecommendationTypes = require(PYMKCarousel.Common.DirectRecommendationTypes)

local FFlagLuaAppEnableSduiHomePage = require(PYMKCarouselParent.SharedFlags).FFlagLuaAppEnableSduiHomePage
local FFlagPymkCarouselExtendProps = require(PYMKCarouselParent.SharedFlags).FFlagPymkCarouselExtendProps

local function useContactsContext(arg1, tbl1)
    local var1

    if FFlagLuaAppEnableSduiHomePage then
        var1 = tbl1 or {}
    elseif FFlagPymkCarouselExtendProps then
        local var2 = useSelector(function(arg2)
            local str1 = tostring(arg2.LocalUserId)
            return RoduxFriends.Selectors.selectRecommendationsForUserId(arg2)(str1) or {}
        end, tutils.shallowEqual)
        var1 = tbl1 or var2
    else
        var1 = useSelector(function(arg2)
            local str1 = tostring(arg2.LocalUserId)
            return RoduxFriends.Selectors.selectRecommendationsForUserId(arg2)(str1) or {}
        end, tutils.shallowEqual)
    end

    return (React.useMemo(function()
        local contacts = ({})
        for _, value in arg1 do
            if value.recommendationContextType ~= RecommendationContextType.Contacts then
                continue
            end

            local id = value.id
            local var2 = var1[id]
            if not var2 then
                continue
            end

            contacts[id] = {
                isLoading = false,
                name = var2.entityDisplayName or "",
                avatarThumbnailUrl = var2.thumbnailEntities and var2.thumbnailEntities.headshotImageUrl or ""
            }
        end

        return { contacts = contacts }
    end, { arg1, var1 }))
end

return useContactsContext
