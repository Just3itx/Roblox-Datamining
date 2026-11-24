-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local FIntOffersPrefetchOnGameJoinFallbackDelayMs = require(InExperienceOffers.Flags.FIntOffersPrefetchOnGameJoinFallbackDelayMs)
local scheduleFallback = require(script.Parent.scheduleFallback)
local OffersDebugLogger = require(InExperienceOffers.Internal.OffersDebugLogger)

local var1 = FIntOffersPrefetchOnGameJoinFallbackDelayMs / 1000

local function whenJoinSettles(callback: (...any) -> (...any))
    local bool1 = false
    local function fire(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        if bool1 then
            return
        end
        bool1 = true
        OffersDebugLogger.logLazy(function(): string
            return "whenJoinSettles: settled path=" .. str1
        end)
        callback(str1)
    end

    task.spawn(function()
        xpcall(function()
            while not Players.LocalPlayer do
                Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
                if bool1 then
                    return
                end
            end

            local localPlayer = Players.LocalPlayer
            assert(localPlayer ~= nil, "LocalPlayer must be non-nil after the wait loop")

            if localPlayer.Character and localPlayer:HasAppearanceLoaded() then
                fire("primary")
            elseif not bool1 then
                localPlayer.CharacterAppearanceLoaded:Once(function()
                    fire("primary")
                end)
            end
        end, function(arg1)
            warn("[InExperienceOffers] whenJoinSettles path 1 errored: " .. tostring(arg1))
        end)
    end)

    OffersDebugLogger.logLazy(function()
        return "whenJoinSettles: scheduled fallback delaySeconds=" .. var1
    end)
    scheduleFallback(var1, function()
        fire("fallback")
    end)
end

return whenJoinSettles
