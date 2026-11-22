-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local scriptParentParentParentParent = scriptParentParentParent.Parent
local React = require(scriptParentParentParentParent.React)
local Dash = require(scriptParentParentParentParent.Dash)

local EntityType = require(scriptParentParentParentParent.UserList).Enums.EntityType

local RecommendationContextType = dependencies.RoduxFriends.Enums.RecommendationContextType
local _DirectRecommendationTypes = require(scriptParentParentParent.Common.DirectRecommendationTypes)

local function usePYMKCarouselUserEntitiesList(arg1)
    return React.useMemo(function()
        return Dash.map(Dash.filter(arg1, function(arg2): boolean
            return not (arg2.isButtonTile or arg2.isTooltip)
        end), function(arg2)
            return {
                id = arg2.id,
                type = if arg2.recommendationContextType == RecommendationContextType.Contacts then EntityType.Contact else EntityType.User
            }
        end)
    end, { arg1 })
end

return usePYMKCarouselUserEntitiesList
