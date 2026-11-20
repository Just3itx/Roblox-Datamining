-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local Object = require(scriptParentParent.LuauPolyfill).Object

local console = require(scriptParentParent.Shared).console

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local _ReactCapturedValue = require(script.Parent.ReactCapturedValue)

local ReactUpdateQueueNew = require(script.Parent["ReactUpdateQueue.new"])

local _Shared = require(scriptParentParent.Shared)

local ReactFiberSuspenseContextNew = require(script.Parent["ReactFiberSuspenseContext.new"])

local getComponentName = require(scriptParentParent.Shared).getComponentName

local ReactWorkTags = require(script.Parent.ReactWorkTags)
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent

local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local DidCapture = ReactFiberFlags.DidCapture
local Incomplete = ReactFiberFlags.Incomplete
local NoFlags = ReactFiberFlags.NoFlags
local ShouldCapture = ReactFiberFlags.ShouldCapture
local LifecycleEffectMask = ReactFiberFlags.LifecycleEffectMask
local ForceUpdateForLegacySuspense = ReactFiberFlags.ForceUpdateForLegacySuspense

local shouldCaptureSuspense = require(script.Parent["ReactFiberSuspenseComponent.new"]).shouldCaptureSuspense
local ReactTypeOfMode = require(script.Parent.ReactTypeOfMode)
local NoMode = ReactTypeOfMode.NoMode
local BlockingMode = ReactTypeOfMode.BlockingMode
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode
local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler
local createCapturedValue = require(script.Parent.ReactCapturedValue).createCapturedValue

local enqueueCapturedUpdate = ReactUpdateQueueNew.enqueueCapturedUpdate
local createUpdate = ReactUpdateQueueNew.createUpdate
local CaptureUpdate = ReactUpdateQueueNew.CaptureUpdate
local ForceUpdate = ReactUpdateQueueNew.ForceUpdate
local enqueueUpdate = ReactUpdateQueueNew.enqueueUpdate
local markFailedErrorBoundaryForHotReloading = require(script.Parent["ReactFiberHotReloading.new"]).markFailedErrorBoundaryForHotReloading

local hasSuspenseContext = ReactFiberSuspenseContextNew.hasSuspenseContext

local InvisibleParentSuspenseContext = ReactFiberSuspenseContextNew.InvisibleParentSuspenseContext
local suspenseStackCursor = ReactFiberSuspenseContextNew.suspenseStackCursor

local ReactFiberWorkLoopNew = nil
local markLegacyErrorBoundaryAsFailed = nil
local isAlreadyFailedLegacyErrorBoundary = nil
local pingSuspendedRoot = nil

local function func1(...)
    if not markLegacyErrorBoundaryAsFailed then
        ReactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])
        markLegacyErrorBoundaryAsFailed = ReactFiberWorkLoopNew.markLegacyErrorBoundaryAsFailed
    end
    return markLegacyErrorBoundaryAsFailed(...)
end

local function func2(...)
    if ReactFiberWorkLoopNew == nil then
        ReactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])
    end
    pingSuspendedRoot = ReactFiberWorkLoopNew.pingSuspendedRoot
    return pingSuspendedRoot(...)
end

local function func3(...)
    if ReactFiberWorkLoopNew == nil then
        ReactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])
    end
    isAlreadyFailedLegacyErrorBoundary = ReactFiberWorkLoopNew.isAlreadyFailedLegacyErrorBoundary
    return isAlreadyFailedLegacyErrorBoundary(...)
end

local logCapturedError = require(script.Parent.ReactFiberErrorLogger).logCapturedError
local logComponentSuspended = require(script.Parent.DebugTracing).logComponentSuspended

local markComponentSuspended = require(script.Parent.SchedulingProfiler).markComponentSuspended

local SyncLane = ReactFiberLane.SyncLane
local NoTimestamp = ReactFiberLane.NoTimestamp
local includesSomeLane = ReactFiberLane.includesSomeLane
local mergeLanes = ReactFiberLane.mergeLanes
local pickArbitraryLane = ReactFiberLane.pickArbitraryLane

function createRootErrorUpdate(arg1, arg2, arg3, callback)
    local update = createUpdate(NoTimestamp, arg3)

    update.tag = CaptureUpdate

    update.payload = {
        element = Object.None
    }
    local value = arg2.value
    function update.callback()
        if callback ~= nil then
            callback(value)
        end
        logCapturedError(arg1, arg2)
    end
    return update
end

function createClassErrorUpdate(arg1, arg2, arg3)
    local update = createUpdate(NoTimestamp, arg3)
    update.tag = CaptureUpdate
    local getDerivedStateFromError = arg1.type.getDerivedStateFromError
    if typeof(getDerivedStateFromError) == "function" then
        local value = arg2.value
        function update.payload()
            logCapturedError(arg1, arg2)
            return getDerivedStateFromError(value)
        end
    end

    local stateNode = arg1.stateNode
    if stateNode == nil or typeof(stateNode.componentDidCatch) ~= "function" then
        if ReactGlobals.__DEV__ then
            function update.callback()
                markFailedErrorBoundaryForHotReloading(arg1)
            end
        end
        return update
    end

    function update.callback()
        if ReactGlobals.__DEV__ then
            markFailedErrorBoundaryForHotReloading(arg1)
        end
        if typeof(getDerivedStateFromError) ~= "function" then
            func1(stateNode)

            logCapturedError(arg1, arg2)
        end
        local value = arg2.value
        local stack = arg2.stack

        stateNode:componentDidCatch(value, { componentStack = stack or "" })

        if ReactGlobals.__DEV__ and typeof(getDerivedStateFromError) ~= "function" and not includesSomeLane(arg1.lanes, SyncLane) then
            console.error(
                "%s: Error boundaries should implement getDerivedStateFromError(). In that method, return a state update to display an error message or fallback UI.",
                getComponentName(arg1.type) or "Unknown"
            )
        end
    end

    return update
