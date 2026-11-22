-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayabilityRodux = script:FindFirstAncestor("PlayabilityRodux")
local PlayabilityRoduxParent = PlayabilityRodux.Parent

local Promise = require(PlayabilityRoduxParent.Promise)
local Result = require(PlayabilityRoduxParent.Result)
local PerformFetch = require(PlayabilityRoduxParent.Http).PerformFetch
local GamesMultigetPlayabilityStatus = require(PlayabilityRodux.PlayabilityStatus.GamesMultigetPlayabilityStatus)
local SetPlayabilityStatus = require(PlayabilityRodux.PlayabilityStatus.SetPlayabilityStatus)
local PlayabilityStatusModel = require(PlayabilityRodux.PlayabilityStatus.PlayabilityStatusModel)

local Logger = require(PlayabilityRodux.Logger)

local function keyMapper(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return "luaapp.gamesapi.playabilitystatus." .. arg1
end

local module = { KeyMapper = keyMapper }

function module.Fetch(arg1, arg2)
    assert(type(arg2) == "table", "ApiFetchPlayabilityStatus thunk expects universeIds to be a table")
    assert(#arg2 > 0, "ApiFetchPlayabilityStatus thunk expects universeIds count to be greater than 0")
    assert(#arg2 <= 100, "ApiFetchPlayabilityStatus thunk expects universeIds count to not exceed " .. 100)

    return PerformFetch.Batch(arg2, keyMapper, function(arg3, arg4)
        return GamesMultigetPlayabilityStatus(arg1, arg4):andThen(function(arg5)
            local tbl1 = {}
            for _, value in ipairs(arg4) do
                tbl1[keyMapper(value)] = Result.new(false, nil)
            end

            local responseBody = arg5 and arg5.responseBody
            if responseBody ~= nil then
                local tbl2 = {}
                for _, value in pairs(responseBody) do
                    PlayabilityStatusModel.fromJsonData(value):match(function(arg6)
                        tbl2[arg6.universeId] = arg6
                        local tbl3 = tbl1
                        local universeId = value.universeId
                        tbl3[keyMapper(tostring(universeId))] = Result.new(true, nil)
                    end):matchError(function(arg6)
                        warn(arg6)
                    end)
                end

                if next(tbl2) then
                    arg3:dispatch(SetPlayabilityStatus(tbl2))
                end
            else
                Logger:warning("Response from GameGetVotes is malformed!")
            end

            return Promise.resolve(tbl1)
        end, function(_)
            local tbl1 = {}
            for _, value in ipairs(arg4) do
                tbl1[keyMapper(value)] = Result.new(false, nil)
            end
            return Promise.resolve(tbl1)
        end)
    end)
end

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (keyMapper(arg2)))
end

return module
