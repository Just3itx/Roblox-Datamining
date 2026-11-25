-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Signals = require(SquadsCoreParent.Signals)

local getLuckyRecommendation = require(SquadsCore.NetworkRequests).getLuckyRecommendation
local SquadLuckyRecommendationError = require(SquadsCore.Enums.SquadLuckyRecommendationError)
local SquadLuckyRecommendationPhase = require(SquadsCore.Enums.SquadLuckyRecommendationPhase)
local SquadLuckyRecommendationRevealType = require(SquadsCore.Enums.SquadLuckyRecommendationRevealType)
local _Types = require(SquadsCore.Types)

return function()
    local getState, var2 = Signals.createSignal({ phase = SquadLuckyRecommendationPhase.Idle })

    local luckyRecommendation = nil
    local var3 = nil

    local function cancelFetch() -- Luacid: Inlined by compiler; 2 call sites recovered
        if luckyRecommendation then
            luckyRecommendation()
            luckyRecommendation = nil
        end
    end

    local function func2(pickRequestId: string, squadId: string)
        cancelFetch()
        local tbl1 = {
            pickRequestId = pickRequestId,
            squadId = squadId,
            revealType = SquadLuckyRecommendationRevealType.Default,
            result = nil
        }

        var3 = tbl1
        var2({ phase = SquadLuckyRecommendationPhase.Rolling })

        luckyRecommendation = getLuckyRecommendation(pickRequestId, function(recommendation)
            luckyRecommendation = nil
            tbl1.result = { isSuccess = true, recommendation = recommendation }
        end, function(error)
            luckyRecommendation = nil
            tbl1.result = { isSuccess = false, error = error }
        end)
    end

    return {
        getState = getState,
        getAnalyticsContext = function()
            return {
                pickRequestId = if var3 then var3.pickRequestId else nil,
                revealType = if var3 then var3.revealType else nil
            }
        end,
        startRoll = function(squadId: string, bool1: boolean?)
            if bool1 and var3 ~= nil and var3.squadId == squadId then
                if getState(false).phase == SquadLuckyRecommendationPhase.Revealed then
                    var3.revealType = SquadLuckyRecommendationRevealType.Restored
                    return
                end

                if var3.result ~= nil and var3.result.isSuccess then
                    var3.revealType = SquadLuckyRecommendationRevealType.Preloaded
                    return
                end
            end
            local pickRequestId = HttpService:GenerateGUID(false)
            func2(pickRequestId, squadId)
        end,
        endRoll = function()
            if getState(false).phase ~= SquadLuckyRecommendationPhase.Rolling then
                return
            end

            cancelFetch()
            local result = if var3 == nil then nil else var3.result

            if result == nil then
                var2({ phase = SquadLuckyRecommendationPhase.Errored, error = SquadLuckyRecommendationError.Timeout })
            elseif result.isSuccess then
                var2({ phase = SquadLuckyRecommendationPhase.Revealed, recommendation = result.recommendation })
            else
                var2({ phase = SquadLuckyRecommendationPhase.Errored, error = result.error })
            end
        end,
        cancelFetch = cancelFetch
    }
end
