-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameProductInfoRodux = script:FindFirstAncestor("GameProductInfoRodux")
local GameProductInfoRoduxParent = GameProductInfoRodux.Parent
local Promise = require(GameProductInfoRoduxParent.Promise)
local Result = require(GameProductInfoRoduxParent.Result)
local PerformFetch = require(GameProductInfoRoduxParent.Http).PerformFetch
local Logging = require(GameProductInfoRoduxParent.AppCommonLib).Logging
local SetGamesProductInfo = require(GameProductInfoRodux.SetGamesProductInfo)
local GamesGetProductInfo = require(GameProductInfoRodux.GamesGetProductInfo)
local GameProductInfo = require(GameProductInfoRodux.GameProductInfo)

local module = {}

local function KeyMapper(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return "luaapp.gamesapi.games-product-info." .. arg1
end

module.KeyMapper = KeyMapper

function module.Fetch(arg1, arg2)
    assert(type(arg2) == "table", "FetchGamesProductInfo thunk expects universeIds to be a table")
    assert(#arg2 > 0, "FetchGamesProductInfo thunk expects universeIds count to be greater than 0")
    assert(#arg2 <= 100, "FetchGamesProductInfo thunk expects universeIds count to not exceed " .. 100)

    return PerformFetch.Batch(arg2, KeyMapper, function(arg3, arg4)
        return GamesGetProductInfo(arg1, arg4):andThen(function(arg5)
            local tbl1 = {}
            for _, value in ipairs(arg4) do
                tbl1[KeyMapper(value)] = Result.new(false, nil)
            end

            local data = arg5 and arg5.responseBody and arg5.responseBody.data
            if data ~= nil then
                local tbl2 = {}
                for _, value in ipairs(data) do
                    GameProductInfo.fromJsonData(value):match(function(arg6)
                        tbl2[arg6.universeId] = arg6
                        tbl1[KeyMapper(arg6.universeId)] = Result.new(true, nil)
                    end):matchError(function(arg6)
                        Logging.warn(arg6)
                    end)
                end

                if next(tbl2) then
                    arg3:dispatch(SetGamesProductInfo(tbl2))
                end
            else
                Logging.warn("Response from GamesGetProductInfo is malformed!")
            end

            return Promise.resolve(tbl1)
        end, function(_)
            local tbl1 = {}
            for _, value in ipairs(arg4) do
                tbl1[KeyMapper(value)] = Result.new(false, nil)
            end
            return Promise.resolve(tbl1)
        end)
    end)
end

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (KeyMapper(arg2)))
end

return module
