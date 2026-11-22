-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local _ProgressLoadingParent = ProgressLoading.Parent

local _Types = require(script.Parent.Types)
local Constants = require(script.Parent.Constants)
local tryMilestoneOperation = require(script.Parent.tryMilestoneOperation)
local FIntLoadingScreenMilestonesSampleRate = require(ProgressLoading.Flags.FIntLoadingScreenMilestonesSampleRate)

local function getAddedWait(arg1)
    local var1 = arg1.getEvents(false)[Constants.EVENT_NAME]
    local deltaMs = nil
    local deltaMs2 = nil
    if var1 and var1.milestones then
        for _, value in var1.milestones do
            local name = value.name
            if name == Constants.Milestone.DismissRequested and deltaMs == nil then
                deltaMs = value.deltaMs
            elseif name == Constants.Milestone.DismissStarted then
                deltaMs2 = value.deltaMs
            end
        end
    end
    return if deltaMs and deltaMs2 and deltaMs <= deltaMs2 then deltaMs2 - deltaMs else nil
end

local function getHoldGateHit(arg1): boolean?
    local var1 = arg1.getEvents(false)[Constants.EVENT_NAME]
    local deltaMs = nil
    local deltaMs2 = nil
    if var1 and var1.milestones then
        for _, value in var1.milestones do
            local name = value.name

            if name == Constants.Milestone.DismissRequested and value.id == Constants.DismissSource.NormalReady and deltaMs == nil then
                deltaMs = value.deltaMs
            elseif name == Constants.Milestone.DismissGateReleased and deltaMs2 == nil then
                deltaMs2 = value.deltaMs
            end
        end
    end
    return if deltaMs == nil or deltaMs2 == nil then nil else deltaMs < deltaMs2
end

return {
    startMilestoneTracker = function(arg1, arg2)
        return tryMilestoneOperation(function()
            arg1.trackStart(Constants.EVENT_NAME)
            arg1.updateMetadata(
                Constants.EVENT_NAME,
                {
                    category = arg2.category,
                    page = arg2.page,
                    subcategory = arg2.subcategory
                }
            )
        end)
    end,
    recordMilestone = function(arg1, str1: string, id)
        return tryMilestoneOperation(function()
            arg1.trackMilestone(Constants.EVENT_NAME, str1, id and { id = id } or nil)
        end)
    end,
    completeMilestoneTracker = function(arg1, bool1: boolean, dismissSource, bool2: boolean?)
        local addedWait = nil
        local holdGateHit = nil
        return tryMilestoneOperation(function()
            addedWait = if bool1 then getAddedWait(arg1) else nil
            holdGateHit = if bool2 then getHoldGateHit(arg1) else nil
            if dismissSource then
                arg1.updateMetadata(Constants.EVENT_NAME, { dismissSource = dismissSource })
            end
            arg1.trackEnd(Constants.EVENT_NAME, { samplingRateOverride = FIntLoadingScreenMilestonesSampleRate })
        end), addedWait, holdGateHit
    end,
    discardMilestoneTracker = function(arg1)
        return tryMilestoneOperation(function()
            arg1.destroyEvent(Constants.EVENT_NAME)
        end)
    end
}
