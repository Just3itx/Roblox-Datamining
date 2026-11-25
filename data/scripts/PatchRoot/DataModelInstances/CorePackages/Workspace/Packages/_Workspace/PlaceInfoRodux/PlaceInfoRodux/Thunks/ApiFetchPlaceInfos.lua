-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlaceInfoRodux = script:FindFirstAncestor("PlaceInfoRodux")
local PlaceInfoRoduxParent = PlaceInfoRodux.Parent

local Functional = require(PlaceInfoRoduxParent.AppCommonLib).Functional
local GetPlaceInfos = require(PlaceInfoRodux.Requests).GetPlaceInfos

local PlaceInfoModel = require(PlaceInfoRodux.Models).PlaceInfoModel
local ReceivedMultiplePlaceInfos = require(PlaceInfoRodux.Actions).ReceivedMultiplePlaceInfos

return function(arg1, arg2)
    return function(arg3)
        return GetPlaceInfos(arg1, arg2):andThen(function(arg4)
            local responseBody = arg4.responseBody

            local var1 = Functional.Map(responseBody, function(arg5)
                return PlaceInfoModel.fromWeb(arg5)
            end)

            arg3:dispatch(ReceivedMultiplePlaceInfos(var1))

            return var1
        end):catch(function(arg4)
            warn("ApiFetchlaceInfos failed with error code " .. tostring(arg4.HttpError))
        end)
    end
end
