-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local HomePageLoadTrackerParent = script:FindFirstAncestor("HomePageLoadTracker").Parent

local default = require(HomePageLoadTrackerParent.LoggingProtocol).default
local SharedFlags = require(HomePageLoadTrackerParent.SharedFlags)
local TimeToInteractiveTracker = require(HomePageLoadTrackerParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local Milestone = TimeToInteractiveTracker.Milestone

local FFlagLuaAppHomePagePLTDualLog = SharedFlags.FFlagLuaAppHomePagePLTDualLog
local FIntHomePagePLTSampleRate = SharedFlags.FIntHomePagePLTSampleRate

local bool1 = false

local bool2 = false
local bool3 = false
local bool4 = false

local var1 = nil

local module = {}

function module.beginVisit()
    local launchType = if bool1 then "warm" else "cold"
    bool1 = true
    var1 = launchType

    bool2 = false
    bool3 = false
    bool4 = false

    default:logEvent("home_page_load_begin", { launch_type = launchType })

    if not FFlagLuaAppHomePagePLTDualLog then
        return
    end
    TimeToInteractiveTracker.trackStart("HomePage_PLT")
    TimeToInteractiveTracker.updateMetadata("HomePage_PLT", { coldStart = launchType == "cold", page = "Home" })
end

function module.logRenderStarted()
    if bool2 then
        return
    end
    bool2 = true
    default:logEvent("home_page_render_started", { launch_type = var1 })
    if FFlagLuaAppHomePagePLTDualLog then
        TimeToInteractiveTracker.trackMilestone("HomePage_PLT", Milestone.RenderStarted)
    end
end

function module.logSurfaceMounted()
    if bool3 then
        return
    end
    bool3 = true
    default:logEvent("home_page_surface_mounted", { launch_type = var1 })
    if FFlagLuaAppHomePagePLTDualLog then
        TimeToInteractiveTracker.trackMilestone("HomePage_PLT", Milestone.SurfaceMounted)
    end
end

function module.logFunctionallyReadyAndEnd()
    if bool4 then
        return
    end
    bool4 = true
    default:logEvent("home_page_functionally_ready", { launch_type = var1 })
    default:logEvent("home_page_load_end", { launch_type = var1 })
    if FFlagLuaAppHomePagePLTDualLog then
        TimeToInteractiveTracker.trackMilestone("HomePage_PLT", Milestone.FunctionallyReady)
        TimeToInteractiveTracker.trackEnd("HomePage_PLT", { samplingRateOverride = FIntHomePagePLTSampleRate })
    end
end

function module.isWarmVisit(): boolean
    return var1 == "warm"
end

return module
