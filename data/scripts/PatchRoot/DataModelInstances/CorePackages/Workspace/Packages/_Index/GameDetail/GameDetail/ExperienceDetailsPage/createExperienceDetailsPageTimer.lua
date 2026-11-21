-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local SduiSurfaceLoadTimeTracker = require(GameDetailParent.SduiSharedUtilities).SduiSurfaceLoadTimeTracker
local TimeToInteractiveTracker = require(GameDetailParent.TimeToInteractiveTracker).TimeToInteractiveTracker

local EDPTTIConstants = require(GameDetailParent.GameDetailTelemetry).EDPTTIConstants

local EDP_TTI_EVENT_NAME = EDPTTIConstants.EDP_TTI_EVENT_NAME
local FIRST_MEDIA_RESOLVED = EDPTTIConstants.EDP_MILESTONE.FIRST_MEDIA_RESOLVED

local function createExperienceDetailsPageTimer(str1: string, metadata)
    local loadTimerWithSurfaceLoadTime = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(str1, {
        eventName = EDP_TTI_EVENT_NAME,
        metadata = metadata,
        manualSurfaceReady = true,
        manualFunctionallyReady = true,
        startImmediately = true
    })

    local bool1 = false
    local bool2 = false
    local bool3 = false
    local var1 = nil

    local trackSurfaceReady = loadTimerWithSurfaceLoadTime.trackSurfaceReady
    local function finishSurfaceReady() -- Luacid: Inlined by compiler; 2 call sites recovered
        trackSurfaceReady(var1)
    end

    local function markPlayButtonReady()
        if bool3 then
            return
        end
        bool3 = true
        if bool2 then
            finishSurfaceReady()
        end
    end

    function loadTimerWithSurfaceLoadTime.trackSurfaceReady(tbl1)
        if not bool1 then
            bool1 = true
            local mediaFound = if tbl1 then tbl1.mediaFound else nil
            TimeToInteractiveTracker.trackMilestone(
                EDP_TTI_EVENT_NAME,
                FIRST_MEDIA_RESOLVED,
                {
                    id = if mediaFound == true then "success" elseif mediaFound == false then "failed" else "unknown"
                }
            )
        end

        if bool2 then
            return
        end
        bool2 = true
        var1 = tbl1
        if bool3 then
            finishSurfaceReady()
        end
    end

    loadTimerWithSurfaceLoadTime.markPlayButtonReady = markPlayButtonReady

    return loadTimerWithSurfaceLoadTime
end

return createExperienceDetailsPageTimer
