-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console
local Set = require(scriptParentParent.LuauPolyfill).Set

local __DEV__ = ReactGlobals.__DEV__
local __YOLO__ = ReactGlobals.__YOLO__

local module = {}

local _Shared = require(scriptParentParent.Shared)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local Scheduler = require(scriptParentParent.Scheduler)

local _ReactFiberSuspenseComponentNew = require(script.Parent["ReactFiberSuspenseComponent.new"])

local ReactFiberStackNew = require(script.Parent["ReactFiberStack.new"])

local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags

local enableDebugTracing = ReactFeatureFlags.enableDebugTracing
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler
local skipUnmountedBoundaries = ReactFeatureFlags.skipUnmountedBoundaries
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects
local deletedTreeCleanUpLevel = ReactFeatureFlags.deletedTreeCleanUpLevel
local enableNewTreeCleanupPath = ReactFeatureFlags.enableNewTreeCleanupPath
local Shared = require(scriptParentParent.Shared)

local describeError = require(scriptParentParent.Shared).describeError
local ReactSharedInternals = Shared.ReactSharedInternals
local invariant = Shared.invariant

local SchedulerWithReactIntegrationNew = require(script.Parent["SchedulerWithReactIntegration.new"])
local scheduleCallback = SchedulerWithReactIntegrationNew.scheduleCallback
local cancelCallback = SchedulerWithReactIntegrationNew.cancelCallback
local getCurrentPriorityLevel = SchedulerWithReactIntegrationNew.getCurrentPriorityLevel
local runWithPriority = SchedulerWithReactIntegrationNew.runWithPriority
local shouldYield = SchedulerWithReactIntegrationNew.shouldYield
local requestPaint = SchedulerWithReactIntegrationNew.requestPaint
local now = SchedulerWithReactIntegrationNew.now
local NoPriority = SchedulerWithReactIntegrationNew.NoPriority
local ImmediatePriority = SchedulerWithReactIntegrationNew.ImmediatePriority
local UserBlockingPriority = SchedulerWithReactIntegrationNew.UserBlockingPriority
local NormalPriority = SchedulerWithReactIntegrationNew.NormalPriority
local flushSyncCallbackQueue = SchedulerWithReactIntegrationNew.flushSyncCallbackQueue
local scheduleSyncCallback = SchedulerWithReactIntegrationNew.scheduleSyncCallback

local DebugTracing = require(script.Parent.DebugTracing)

local SchedulingProfiler = require(script.Parent.SchedulingProfiler)

local tracing = require(scriptParentParent.Scheduler).tracing

local __interactionsRef = tracing.__interactionsRef
local __subscriberRef = tracing.__subscriberRef

local ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local ReactFiberNew = require(script.Parent["ReactFiber.new"])

local ReactTypeOfMode = require(script.Parent.ReactTypeOfMode)

local ReactWorkTags = require(script.Parent.ReactWorkTags)

local LegacyRoot = require(script.Parent.ReactRootTags).LegacyRoot
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)

local SyncLane = ReactFiberLane.SyncLane
local SyncBatchedLane = ReactFiberLane.SyncBatchedLane
local NoTimestamp = ReactFiberLane.NoTimestamp
local findUpdateLane = ReactFiberLane.findUpdateLane
local findTransitionLane = ReactFiberLane.findTransitionLane
local findRetryLane = ReactFiberLane.findRetryLane
local includesSomeLane = ReactFiberLane.includesSomeLane
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes
local mergeLanes = ReactFiberLane.mergeLanes
local removeLanes = ReactFiberLane.removeLanes
local pickArbitraryLane = ReactFiberLane.pickArbitraryLane
local hasDiscreteLanes = ReactFiberLane.hasDiscreteLanes
local includesNonIdleWork = ReactFiberLane.includesNonIdleWork
local includesOnlyRetries = ReactFiberLane.includesOnlyRetries
local includesOnlyTransitions = ReactFiberLane.includesOnlyTransitions
local getNextLanes = ReactFiberLane.getNextLanes
local returnNextLanesPriority = ReactFiberLane.returnNextLanesPriority
local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority
local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority
local markStarvedLanesAsExpired = ReactFiberLane.markStarvedLanesAsExpired

local getLanesToRetrySynchronouslyOnError = ReactFiberLane.getLanesToRetrySynchronouslyOnError
local markRootUpdated = ReactFiberLane.markRootUpdated
local markRootPinged = ReactFiberLane.markRootPinged
local markRootExpired = ReactFiberLane.markRootExpired
local markDiscreteUpdatesExpired = ReactFiberLane.markDiscreteUpdatesExpired
local markRootFinished = ReactFiberLane.markRootFinished
local schedulerPriorityToLanePriority = ReactFiberLane.schedulerPriorityToLanePriority
local lanePriorityToSchedulerPriority = ReactFiberLane.lanePriorityToSchedulerPriority
local ReactFiberTransition = require(script.Parent.ReactFiberTransition)

local ReactFiberUnwindWorkNew = require(script.Parent["ReactFiberUnwindWork.new"])
local unwindWork = ReactFiberUnwindWorkNew.unwindWork
local unwindInterruptedWork = ReactFiberUnwindWorkNew.unwindInterruptedWork
local ReactFiberThrowNew = require(script.Parent["ReactFiberThrow.new"])
local throwException = ReactFiberThrowNew.throwException
local createRootErrorUpdate = ReactFiberThrowNew.createRootErrorUpdate
local createClassErrorUpdate = ReactFiberThrowNew.createClassErrorUpdate
local ReactFiberCommitWorkNew = require(script.Parent["ReactFiberCommitWork.new"])

local commitBeforeMutationLifeCycles = ReactFiberCommitWorkNew.commitBeforeMutationLifeCycles
local commitPlacement = ReactFiberCommitWorkNew.commitPlacement
local commitWork = ReactFiberCommitWorkNew.commitWork
local commitDeletion = ReactFiberCommitWorkNew.commitDeletion
local commitPassiveUnmount = ReactFiberCommitWorkNew.commitPassiveUnmount

local commitPassiveUnmountInsideDeletedTree = ReactFiberCommitWorkNew.commitPassiveUnmountInsideDeletedTree
local commitPassiveMount = ReactFiberCommitWorkNew.commitPassiveMount
local commitDetachRef = ReactFiberCommitWorkNew.commitDetachRef

local invokeLayoutEffectMountInDEV = ReactFiberCommitWorkNew.invokeLayoutEffectMountInDEV
local invokePassiveEffectMountInDEV = ReactFiberCommitWorkNew.invokePassiveEffectMountInDEV
local invokeLayoutEffectUnmountInDEV = ReactFiberCommitWorkNew.invokeLayoutEffectUnmountInDEV

local invokePassiveEffectUnmountInDEV = ReactFiberCommitWorkNew.invokePassiveEffectUnmountInDEV
local recursivelyCommitLayoutEffects = ReactFiberCommitWorkNew.recursivelyCommitLayoutEffects

local Promise = require(scriptParentParent.Promise)

local enqueueUpdate = require(script.Parent["ReactUpdateQueue.new"]).enqueueUpdate

local resetContextDependencies = require(script.Parent["ReactFiberNewContext.new"]).resetContextDependencies

local RobloxReactProfiling = require(script.Parent.RobloxReactProfiling)

local var1 = nil

local tbl1 = {
    resetHooksAfterThrowRef = nil,
    ContextOnlyDispatcherRef = nil,
    getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = nil,
    originalBeginWorkRef = nil,
    completeWorkRef = nil
}

local function beginWork(arg1, arg2, arg3)
    if not tbl1.originalBeginWorkRef then
        tbl1.originalBeginWorkRef = require(script.Parent["ReactFiberBeginWork.new"]).beginWork
    end
    return tbl1.originalBeginWorkRef(arg1, arg2, arg3)
end

local function func2(alternate, arg1, subtreeRenderLanes) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not tbl1.completeWorkRef then
        tbl1.completeWorkRef = require(script.Parent["ReactFiberCompleteWork.new"]).completeWork
    end
    return tbl1.completeWorkRef(alternate, arg1, subtreeRenderLanes)
end

local ReactFiberHooksNew = nil

local function initReactFiberHooks() -- Luacid: Inlined by compiler; 8 call sites recovered
    ReactFiberHooksNew = require(script.Parent["ReactFiberHooks.new"])
    tbl1.resetHooksAfterThrowRef = ReactFiberHooksNew.resetHooksAfterThrow
    tbl1.ContextOnlyDispatcherRef = ReactFiberHooksNew.ContextOnlyDispatcher
    tbl1.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef = ReactFiberHooksNew.getIsUpdatingOpaqueValueInRenderPhaseInDEV
end

local function func3() -- Luacid: Inlined by compiler; 2 call sites recovered
    if not tbl1.resetHooksAfterThrowRef then
        initReactFiberHooks()
    end

    return tbl1.resetHooksAfterThrowRef()
end

local function func4() -- Luacid: Inlined by compiler; 2 call sites recovered
    if not tbl1.ContextOnlyDispatcherRef then
        initReactFiberHooks()
    end

    return tbl1.ContextOnlyDispatcherRef
end

local function _() -- Luacid: unused: defined but never referenced
    if not tbl1.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef then
        initReactFiberHooks()
    end

    return tbl1.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef()
end

local createCapturedValue = require(script.Parent.ReactCapturedValue).createCapturedValue
local push = ReactFiberStackNew.push
local pop = ReactFiberStackNew.pop
local createCursor = ReactFiberStackNew.createCursor

local ReactProfilerTimerNew = require(script.Parent["ReactProfilerTimer.new"])

local getComponentName = require(scriptParentParent.Shared).getComponentName
local ReactStrictModeWarningsNew = require(script.Parent["ReactStrictModeWarnings.new"])
local ReactCurrentFiber = require(script.Parent.ReactCurrentFiber)

local current = ReactCurrentFiber.current
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber
local ReactErrorUtils = require(scriptParentParent.Shared).ReactErrorUtils
local invokeGuardedCallback = ReactErrorUtils.invokeGuardedCallback
local hasCaughtError = ReactErrorUtils.hasCaughtError
local clearCaughtError = ReactErrorUtils.clearCaughtError

local onCommitRoot = require(script.Parent["ReactFiberDevToolsHook.new"]).onCommitRoot
local onCommitRoot2 = require(script.Parent.ReactTestSelectors).onCommitRoot

local enqueueTask = require(scriptParentParent.Shared).enqueueTask
local doesFiberContain = require(script.Parent.ReactFiberTreeReflection).doesFiberContain

local ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher
local ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner
local IsSomeRendererActing = ReactSharedInternals.IsSomeRendererActing
local var2 = nil

local tbl2 = {}

local Placement = ReactFiberFlags.Placement
local Update = ReactFiberFlags.Update
local Ref = ReactFiberFlags.Ref
local HostUpdate = ReactFiberFlags.HostUpdate
tbl2.MutationWorkFlags = bit32.bor(Placement, Update, Ref, HostUpdate)

module.NoContext = 0
module.RetryAfterError = 64

local getExecutionContext = 0

local getWorkInProgressRoot = nil

local var4 = nil

local NoLanes = ReactFiberLane.NoLanes

module.subtreeRenderLanes = ReactFiberLane.NoLanes
local cursor = createCursor(ReactFiberLane.NoLanes)

local num2 = 0

local var5 = nil

local NoLanes2 = ReactFiberLane.NoLanes

local ReactFiberWorkInProgress = require(script.Parent.ReactFiberWorkInProgress)

local workInProgressRootSkippedLanes = ReactFiberWorkInProgress.workInProgressRootSkippedLanes

local NoLanes3 = ReactFiberLane.NoLanes

local NoLanes4 = ReactFiberLane.NoLanes

local var6 = nil

local num3 = 0

local huge = math.huge

local var7 = nil

local function resetRenderTimer() -- Luacid: Inlined by compiler; 10 call sites recovered
    huge = now() + 500
end

