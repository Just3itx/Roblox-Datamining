-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlaceInfoRodux = script:FindFirstAncestor("PlaceInfoRodux")
local PlaceInfoRoduxParent = PlaceInfoRodux.Parent

local ReceivedMultiplePlaceInfos = require(PlaceInfoRodux.Actions).ReceivedMultiplePlaceInfos

local Immutable = require(PlaceInfoRoduxParent.AppCommonLib).Immutable

return function(arg1, arg2)
    arg1 = arg1 or {}
    if arg2.type == ReceivedMultiplePlaceInfos.name then
        local tbl1 = {}
        for _, placeInfo in ipairs(arg2.placeInfos) do
            tbl1[placeInfo.placeId] = placeInfo
        end

        arg1 = Immutable.JoinDictionaries(arg1, tbl1)
    end
    return arg1
end
