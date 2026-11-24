-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local Url = require(InExperienceShopParent.Http).Url
local HttpClient = require(InExperienceShopParent.HttpClient)
local _Types = require(InExperienceShop.Types)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)
local FFlagLuaAppEnableGamePassFreeTrials = require(InExperienceShop.Flags.FFlagLuaAppEnableGamePassFreeTrials)
local parseGamePassTrialAvailabilities = require(script.Parent.parseGamePassTrialAvailabilities)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function emptyAvailabilities()
    return {
        available = {},
        active = {},
        redeemed = {}
    }
end

local function trialAvailabilitiesUrl(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{Url.APIS_URL}game-passes/v1/universes/{num1}/trial-availabilities`
end

return {
    fetchGamePassTrialAvailabilities = function(num1: number)
        if FFlagLuaAppEnableGamePassFreeTrials and RunService:IsStudio() and game.GameId == 0 then
            ShopDebugLogger.logLazy(function(): string
                return "fetchGamePassTrialAvailabilities: skipped unpublished Studio universeId=" .. tostring(num1)
            end)
            return Promise.resolve((emptyAvailabilities()))
        end

        local var1 = fetch({
            method = "GET",
            url = trialAvailabilitiesUrl(num1),
            analyticsKey = "game-pass-trial-availabilities.get",
            decode = function(arg1)
                if typeof(arg1) ~= "table" or typeof(arg1.trialAvailabilities) ~= "table" then
                    error("fetchGamePassTrialAvailabilities: malformed response, expected { trialAvailabilities = ... }")
                end
                return parseGamePassTrialAvailabilities(arg1.trialAvailabilities)
            end
        })
        return asPromise(var1)
    end
}
