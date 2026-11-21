-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local sendAXStat = AvatarExperienceAnalytics.sendAXStat
local AnalyticsService = AvatarExperienceAnalytics.AnalyticsService
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)
local FFlagAXSendModelMismatchCounter = require(AvatarExperienceCatalog.Flags.FFlagAXSendModelMismatchCounter)

local function makeAXResponseHandler(arg1, func1: (...any) -> (...any), tbl1)
    local latencyCounter = if tbl1 then tbl1.latencyCounter else nil
    local modelMismatchCounter = if tbl1 then tbl1.modelMismatchCounter else nil
    local var1 = if latencyCounter then os.clock() else nil

    return (arg1:andThen(function(arg2)
        if latencyCounter and var1 then
            local deltaMs = (os.clock() - var1) * 1000
            sendAXStat({ statName = latencyCounter, deltaMs = deltaMs })
        end

        local var2, var3 = func1(if arg2 then arg2.responseBody else nil)
        if var3 then
            if FFlagAXSendModelMismatchCounter and modelMismatchCounter then
                AnalyticsService.EventStream:sendEventDeferred(modelMismatchCounter, "marketplaceModelMismatchMetric", {})
            end

            warn(var3)
        end

        return var2
    end))
end
return makeAXResponseHandler