end

local function attachPingListener(arg1, arg2, lanes)
    local pingCache = arg1.pingCache
    local tbl1

    if pingCache == nil then
        tbl1 = {}
        arg1.pingCache = {
            [arg2] = tbl1
        }
        local _pingCache = arg1.pingCache
    else
        tbl1 = pingCache[arg2]

        if tbl1 == nil then
            tbl1 = {}
            pingCache[arg2] = tbl1
        end
    end

    if tbl1[lanes] then
        return
    end
    tbl1[lanes] = true
    local function func4()
        return func2(arg1, arg2, lanes)
    end
    arg2:andThen(func4, func4)
end

function throwException(arg1, arg2, arg3, arg4, lanes, arg5, callback)
    arg3.flags = bit32.bor(arg3.flags, Incomplete)
    local _return

    if arg4 == nil or typeof(arg4) ~= "table" or typeof(arg4.andThen) ~= "function" then
        _return = arg2
    else
        if ReactGlobals.__DEV__ and enableDebugTracing and bit32.band(arg3.mode, DebugTracingMode) ~= 0 then
            local componentName = getComponentName(arg3.type) or "Unknown"
            logComponentSuspended(componentName, arg4)
        end

        if enableSchedulingProfiler then
            markComponentSuspended(arg3, arg4)
        end

        if bit32.band(arg3.mode, BlockingMode) == NoMode then
            local alternate = arg3.alternate
            if alternate then
                arg3.updateQueue = alternate.updateQueue
                arg3.memoizedState = alternate.memoizedState
                arg3.lanes = alternate.lanes
            else
                arg3.updateQueue = nil
                arg3.memoizedState = nil
            end
        end

        local var1 = hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext)
        _return = arg2

        repeat
            if arg2.tag == SuspenseComponent and shouldCaptureSuspense(arg2, var1) then
                local updateQueue = arg2.updateQueue
                if updateQueue == nil then
                    arg2.updateQueue = {
                        [arg4] = true
                    }
                else
                    updateQueue[arg4] = true
                end

                if bit32.band(arg2.mode, BlockingMode) == NoMode then
                    local flags = arg2.flags
                    arg2.flags = bit32.bor(flags, DidCapture)
                    arg3.flags = bit32.bor(arg3.flags, ForceUpdateForLegacySuspense)

                    arg3.flags = bit32.band(arg3.flags, bit32.bnot(bit32.bor(LifecycleEffectMask, Incomplete)))

                    if arg3.tag == ClassComponent then
                        if arg3.alternate == nil then
                            arg3.tag = IncompleteClassComponent
                        else
                            local update = createUpdate(NoTimestamp, SyncLane)
                            update.tag = ForceUpdate
                            enqueueUpdate(arg3, update)
                        end
                    end

                    arg3.lanes = mergeLanes(arg3.lanes, SyncLane)

                    return
                end

                attachPingListener(arg1, arg4, lanes)

                local flags = arg2.flags
                arg2.flags = bit32.bor(flags, ShouldCapture)
                arg2.lanes = lanes

                return
            end

            arg2 = arg2.return_
        until arg2 == nil

        arg4 = (getComponentName(arg3.type) or "A React component") .. " suspended while rendering, but no fallback UI was specified.\n\nAdd a <Suspense fallback=...> component higher in the tree to provide a loading indicator or placeholder to display."
    end

    callback()

    local capturedValue = createCapturedValue(arg4, arg3)

    while _return.tag ~= HostRoot do
        if _return.tag == ClassComponent then
            local type = _return.type
            local stateNode = _return.stateNode

            if bit32.band(_return.flags, DidCapture) == NoFlags
                and (typeof(type.getDerivedStateFromError) == "function"
                    or stateNode ~= nil and typeof(stateNode.componentDidCatch) == "function" and not func3(stateNode))
            then
                local flags = _return.flags
                _return.flags = bit32.bor(flags, ShouldCapture)
                local var1 = pickArbitraryLane(lanes)
                _return.lanes = mergeLanes(_return.lanes, var1)

                local classErrorUpdate = createClassErrorUpdate(_return, capturedValue, var1)
                enqueueCapturedUpdate(_return, classErrorUpdate)
                return
            end
        end
        _return = _return.return_
        if _return == nil then
            return
        end
    end

    local flags = _return.flags
    _return.flags = bit32.bor(flags, ShouldCapture)
    local var1 = pickArbitraryLane(lanes)
    _return.lanes = mergeLanes(_return.lanes, var1)

    local rootErrorUpdate = createRootErrorUpdate(_return, capturedValue, var1, arg5)
    enqueueCapturedUpdate(_return, rootErrorUpdate)
end
return {
    throwException = throwException,
    createRootErrorUpdate = createRootErrorUpdate,
    createClassErrorUpdate = createClassErrorUpdate
}
