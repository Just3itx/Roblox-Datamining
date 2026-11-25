-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:40:53Z
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

    tbl1._universeVotes = {}
    tbl1._requestImpl = _requestImpl or var1

    return (setmetatable(tbl1, module))
end

function module.upVotes(tbl1, num1: number)
    return tbl1:_getVotes(num1, "upVotes")
end

function module.downVotes(tbl1, num1: number)
    return tbl1:_getVotes(num1, "downVotes")
end

function module.rating(tbl1, num1: number)
    return tbl1:_getVotes(num1, "rating")
end

function module:_fetchUniversesVotes(universeIds)
    local var1 = Url:makeQueryString({ universeIds = universeIds })

    local str1 = string.format("%sv1/games/votes?%s", Url.GAME_URL, var1)

    return self._requestImpl(str1, "GET")
end

function module:getUniversesVotes(tbl1)
    local promise = Promise.new(function(callback, callback2)
        self:_fetchUniversesVotes(tbl1):andThen(function(tbl2)
            if not (tbl2 and tbl2.responseBody) then
                callback(nil)
                return
            end

            local tbl3 = {}

            for _, value in tbl2.responseBody.data do
                local rating = if value.upVotes + value.downVotes == 0 then 0 else value.upVotes / (value.upVotes + value.downVotes)

                local tbl4 = {
                    universeId = value.id,
                    upVotes = value.upVotes,
                    downVotes = value.downVotes,
                    rating = rating
                }
                tbl3[value.id] = tbl4

                self._universeVotes[value.id] = tbl4
            end
            callback(tbl3)
        end):catch(function(arg1)
            callback2(arg1)
        end)
    end)

    local universesVotes = ({})
    for _, value in tbl1 do
        if self._universeVotes[value] then
            universesVotes[value] = Promise.resolve(self._universeVotes[value])
        else
            self._universeVotes[value] = promise:andThen(function(tbl2)
                return tbl2[value]
            end)

            universesVotes[value] = self._universeVotes[value]
        end
    end
    return universesVotes
end

function module:_getVotes(num1: number, str1: string)
    if self._universeVotes[num1] and self._universeVotes[num1][str1] then
        return Promise.resolve(self._universeVotes[num1][str1])
    elseif self._universeVotes[num1] then
        return self._universeVotes[num1]:andThen(function(_)
            return self._universeVotes[num1][str1]
        end)
    end

    return (self:getUniversesVotes({ num1 })[num1]:andThen(function(tbl1)
        return tbl1[str1]
    end))
end

module.default = module.new()

return module
