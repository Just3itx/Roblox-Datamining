-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local FFlagReportBuildUIVisibility = require(BuildExperience.Flags.FFlagReportBuildUIVisibility)

local engineFeature = game:GetEngineFeature("SSMetabuiLua")

local function getSafetyService() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): SafetyService
        return game:GetService("SafetyService")
    end)
    return if success then result else nil
end

local function createBuildUIVisibility(safetyService)
    local getOpenPanelCountForTests = 0

    return {
        acquire = function()
            getOpenPanelCountForTests += 1
            if getOpenPanelCountForTests ~= 1 or safetyService == nil then
                return
            end

            pcall(function()
                safetyService:ReportBuildUIOpen()
            end)
        end,
        release = function()
            if getOpenPanelCountForTests == 0 then
                return
            end

            getOpenPanelCountForTests -= 1
            if getOpenPanelCountForTests ~= 0 or safetyService == nil then
                return
            end

            pcall(function()
                safetyService:ReportBuildUIClose()
            end)
        end,
        getOpenPanelCountForTests = function()
            return getOpenPanelCountForTests
        end
    }
end

local buildUIVisibility = createBuildUIVisibility(if FFlagReportBuildUIVisibility and engineFeature then getSafetyService() else nil)

return {
    acquire = buildUIVisibility.acquire,
    release = buildUIVisibility.release,
    getOpenPanelCountForTests = buildUIVisibility.getOpenPanelCountForTests,
    createForTests = createBuildUIVisibility
}
