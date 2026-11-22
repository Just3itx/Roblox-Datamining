-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PageLoadTrackerParent = script:FindFirstAncestor("PageLoadTracker").Parent
local React = require(PageLoadTrackerParent.React)

local PageTrackerContext = require(script.Parent.Parent.PageTrackerContext)
local _createPageTracker = require(script.Parent.Parent.createPageTracker)
local Signal = require(script.Parent.Parent.Parent.AppCommonLib).Signal

local FFlagLuaAppEnableChatMilestones = require(PageLoadTrackerParent.SharedFlags).FFlagLuaAppEnableChatMilestones

local function createNoOpTracker()
    return {
        pageName = "",
        startTime = 0,
        lastActivityTime = 0,
        timeoutThread = nil,
        isActive = false,
        numLoads = 0,
        onCompleteSignal = Signal.new(),
        sentMilestones = {},
        start = function() end,
        logMilestone = function() end,
        stop = function() end,
        onComponentAdded = function() end,
        complete = function() end,
        sendMilestone = function() end
    }
end

local function usePageTracker()
    local var1 = React.useContext(PageTrackerContext)

    if var1 == nil then
        if FFlagLuaAppEnableChatMilestones then
            return React.useMemo(function()
                return (createNoOpTracker())
            end, {})
        end
        error("usePageTracker must be used within a PageTrackerContext.Provider")
    end

    return var1
end

return usePageTracker
