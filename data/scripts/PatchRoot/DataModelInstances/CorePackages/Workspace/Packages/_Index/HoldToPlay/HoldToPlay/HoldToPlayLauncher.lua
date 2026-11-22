-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HoldToPlay = script:FindFirstAncestor("HoldToPlay")
local HoldToPlayParent = HoldToPlay.Parent

local React = require(HoldToPlayParent.React)

local FocusNavigationUtils = require(HoldToPlayParent.FocusNavigationUtils)
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local ButtonHoldStateEnum = FocusNavigationUtils.ButtonHoldStateEnum
local AppShortcutBarContext = require(HoldToPlayParent.AppShortcutBar).AppShortcutBarContext

local HoldToPlayLoader = require(HoldToPlay.HoldToPlayLoader)
local FFlagLuaAppDemoModePlayButtonTelemetry = require(HoldToPlayParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry

local function HoldToPlayLauncher(tbl1)
    local var1 = AppShortcutBarContext.useDispatchButtonHoldStarted()
    local var2 = AppShortcutBarContext.useDispatchButtonHoldEnded()

    React.useEffect(function()
        if tbl1.holdState == ButtonHoldStateEnum.JUST_PRESSED then
            var1(FocusNavigationEventNameEnum.HoldToPlay, tbl1.holdProgress)
        elseif tbl1.holdState == ButtonHoldStateEnum.NOT_HELD then
            var2(FocusNavigationEventNameEnum.HoldToPlay)
        end
    end, {
        tbl1.holdState,
        tbl1.holdProgress,
        var1,
        var2
    })
    local reportExperienceLaunched = React.useCallback(function(str1: string?)
        local reportExperienceLaunched = tbl1.reportExperienceLaunched
        local selectedEntry = tbl1.selectedEntry
        local referralSource = tbl1.referralSource
        local var3 = nil
        local launchContext = tbl1.launchContext
        local selectedIndex = tbl1.selectedIndex
        if not FFlagLuaAppDemoModePlayButtonTelemetry then
            str1 = nil
        end

        reportExperienceLaunched(selectedEntry, referralSource, var3, launchContext, selectedIndex, str1)
    end, {
        tbl1.reportExperienceLaunched,
        tbl1.selectedEntry,
        tbl1.referralSource,
        tbl1.selectedIndex,
        tbl1.launchContext
    })

    local selectedNavigationUniverseId = tbl1.selectedNavigationUniverseId

    if not selectedNavigationUniverseId then
        if tbl1.selectedEntry then
            selectedNavigationUniverseId = tbl1.selectedEntry.universeId or nil
        else
            selectedNavigationUniverseId = nil
        end
    end

    if not selectedNavigationUniverseId
        or tbl1.holdState ~= ButtonHoldStateEnum.HOLDING and tbl1.holdState ~= ButtonHoldStateEnum.COMPLETED
    then
        return nil
    end

    return React.createElement(HoldToPlayLoader, {
        universeId = selectedNavigationUniverseId,
        shouldAttemptLaunch = tbl1.holdState == ButtonHoldStateEnum.COMPLETED,
        reportExperienceLaunched = reportExperienceLaunched,
        onLaunched = tbl1.cancelHold
    })
end

return HoldToPlayLauncher