function module.getRenderTargetTime()
    return huge
end

local bool1 = false
local var8 = nil
local var9 = nil

local bool2 = false
local var10 = nil
local var11 = NoPriority
local NoLanes5 = ReactFiberLane.NoLanes

local var12 = nil

local num4 = 0
local var13 = nil

local num5 = 0

local var14 = nil

local var15 = NoTimestamp
local NoLanes6 = ReactFiberLane.NoLanes
local NoLanes7 = ReactFiberLane.NoLanes

local var16 = nil
local bool3 = false

function module.getWorkInProgressRoot()
    return getWorkInProgressRoot
end

function module.requestEventTime()
    if bit32.band(getExecutionContext, 0x30) ~= 0 then
        return now()
    end

    if var15 == NoTimestamp then
        var15 = now()
    end

    return var15
end

function module.requestUpdateLane(arg1)
    local mode = arg1.mode
    if bit32.band(mode, ReactTypeOfMode.BlockingMode) == ReactTypeOfMode.NoMode then
        return SyncLane
    end

    if bit32.band(mode, ReactTypeOfMode.ConcurrentMode) == ReactTypeOfMode.NoMode then
        return if getCurrentPriorityLevel() == ImmediatePriority then SyncLane else SyncBatchedLane
    end
    if not ReactFeatureFlags.deferRenderPhaseUpdateToNextBatch
        and bit32.band(getExecutionContext, 0x10) ~= 0
        and NoLanes ~= ReactFiberLane.NoLanes
    then
        return pickArbitraryLane(NoLanes)
    end

    if NoLanes6 == ReactFiberLane.NoLanes then
        NoLanes6 = NoLanes2
    end

    if ReactFiberTransition.requestCurrentTransition() ~= ReactFiberTransition.NoTransition then
        if NoLanes7 ~= ReactFiberLane.NoLanes then
            if var6 ~= nil then
                NoLanes7 = var6.pendingLanes
            else
                NoLanes7 = ReactFiberLane.NoLanes
            end
        end
        return findTransitionLane(NoLanes6, NoLanes7)
    end

    local currentPriorityLevel = getCurrentPriorityLevel()

    if bit32.band(getExecutionContext, 4) ~= 0 and currentPriorityLevel == UserBlockingPriority then
        return (findUpdateLane(ReactFiberLane.InputDiscreteLanePriority, NoLanes6))
    end
    local var17 = schedulerPriorityToLanePriority(currentPriorityLevel)

    if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        local currentUpdateLanePriority = getCurrentUpdateLanePriority()

        if var17 ~= currentUpdateLanePriority and currentUpdateLanePriority ~= ReactFiberLane.NoLanePriority and __DEV__ then
            console.error(
                "Expected current scheduler lane priority %s to match current update lane priority %s",
                tostring(var17),
                tostring(currentUpdateLanePriority)
            )
        end
    end

    return (findUpdateLane(var17, NoLanes6))
end

function requestRetryLane(arg1)
    local mode = arg1.mode
    if bit32.band(mode, ReactTypeOfMode.BlockingMode) == ReactTypeOfMode.NoMode then
        return SyncLane
    end

    if bit32.band(mode, ReactTypeOfMode.ConcurrentMode) == ReactTypeOfMode.NoMode then
        return if getCurrentPriorityLevel() == ImmediatePriority then SyncLane else SyncBatchedLane
    end

    if NoLanes6 == ReactFiberLane.NoLanes then
        NoLanes6 = NoLanes2
    end
    return findRetryLane(NoLanes6)
end

function module.scheduleUpdateOnFiber(arg1, arg2, num6: number)
    tbl2.checkForNestedUpdates()

    local var17 = tbl2.markUpdateLaneFromFiberToRoot(arg1, arg2)
    if var17 == nil then
        return nil
    end

    markRootUpdated(var17, arg2, num6)

    if var17 == getWorkInProgressRoot then
        tbl2.warnAboutRenderPhaseUpdatesInDEV(arg1)

        if ReactFeatureFlags.deferRenderPhaseUpdateToNextBatch or bit32.band(getExecutionContext, 0x10) == 0 then
            NoLanes3 = mergeLanes(NoLanes3, arg2)
        end
        if num2 == 4 then
            tbl2.markRootSuspended(var17, NoLanes)
        end
    end

    local currentPriorityLevel = getCurrentPriorityLevel()

    if arg2 ~= SyncLane then
        if bit32.band(getExecutionContext, 4) ~= 0
            and (currentPriorityLevel == UserBlockingPriority or currentPriorityLevel == ImmediatePriority)
        then
            if var12 == nil then
                var12 = Set.new({ var17 })
            else
                var12:add(var17)
            end
        end

        var1(var17, num6)
        tbl2.schedulePendingInteractions(var17, arg2)
    elseif bit32.band(getExecutionContext, 8) ~= 0 and bit32.band(getExecutionContext, 0x30) == 0 then
        tbl2.schedulePendingInteractions(var17, arg2)

        tbl2.performSyncWorkOnRoot(var17)
    else
        var1(var17, num6)
        tbl2.schedulePendingInteractions(var17, arg2)
        if getExecutionContext == 0 then
            resetRenderTimer()
            flushSyncCallbackQueue()
        end
    end

    var6 = var17
    return var17
end

function tbl2.markUpdateLaneFromFiberToRoot(arg1, arg2)
    arg1.lanes = mergeLanes(arg1.lanes, arg2)
    local alternate = arg1.alternate
    if alternate ~= nil then
        alternate.lanes = mergeLanes(alternate.lanes, arg2)
    end
    if __DEV__
        and alternate == nil
        and bit32.band(arg1.flags, bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Hydrating)) ~= ReactFiberFlags.NoFlags
    then
        tbl2.warnAboutUpdateOnNotYetMountedFiberInDEV(arg1)
    end

    local _return = arg1.return_
    local var17 = arg1

    while _return ~= nil do
        _return.childLanes = mergeLanes(_return.childLanes, arg2)
        local alternate2 = _return.alternate
        if alternate2 ~= nil then
            alternate2.childLanes = mergeLanes(alternate2.childLanes, arg2)
        elseif __DEV__
            and bit32.band(_return.flags, bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Hydrating)) ~= ReactFiberFlags.NoFlags
        then
            tbl2.warnAboutUpdateOnNotYetMountedFiberInDEV(var17)
        end

        local _return2 = _return.return_
        arg1 = _return
        _return = _return2
    end
    return if arg1.tag == ReactWorkTags.HostRoot then arg1.stateNode else nil
end

var1 = function(arg1, num6: number)
    local callbackNode = arg1.callbackNode

    markStarvedLanesAsExpired(arg1, num6)
    local var17 = if arg1 == getWorkInProgressRoot then NoLanes else ReactFiberLane.NoLanes
    local nextLanes = getNextLanes(arg1, var17)

    local callbackPriority = returnNextLanesPriority()

    if nextLanes == ReactFiberLane.NoLanes then
        if callbackNode ~= nil then
            cancelCallback(callbackNode)
            arg1.callbackNode = nil
            arg1.callbackPriority = ReactFiberLane.NoLanePriority
        end
        return
    end

    if callbackNode ~= nil then
        if arg1.callbackPriority == callbackPriority then
            return
        end

        cancelCallback(callbackNode)
    end

    local var19

    if callbackPriority == ReactFiberLane.SyncLanePriority then
        var19 = scheduleSyncCallback(function()
            local var20 = RobloxReactProfiling.profileRootBeforeUnitOfWork(arg1)
            local var21 = tbl2.performSyncWorkOnRoot(arg1)
            RobloxReactProfiling.profileRootAfterYielding(var20)
            return var21
        end)
    elseif callbackPriority == ReactFiberLane.SyncBatchedLanePriority then
        var19 = scheduleCallback(ImmediatePriority, function()
            local var20 = RobloxReactProfiling.profileRootBeforeUnitOfWork(arg1)
            local var21 = tbl2.performSyncWorkOnRoot(arg1)
            RobloxReactProfiling.profileRootAfterYielding(var20)
            return var21
        end)
    else
        local var20 = lanePriorityToSchedulerPriority(callbackPriority)
        var19 = scheduleCallback(var20, function()
            local var21 = RobloxReactProfiling.profileRootBeforeUnitOfWork(arg1)
            local var22 = tbl2.performConcurrentWorkOnRoot(arg1)
            RobloxReactProfiling.profileRootAfterYielding(var21)
            return var22
        end)
    end

    arg1.callbackPriority = callbackPriority
    arg1.callbackNode = var19
end

function tbl2.performConcurrentWorkOnRoot(arg1)
    var15 = NoTimestamp
    NoLanes6 = ReactFiberLane.NoLanes
    NoLanes7 = ReactFiberLane.NoLanes

    invariant(bit32.band(getExecutionContext, 0x30) == 0, "Should not already be working.")

    local callbackNode = arg1.callbackNode
    if module.flushPassiveEffects() and arg1.callbackNode ~= callbackNode then
        return nil
    end

    local var17 = getNextLanes
    local var18 = if arg1 == getWorkInProgressRoot then NoLanes else ReactFiberLane.NoLanes
    local var19 = var17(arg1, var18)

    if var19 == ReactFiberLane.NoLanes then
        return nil
    end

    local var20 = tbl2.renderRootConcurrent(arg1, var19)

    if includesSomeLane(NoLanes2, NoLanes3) then
        tbl2.prepareFreshStack(arg1, ReactFiberLane.NoLanes)
    elseif var20 ~= 0 then
        if var20 == 2 then
            getExecutionContext = bit32.bor(getExecutionContext, 0x40)

            if arg1.hydrate then
                arg1.hydrate = false
                ReactFiberHostConfig.clearContainer(arg1.containerInfo)
            end

            var19 = getLanesToRetrySynchronouslyOnError(arg1)
            if var19 ~= ReactFiberLane.NoLanes then
                var20 = tbl2.renderRootSync(arg1, var19)
            end
        end

        if var20 == 1 then
            local var21 = var5
            tbl2.prepareFreshStack(arg1, ReactFiberLane.NoLanes)
            tbl2.markRootSuspended(arg1, var19)
            var1(arg1, now())
            error(var21)
        end

        arg1.finishedWork = arg1.current.alternate
        arg1.finishedLanes = var19
        tbl2.finishConcurrentRender(arg1, var20, var19)
    end

    var1(arg1, now())
    return if arg1.callbackNode == callbackNode then function()
        local var21 = RobloxReactProfiling.profileRootBeforeUnitOfWork(arg1)
        local var22 = tbl2.performConcurrentWorkOnRoot(arg1)
        RobloxReactProfiling.profileRootAfterYielding(var21)
        return var22
    end else nil
end

local num6 = 0
local bool4 = false

function shouldForceFlushFallbacksInDEV()
    return __DEV__ and num6 > 0
end

function tbl2.finishConcurrentRender(arg1, arg2, arg3)
    if arg2 == 0 or arg2 == 1 then
        invariant(false, "Root did not complete. This is a bug in React.")
        return
    end

    if arg2 == 2 then
        tbl2.commitRoot(arg1)
        return
    elseif arg2 == 3 then
        tbl2.markRootSuspended(arg1, arg3)

        if includesOnlyRetries(arg3) and not shouldForceFlushFallbacksInDEV() then
            local var17 = num3 + 500 - now()

            if var17 > 10 then
                if getNextLanes(arg1, ReactFiberLane.NoLanes) ~= ReactFiberLane.NoLanes then
                    return
                end
                local suspendedLanes = arg1.suspendedLanes
                if not isSubsetOfLanes(suspendedLanes, arg3) then
                    local var18 = module.requestEventTime()
                    markRootPinged(arg1, suspendedLanes, var18)
                    return
                end

                arg1.timeoutHandle = ReactFiberHostConfig.scheduleTimeout(function()
                    return tbl2.commitRoot(arg1)
                end, var17)

                return
            end
        end

        tbl2.commitRoot(arg1)
        return
    end

    if arg2 ~= 4 then
        if arg2 == 5 then
            tbl2.commitRoot(arg1)
        else
            invariant(false, "Unknown root exit status.")
        end

        return
    end

    tbl2.markRootSuspended(arg1, arg3)

    if includesOnlyTransitions(arg3) then
        return
    end

    if not shouldForceFlushFallbacksInDEV() then
        local mostRecentEventTime = ReactFiberLane.getMostRecentEventTime(arg1, arg3)

        local var17 = now() - mostRecentEventTime
        local var18 = jnd(var17) - var17

        if var18 > 10 then
            arg1.timeoutHandle = ReactFiberHostConfig.scheduleTimeout(function()
                return tbl2.commitRoot(arg1)
            end, var18)

            return
        end
    end

    tbl2.commitRoot(arg1)
