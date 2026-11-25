-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlaceInfoRodux = script:FindFirstAncestor("PlaceInfoRodux")
local PlaceInfoRoduxParent = PlaceInfoRodux.Parent

local Immutable = require(PlaceInfoRoduxParent.AppCommonLib).Immutable

local RequestMultiplePlaceInfos = require(PlaceInfoRodux.Actions).RequestMultiplePlaceInfos
local FailedToFetchMultiplePlaceInfos = require(PlaceInfoRodux.Actions).FailedToFetchMultiplePlaceInfos
local ReceivedMultiplePlaceInfos = require(PlaceInfoRodux.Actions).ReceivedMultiplePlaceInfos

return function(arg1, arg2)
    arg1 = arg1 or {}
    if arg2.type == RequestMultiplePlaceInfos.name then
        local tbl1 = ({})
        for _, placeId in ipairs(arg2.placeIds) do
            tbl1[placeId] = true
        end
        return Immutable.JoinDictionaries(arg1, tbl1)
    end

    if arg2.type == ReceivedMultiplePlaceInfos.name then
        local tbl1 = {}
        for _, placeInfo in ipairs(arg2.placeInfos) do
            tbl1[placeInfo.placeId] = false
        end
        return Immutable.JoinDictionaries(arg1, tbl1)
    end

    if arg2.type ~= FailedToFetchMultiplePlaceInfos.name then
        return arg1
    end

    local tbl1 = ({})
    for _, placeId in ipairs(arg2.placeIds) do
        tbl1[placeId] = false
    end
    return Immutable.JoinDictionaries(arg1, tbl1)
end
