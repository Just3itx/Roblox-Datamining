-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRodux = script:FindFirstAncestor("GameDetailRodux")
local GameDetailRoduxParent = GameDetailRodux.Parent

local DataHydration = require(GameDetailRoduxParent.DataHydration)
local Functional = require(GameDetailRoduxParent.AppCommonLib).Functional
local GamesMultigetPlaceDetails = require(GameDetailRodux.GamesByPlaceId.GamesMultigetPlaceDetails)
local PlaceInfoModel = require(GameDetailRoduxParent.PlaceInfoRodux).Models.PlaceInfoModel
local ReceivedPlacesInfos = require(GameDetailRoduxParent.PlaceInfoRodux).Actions.ReceivedPlacesInfos

local ConvertUniverseIdToString = require(GameDetailRoduxParent.SharedFlags).ConvertUniverseIdToString

return function(arg1, arg2)
    return function(arg3)
        if not arg2 or #arg2 == 0 then
            return
        end

        return GamesMultigetPlaceDetails(arg1, arg2):andThen(function(arg4)
            local responseBody = arg4.responseBody

            local tbl1 = {}
            local var1 = Functional.Map(responseBody, function(arg5)
                local web = PlaceInfoModel.fromWeb(arg5)
                table.insert(tbl1, (ConvertUniverseIdToString(web.universeId)))
                return web
            end)

            arg3:dispatch(ReceivedPlacesInfos(var1))

            if #tbl1 > 0 then
                DataHydration.Game.getGameIconStore(false).getAndFetchGameIcons(tbl1)
            end

            return var1
        end)
    end
end