end

function tbl2.markRootSuspended(arg1, arg2)
    arg2 = removeLanes(arg2, NoLanes4)
    arg2 = removeLanes(arg2, NoLanes3)
    ReactFiberLane.markRootSuspended(arg1, arg2)
end

function tbl2.performSyncWorkOnRoot(arg1)
    invariant(bit32.band(getExecutionContext, 0x30) == 0, "Should not already be working.")

    module.flushPassiveEffects()
    local var17, var18

    if arg1 == getWorkInProgressRoot and includesSomeLane(arg1.expiredLanes, NoLanes) then
        var17 = NoLanes
        var18 = tbl2.renderRootSync(arg1, var17)

        if includesSomeLane(NoLanes2, NoLanes3) then
            var17 = getNextLanes(arg1, var17)
            var18 = tbl2.renderRootSync(arg1, var17)
        end
    else
        var17 = getNextLanes(arg1, ReactFiberLane.NoLanes)
        var18 = tbl2.renderRootSync(arg1, var17)
    end

    if arg1.tag ~= LegacyRoot and var18 == 2 then
        getExecutionContext = bit32.bor(getExecutionContext, 0x40)

        if arg1.hydrate then
            arg1.hydrate = false
            ReactFiberHostConfig.clearContainer(arg1.containerInfo)
        end

        var17 = getLanesToRetrySynchronouslyOnError(arg1)
        if var17 ~= ReactFiberLane.NoLanes then
            var18 = tbl2.renderRootSync(arg1, var17)
        end
    end

    if var18 == 1 then
        local var19 = var5
        tbl2.prepareFreshStack(arg1, ReactFiberLane.NoLanes)
        tbl2.markRootSuspended(arg1, var17)
        var1(arg1, now())
        error(var19)
    end

    arg1.finishedWork = arg1.current.alternate
    arg1.finishedLanes = var17
    tbl2.commitRoot(arg1)

    var1(arg1, now())

    return nil
end

function module.flushRoot(arg1, arg2)
    markRootExpired(arg1, arg2)
    var1(arg1, now())

    if bit32.band(getExecutionContext, 0x30) == 0 then
        resetRenderTimer()
        flushSyncCallbackQueue()
    end
end

function module.getExecutionContext()
    return getExecutionContext
end

function module.flushDiscreteUpdates()
    if bit32.band(getExecutionContext, 0b110001) ~= 0 then
        if __DEV__ and bit32.band(getExecutionContext, 0x10) ~= 0 then
            console.error("unstable_flushDiscreteUpdates: Cannot flush updates when React is already rendering.")
        end

        return
    end
    tbl2.flushPendingDiscreteUpdates()

    module.flushPassiveEffects()
end

function module.deferredUpdates(func5: (...any) -> (...any))
    if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        return runWithPriority(NormalPriority, func5)
    end

    local currentUpdateLanePriority = getCurrentUpdateLanePriority()
    local success, result

    if not __YOLO__ then
        setCurrentUpdateLanePriority(ReactFiberLane.DefaultLanePriority)

        success, result = xpcall(runWithPriority, describeError, NormalPriority, func5)
    else
        setCurrentUpdateLanePriority(ReactFiberLane.DefaultLanePriority)
        result = runWithPriority(NormalPriority, func5)
        success = true
    end

    setCurrentUpdateLanePriority(currentUpdateLanePriority)

    if success then
        return result
    end
    error(result)
end

function tbl2.flushPendingDiscreteUpdates()
    if var12 ~= nil then
        local var17 = var12
        var12 = nil
        var17:forEach(function(arg1)
            markDiscreteUpdatesExpired(arg1)
            var1(arg1, now())
        end)
    end

    flushSyncCallbackQueue()
end

function module.batchedUpdates(callback: (...any) -> (...any), arg1)
    local num7 = getExecutionContext
    getExecutionContext = bit32.bor(getExecutionContext, 1)
    local success, result

    if not __YOLO__ then
        success, result = xpcall(callback, describeError, arg1)
    else
        result = callback(arg1)
        success = true
    end

    getExecutionContext = num7
    if getExecutionContext == 0 then
        resetRenderTimer()
        flushSyncCallbackQueue()
    end

    if success then
        return result
    end
    error(result)
end

function module.batchedEventUpdates(callback: (...any) -> (...any), arg1)
    local num7 = getExecutionContext
    getExecutionContext = bit32.bor(getExecutionContext, 2)
    local success, result

    if not __YOLO__ then
        success, result = xpcall(callback, describeError, arg1)
    else
        result = callback(arg1)
        success = true
    end

    getExecutionContext = num7
    if getExecutionContext == 0 then
        resetRenderTimer()
        flushSyncCallbackQueue()
    end

    if success then
        return result
    end
    error(result)
end

function module.discreteUpdates(func5: (...any) -> (...any), arg1, arg2, arg3, arg4)
    local num7 = getExecutionContext
    getExecutionContext = bit32.bor(getExecutionContext, 4)

    if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        local success, result = xpcall(runWithPriority, describeError, UserBlockingPriority, function()
            return func5(arg1, arg2, arg3, arg4)
        end)

        getExecutionContext = num7
        if getExecutionContext == 0 then
            resetRenderTimer()
            flushSyncCallbackQueue()
        end

        if success then
            return result
        end
        error(result)

        return
    end

    local currentUpdateLanePriority = getCurrentUpdateLanePriority()

    setCurrentUpdateLanePriority(ReactFiberLane.InputDiscreteLanePriority)
    local success, result = xpcall(runWithPriority, describeError, UserBlockingPriority, function()
        return func5(arg1, arg2, arg3, arg4)
    end)

    setCurrentUpdateLanePriority(currentUpdateLanePriority)
    getExecutionContext = num7
    if getExecutionContext == 0 then
        resetRenderTimer()
        flushSyncCallbackQueue()
    end

    if success then
        return result
    end
    error(result)
end

function module.unbatchedUpdates(callback: (...any) -> (...any), arg1)
    local num7 = getExecutionContext
    getExecutionContext = bit32.band(getExecutionContext, 0xFFFFFFFE)
    getExecutionContext = bit32.bor(getExecutionContext, 8)
    local success, result

    if not __YOLO__ then
        success, result = xpcall(callback, describeError, arg1)
    else
        result = callback(arg1)
        success = true
    end

    getExecutionContext = num7
    if getExecutionContext == 0 then
        resetRenderTimer()
        flushSyncCallbackQueue()
    end

    if success then
        return result
    end
    error(result)
end

function module.flushSync(func5: (...any) -> (...any), arg1)
    local num7 = getExecutionContext

    if bit32.band(num7, 0x30) ~= 0 then
        if __DEV__ then
            console.error(
                "flushSync was called from inside a lifecycle method. React cannot flush when React is already rendering. Consider moving this call to a scheduler task or micro task."
            )
        end

        return func5(arg1)
    end
    getExecutionContext = bit32.bor(getExecutionContext, 1)

    if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        local success, result

        if __YOLO__ then
            success = true
            if func5 then
                result = runWithPriority(ImmediatePriority, function()
                    return func5(arg1)
                end)
            else
                result = nil
            end
        elseif func5 then
            success, result = xpcall(runWithPriority, describeError, ImmediatePriority, function()
                return func5(arg1)
            end)
        else
            success = true
            result = nil
        end

        getExecutionContext = num7

        flushSyncCallbackQueue()
        if not success then
            error(result)
        end
        return result
    end

    local currentUpdateLanePriority = getCurrentUpdateLanePriority()

    setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority)
    local success, result

    if __YOLO__ then
        success = true
        setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority)
        if func5 then
            result = runWithPriority(ImmediatePriority, function()
                return func5(arg1)
            end)
        else
            result = nil
        end
    elseif func5 then
        success, result = xpcall(runWithPriority, describeError, ImmediatePriority, function()
            return func5(arg1)
        end)
    else
        success = true
        result = nil
    end

    setCurrentUpdateLanePriority(currentUpdateLanePriority)
    getExecutionContext = num7

    flushSyncCallbackQueue()

    if not success then
        error(result)
    end
    return result
end

function module.flushControlled(func5: (...any) -> (...any))
    local num7 = getExecutionContext
    getExecutionContext = bit32.bor(getExecutionContext, 1)
    if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        local currentUpdateLanePriority = getCurrentUpdateLanePriority()

        setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority)

        local success, result = xpcall(runWithPriority, describeError, ImmediatePriority, func5)

        setCurrentUpdateLanePriority(currentUpdateLanePriority)

        getExecutionContext = num7
        if getExecutionContext == 0 then
            resetRenderTimer()
            flushSyncCallbackQueue()
        end

        if not success then
            error(result)
        end
    else
        local success, result = xpcall(runWithPriority, describeError, ImmediatePriority, func5)

        getExecutionContext = num7
        if getExecutionContext == 0 then
            resetRenderTimer()
            flushSyncCallbackQueue()
        end

        if not success then
            error(result)
        end
    end
end

function module.pushRenderLanes(arg1, arg2)
    push(cursor, module.subtreeRenderLanes, arg1)
    module.subtreeRenderLanes = mergeLanes(module.subtreeRenderLanes, arg2)
    NoLanes2 = mergeLanes(NoLanes2, arg2)
end

function module.popRenderLanes(arg1)
    module.subtreeRenderLanes = cursor.current
    pop(cursor, arg1)
end

function tbl2.prepareFreshStack(arg1, subtreeRenderLanes)
    arg1.finishedWork = nil
    arg1.finishedLanes = ReactFiberLane.NoLanes

    local timeoutHandle = arg1.timeoutHandle
    if timeoutHandle ~= ReactFiberHostConfig.noTimeout then
        arg1.timeoutHandle = ReactFiberHostConfig.noTimeout

        ReactFiberHostConfig.cancelTimeout(timeoutHandle)
    end

    if var4 ~= nil then
        local _return = var4.return_
        while _return ~= nil do
            unwindInterruptedWork(_return)
            _return = _return.return_
        end
    end
    getWorkInProgressRoot = arg1
    var4 = ReactFiberNew.createWorkInProgress(arg1.current, nil)
    NoLanes = subtreeRenderLanes
    module.subtreeRenderLanes = subtreeRenderLanes
    NoLanes2 = subtreeRenderLanes
    num2 = 0
    var5 = nil
    workInProgressRootSkippedLanes(ReactFiberLane.NoLanes)
    NoLanes3 = ReactFiberLane.NoLanes
    NoLanes4 = ReactFiberLane.NoLanes

    if ReactFeatureFlags.enableSchedulerTracing then
        var14 = nil
    end

    if __DEV__ then
        ReactStrictModeWarningsNew.discardPendingWarnings()
    end
end

function tbl2.handleError(arg1, arg2)
    while true do
        local var17 = var4

        local success, result = pcall(function()
            resetContextDependencies()
            func3()
            resetCurrentFiber()

            ReactCurrentOwner.current = nil

            if var17 == nil or var17.return_ == nil then
                num2 = 1
                var5 = arg2

                var4 = nil

                return
            end

            if ReactFeatureFlags.enableProfilerTimer and bit32.band(var17.mode, ReactTypeOfMode.ProfileMode) ~= 0 then
                ReactProfilerTimerNew.stopProfilerTimerIfRunningAndRecordDelta(var17, true)
            end

            throwException(arg1, var17.return_, var17, arg2, NoLanes, module.onUncaughtError, module.renderDidError)

            tbl2.completeUnitOfWork(var17)
        end)
        if success then
            break
        end
        arg2 = result
        if var4 == var17 and var17 ~= nil then
            var17 = var17.return_
            var4 = var17
        else
            var17 = var4
        end
    end
