-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local RunService = game:GetService("RunService")

local CoreScriptsRoactCommon = script:FindFirstAncestor("CoreScriptsRoactCommon")
local CoreScriptsRoactCommonParent = CoreScriptsRoactCommon.Parent

local Signals = require(CoreScriptsRoactCommonParent.Signals)
local createSignal = Signals.createSignal

local getIsPrivatePlaytesterStore = require(CoreScriptsRoactCommonParent.DataHydration.IsPrivatePlaytester).getIsPrivatePlaytesterStore

local UniverseConfiguration = require(CoreScriptsRoactCommonParent.DataHydration.UniverseConfiguration)
local getUniverseConfigurationStore = UniverseConfiguration.getUniverseConfigurationStore
local PrivacyType = UniverseConfiguration.PrivacyType

local PlaytestModeAnalytics = require(CoreScriptsRoactCommon.Analytics.PlaytestModeAnalytics)

local BuildModeLaunch = require(CoreScriptsRoactCommonParent.BuildExperiencePlaytestLaunch.BuildModeLaunch)

local bool1 = game:DefineFastFlag("DebugEnablePlaytestMode", false)
local FFlagAddPlaytestModeAnalytics = require(CoreScriptsRoactCommon.Flags.FFlagAddPlaytestModeAnalytics)
local FFlagPlaytestModeExcludeBuildMode = require(CoreScriptsRoactCommon.Flags.FFlagPlaytestModeExcludeBuildMode)
local FFlagPlaytestModeExcludeStudio = require(CoreScriptsRoactCommon.Flags.FFlagPlaytestModeExcludeStudio)
local FFlagPlaytestModeIncludeTeamTest = require(CoreScriptsRoactCommon.Flags.FFlagPlaytestModeIncludeTeamTest)
local FFlagPlaytestModeTooltipOncePerWeek = require(CoreScriptsRoactCommonParent.SharedFlags).FFlagPlaytestModeTooltipOncePerWeek

local FFlagPlaytestModeTooltipOnlyPrivateTesters = require(CoreScriptsRoactCommonParent.SharedFlags).FFlagPlaytestModeTooltipOnlyPrivateTesters

return function()
    local var1, setHasEditAccess = createSignal(false)

    local function getHasTooltipCooldownExpired(): boolean
        local success, result = pcall(function(): string
            return AppStorageService:GetItem("PlaytestModeTooltipSeenAt")
        end)
        if not success or type(result) ~= "string" then
            return true
        end
        local var3 = tonumber(result)
        return var3 == nil or os.time() - var3 >= 604800
    end

    local function markTooltipSeen()
        pcall(function()
            AppStorageService:SetItem("PlaytestModeTooltipSeenAt", tostring(os.time()))
            AppStorageService:Flush()
        end)
    end

    local computed = Signals.createComputed(function(arg1): boolean
        local var3 = getIsPrivatePlaytesterStore(arg1).getAndFetch(game.GameId).data(arg1)
        return not (var3 == nil) and var3.isPlaytester == true
    end)

    local computed2 = Signals.createComputed(function(arg1): boolean
        local var3 = getUniverseConfigurationStore(arg1).getAndFetchSummary(game.GameId).data(arg1)
        return not (var3 == nil) and var3.privacyType == PrivacyType.Private
    end)

    local tbl1 = {
        getIsPlaytestMode = Signals.createComputed(function(arg1): boolean
            if bool1 then
                return true
            end

            if FFlagPlaytestModeExcludeBuildMode and BuildModeLaunch:hasBuildMode() then
                return false
            end

            if FFlagPlaytestModeIncludeTeamTest and RunService:IsTeamTest() then
                if FFlagAddPlaytestModeAnalytics then
                    if RunService:IsStudio() then
                        PlaytestModeAnalytics.logPlaytestModeEnabled("studio_team_test")
                    else
                        PlaytestModeAnalytics.logPlaytestModeEnabled("team_test_server")
                    end
                end
                return true
            end

            if computed(arg1) then
                if FFlagAddPlaytestModeAnalytics then
                    PlaytestModeAnalytics.logPlaytestModeEnabled("private_playtester")
                end
                return true
            end

            if not var1(arg1) or not computed2(arg1) or FFlagPlaytestModeExcludeStudio and RunService:IsStudio() then
                return false
            end

            if FFlagAddPlaytestModeAnalytics then
                PlaytestModeAnalytics.logPlaytestModeEnabled("private_game")
            end
            return true
        end),
        getIsPrivatePlaytester = if FFlagPlaytestModeTooltipOnlyPrivateTesters then computed else nil,
        setHasEditAccess = setHasEditAccess,
        getHasTooltipCooldownExpired = 0,
        markTooltipSeen = 0
    }

    if not FFlagPlaytestModeTooltipOncePerWeek then
        getHasTooltipCooldownExpired = nil
    end

    tbl1.getHasTooltipCooldownExpired = getHasTooltipCooldownExpired

    if not FFlagPlaytestModeTooltipOncePerWeek then
        markTooltipSeen = nil
    end

    tbl1.markTooltipSeen = markTooltipSeen
    return tbl1
end
