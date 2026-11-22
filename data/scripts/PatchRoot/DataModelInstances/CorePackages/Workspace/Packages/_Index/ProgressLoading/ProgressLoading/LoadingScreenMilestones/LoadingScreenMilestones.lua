-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local Constants = require(script.Parent.Constants)
local _Types = require(script.Parent.Types)
local LoadingMilestoneTelemetry = require(script.Parent.LoadingMilestoneTelemetry)
local LoadingMilestoneTracker = require(script.Parent.LoadingMilestoneTracker)
local tryMilestoneOperation = require(script.Parent.tryMilestoneOperation)

local AbortReason = Constants.AbortReason
local Outcome = Constants.Outcome
local Milestone = Constants.Milestone

local var1 = nil

local function getTreatmentSubcategory(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    return (if arg1.host == Constants.Host.DeferredJoin then "DeferredJoin_" else "") .. (if arg1.reducedMotion then "ReducedMotion_" else "") .. (if arg1.holdEnabled then "HoldOn" else "HoldOff")
end

return {
    start = function(arg1): {abort: (any) -> (), complete: () -> (), contentVisible: (any) -> (), dismissRequested: (any) -> (), record: (any) -> ()}?
        if var1 then
            var1.abort(AbortReason.Replaced)
        end

        local var2 = nil
        local var3 = nil
        local var4 = nil
        local tbl1 = ({})
        local subcategory = getTreatmentSubcategory(arg1)
        local page = arg1.page
        local tbl2 = {
            category = Constants.CATEGORY,
            page = page,
            subcategory = subcategory
        }

        local function discard() -- Luacid: Inlined by compiler; 1 call site recovered
            local var5 = var2
            var2 = nil
            if var5 then
                return LoadingMilestoneTracker.discardMilestoneTracker(var5)
            end
            return true
        end

        local function reportOutcome(arg2) -- Luacid: Inlined by compiler; 6 call sites recovered
            LoadingMilestoneTelemetry.countMilestonesOutcome(tbl2, arg2)
        end

        local function record(str1: string, arg2) -- Luacid: unused: defined but never referenced
            local var5 = if arg2 then str1 .. "/" .. arg2 else str1

            if var1 ~= var3 or tbl1[var5] then
                return
            end
            tbl1[var5] = true
            local var6 = var2
            if not var6 or LoadingMilestoneTracker.recordMilestone(var6, str1, arg2) then
                return
            end

            var1 = nil
            local var7 = var2
            var2 = nil
            if var7 then
                LoadingMilestoneTracker.discardMilestoneTracker(var7)
            end

            reportOutcome(Outcome.InstrumentationError)
        end
        var3 = {
            dismissRequested = function(arg2)
                if var1 == var3 then
                    var4 = var4 or arg2
                end
                local dismissRequested2 = Milestone.DismissRequested
                local var5 = if arg2 then dismissRequested2 .. "/" .. arg2 else dismissRequested2

                if var1 ~= var3 then
                    return
                end

                if tbl1[var5] then
                    return
                end
                tbl1[var5] = true
                local var6 = var2
                if not var6 or LoadingMilestoneTracker.recordMilestone(var6, dismissRequested2, arg2) then
                    return
                end

                var1 = nil
                local var7 = var2
                var2 = nil
                if var7 then
                    LoadingMilestoneTracker.discardMilestoneTracker(var7)
                end

                reportOutcome(Outcome.InstrumentationError)
            end,
            contentVisible = function(arg2)
                if not tbl1[Milestone.ScreenVisible] or tbl1[Milestone.DismissStarted] then
                    return
                end
                local contentVisible2 = Milestone.ContentVisible
                local var5 = if arg2 then contentVisible2 .. "/" .. arg2 else contentVisible2

                if var1 ~= var3 then
                    return
                end

                if tbl1[var5] then
                    return
                end
                tbl1[var5] = true
                local var6 = var2
                if not var6 or LoadingMilestoneTracker.recordMilestone(var6, contentVisible2, arg2) then
                    return
                end

                var1 = nil
                local var7 = var2
                var2 = nil
                if var7 then
                    LoadingMilestoneTracker.discardMilestoneTracker(var7)
                end

                reportOutcome(Outcome.InstrumentationError)
            end,
            record = function(arg2)
                if var1 ~= var3 then
                    return
                end

                if tbl1[arg2] then
                    return
                end
                tbl1[arg2] = true
                local var5 = var2
                if not var5 or LoadingMilestoneTracker.recordMilestone(var5, arg2, nil) then
                    return
                end

                var1 = nil
                local var6 = var2
                var2 = nil
                if var6 then
                    LoadingMilestoneTracker.discardMilestoneTracker(var6)
                end

                reportOutcome(Outcome.InstrumentationError)
            end,
            complete = function()
                if var1 ~= var3 then
                    return
                end
                var1 = nil
                local completed = Outcome.Completed
                local var5 = var2
                if var5 then
                    local completeMilestoneTracker = LoadingMilestoneTracker.completeMilestoneTracker
                    local bool1 = not (var4 == nil) and tbl1[Milestone.DismissStarted] == true
                    local var6 = var4
                    local bool2 = subcategory == "HoldOn" and var4 == Constants.DismissSource.NormalReady
                    local var7, var8, var9 = completeMilestoneTracker(var5, bool1, var6, bool2)

                    if var7 and var8 ~= nil and var4 then
                        var7 = LoadingMilestoneTelemetry.reportAddedWait(tbl2, var8, var4)
                    end
                    if var7 and tbl1[Milestone.ScreenVisible] and tbl1[Milestone.DismissStarted] then
                        var7 = LoadingMilestoneTelemetry.reportContentVisibility(
                            tbl2,
                            tbl1[Milestone.ContentVisible .. "/" .. Constants.ContentId.Title] == true,
                            tbl1[Milestone.ContentVisible .. "/" .. Constants.ContentId.Creator] == true,
                            tbl1[Milestone.ContentVisible .. "/" .. Constants.ContentId.Thumbnail] == true
                        )
                    end
                    if var7 and var9 ~= nil then
                        var7 = LoadingMilestoneTelemetry.reportHoldGateHit(tbl2, var9)
                    end
                    if not var7 then
                        local var10 = var2
                        var2 = nil
                        if var10 then
                            LoadingMilestoneTracker.discardMilestoneTracker(var10)
                        end

                        completed = Outcome.InstrumentationError
                    end
                end
                var2 = nil
                reportOutcome(completed)
            end,
            abort = function(arg2)
                if var1 ~= var3 then
                    return
                end
                var1 = nil

                if not discard() then
                    arg2 = Outcome.InstrumentationError
                end

                reportOutcome(arg2)
            end
        }
        var1 = var3

        local bool1 = false
        if tryMilestoneOperation(function()
            tbl2 = LoadingMilestoneTelemetry.getMilestoneSessionMetadata(subcategory, page)
            if not LoadingMilestoneTelemetry.countMilestonesStarted(tbl2) then
                return
            end

            local timeToInteractiveTracker = require(ProgressLoadingParent.TimeToInteractiveTracker).TimeToInteractiveTracker
            var2 = timeToInteractiveTracker
            bool1 = LoadingMilestoneTracker.startMilestoneTracker(timeToInteractiveTracker, tbl2)
        end) and bool1 then
            return var3
        end

        var3.abort(AbortReason.InitializationFailed)
        return nil
    end,
    AbortReason = AbortReason,
    Page = Constants.Page,
    Milestone = Milestone,
    DismissSource = Constants.DismissSource
}
