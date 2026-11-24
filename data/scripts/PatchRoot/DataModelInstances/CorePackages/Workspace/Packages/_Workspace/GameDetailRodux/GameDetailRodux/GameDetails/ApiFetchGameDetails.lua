-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRodux = script:FindFirstAncestor("GameDetailRodux")
local GameDetailRoduxParent = GameDetailRodux.Parent

local Promise = require(GameDetailRoduxParent.Promise)
local ArgCheck = require(GameDetailRoduxParent.ArgCheck)
local Result = require(GameDetailRoduxParent.Result)
local PerformFetch = require(GameDetailRoduxParent.Http).PerformFetch

local GamesMultigetDetails = require(script.Parent.GamesMultigetDetails)
local AddGameDetails = require(GameDetailRodux.GameDetails.AddGameDetails)
local SetGameDetailError = require(GameDetailRodux.GameDetails.SetGameDetailError)
local GameDetailModel = require(GameDetailRodux.GameDetails.GameDetailModel)
local EnumGameDetailErrorTypes = require(GameDetailRoduxParent.DiscoveryTypes).EnumGameDetailErrorTypes

local Logger = require(GameDetailRodux.Logger)

local module = {}

local function KeyMapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.gamesapi.games." .. arg1
end

module.KeyMapper = KeyMapper

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (KeyMapper(arg2)))
end

function module.Fetch(arg1, arg2)
    ArgCheck.isType(arg2, "table", "ApiFetchGameDetails: universeIds")

    return PerformFetch.Batch(arg2, KeyMapper, function(arg3, arg4)
        return GamesMultigetDetails(arg1, arg4):andThen(function(arg5)
            local tbl1 = {}

            local data = arg5 and arg5.responseBody and arg5.responseBody.data
            if data ~= nil then
                local tbl2 = {}

                for _, value in ipairs(data) do
                    local jsonData = GameDetailModel.fromJsonData(value)
                    tbl2[jsonData.id] = jsonData
                    tbl1[KeyMapper(jsonData.id)] = Result.new(true, jsonData)
                end

                for _, value in pairs(arg4) do
                    if not tbl2[value] then
                        arg3:dispatch(SetGameDetailError(value, EnumGameDetailErrorTypes.ExperienceUnavailable))
                    end
                end

                if next(tbl2) then
                    arg3:dispatch(AddGameDetails(tbl2))
                end
            else
                Logger:warning("Response from GamesMultigetDetails is malformed!")
            end

            return Promise.resolve(tbl1)
        end, function(_)
            return Promise.resolve({})
        end)
    end)
end

return module
