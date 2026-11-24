-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local DsaIllegalContentReporting = script:FindFirstAncestor("DsaIllegalContentReporting")
local DsaIllegalContentReportingParent = DsaIllegalContentReporting.Parent
local Constants = require(DsaIllegalContentReporting.Utility.Constants)
local SharedFlags = require(DsaIllegalContentReportingParent.SharedFlags)

local isInDSAFeaturesOverrideList = require(DsaIllegalContentReporting.Utility.isInDSAFeaturesOverrideList)
local GetFFlagDSAIllegalContentReporting = SharedFlags.GetFFlagDSAIllegalContentReporting

local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local bool1 = false

if GetFFlagDSAIllegalContentReporting() then
    task.spawn(function()
        local localPlayer = Players.LocalPlayer
        while not localPlayer do
            Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            localPlayer = Players.LocalPlayer
        end

        local success, result = pcall(LocalizationService.GetCountryRegionForPlayerAsync, LocalizationService, localPlayer)

        if not success then
            return
        end

        for _, value in ipairs(Constants.ELIGIBLE_COUNTRY_REGION_CODES) do
            if result == value then
                bool1 = true
                return
            end
        end
    end)
end

function isShowEUDSAIllegalContentReportingLink()
    return if isInDSAFeaturesOverrideList() then true else GetFFlagDSAIllegalContentReporting() and bool1
end

return isShowEUDSAIllegalContentReportingLink
