-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local DsaIllegalContentReportingParent = script:FindFirstAncestor("DsaIllegalContentReporting").Parent
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local FFlagAddTakeItDownReportLinkToSurfaces = require(DsaIllegalContentReportingParent.SharedFlags).FFlagAddTakeItDownReportLinkToSurfaces

local str1 = game:DefineFastString("CountriesWithTakeItDownReport", "US")

local bool1 = false

if FFlagAddTakeItDownReportLinkToSurfaces then
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

        local tbl1 = str1:split(",")
        for _, value in ipairs(tbl1) do
            if result == value then
                bool1 = true
                return
            end
        end
    end)
end

local function getTakeItDownReportLinkVisibility()
    return FFlagAddTakeItDownReportLinkToSurfaces and bool1
end

return getTakeItDownReportLinkVisibility
