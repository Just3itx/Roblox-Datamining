-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlaceInfoRoduxParent = script:FindFirstAncestor("PlaceInfoRodux").Parent

local Promise = require(PlaceInfoRoduxParent.Promise)
local Http = require(PlaceInfoRoduxParent.Http)
local HttpRequest = require(PlaceInfoRoduxParent.HttpRequest)
local _LuauPolyfill = require(PlaceInfoRoduxParent.LuauPolyfill)

local Url = Http.Url

local module = ({})
module.__index = module

function module.new(_requestImpl: ((...any) -> (...any))?)
    local tbl1 = {}

    local var1 = HttpRequest.config({
        requestFunction = function(str1: string, str2: string, tbl2)
            return HttpRequest.requestFunctions.HttpRbxApi(str1, str2, tbl2)
        end
    })

    tbl1._placeInfo = {}
    tbl1._requestImpl = _requestImpl or var1

    return (setmetatable(tbl1, module))
end

function module.name(tbl1, num1: number)
    return tbl1:_getInfo(num1, "name")
end

function module.description(tbl1, num1: number)
    return tbl1:_getInfo(num1, "description")
end

function module.universeId(tbl1, num1: number)
    return tbl1:_getInfo(num1, "universeId")
end

function module:_fetchPlacesInfo(placeIds)
    local var1 = Url:makeQueryString({ placeIds = placeIds })

    local str1 = string.format("%sv1/games/multiget-place-details?%s", Url.GAME_URL, var1)

    return self._requestImpl(str1, "GET")
end

function module:getPlacesInfo(tbl1)
    local promise = Promise.new(function(callback, callback2)
        self:_fetchPlacesInfo(tbl1):andThen(function(tbl2)
            if not (tbl2 and tbl2.responseBody) then
                callback(nil)
                return
            end

            local tbl3 = {}

            for _, value in tbl2.responseBody do
                local tbl4 = {
                    universeId = value.universeId,
                    name = value.name,
                    description = value.description
                }
                tbl3[value.placeId] = tbl4

                self._placeInfo[value.placeId] = tbl4
            end
            callback(tbl3)
        end):catch(function(arg1)
            callback2(arg1)
        end)
    end)

    local placesInfo = ({})
    for _, value in tbl1 do
        if self._placeInfo[value] then
            placesInfo[value] = Promise.resolve(self._placeInfo[value])
        else
            self._placeInfo[value] = promise:andThen(function(tbl2)
                return tbl2[value]
            end)
            placesInfo[value] = self._placeInfo[value]
        end
    end
    return placesInfo
end

function module:_getInfo(num1: number, str1: string)
    if self._placeInfo[num1] and self._placeInfo[num1][str1] then
        return Promise.resolve(self._placeInfo[num1][str1])
    elseif self._placeInfo[num1] then
        return self._placeInfo[num1]:andThen(function(_)
            return self._placeInfo[num1][str1]
        end)
    end

    return (self:getPlacesInfo({ num1 })[num1]:andThen(function(tbl1)
        return tbl1[str1]
    end))
end

module.default = module.new()

return module
