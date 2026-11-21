-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)
local React = require(GameFiltersParent.React)
local TopicInfosReducer = require(GameFiltersParent.TopicInfosRodux).TopicInfosReducer

local useSelector = require(GameFiltersParent.RoactUtils).Hooks.RoactRodux.useSelector

local function useGameFilterAnalyticsInfo(str1: string, sortPos: number)
    local var1 = useSelector(function(arg1)
        return arg1.Personalization[TopicInfosReducer.key][str1]
    end)

    return React.useMemo(function(): {[any]: any} | {gameSetTargetId: any, gameSetTypeId: any, sortPos: number}
        return if var1 then {
            gameSetTypeId = var1.gameSetTypeId,
            gameSetTargetId = var1.gameSetTargetId,
            sortPos = sortPos
        } else {}
    end, { var1, sortPos })
end

return useGameFilterAnalyticsInfo