end

function tbl2.pushDispatcher()
    local current2 = ReactCurrentDispatcher.current

    ReactCurrentDispatcher.current = func4()
    if current2 == nil then
        return func4()
    end

    return current2
end

function tbl2.popDispatcher(current2)
    ReactCurrentDispatcher.current = current2
end

function tbl2.pushInteractions(arg1)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return nil
    end

    local current2 = __interactionsRef.current
    __interactionsRef.current = arg1.memoizedInteractions
    return current2
end

function tbl2.popInteractions(current2)
    if ReactFeatureFlags.enableSchedulerTracing then
        __interactionsRef.current = current2
    end
end

function module.markCommitTimeOfFallback()
    num3 = now()
end

function module.markSkippedUpdateLanes(arg1)
    ReactFiberWorkInProgress.markSkippedUpdateLanes(arg1)
end

function module.renderDidSuspend()
    if num2 == 0 then
        num2 = 3
    end
end

function module.renderDidSuspendDelayIfPossible()
    if num2 == 0 or num2 == 3 then
        num2 = 4
    end

    if getWorkInProgressRoot ~= nil and (includesNonIdleWork(workInProgressRootSkippedLanes()) or includesNonIdleWork(NoLanes3)) then
        tbl2.markRootSuspended(getWorkInProgressRoot, NoLanes)
    end
end

function module.renderDidError()
    if num2 ~= 5 then
        num2 = 2
    end
end

function module.renderHasNotSuspendedYet(): boolean
    return num2 == 0
end

function tbl2.renderRootSync(arg1, arg2)
    local num7 = getExecutionContext
    getExecutionContext = bit32.bor(getExecutionContext, 0x10)
    local var17 = tbl2.pushDispatcher()

    if getWorkInProgressRoot ~= arg1 or NoLanes ~= arg2 then
        tbl2.prepareFreshStack(arg1, arg2)
        tbl2.startWorkOnPendingInteractions(arg1, arg2)
    end

    local var18 = tbl2.pushInteractions(arg1)

    if __DEV__ and enableDebugTracing then
        DebugTracing.logRenderStarted(arg2)
    end

    if enableSchedulingProfiler then
        SchedulingProfiler.markRenderStarted(arg2)
    end

    while true do
        local result = nil
        local success

        if not __YOLO__ then
            success, result = xpcall(tbl2.workLoopSync, describeError)
        else
            tbl2.workLoopSync()
            success = true
        end

        if success then
            resetContextDependencies()
            if ReactFeatureFlags.enableSchedulerTracing then
                tbl2.popInteractions(var18)
            end

            getExecutionContext = num7
            tbl2.popDispatcher(var17)

            if var4 ~= nil then
                invariant(
                    false,
                    "Cannot commit an incomplete root. This error is likely caused by a bug in React. Please file an issue."
                )
            end

            if __DEV__ and enableDebugTracing then
                DebugTracing.logRenderStopped()
            end

            if enableSchedulingProfiler then
                SchedulingProfiler.markRenderStopped()
            end

            getWorkInProgressRoot = nil
            NoLanes = ReactFiberLane.NoLanes

            return num2
        end

        tbl2.handleError(arg1, result)
    end
end

function tbl2.workLoopSync()
    while var4 ~= nil do
        tbl2.performUnitOfWork(var4)
    end
end

function tbl2.renderRootConcurrent(arg1, arg2)
    local num7 = getExecutionContext
    getExecutionContext = bit32.bor(getExecutionContext, 0x10)
    local var17 = tbl2.pushDispatcher()

    if getWorkInProgressRoot ~= arg1 or NoLanes ~= arg2 then
        resetRenderTimer()
        tbl2.prepareFreshStack(arg1, arg2)
        tbl2.startWorkOnPendingInteractions(arg1, arg2)
    end

    local var18 = tbl2.pushInteractions(arg1)

    if __DEV__ and enableDebugTracing then
        DebugTracing.logRenderStarted(arg2)
    end

    if enableSchedulingProfiler then
        SchedulingProfiler.markRenderStarted(arg2)
    end

    while true do
        local success, result

        if not __YOLO__ then
            success, result = xpcall(tbl2.workLoopConcurrent, describeError)
            if success then
                result = "break"
            end
        else
            tbl2.workLoopConcurrent()
            result = "break"
            success = true
        end

        if result == "break" then
            resetContextDependencies()
            if ReactFeatureFlags.enableSchedulerTracing then
                tbl2.popInteractions(var18)
            end

            tbl2.popDispatcher(var17)
            getExecutionContext = num7

            if __DEV__ and enableDebugTracing then
                DebugTracing.logRenderStopped()
            end

            if var4 ~= nil then
                if enableSchedulingProfiler then
                    SchedulingProfiler.markRenderYielded()
                end
                return 0
            end

            if enableSchedulingProfiler then
                SchedulingProfiler.markRenderStopped()
            end

            getWorkInProgressRoot = nil
            NoLanes = ReactFiberLane.NoLanes

            return num2
        end

        if not success then
            tbl2.handleError(arg1, result)
        end
    end
end

function tbl2.workLoopConcurrent()
    while var4 ~= nil and not shouldYield() do
        tbl2.performUnitOfWork(var4)
    end
end

