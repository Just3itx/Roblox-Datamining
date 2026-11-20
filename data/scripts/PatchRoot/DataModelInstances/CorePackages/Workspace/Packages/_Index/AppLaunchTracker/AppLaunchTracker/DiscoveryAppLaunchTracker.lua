-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppLaunchTracker = script:FindFirstAncestor("AppLaunchTracker")
local RoduxPerfTracker = require(AppLaunchTracker.RoduxPerfTracker)
local DiscoveryAppLaunchEvents = require(AppLaunchTracker.DiscoveryAppLaunchEvents)
local _AppLaunchTrackerTypes = require(AppLaunchTracker.AppLaunchTrackerTypes)

local isEnabled = require(AppLaunchTracker.Flags).FIntAppLaunchTrackerEnableHundredthsPercent >= math.random(10000)

local bool2 = game:DefineFastFlag("LuaAppShouldTrackTopThunks", false)
local num1 = game:DefineFastInt("LuaAppLaunchTrackerTimeoutSec", 60)
local str1 = game:DefineFastString(
    "LuaAppLaunchTrackerMilestones",
    "lua_app_starter_script_requires_begin,lua_app_starter_script_requires_end,startup_page_did_mount,fetch_homepage_data_begin,home_page_container_init,fetch_homepage_data_end,home_page_interactive_legacy,home_page_interactive"
)

local module = {}
module.__index = module

function module.isEnabled()
    return isEnabled
end

function module.disable()
    isEnabled = false
end

function module.new(loggingProtocol)
    local success, result = pcall(function()
        local result = ({})
        for value in (str1:gmatch("([A-Za-z0-9_]+)")) do
            result[value] = true
        end
        return result
    end)

    if not success then
        DiscoveryAppLaunchEvents.reportError(loggingProtocol, "Failed to parse FStringLuaAppLaunchTrackerMilestones")
    end

    local self = setmetatable({
        roduxTracker = RoduxPerfTracker.new(true, bool2, true),
        numTileRenders = 0,
        numTilesInit = 0,
        numFeedRenders = 0,
        numFeedItems = 0,
        totalSduiDuration = 0,
        previousMilestone = "",
        previousMilestoneTime = 0,
        loggingProtocol = loggingProtocol,
        supportedMilestones = not success and {} or result
    }, module)

    if num1 > 0 then
        task.delay(num1, function()
            if isEnabled then
                DiscoveryAppLaunchEvents.reportError(
                    loggingProtocol,
                    `Timeout after previousMilestone: {self.previousMilestone}`
                )
                self.roduxTracker:stopTracking()
                module.disable()
            end
        end)
    end

    return self
end

function module:trackTileRender()
    self.numTileRenders += 1
end

function module:trackTileInit()
    self.numTilesInit += 1
end

function module:trackFeedRender()
    self.numFeedRenders += 1
end

function module:trackNumFeedItems(numFeedItems: number)
    self.numFeedItems = numFeedItems
end

function module:trackSduiDuration(num2: number)
    self.totalSduiDuration += num2
end

function module:onMilestoneChanged(previousMilestone: string)
    if not isEnabled or not self.supportedMilestones[previousMilestone] then
        return
    end

    local previousMilestoneTime = os.clock()
    if self.previousMilestoneTime > 0 then
        local var1 = (previousMilestoneTime - self.previousMilestoneTime) * 1000
        local stats = self.roduxTracker:getStats()
        DiscoveryAppLaunchEvents.reportStatsforMilestone(
            self.loggingProtocol,
            previousMilestone,
            self.previousMilestone,
            var1,
            stats,
            self.numTilesInit,
            self.numTileRenders,
            self.numFeedItems,
            self.numFeedRenders,
            self.totalSduiDuration
        )
    end

    self.roduxTracker:clear()
    self.numFeedRenders = 0
    self.numTilesInit = 0
    self.numTileRenders = 0
    self.totalSduiDuration = 0

    self.previousMilestone = previousMilestone
    self.previousMilestoneTime = previousMilestoneTime
end

function module:stopTracking()
    self.roduxTracker:stopTracking()
    module.disable()
end

function module.createDefault(...)
    module.default = module.new(...)
end

return module
