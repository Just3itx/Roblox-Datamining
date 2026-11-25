-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlaceInfoRodux = script:FindFirstAncestor("PlaceInfoRodux")
local PlaceInfoRoduxParent = PlaceInfoRodux.Parent

local Immutable = require(PlaceInfoRoduxParent.AppCommonLib).Immutable
local ReceivedPlacesInfos = require(PlaceInfoRodux.Actions).ReceivedPlacesInfos

local ConvertUniverseIdToString = require(PlaceInfoRoduxParent.SharedFlags).ConvertUniverseIdToString

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == ReceivedPlacesInfos.name then
        for _, placesInfo in pairs(arg2.placesInfos) do
            local var1 = ConvertUniverseIdToString(placesInfo.universeId)

            arg1 = Immutable.Set(arg1, var1, placesInfo)
        end
    end

    return arg1
end
