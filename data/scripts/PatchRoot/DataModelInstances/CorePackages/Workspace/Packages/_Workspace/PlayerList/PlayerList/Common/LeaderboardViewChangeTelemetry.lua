-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local throttlingPercentage = game:DefineFastInt("PlayerListReskinViewChangeTelemetryThrottleHundredthsPercent", 10000)

local lastUpdated = { 2026, 8, 13 }

local config = {
    eventName = "coreui_playerlist_leaderboard_view_change",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = lastUpdated,
    description = "Fired when the leaderboard is shown, hidden, the user switches tabs, a Friends/Global tab fails to load, or the user retries after a load error."
}

local config2 = {
    eventName = "coreui_playerlist_leaderboard_view_change",
    backends = { "RobloxTelemetryCounter" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = lastUpdated,
    description = "Counter for leaderboard show / hide / tab-switch / load-error / retry-error view changes."
}

local var1 = nil
local bool1 = false
local bool2 = false

local function log(action: string, tab: string?)
    local standardizedFields = {
        "addPlaceId",
        "addUniverseId",
        "addSessionInfo",
        "addSessionId",
        "addPlaySessionId"
    }
    local customFields = { action = action }

    if tab ~= nil then
        customFields.tab = tab
    end

    local tbl4 = { standardizedFields = standardizedFields, customFields = customFields }
    TelemetryService:LogEvent(config, tbl4)
    TelemetryService:LogCounter(config2, tbl4, 1)
end

return {
    logSwitchTab = function(tab: string)
        var1 = tab
        bool1 = true
        log("switch_tab", tab)
    end,
    logVisibility = function(bool3: boolean, bool4: boolean?)
        if bool3 and bool4 and not bool1 then
            bool2 = true
            return
        end
        bool2 = false
        log(if bool3 then "show_leaderboard" else "hide_leaderboard", var1)
    end,
    logLoadError = function(tab: string)
        log("load_error", tab)
    end,
    logRetryError = function(tab: string)
        log("retry_error", tab)
    end,
    setCurrentTab = function(str1: string?)
        var1 = str1
        bool1 = true
        if bool2 then
            bool2 = false
            log("show_leaderboard", var1)
        end
    end,
    clearCurrentTab = function()
        var1 = nil
        bool1 = false
    end,
    _setServicesForTesting = function(arg1)
        TelemetryService = arg1
        var1 = nil
        bool1 = false
        bool2 = false
    end
}
