-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local CorePackages = game:GetService("CorePackages")
local Stats = game:GetService("Stats")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local InGameMenu = RobloxGui.Modules.InGameMenu

local default = require(CorePackages.Workspace.Packages.LoggingProtocol).default

local isNewInGameMenuEnabled = require(RobloxGui.Modules.isNewInGameMenuEnabled)
local SendAnalytics = require(InGameMenu.Utility.SendAnalytics)
local Constants = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Constants
local Constants2 = require(InGameMenu.Resources.Constants)

local var1 = require(script.Parent.Flags.GetFFlagEnableInGameMenuDurationLogger)()
local FrameRateManager = if Stats then Stats:FindFirstChild("FrameRateManager") else nil
local RenderAverage = if FrameRateManager then FrameRateManager:FindFirstChild("RenderAverage") else nil

local function getCurrentMenuVersion(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if isNewInGameMenuEnabled() then 2 else 1
end

local function getMenuAnimationTime(bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if bool1 then Constants2.ShieldOpenAnimationTweenTime else Constants2.ShieldCloseAnimationTweenTime
end

local function getMonoTimeSec(): number -- Luacid: Inlined by compiler; 7 call sites recovered
    return os.clock()
end

local function getFps() -- Luacid: Inlined by compiler; 1 call site recovered
    return if RenderAverage then 1000 / RenderAverage:GetValue() else nil
end

local game_session = HttpService:GenerateGUID()
local monoTimeSec = getMonoTimeSec()
local monoTimeSec2 = getMonoTimeSec()

local var2 = nil
local var3 = nil
local bool1 = false
local bool2 = false
local num1 = 0

local function sendEvent(arg1, tbl1)
    tbl1.fps = getFps()
    tbl1.menu_version = getCurrentMenuVersion()

    if var1 then
        arg1 ..= "_v" .. tbl1.menu_version
    end

    if not tbl1.menu_session then
        return
    end

    if var1 then
        default:logEvent(arg1, tbl1)
        return
    end
    SendAnalytics(Constants.AnalyticsInGameMenuName, arg1, tbl1)
end

local function sendMenuOpening()
    local var4 = if var1 then Constants.AnalyticsGameMenuOpenStart else Constants.AnalyticsPerfMenuOpening
    local tbl1 = {
        menu_session = var2,
        game_session = game_session,
        count = num1,
        interrupted_closing = bool1
    }

    if var1 then
        sendEvent(Constants.AnalyticsGameMenuFlowStart, tbl1)
    end

    sendEvent(var4, tbl1)
end

local function sendMenuStarted(transitionTimeTotal: number, transitionTimeNormalized) -- Luacid: Inlined by compiler; 1 call site recovered
    local var4 = if var1 then Constants.AnalyticsGameMenuOpenEnd else Constants.AnalyticsPerfMenuStarted
    sendEvent(var4, {
        menu_session = var2,
        transition_time_total = transitionTimeTotal,
        transition_time_normalized = transitionTimeNormalized
    })
end

local function sendMenuClosed(transitionTimeTotal: number, transitionTimeNormalized)
    local var4 = if var1 then Constants.AnalyticsGameMenuCloseEnd else Constants.AnalyticsPerfMenuClosed
    local tbl1 = {
        menu_session = var3,
        transition_time_total = transitionTimeTotal,
        transition_time_normalized = transitionTimeNormalized
    }
    sendEvent(var4, tbl1)

    if var1 then
        sendEvent(Constants.AnalyticsGameMenuFlowEnd, tbl1)
    end
end

local function sendMenuEnding(sessionTime, bool3: boolean?) -- Luacid: unused: defined but never referenced
    local reason = if bool3 then "leaving" else "resume"
    local var4 = if var1 then Constants.AnalyticsGameMenuCloseStart else Constants.AnalyticsPerfMenuEnding
    sendEvent(var4, { menu_session = var2, session_time = sessionTime, reason = reason, interrupted_opening = bool2 })
end

return {
    menuOpenBegin = function()
        if var2 then
            return
        end
        num1 += 1
        monoTimeSec = getMonoTimeSec()
        var2 = HttpService:GenerateGUID()
        sendMenuOpening()
        bool2 = true
        bool1 = false
    end,
    menuOpenComplete = function()
        local transitionTimeTotal = getMonoTimeSec() - monoTimeSec
        sendMenuStarted(transitionTimeTotal, transitionTimeTotal - getMenuAnimationTime(true))

        bool2 = false
    end,
    menuClose = function()
        monoTimeSec2 = getMonoTimeSec()
        local sessionTime = monoTimeSec2 - monoTimeSec
        local var4 = if var1 then Constants.AnalyticsGameMenuCloseStart else Constants.AnalyticsPerfMenuEnding
        sendEvent(var4, { menu_session = var2, session_time = sessionTime, reason = "resume", interrupted_opening = bool2 })

        var3 = var2
        var2 = nil
        bool2 = false
        bool1 = true
    end,
    menuCloseComplete = function()
        local transitionTimeTotal = getMonoTimeSec() - monoTimeSec2
        local transitionTimeNormalized = transitionTimeTotal - getMenuAnimationTime(false)

        sendMenuClosed(transitionTimeTotal, transitionTimeNormalized)
        var3 = nil
        bool1 = false
    end,
    leavingGame = function()
        local sessionTime = getMonoTimeSec() - monoTimeSec
        local var4 = if var1 then Constants.AnalyticsGameMenuCloseStart else Constants.AnalyticsPerfMenuEnding
        sendEvent(var4, { menu_session = var2, session_time = sessionTime, reason = "leaving", interrupted_opening = bool2 })

        var2 = nil
    end,
    getFps = getFps
}