if ReactFeatureFlags.enableWorkLoopTrims then
    function tbl2.performUnitOfWork(arg1)
        local enableUnitOfWorkProfiling = RobloxReactProfiling.enableUnitOfWorkProfiling
        local var17 = if enableUnitOfWorkProfiling then RobloxReactProfiling.profileUnitOfWorkBefore(arg1) else nil
        local alternate = arg1.alternate
        if __DEV__ then
            setCurrentFiber(arg1)
        end

        local var18

        if ReactFeatureFlags.enableProfilerTimer and bit32.band(arg1.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
            ReactProfilerTimerNew.startProfilerTimer(arg1)
            var18 = tbl2.beginWork(alternate, arg1, module.subtreeRenderLanes)
            ReactProfilerTimerNew.stopProfilerTimerIfRunningAndRecordDelta(arg1, true)

            if __DEV__ then
                resetCurrentFiber()
            end
            arg1.memoizedProps = arg1.pendingProps
            if var18 == nil then
                tbl2.completeUnitOfWork(arg1)
            else
                var4 = var18
            end

            ReactCurrentOwner.current = nil

            if enableUnitOfWorkProfiling then
                RobloxReactProfiling.profileUnitOfWorkAfter(var17)
            end
            return
        end

        var18 = tbl2.beginWork(alternate, arg1, module.subtreeRenderLanes)

        if __DEV__ then
            resetCurrentFiber()
        end
        arg1.memoizedProps = arg1.pendingProps
        if var18 == nil then
            tbl2.completeUnitOfWork(arg1)
        else
            var4 = var18
        end

        ReactCurrentOwner.current = nil

        if enableUnitOfWorkProfiling then
            RobloxReactProfiling.profileUnitOfWorkAfter(var17)
        end
    end
else
    function tbl2.performUnitOfWork(arg1)
        local var17 = RobloxReactProfiling.profileUnitOfWorkBefore(arg1)

        local alternate = arg1.alternate
        setCurrentFiber(arg1)
        local var18

        if ReactFeatureFlags.enableProfilerTimer and bit32.band(arg1.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
            ReactProfilerTimerNew.startProfilerTimer(arg1)
            var18 = tbl2.beginWork(alternate, arg1, module.subtreeRenderLanes)
            ReactProfilerTimerNew.stopProfilerTimerIfRunningAndRecordDelta(arg1, true)

            resetCurrentFiber()
            arg1.memoizedProps = arg1.pendingProps
            if var18 == nil then
                tbl2.completeUnitOfWork(arg1)
            else
                var4 = var18
            end

            ReactCurrentOwner.current = nil

            RobloxReactProfiling.profileUnitOfWorkAfter(var17)
            return
        end

        var18 = tbl2.beginWork(alternate, arg1, module.subtreeRenderLanes)

        resetCurrentFiber()
        arg1.memoizedProps = arg1.pendingProps
        if var18 == nil then
            tbl2.completeUnitOfWork(arg1)
        else
            var4 = var18
        end

        ReactCurrentOwner.current = nil

        RobloxReactProfiling.profileUnitOfWorkAfter(var17)
    end
end

function tbl2.completeUnitOfWork(arg1)
    local var17

    while true do
        local bool5 = false
        local alternate = arg1.alternate
        local _return = arg1.return_

        if bit32.band(arg1.flags, ReactFiberFlags.Incomplete) == ReactFiberFlags.NoFlags then
            if not ReactFeatureFlags.enableWorkLoopTrims or __DEV__ then
                setCurrentFiber(arg1)
            end

            if not ReactFeatureFlags.enableProfilerTimer
                or bit32.band(arg1.mode, ReactTypeOfMode.ProfileMode) == ReactTypeOfMode.NoMode
            then
                bool5 = true
            else
                ReactProfilerTimerNew.startProfilerTimer(arg1)
                var17 = func2(alternate, arg1, module.subtreeRenderLanes)

                ReactProfilerTimerNew.stopProfilerTimerIfRunningAndRecordDelta(arg1, false)
            end

            if bool5 then
                var17 = func2(alternate, arg1, module.subtreeRenderLanes)
            end

            if not ReactFeatureFlags.enableWorkLoopTrims or __DEV__ then
                resetCurrentFiber()
            end

            if var17 ~= nil then
                var4 = var17
                return
            end
        else
            local var18 = unwindWork(arg1, module.subtreeRenderLanes)

            if var18 ~= nil then
                var18.flags = bit32.band(var18.flags, ReactFiberFlags.HostEffectMask)
                var4 = var18
                return
            end

            if ReactFeatureFlags.enableProfilerTimer and bit32.band(arg1.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
                ReactProfilerTimerNew.stopProfilerTimerIfRunningAndRecordDelta(arg1, false)

                local actualDuration = arg1.actualDuration or 0
                local child = arg1.child
                while child ~= nil do
                    actualDuration += child.actualDuration or 0
                    child = child.sibling
                end
                arg1.actualDuration = actualDuration
            end

            if _return ~= nil then
                _return.flags = bit32.bor(_return.flags, ReactFiberFlags.Incomplete)
                _return.subtreeFlags = ReactFiberFlags.NoFlags
                _return.deletions = nil
            end
        end

        local sibling = arg1.sibling
        if sibling ~= nil then
            var4 = sibling
            return
        end

        var4 = _return
        if _return == nil then
            if num2 == 0 then
                num2 = 5
            end
            return
        end

        arg1 = _return
    end
end

function tbl2.commitRoot(arg1)
    local currentPriorityLevel = getCurrentPriorityLevel()
    runWithPriority(ImmediatePriority, function()
        RobloxReactProfiling.profileCommitBefore()
        local var17 = tbl2.commitRootImpl(arg1, currentPriorityLevel)
        RobloxReactProfiling.profileCommitAfter()
        return var17
    end)
    return nil
end

function tbl2.commitRootImpl(arg1, arg2)
    repeat
        module.flushPassiveEffects()
    until var10 == nil
    flushRenderPhaseStrictModeWarningsInDEV()

    invariant(bit32.band(getExecutionContext, 0x30) == 0, "Should not already be working.")

    local finishedWork = arg1.finishedWork
    local finishedLanes = arg1.finishedLanes

    if __DEV__ and enableDebugTracing then
        DebugTracing.logCommitStarted(finishedLanes)
    end

    if enableSchedulingProfiler then
        SchedulingProfiler.markCommitStarted(finishedLanes)
    end

    if finishedWork == nil then
        if __DEV__ and enableDebugTracing then
            DebugTracing.logCommitStopped()
        end

        if enableSchedulingProfiler then
            SchedulingProfiler.markCommitStopped(arg1)
        end

        return nil
    end
    arg1.finishedWork = nil
    arg1.finishedLanes = ReactFiberLane.NoLanes

    invariant(
        finishedWork ~= arg1.current,
        "Cannot commit the same tree as before. This error is likely caused by a bug in React. Please file an issue."
    )

    arg1.callbackNode = nil

    local var17 = mergeLanes(finishedWork.lanes, finishedWork.childLanes)
    markRootFinished(arg1, var17)

    if var12 ~= nil and not hasDiscreteLanes(var17) and var12:has(arg1) then
        var12:delete(arg1)
    end

    if arg1 == getWorkInProgressRoot then
        getWorkInProgressRoot = nil
        var4 = nil
        NoLanes = ReactFiberLane.NoLanes
    end

    local bool5 = bit32.band(
        finishedWork.subtreeFlags,
        bit32.bor(
            ReactFiberFlags.BeforeMutationMask,
            ReactFiberFlags.MutationMask,
            ReactFiberFlags.LayoutMask,
            ReactFiberFlags.PassiveMask
        )
    ) ~= ReactFiberFlags.NoFlags
    local bool6 = bit32.band(
        finishedWork.flags,
        bit32.bor(
            ReactFiberFlags.BeforeMutationMask,
            ReactFiberFlags.MutationMask,
            ReactFiberFlags.LayoutMask,
            ReactFiberFlags.PassiveMask
        )
    ) ~= ReactFiberFlags.NoFlags

    if bool5 or bool6 then
        local currentUpdateLanePriority

        if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
            currentUpdateLanePriority = getCurrentUpdateLanePriority()
            setCurrentUpdateLanePriority(ReactFiberLane.SyncLanePriority)
        else
            currentUpdateLanePriority = nil
        end

        local num7 = getExecutionContext
        getExecutionContext = bit32.bor(getExecutionContext, 0x20)
        local var18 = tbl2.pushInteractions(arg1)

        ReactCurrentOwner.current = nil

        if ReactFeatureFlags.enableCommitTraversalTrims
            and bit32.band(bit32.bor(finishedWork.subtreeFlags, finishedWork.flags), ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags
            and not bool2
        then
            bool2 = true
            scheduleCallback(NormalPriority, function()
                module.flushPassiveEffects()
                return nil
            end)
        end

        var16 = ReactFiberHostConfig.prepareForCommit(arg1.containerInfo)
        bool3 = false

        tbl2.commitBeforeMutationEffects(finishedWork)

        var16 = nil

        if ReactFeatureFlags.enableProfilerTimer then
            ReactProfilerTimerNew.recordCommitTime()
        end

        tbl2.commitMutationEffects(finishedWork, arg1, arg2)

        if bool3 then
            ReactFiberHostConfig.afterActiveInstanceBlur()
        end
        ReactFiberHostConfig.resetAfterCommit(arg1.containerInfo)

        arg1.current = finishedWork

        if __DEV__ and enableDebugTracing then
            DebugTracing.logLayoutEffectsStarted(finishedLanes)
        end

        if enableSchedulingProfiler then
            SchedulingProfiler.markLayoutEffectsStarted(finishedLanes)
        end

        if __DEV__ then
            setCurrentFiber(finishedWork)
            invokeGuardedCallback(
                nil,
                recursivelyCommitLayoutEffects,
                nil,
                finishedWork,
                arg1,
                module.captureCommitPhaseError,
                module.schedulePassiveEffectCallback
            )
            if hasCaughtError() then
                local var19 = clearCaughtError()
                var2(finishedWork, finishedWork, var19)
            end
            resetCurrentFiber()
        else
            local result = nil
            local success

            if not __YOLO__ then
                success, result = xpcall(
                    recursivelyCommitLayoutEffects,
                    describeError,
                    finishedWork,
                    arg1,
                    module.captureCommitPhaseError,
                    module.schedulePassiveEffectCallback
                )
            else
                recursivelyCommitLayoutEffects(finishedWork, arg1, module.captureCommitPhaseError, module.schedulePassiveEffectCallback)
                success = true
            end

            if not success then
                var2(finishedWork, finishedWork, result)
            end
        end

        if __DEV__ and enableDebugTracing then
            DebugTracing.logLayoutEffectsStopped()
        end

        if enableSchedulingProfiler then
            SchedulingProfiler.markLayoutEffectsStopped()
        end

        local subtreeFlags = finishedWork.subtreeFlags
        local passiveMask = ReactFiberFlags.PassiveMask

        if (bit32.band(subtreeFlags, passiveMask) ~= ReactFiberFlags.NoFlags
            or bit32.band(finishedWork.flags, ReactFiberFlags.PassiveMask) ~= ReactFiberFlags.NoFlags)
            and not bool2
        then
            bool2 = true
            scheduleCallback(NormalPriority, function()
                module.flushPassiveEffects()
                return nil
            end)
        end

        requestPaint()

        if ReactFeatureFlags.enableSchedulerTracing then
            tbl2.popInteractions(var18)
        end
        getExecutionContext = num7

        if ReactFeatureFlags.decoupleUpdatePriorityFromScheduler and currentUpdateLanePriority ~= nil then
            setCurrentUpdateLanePriority(currentUpdateLanePriority)
        end
    else
        arg1.current = finishedWork

        if ReactFeatureFlags.enableProfilerTimer then
            ReactProfilerTimerNew.recordCommitTime()
        end
    end

    local bool7 = bool2

    if bool2 then
        bool2 = false
        var10 = arg1
        NoLanes5 = finishedLanes
        var11 = arg2
    end

    local pendingLanes = arg1.pendingLanes

    if pendingLanes == ReactFiberLane.NoLanes then
        var9 = nil
    elseif ReactFeatureFlags.enableSchedulerTracing then
        if var14 ~= nil then
            local var18 = var14
            var14 = nil
            for i = 1, #var18 do
                scheduleInteractions(arg1, var18[i], arg1.memoizedInteractions)
            end
        end

        tbl2.schedulePendingInteractions(arg1, pendingLanes)
    end

    if __DEV__ and enableDoubleInvokingEffects and not bool7 then
        commitDoubleInvokeEffectsInDEV(arg1.current, false)
    end

    if ReactFeatureFlags.enableSchedulerTracing and not bool7 then
        tbl2.finishPendingInteractions(arg1, finishedLanes)
    end

    if pendingLanes ~= SyncLane then
        num4 = 0
    elseif arg1 == var13 then
        num4 += 1
    else
        num4 = 0
        var13 = arg1
    end

    onCommitRoot(finishedWork.stateNode, arg2)

    if __DEV__ then
        onCommitRoot2()
    end

    var1(arg1, now())

    if bool1 then
        bool1 = false
        local var18 = var8
        var8 = nil

        error(var18)
    end

    if bit32.band(getExecutionContext, 8) ~= 0 then
        if __DEV__ and enableDebugTracing then
            DebugTracing.logCommitStopped()
        end

        if enableSchedulingProfiler then
            SchedulingProfiler.markCommitStopped(arg1)
        end

        return nil
    end

    flushSyncCallbackQueue()

    if __DEV__ and enableDebugTracing then
        DebugTracing.logCommitStopped()
    end

    if enableSchedulingProfiler then
        SchedulingProfiler.markCommitStopped(arg1)
    end

    return nil
end

function tbl2.commitBeforeMutationEffects(arg1)
    while true do
        if arg1 == nil then
            return
        end

        if arg1.deletions ~= nil then
            tbl2.commitBeforeMutationEffectsDeletions(arg1.deletions)
        end

        if arg1.child ~= nil and bit32.band(arg1.subtreeFlags, ReactFiberFlags.BeforeMutationMask) ~= ReactFiberFlags.NoFlags then
            tbl2.commitBeforeMutationEffects(arg1.child)
        end

        if ReactFeatureFlags.enableCommitTraversalTrims then
            if var16 ~= nil or bit32.band(arg1.flags, ReactFiberFlags.Snapshot) ~= ReactFiberFlags.NoFlags then
                if __DEV__ then
                    setCurrentFiber(arg1)
                    invokeGuardedCallback(nil, tbl2.commitBeforeMutationEffectsImpl, nil, arg1)

                    if hasCaughtError() then
                        local var17 = clearCaughtError()
                        module.captureCommitPhaseError(arg1, arg1.return_, var17)
                    end
                    resetCurrentFiber()
                else
                    local result = nil
                    local success

                    if not __YOLO__ then
                        success, result = xpcall(tbl2.commitBeforeMutationEffectsImpl, describeError, arg1)
                    else
                        tbl2.commitBeforeMutationEffectsImpl(arg1)
                        success = true
                    end

                    if not success then
                        module.captureCommitPhaseError(arg1, arg1.return_, result)
                    end
                end
            end
        elseif __DEV__ then
            setCurrentFiber(arg1)
            invokeGuardedCallback(nil, tbl2.commitBeforeMutationEffectsImpl, nil, arg1)

            if hasCaughtError() then
                local var17 = clearCaughtError()
                module.captureCommitPhaseError(arg1, arg1.return_, var17)
            end
            resetCurrentFiber()
        else
            local result = nil
            local success

            if not __YOLO__ then
                success, result = xpcall(tbl2.commitBeforeMutationEffectsImpl, describeError, arg1)
            else
                tbl2.commitBeforeMutationEffectsImpl(arg1)
                success = true
            end

            if not success then
                module.captureCommitPhaseError(arg1, arg1.return_, result)
            end
        end

        arg1 = arg1.sibling
    end
end

function tbl2.commitBeforeMutationEffectsImpl(arg1)
    local alternate = arg1.alternate
    local flags = arg1.flags

    if not bool3
        and var16 ~= nil
        and arg1.tag == ReactWorkTags.SuspenseComponent
        and ReactFiberCommitWorkNew.isSuspenseBoundaryBeingHidden(alternate, arg1)
        and doesFiberContain(arg1, var16)
    then
        bool3 = true
        ReactFiberHostConfig.beforeActiveInstanceBlur()
    end

    if bit32.band(flags, ReactFiberFlags.Snapshot) ~= ReactFiberFlags.NoFlags then
        setCurrentFiber(arg1)
        commitBeforeMutationLifeCycles(alternate, arg1)
        resetCurrentFiber()
    end

    if ReactFeatureFlags.enableCommitTraversalTrims
        or bit32.band(flags, ReactFiberFlags.Passive) == ReactFiberFlags.NoFlags
        or bool2
    then
        return
    end

    bool2 = true
    scheduleCallback(NormalPriority, function()
        module.flushPassiveEffects()
        return nil
    end)
end

function tbl2.commitBeforeMutationEffectsDeletions(deletions)
    for i = 1, #deletions do
        local deletion = deletions[i]

        if doesFiberContain(deletion, var16) then
            bool3 = true
            ReactFiberHostConfig.beforeActiveInstanceBlur()
        end
    end
end

function tbl2.commitMutationEffects(arg1, arg2, arg3)
    while arg1 ~= nil do
        local deletions = arg1.deletions
        if deletions ~= nil then
            for _, deletion in deletions do
                local success, result = xpcall(commitDeletion, describeError, arg2, deletion, arg1, arg3)

                if not success then
                    module.captureCommitPhaseError(deletion, arg1, result)
                end
            end
        end

        if arg1.child ~= nil and bit32.band(arg1.subtreeFlags, ReactFiberFlags.MutationMask) ~= ReactFiberFlags.NoFlags then
            tbl2.commitMutationEffects(arg1.child, arg2, arg3)
        end

        if ReactFeatureFlags.enableCommitTraversalTrims then
            if bit32.band(arg1.flags, tbl2.MutationWorkFlags) ~= ReactFiberFlags.NoFlags then
                if __DEV__ then
                    setCurrentFiber(arg1)
                    invokeGuardedCallback(nil, tbl2.commitMutationEffectsImpl, nil, arg1, arg2, arg3)

                    if hasCaughtError() then
                        local var17 = clearCaughtError()
                        module.captureCommitPhaseError(arg1, arg1.return_, var17)
                    end
                    resetCurrentFiber()
                else
                    local result = nil
                    local success

                    if not __YOLO__ then
                        success, result = xpcall(tbl2.commitMutationEffectsImpl, describeError, arg1, arg2, arg3)
                    else
                        tbl2.commitMutationEffectsImpl(arg1, arg2, arg3)
                        success = true
                    end
                    if not success then
                        module.captureCommitPhaseError(arg1, arg1.return_, result)
                    end
                end
            end
        elseif __DEV__ then
            setCurrentFiber(arg1)
            invokeGuardedCallback(nil, tbl2.commitMutationEffectsImpl, nil, arg1, arg2, arg3)

            if hasCaughtError() then
                local var17 = clearCaughtError()
                module.captureCommitPhaseError(arg1, arg1.return_, var17)
            end
            resetCurrentFiber()
        else
            local result = nil
            local success

            if not __YOLO__ then
                success, result = xpcall(tbl2.commitMutationEffectsImpl, describeError, arg1, arg2, arg3)
            else
                tbl2.commitMutationEffectsImpl(arg1, arg2, arg3)
                success = true
            end
            if not success then
                module.captureCommitPhaseError(arg1, arg1.return_, result)
            end
        end

        arg1 = arg1.sibling
    end
end

function tbl2.commitMutationEffectsImpl(arg1, _, _)
    local flags = arg1.flags

    if bit32.band(flags, ReactFiberFlags.Ref) ~= 0 then
        local alternate = arg1.alternate
        if alternate ~= nil then
            commitDetachRef(alternate)
        end
    end

    local num7 = bit32.band(flags, bit32.bor(ReactFiberFlags.Placement, ReactFiberFlags.Update, ReactFiberFlags.Hydrating))

    if ReactFeatureFlags.enableCommitTraversalTrims
        and bit32.band(flags, ReactFiberFlags.HostUpdate) ~= ReactFiberFlags.NoFlags
    then
        num7 = bit32.bor(num7, ReactFiberFlags.Update)
    end

    if num7 == ReactFiberFlags.Placement then
        commitPlacement(arg1)

        arg1.flags = bit32.band(arg1.flags, bit32.bnot(ReactFiberFlags.Placement))
    elseif num7 == ReactFiberFlags.PlacementAndUpdate then
        commitPlacement(arg1)

        arg1.flags = bit32.band(arg1.flags, bit32.bnot(ReactFiberFlags.Placement))

        local alternate = arg1.alternate
        commitWork(alternate, arg1)
    elseif num7 == ReactFiberFlags.Update then
        local alternate = arg1.alternate
        commitWork(alternate, arg1)
    end
end

function tbl2.commitMutationEffectsDeletions(arg1, arg2, arg3, arg4)
    for _, value in arg1 do
        local success, result = xpcall(commitDeletion, describeError, arg3, value, arg2, arg4)

        if not success then
            module.captureCommitPhaseError(value, arg2, result)
        end
    end
end

function module.schedulePassiveEffectCallback()
    if bool2 then
        return
    end

    bool2 = true
    scheduleCallback(NormalPriority, function()
        module.flushPassiveEffects()
        return nil
    end)
end

local var17 = nil
function module.flushPassiveEffects()
    if var11 == NoPriority then
        return false
    end

    local var18 = if NormalPriority < var11 then NormalPriority else var11
    var11 = NoPriority
    if not ReactFeatureFlags.decoupleUpdatePriorityFromScheduler then
        return runWithPriority(var18, var17)
    end

    local currentUpdateLanePriority = getCurrentUpdateLanePriority()

    setCurrentUpdateLanePriority(schedulerPriorityToLanePriority(var18))
    local success, result

    if not __YOLO__ then
        success, result = xpcall(runWithPriority, describeError, var18, var17)
    else
        setCurrentUpdateLanePriority(schedulerPriorityToLanePriority(var18))

        result = runWithPriority(var18, var17)
        success = true
    end

    setCurrentUpdateLanePriority(currentUpdateLanePriority)

    if not success then
        error(result)
    end
    return result
end

local function func5(arg1, arg2)
    while arg2 ~= nil do
        local var18

        if ReactFeatureFlags.enableProfilerTimer
            and ReactFeatureFlags.enableProfilerCommitHooks
            and arg2.tag == ReactWorkTags.Profiler
        then
            var18 = var7
            var7 = arg2
        else
            var18 = nil
        end

        local num7 = bit32.band(arg2.subtreeFlags, ReactFiberFlags.PassiveMask)

        if arg2.child ~= nil and num7 ~= ReactFiberFlags.NoFlags then
            func5(arg1, arg2.child)
        end

        if bit32.band(arg2.flags, ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags then
            if __DEV__ then
                setCurrentFiber(arg2)
                invokeGuardedCallback(nil, commitPassiveMount, nil, arg1, arg2)
                if hasCaughtError() then
                    local var19 = clearCaughtError()
                    module.captureCommitPhaseError(arg2, arg2.return_, var19)
                end
                resetCurrentFiber()
            else
                local result = nil
                local success

                if not __YOLO__ then
                    success, result = xpcall(commitPassiveMount, describeError, arg1, arg2)
                else
                    commitPassiveMount(arg1, arg2)
                    success = true
                end

                if not success then
                    module.captureCommitPhaseError(arg2, arg2.return_, result)
                end
            end
        end

        if ReactFeatureFlags.enableProfilerTimer
            and ReactFeatureFlags.enableProfilerCommitHooks
            and arg2.tag == ReactWorkTags.Profiler
        then
            if var18 ~= nil then
                local stateNode = var18.stateNode
                stateNode.passiveEffectDuration += arg2.stateNode.passiveEffectDuration
            end

            var7 = var18
        end

        arg2 = arg2.sibling
    end
end

function tbl2.commitPassiveMountEffectsOnFibers(arg1, arg2)
    for i = 1, #arg2 do
        local var18 = arg2[i]
        if __DEV__ then
            setCurrentFiber(var18)
            invokeGuardedCallback(nil, commitPassiveMount, nil, arg1, var18)
            if hasCaughtError() then
                local var19 = clearCaughtError()
                module.captureCommitPhaseError(var18, var18.return_, var19)
            end
            resetCurrentFiber()
        else
            local result = nil
            local success

            if not __YOLO__ then
                success, result = xpcall(commitPassiveMount, describeError, arg1, var18)
            else
                commitPassiveMount(arg1, var18)
                success = true
            end

            if not success then
                module.captureCommitPhaseError(var18, var18.return_, result)
            end
        end
    end
end

local function flushPassiveUnmountEffects(arg1)
    while arg1 ~= nil do
        local deletions = arg1.deletions
        if deletions ~= nil then
            for i = 1, #deletions do
                local deletion = deletions[i]
                tbl2.flushPassiveUnmountEffectsInsideOfDeletedTree(deletion, arg1)

                if not (enableNewTreeCleanupPath and deletedTreeCleanUpLevel >= 2) then
                    tbl2.detachFiberAfterEffects(deletion)
                end
            end

            if enableNewTreeCleanupPath and deletedTreeCleanUpLevel >= 1 then
                local alternate = arg1.alternate
                if alternate ~= nil then
                    local child = alternate.child
                    if child ~= nil then
                        alternate.child = nil
                        while true do
                            local sibling = child.sibling
                            child.sibling = nil

                            if sibling == nil then
                                break
                            end

                            child = sibling
                        end
                    end
                end
            end
        end

        local child = arg1.child
        if child ~= nil and bit32.band(arg1.subtreeFlags, ReactFiberFlags.PassiveMask) ~= ReactFiberFlags.NoFlags then
            flushPassiveUnmountEffects(child)
        end

        if bit32.band(arg1.flags, ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags then
            setCurrentFiber(arg1)
            commitPassiveUnmount(arg1)
            resetCurrentFiber()
        end

        arg1 = arg1.sibling
    end
end

function tbl2.flushPassiveUnmountEffectsCollecting(arg1, tbl3: {any})
    while arg1 ~= nil do
        local deletions = arg1.deletions
        if deletions ~= nil then
            for i = 1, #deletions do
                local deletion = deletions[i]
                tbl2.flushPassiveUnmountEffectsInsideOfDeletedTree(deletion, arg1)

                if not (enableNewTreeCleanupPath and deletedTreeCleanUpLevel >= 2) then
                    tbl2.detachFiberAfterEffects(deletion)
                end
            end

            if enableNewTreeCleanupPath and deletedTreeCleanUpLevel >= 1 then
                local alternate = arg1.alternate
                if alternate ~= nil then
                    local child = alternate.child
                    if child ~= nil then
                        alternate.child = nil
                        while true do
                            local sibling = child.sibling
                            child.sibling = nil

                            if sibling == nil then
                                break
                            end

                            child = sibling
                        end
                    end
                end
            end
        end

        local child = arg1.child
        if child ~= nil and bit32.band(arg1.subtreeFlags, ReactFiberFlags.PassiveMask) ~= ReactFiberFlags.NoFlags then
            tbl2.flushPassiveUnmountEffectsCollecting(child, tbl3)
        end

        if bit32.band(arg1.flags, ReactFiberFlags.Passive) ~= ReactFiberFlags.NoFlags then
            table.insert(tbl3, arg1)
            setCurrentFiber(arg1)
            commitPassiveUnmount(arg1)
            resetCurrentFiber()
        end

        arg1 = arg1.sibling
    end
end

function tbl2.flushPassiveUnmountEffectsInsideOfDeletedTree(arg1, arg2)
    if bit32.band(arg1.subtreeFlags, ReactFiberFlags.PassiveStatic) ~= ReactFiberFlags.NoFlags
        or enableNewTreeCleanupPath and deletedTreeCleanUpLevel >= 2
    then
        local child = arg1.child
        while child ~= nil do
            local sibling = child.sibling
            tbl2.flushPassiveUnmountEffectsInsideOfDeletedTree(child, arg2)
            child = sibling
        end
    end

    if bit32.band(arg1.flags, ReactFiberFlags.PassiveStatic) ~= ReactFiberFlags.NoFlags then
        setCurrentFiber(arg1)
        commitPassiveUnmountInsideDeletedTree(arg1, arg2)

        resetCurrentFiber()
    end

    if enableNewTreeCleanupPath and deletedTreeCleanUpLevel >= 2 then
        tbl2.detachFiberAfterEffects(arg1)
    end
end

var17 = function(): boolean
    if var10 == nil then
        return false
    end

    local var18 = var10
    local var19 = NoLanes5
    var10 = nil
    NoLanes5 = ReactFiberLane.NoLanes

    invariant(bit32.band(getExecutionContext, 0x30) == 0, "Cannot flush passive effects while already rendering.")

    if __DEV__ and enableDebugTracing then
        DebugTracing.logPassiveEffectsStarted(var19)
    end

    if enableSchedulingProfiler then
        SchedulingProfiler.markPassiveEffectsStarted(var19)
    end

    local num7 = getExecutionContext
    getExecutionContext = bit32.bor(getExecutionContext, 0x20)
    local var20 = tbl2.pushInteractions(var18)

    if ReactFeatureFlags.enableCommitTraversalTrims then
        if not (ReactFeatureFlags.enableProfilerTimer and ReactFeatureFlags.enableProfilerCommitHooks) then
            local passiveMountFibers = tbl2.passiveMountFibers or {}
            tbl2.passiveMountFibers = nil
            tbl2.flushPassiveUnmountEffectsCollecting(var18.current, passiveMountFibers)
            tbl2.commitPassiveMountEffectsOnFibers(var18, passiveMountFibers)
            table.clear(passiveMountFibers)
            tbl2.passiveMountFibers = passiveMountFibers
        else
            flushPassiveUnmountEffects(var18.current)
            func5(var18, var18.current)
        end
    else
        flushPassiveUnmountEffects(var18.current)
        func5(var18, var18.current)
    end

    if __DEV__ and enableDebugTracing then
        DebugTracing.logPassiveEffectsStopped()
    end

    if enableSchedulingProfiler then
        SchedulingProfiler.markPassiveEffectsStopped(var18)
    end

    if __DEV__ and enableDoubleInvokingEffects then
        commitDoubleInvokeEffectsInDEV(var18.current, true)
    end

    if ReactFeatureFlags.enableSchedulerTracing then
        tbl2.popInteractions(var20)
        tbl2.finishPendingInteractions(var18, var19)
    end

    getExecutionContext = num7

    flushSyncCallbackQueue()

    if var10 == nil then
        num5 = 0
    else
        num5 += 1
    end

    return true
end

function module.isAlreadyFailedLegacyErrorBoundary(stateNode)
    return not (var9 == nil) and var9:has(stateNode)
end

function module.markLegacyErrorBoundaryAsFailed(arg1)
    if var9 == nil then
        var9 = Set.new({ arg1 })
        return
    end
    var9:add(arg1)
end

function module.onUncaughtError(arg1)
    if not bool1 then
        bool1 = true
        var8 = arg1
    end
end

var2 = function(arg1, arg2, arg3)
    local capturedValue = createCapturedValue(arg3, arg2)

    local rootErrorUpdate = createRootErrorUpdate(arg1, capturedValue, SyncLane, module.onUncaughtError)
    enqueueUpdate(arg1, rootErrorUpdate)
    local var18 = module.requestEventTime()
    local var19 = tbl2.markUpdateLaneFromFiberToRoot(arg1, SyncLane)
    if var19 ~= nil then
        markRootUpdated(var19, SyncLane, var18)
        var1(var19, var18)
        tbl2.schedulePendingInteractions(var19, SyncLane)
    end
end

function module.captureCommitPhaseError(arg1, arg2, arg3)
    if arg1.tag == ReactWorkTags.HostRoot then
        var2(arg1, arg1, arg3)
        return
    end

    if not skipUnmountedBoundaries then
        arg2 = arg1.return_
    end

    while arg2 ~= nil do
        if arg2.tag == ReactWorkTags.HostRoot then
            var2(arg2, arg1, arg3)
            return
        end
        if arg2.tag == ReactWorkTags.ClassComponent then
            local type = arg2.type
            local stateNode = arg2.stateNode

            if typeof(type.getDerivedStateFromError) == "function"
                or typeof(stateNode.componentDidCatch) == "function" and not module.isAlreadyFailedLegacyErrorBoundary(stateNode)
            then
                local capturedValue = createCapturedValue(arg3, arg1)
                local classErrorUpdate = createClassErrorUpdate(arg2, capturedValue, SyncLane)
                enqueueUpdate(arg2, classErrorUpdate)
                local var18 = module.requestEventTime()
                local var19 = tbl2.markUpdateLaneFromFiberToRoot(arg2, SyncLane)
                if var19 ~= nil then
                    markRootUpdated(var19, SyncLane, var18)
                    var1(var19, var18)
                    tbl2.schedulePendingInteractions(var19, SyncLane)
                end
                return
            end
        end
        arg2 = arg2.return_
    end
end

function module.pingSuspendedRoot(arg1, arg2, arg3)
    local pingCache = arg1.pingCache
    if pingCache ~= nil then
        pingCache[arg2] = nil
    end

    local var18 = module.requestEventTime()
    markRootPinged(arg1, arg3, var18)

    if getWorkInProgressRoot == arg1 and isSubsetOfLanes(NoLanes, arg3) then
        if num2 == 4 or num2 == 3 and includesOnlyRetries(NoLanes) and now() - num3 < 500 then
            tbl2.prepareFreshStack(arg1, ReactFiberLane.NoLanes)
        else
            NoLanes4 = mergeLanes(NoLanes4, arg3)
        end
    end

    var1(arg1, var18)
    tbl2.schedulePendingInteractions(arg1, arg3)
end

function retryTimedOutBoundary(arg1, arg2)
    if arg2 == ReactFiberLane.NoLane then
        arg2 = requestRetryLane(arg1)
    end

    local var18 = module.requestEventTime()
    local var19 = tbl2.markUpdateLaneFromFiberToRoot(arg1, arg2)
    if var19 ~= nil then
        markRootUpdated(var19, arg2, var18)
        var1(var19, var18)
        tbl2.schedulePendingInteractions(var19, arg2)
    end
end

function module.resolveRetryWakeable(arg1, arg2)
    local noLane = ReactFiberLane.NoLane

    local stateNode = arg1.stateNode

    if stateNode ~= nil then
        stateNode:delete(arg2)
    end

    retryTimedOutBoundary(arg1, noLane)
end

function jnd(num7: number): number
    if num7 < 120 then
        return 120
    end

    if num7 < 480 then
        return 480
    end

    if num7 < 1080 then
        return 1080
    end

    if num7 < 1920 then
        return 1920
    end

    if num7 < 3000 then
        return 3000
    end

    if num7 < 4320 then
        return 4320
    end
    return math.ceil(num7 / 1960) * 1960
end

function tbl2.checkForNestedUpdates()
    if num4 > 50 then
        num4 = 0
        var13 = nil
        invariant(
            false,
            "Maximum update depth exceeded. This can happen when a component repeatedly calls setState inside componentWillUpdate or componentDidUpdate. React limits the number of nested updates to prevent infinite loops."
        )
    end

    if __DEV__ and num5 > 50 then
        num5 = 0
        console.error(
            "Maximum update depth exceeded. This can happen when a component calls setState inside useEffect, but useEffect either doesn't have a dependency array, or one of the dependencies changes on every render."
        )
    end
end

function flushRenderPhaseStrictModeWarningsInDEV()
    if not __DEV__ then
        return
    end

    ReactStrictModeWarningsNew.flushLegacyContextWarning()

    if ReactFeatureFlags.warnAboutDeprecatedLifecycles then
        ReactStrictModeWarningsNew.flushPendingUnsafeLifecycleWarnings()
    end
end

function commitDoubleInvokeEffectsInDEV(current2, bool5: boolean)
    if not __DEV__ or not enableDoubleInvokingEffects then
        return
    end

    setCurrentFiber(current2)
    invokeEffectsInDev(current2, ReactFiberFlags.MountLayoutDev, invokeLayoutEffectUnmountInDEV)

    if bool5 then
        invokeEffectsInDev(current2, ReactFiberFlags.MountPassiveDev, invokePassiveEffectUnmountInDEV)
    end

    invokeEffectsInDev(current2, ReactFiberFlags.MountLayoutDev, invokeLayoutEffectMountInDEV)

    if bool5 then
        invokeEffectsInDev(current2, ReactFiberFlags.MountPassiveDev, invokePassiveEffectMountInDEV)
    end

    resetCurrentFiber()
end

function invokeEffectsInDev(arg1, arg2, callback: (...any) -> (...any))
    if not __DEV__ or not enableDoubleInvokingEffects then
        return
    end
    while arg1 ~= nil do
        if arg1.child ~= nil and bit32.band(arg1.subtreeFlags, arg2) ~= ReactFiberFlags.NoFlags then
            invokeEffectsInDev(arg1.child, arg2, callback)
        end

        if bit32.band(arg1.flags, arg2) ~= ReactFiberFlags.NoFlags then
            callback(arg1)
        end

        arg1 = arg1.sibling
    end
end

local var18 = nil
function tbl2.warnAboutUpdateOnNotYetMountedFiberInDEV(arg1)
    if not __DEV__ then
        return
    end

    if bit32.band(getExecutionContext, 0x10) ~= 0 then
        return
    end

    if bit32.band(arg1.mode, bit32.bor(ReactTypeOfMode.BlockingMode, ReactTypeOfMode.ConcurrentMode)) == 0 then
        return
    end

    local tag = arg1.tag

    if tag ~= ReactWorkTags.IndeterminateComponent
        and tag ~= ReactWorkTags.HostRoot
        and tag ~= ReactWorkTags.ClassComponent
        and tag ~= ReactWorkTags.FunctionComponent
        and tag ~= ReactWorkTags.ForwardRef
        and tag ~= ReactWorkTags.MemoComponent
        and tag ~= ReactWorkTags.SimpleMemoComponent
        and tag ~= ReactWorkTags.Block
    then
        return
    end

    local componentName = getComponentName(arg1.type) or "ReactComponent"
    if var18 ~= nil then
        if var18[componentName] then
            return
        end
        var18[componentName] = true
    else
        var18 = {
            [componentName] = true
        }
    end
    local current2 = ReactCurrentFiber.current
    local success, result = pcall(function()
        setCurrentFiber(arg1)
        console.error(
            "Can't perform a React state update on a component that hasn't mounted yet. This indicates that you have a side-effect in your render function that asynchronously later calls tries to update the component. Move this work to useEffect instead."
        )
    end)

    if current2 then
        setCurrentFiber(arg1)
    else
        resetCurrentFiber()
    end

    if not success then
        error(result)
    end
end

if __DEV__ and ReactFeatureFlags.replayFailedUnitOfWorkWithInvokeGuardedCallback then
    function tbl2.beginWork(arg1, arg2, arg3)
        local var19 = ReactFiberNew.assignFiberPropertiesInDEV(nil, arg2)

        local success, result = xpcall(beginWork, describeError, arg1, arg2, arg3)
        if not success then
            if result ~= nil and typeof(result) == "table" and typeof(result.andThen) == "function" then
                error(result)
            end

            resetContextDependencies()
            func3()
            unwindInterruptedWork(arg2)

            ReactFiberNew.assignFiberPropertiesInDEV(arg2, var19)

            if ReactFeatureFlags.enableProfilerTimer and bit32.band(arg2.mode, ReactTypeOfMode.ProfileMode) ~= 0 then
                ReactProfilerTimerNew.startProfilerTimer(arg2)
            end

            invokeGuardedCallback(nil, beginWork, nil, arg1, arg2, arg3)

            if hasCaughtError() then
                local var20 = clearCaughtError()

                error(var20)
                return result
            end

            error(result)
        end

        return result
    end
else
    tbl2.beginWork = beginWork
end

local bool5 = false
local var19 = nil
var19 = __DEV__ and {} or var19

function tbl2.warnAboutRenderPhaseUpdatesInDEV(arg1)
    if not __DEV__ or not ReactCurrentFiber.isRendering or bit32.band(getExecutionContext, 0x10) == 0 then
        return
    end

    if not tbl1.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef then
        initReactFiberHooks()
    end

    if tbl1.getIsUpdatingOpaqueValueInRenderPhaseInDEVRef() then
        return
    end

    if arg1.tag == ReactWorkTags.FunctionComponent
        or arg1.tag == ReactWorkTags.ForwardRef
        or arg1.tag == ReactWorkTags.SimpleMemoComponent
    then
        local componentName = var4 and getComponentName(var4.type) or "Unknown"

        if var19[componentName] == nil then
            var19[componentName] = true
            local componentName2 = getComponentName(arg1.type) or "Unknown"

            console.error(
                "Cannot update a component (`%s`) while rendering a different component (`%s`). To locate the bad setState() call inside `%s`, follow the stack trace as described in https://reactjs.org/link/setstate-in-render",
                componentName2,
                componentName,
                componentName
            )
        end
    elseif arg1.tag == ReactWorkTags.ClassComponent and not bool5 then
        console.error(
            "Cannot update during an existing state transition (such as within `render`). Render methods should be a pure function of props and state."
        )

        bool5 = true
    end
end

module.IsThisRendererActing = { current = false }

function module.warnIfNotScopedWithMatchingAct(arg1)
    if not __DEV__
        or ReactFiberHostConfig.warnsIfNotActing ~= true
        or IsSomeRendererActing.current ~= true
        or module.IsThisRendererActing.current == true
    then
        return
    end
    local current2 = ReactCurrentFiber.current
    local success, result = pcall(function()
        setCurrentFiber(arg1)

        console.error(
            "It looks like you're using the wrong act() around your test interactions.\nBe sure to use the matching version of act() corresponding to your renderer:\n\n-- for react-roblox:\nlocal React = require(Packages.React)\n-- ...\nReact.TestUtils.act(function() ... end)\n\n-- for react-test-renderer:\nlocal TestRenderer = require(Packages.ReactTestRenderer)\n-- ...\nTestRenderer.act(function() ... end)"
        )
    end)

    if current2 then
        setCurrentFiber(arg1)
    else
        resetCurrentFiber()
    end

    if not success then
        error(result)
    end
end

function module.warnIfNotCurrentlyActingEffectsInDEV(arg1)
    if __DEV__
        and ReactFiberHostConfig.warnsIfNotActing == true
        and bit32.band(arg1.mode, ReactTypeOfMode.StrictMode) ~= ReactTypeOfMode.NoMode
        and IsSomeRendererActing.current == false
        and module.IsThisRendererActing.current == false
    then
        console.error(
            "An update to %s ran an effect, but was not wrapped in act(...).\n\nWhen testing, code that causes React state updates should be wrapped into act(...):\n\nact(function()\n  --[[ fire events that update state ]]\nend)\n--[[ assert on the output ]]\n\nThis ensures that you're testing the behavior the user would see in the real client. Learn more at https://reactjs.org/link/wrap-tests-with-act",
            getComponentName(arg1.type)
        )
    end
end

function module.warnIfNotCurrentlyActingUpdatesInDEV(arg1)
    if not __DEV__
        or ReactFiberHostConfig.warnsIfNotActing ~= true
        or getExecutionContext ~= 0
        or IsSomeRendererActing.current ~= false
        or module.IsThisRendererActing.current ~= false
    then
        return
    end
    local var20 = current
    local success, result = pcall(function()
        setCurrentFiber(arg1)

        console.error(
            "An update to %s inside a test was not wrapped in act(...).\n\nWhen testing, code that causes React state updates should be wrapped into act(...):\n\nact(function()\n  --[[ fire events that update state ]]\nend)\n--[[ assert on the output ]]\n\nThis ensures that you're testing the behavior the user would see in the client application. Learn more at https://reactjs.org/link/wrap-tests-with-act",
            getComponentName(arg1.type)
        )
    end)

    if var20 then
        setCurrentFiber(arg1)
    else
        resetCurrentFiber()
    end

    if success then
        return result
    end
end

local bool6 = false

function module.warnIfUnmockedScheduler(arg1)
    if not __DEV__ or bool6 ~= false or Scheduler.unstable_flushAllWithoutAsserting ~= nil then
        return
    end

    if bit32.band(arg1.mode, ReactTypeOfMode.BlockingMode) ~= 0 or bit32.band(arg1.mode, ReactTypeOfMode.ConcurrentMode) ~= 0 then
        bool6 = true

        console.error(
            "In Concurrent or Sync modes, the 'scheduler' module needs to be mocked to guarantee consistent behaviour across tests and client application. For example, with Jest: \njest.mock('scheduler', function() return require(Packages.Scheduler).unstable_mock end)\n\nFor more info, visit https://reactjs.org/link/mock-scheduler"
        )
        return
    end

    if ReactFeatureFlags.warnAboutUnmockedScheduler == true then
        bool6 = true

        console.error(
            "Starting from React v18, the 'scheduler' module will need to be mocked to guarantee consistent behaviour across tests and client applications. For example, with Jest: \njest.mock('scheduler', function() return require(Packages.Scheduler).unstable_mock end)\n\nFor more info, visit https://reactjs.org/link/mock-scheduler"
        )
    end
end

function computeThreadID(arg1, arg2)
    return arg2 * 1000 + arg1.interactionThreadID
end

function module.markSpawnedWork(arg1)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return
    end

    if var14 == nil then
        var14 = { arg1 }
    else
        table.insert(var14, arg1)
    end
end

function scheduleInteractions(arg1, arg2, arg3)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return
    end

    if not (arg3.size > 0) then
        return
    end

    local pendingInteractionMap = arg1.pendingInteractionMap
    local var20 = pendingInteractionMap:get(arg2)
    if var20 ~= nil then
        arg3:forEach(function(arg4)
            if not var20:has(arg4) then
                arg4.__count += 1
            end

            var20:add(arg4)
        end)
    else
        pendingInteractionMap:set(arg2, Set.new(arg3))

        for _, value in arg3 do
            value.__count += 1
        end
    end

    local current2 = __subscriberRef.current
    if current2 ~= nil then
        local var21 = computeThreadID(arg1, arg2)
        current2.onWorkScheduled(arg3, var21)
    end
end

function tbl2.schedulePendingInteractions(arg1, arg2)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return
    end

    scheduleInteractions(arg1, arg2, __interactionsRef.current)
end

function tbl2.startWorkOnPendingInteractions(arg1, arg2)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return
    end

    local set = Set.new()
    arg1.pendingInteractionMap:forEach(function(arg3, arg4)
        if includesSomeLane(arg2, arg4) then
            arg3:forEach(function(arg5)
                set:add(arg5)
            end)
        end
    end)

    arg1.memoizedInteractions = set

    if not (set.size > 0) then
        return
    end

    local current2 = __subscriberRef.current
    if current2 == nil then
        return
    end

    local var20 = computeThreadID(arg1, arg2)

    local success, result = xpcall(current2.onWorkStarted, describeError, set, var20)
    if not success then
        scheduleCallback(ImmediatePriority, function()
            error(result)
        end)
    end
end

function tbl2.finishPendingInteractions(arg1, arg2)
    if not ReactFeatureFlags.enableSchedulerTracing then
        return
    end

    local pendingLanes = arg1.pendingLanes

    local current2 = nil

    local success = true
    local var20 = nil
    if current2 ~= nil and arg1.memoizedInteractions.size > 0 then
        local var21 = computeThreadID(arg1, arg2)
        current2 = __subscriberRef.current

        local onWorkStopped = current2.onWorkStopped
        local var22 = describeError
        local memoizedInteractions = arg1.memoizedInteractions
        local result
        success, result = xpcall(onWorkStopped, var22, memoizedInteractions, var21)
        var20 = result
    end

    local pendingInteractionMap = arg1.pendingInteractionMap
    pendingInteractionMap:forEach(function(arg3, arg4)
        if includesSomeLane(pendingLanes, arg4) then
            return
        end

        pendingInteractionMap:delete(arg4)
        arg3:forEach(function(arg5)
            arg5.__count -= 1

            if current2 == nil or arg5.__count ~= 0 then
                return
            end

            local success2, result = xpcall(current2.onInteractionScheduledWorkCompleted, describeError, arg5)

            if not success2 then
                scheduleCallback(ImmediatePriority, function()
                    error(result)
                end)
            end
        end)
    end)

    if not success then
        scheduleCallback(ImmediatePriority, function()
            error(var20)
        end)
    end
end

local bool7 = false
local bool8 = false

local unstable_flushAllWithoutAsserting = Scheduler.unstable_flushAllWithoutAsserting
local bool9 = typeof(unstable_flushAllWithoutAsserting) == "function"

local function flushActWork()
    if unstable_flushAllWithoutAsserting ~= nil then
        local bool10 = bool7
        bool7 = true
        local success, result = xpcall(unstable_flushAllWithoutAsserting, describeError)

        bool7 = bool10

        if success then
            return result
        end

        error(result)
        return
    end

    local bool10 = bool7
    bool7 = true

    local success, result = xpcall(function(): boolean
        local bool11 = false

        while module.flushPassiveEffects() do
            bool11 = true
        end

        return bool11
    end, describeError)

    bool7 = bool10

    if success then
        return result
    end

    error(result)
end

local function flushWorkAndMicroTasks(callback: (...any) -> (...any))
    local success, result = xpcall(flushActWork, describeError)
    if success then
        success, result = xpcall(enqueueTask, describeError, function()
            if flushActWork() then
                flushWorkAndMicroTasks(callback)
                return
            end
            callback()
        end)
    end

    if not success then
        callback(result)
    end
end

function module.act(func6: (...any) -> (...any))
    if not __DEV__ and not ReactGlobals.__ROACT_17_MOCK_SCHEDULER__ and bool4 == false then
        bool4 = true

        console.error("act(...) is not supported in production builds of React, and might not behave as expected.")
    end

    local num7 = num6
    num6 += 1

    local current2 = IsSomeRendererActing.current
    local current3 = module.IsThisRendererActing.current
    local bool10 = bool8
    IsSomeRendererActing.current = true
    module.IsThisRendererActing.current = true
    bool8 = true

    local function onDone() -- Luacid: Inlined by compiler; 6 call sites recovered
        num6 -= 1
        IsSomeRendererActing.current = current2
        module.IsThisRendererActing.current = current3
        bool8 = bool10
        if __DEV__ and num7 < num6 then
            console.error(
                "You seem to have overlapping act() calls, this is not supported. Be sure to await previous act() calls before making a new one. "
            )
        end
    end

    local success, result = xpcall(module.batchedUpdates, describeError, func6)
    if not success then
        onDone()
        error(result)
    end

    if result == nil or typeof(result) ~= "table" or typeof(result.andThen) ~= "function" then
        if __DEV__ and result ~= nil then
            console.error(
                "The callback passed to act(...) function must return nil, or a Promise. You returned %s",
                tostring(result)
            )
        end

        local success2, result2 = xpcall(function()
            if num6 == 1 and (bool9 == false or current2 == false) then
                flushActWork()
            end

            onDone()
        end, describeError)

        if not success2 then
            onDone()
            error(result2)
        end

        return {
            andThen = function(_, callback, _)
                if __DEV__ then
                    console.error("Do not await the result of calling act(...) with sync logic, it is not a Promise.")
                end

                callback()
            end
        }
    end

    local bool11 = false
    if __DEV__ and typeof(Promise) ~= nil then
        Promise.resolve():andThen(function() end):andThen(function()
            if bool11 == false then
                console.error(
                    "You called act(Promise.new(function() --[[ ... ]] end)) without :await() or :expect(). This could lead to unexpected testing behaviour, interleaving multiple act calls and mixing their scopes. You should - act(function() Promise.new(function() --[[ ... ]] end):await() end);"
                )
            end
        end)
    end

    return {
        andThen = function(_, callback, callback2)
            bool11 = true
            return result:andThen(function()
                if num6 > 1 or bool9 == true and current2 == true then
                    onDone()
                    callback()
                    return
                end

                flushWorkAndMicroTasks(function(arg1)
                    onDone()

                    if arg1 then
                        callback2(arg1)
                        return
                    end
                    callback()
                end)
            end, function(arg1)
                onDone()
                callback2(arg1)
            end)
        end
    }
end

function tbl2.detachFiberAfterEffects(arg1)
    if enableNewTreeCleanupPath then
        local alternate = arg1.alternate
        if alternate ~= nil then
            arg1.alternate = nil
            tbl2.detachFiberAfterEffects(alternate)
        end
    end

    if not (enableNewTreeCleanupPath and deletedTreeCleanUpLevel >= 2) then
        arg1.child = nil
        arg1.deletions = nil
        arg1.dependencies = nil
        arg1.memoizedProps = nil
        arg1.memoizedState = nil
        arg1.pendingProps = nil
        arg1.sibling = nil
        arg1.stateNode = nil
        arg1.updateQueue = nil

        if __DEV__ then
            arg1._debugOwner = nil
        end

        return
    end

    arg1.child = nil
    arg1.deletions = nil
    arg1.sibling = nil

    if __DEV__ then
        arg1._debugOwner = nil
    end

    if not (deletedTreeCleanUpLevel >= 3) then
        return
    end

    arg1.return_ = nil
    arg1.dependencies = nil
    arg1.memoizedProps = nil
    arg1.memoizedState = nil
    arg1.pendingProps = nil
    arg1.stateNode = nil

    arg1.updateQueue = nil
end

return module
