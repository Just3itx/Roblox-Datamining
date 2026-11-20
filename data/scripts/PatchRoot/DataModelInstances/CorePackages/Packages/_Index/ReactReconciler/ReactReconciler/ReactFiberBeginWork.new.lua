-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function unimplemented(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: " .. tostring(str1))
    error("FIXME (roblox): " .. str1 .. " is unimplemented", 2)
end

local scriptParentParent = script.Parent.Parent

local console = require(scriptParentParent.Shared).console
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local inspect = LuauPolyfill.util.inspect

local __DEV__ = require(scriptParentParent.ReactGlobals).__DEV__

local __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ = require(scriptParentParent.ReactGlobals).__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__
local __COMPAT_WARNINGS__ = require(scriptParentParent.ReactGlobals).__COMPAT_WARNINGS__

local _Shared = require(scriptParentParent.Shared)

local _React = require(scriptParentParent.React)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local _ReactFiberSuspenseComponentNew = require(script.Parent["ReactFiberSuspenseComponent.new"])

local ReactFiberSuspenseContextNew = require(script.Parent["ReactFiberSuspenseContext.new"])

local _ReactFiberOffscreenComponent = require(script.Parent.ReactFiberOffscreenComponent)

local checkPropTypes = require(scriptParentParent.Shared).checkPropTypes

local ReactWorkTags = require(script.Parent.ReactWorkTags)

local FunctionComponent = ReactWorkTags.FunctionComponent
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local HostComponent = ReactWorkTags.HostComponent
local HostText = ReactWorkTags.HostText
local HostPortal = ReactWorkTags.HostPortal
local ForwardRef = ReactWorkTags.ForwardRef
local Fragment = ReactWorkTags.Fragment
local Mode = ReactWorkTags.Mode
local ContextProvider = ReactWorkTags.ContextProvider
local ContextConsumer = ReactWorkTags.ContextConsumer
local Profiler = ReactWorkTags.Profiler
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local MemoComponent = ReactWorkTags.MemoComponent
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local LazyComponent = ReactWorkTags.LazyComponent
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent

local OffscreenComponent = ReactWorkTags.OffscreenComponent
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local NoFlags = ReactFiberFlags.NoFlags
local StaticMask = ReactFiberFlags.StaticMask
local PerformedWork = ReactFiberFlags.PerformedWork
local Placement = ReactFiberFlags.Placement
local Hydrating = ReactFiberFlags.Hydrating
local ContentReset = ReactFiberFlags.ContentReset
local DidCapture = ReactFiberFlags.DidCapture

local Ref = ReactFiberFlags.Ref
local Deletion = ReactFiberFlags.Deletion
local ForceUpdateForLegacySuspense = ReactFiberFlags.ForceUpdateForLegacySuspense
local ReactSharedInternals = require(scriptParentParent.Shared).ReactSharedInternals
local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags

local debugRenderPhaseSideEffectsForStrictMode = ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode
local disableLegacyContext = ReactFeatureFlags.disableLegacyContext
local disableModulePatternComponents = ReactFeatureFlags.disableModulePatternComponents
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer

local warnAboutDefaultPropsOnFunctionComponents = ReactFeatureFlags.warnAboutDefaultPropsOnFunctionComponents

local invariant = require(scriptParentParent.Shared).invariant
local describeError = require(scriptParentParent.Shared).describeError
local shallowEqual = require(scriptParentParent.Shared).shallowEqual
local getComponentName = require(scriptParentParent.Shared).getComponentName
local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local _getIteratorFn = ReactSymbols.getIteratorFn
local ReactStrictModeWarningsNew = require(script.Parent["ReactStrictModeWarnings.new"])
local ReactCurrentFiber = require(script.Parent.ReactCurrentFiber)

local getCurrentFiberOwnerNameInDevOrNull = ReactCurrentFiber.getCurrentFiberOwnerNameInDevOrNull
local setIsRendering = ReactCurrentFiber.setIsRendering
local ReactFiberHotReloadingNew = require(script.Parent["ReactFiberHotReloading.new"])

local resolveFunctionForHotReloading = ReactFiberHotReloadingNew.resolveFunctionForHotReloading

local resolveForwardRefForHotReloading = ReactFiberHotReloadingNew.resolveForwardRefForHotReloading

local resolveClassForHotReloading = ReactFiberHotReloadingNew.resolveClassForHotReloading

local ReactChildFiberNew = require(script.Parent["ReactChildFiber.new"])
local mountChildFibers = ReactChildFiberNew.mountChildFibers
local reconcileChildFibers = ReactChildFiberNew.reconcileChildFibers
local cloneChildFibers = ReactChildFiberNew.cloneChildFibers
local ReactUpdateQueueNew = require(script.Parent["ReactUpdateQueue.new"])
local processUpdateQueue = ReactUpdateQueueNew.processUpdateQueue
local cloneUpdateQueue = ReactUpdateQueueNew.cloneUpdateQueue
local initializeUpdateQueue = ReactUpdateQueueNew.initializeUpdateQueue
local ReactTypeOfMode = require(script.Parent.ReactTypeOfMode)
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode
local NoMode = ReactTypeOfMode.NoMode
local ProfileMode = ReactTypeOfMode.ProfileMode
local StrictMode = ReactTypeOfMode.StrictMode
local BlockingMode = ReactTypeOfMode.BlockingMode
local ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)
local shouldSetTextContent = ReactFiberHostConfig.shouldSetTextContent
local isSuspenseInstancePending = ReactFiberHostConfig.isSuspenseInstancePending
local isSuspenseInstanceFallback = ReactFiberHostConfig.isSuspenseInstanceFallback
local registerSuspenseInstanceRetry = ReactFiberHostConfig.registerSuspenseInstanceRetry
local supportsHydration = ReactFiberHostConfig.supportsHydration

local ReactFiberHostContextNew = require(script.Parent["ReactFiberHostContext.new"])
local pushHostContext = ReactFiberHostContextNew.pushHostContext
local pushHostContainer = ReactFiberHostContextNew.pushHostContainer
local suspenseStackCursor = ReactFiberSuspenseContextNew.suspenseStackCursor
local hasSuspenseContext = ReactFiberSuspenseContextNew.hasSuspenseContext
local ForceSuspenseFallback = ReactFiberSuspenseContextNew.ForceSuspenseFallback
local addSubtreeSuspenseContext = ReactFiberSuspenseContextNew.addSubtreeSuspenseContext

local InvisibleParentSuspenseContext = ReactFiberSuspenseContextNew.InvisibleParentSuspenseContext
local pushSuspenseContext = ReactFiberSuspenseContextNew.pushSuspenseContext

local setDefaultShallowSuspenseContext = ReactFiberSuspenseContextNew.setDefaultShallowSuspenseContext

local ReactFiberNewContextNew = require(script.Parent["ReactFiberNewContext.new"])
local propagateContextChange = ReactFiberNewContextNew.propagateContextChange
local readContext = ReactFiberNewContextNew.readContext
local calculateChangedBits = ReactFiberNewContextNew.calculateChangedBits

local prepareToReadContext = ReactFiberNewContextNew.prepareToReadContext
local pushProvider = ReactFiberNewContextNew.pushProvider

local tbl1 = { renderWithHooksRef = nil, bailoutHooksRef = nil, shouldSuspendRef = nil }

local function shouldSuspend(arg1) -- Luacid: unused: defined but never referenced
    if not tbl1.shouldSuspendRef then
        tbl1.shouldSuspendRef = require(script.Parent.ReactFiberReconciler).shouldSuspend
    end
    return tbl1.shouldSuspendRef(arg1)
end

local function initReactFiberHooks() -- Luacid: Inlined by compiler; 2 call sites recovered
    local reactFiberHooksNew = require(script.Parent["ReactFiberHooks.new"])
    tbl1.renderWithHooksRef = reactFiberHooksNew.renderWithHooks
    tbl1.bailoutHooksRef = reactFiberHooksNew.bailoutHooks
end

local function renderWithHooks(...)
    if not tbl1.renderWithHooksRef then
        initReactFiberHooks()
    end

    return tbl1.renderWithHooksRef(...)
end

local function bailoutHooks(...)
    if not tbl1.bailoutHooksRef then
        initReactFiberHooks()
    end

    return tbl1.bailoutHooksRef(...)
end

local stopProfilerTimerIfRunning = require(script.Parent["ReactProfilerTimer.new"]).stopProfilerTimerIfRunning
local ReactFiberContextNew = require(script.Parent["ReactFiberContext.new"])
local getMaskedContext = ReactFiberContextNew.getMaskedContext
local getUnmaskedContext = ReactFiberContextNew.getUnmaskedContext
local hasContextChanged = ReactFiberContextNew.hasContextChanged
local pushContextProvider = ReactFiberContextNew.pushContextProvider
local isContextProvider = ReactFiberContextNew.isContextProvider
local pushTopLevelContextObject = ReactFiberContextNew.pushTopLevelContextObject
local invalidateContextProvider = ReactFiberContextNew.invalidateContextProvider

local ReactFiberHydrationContextNew = require(script.Parent["ReactFiberHydrationContext.new"])
local resetHydrationState = ReactFiberHydrationContextNew.resetHydrationState
local enterHydrationState = ReactFiberHydrationContextNew.enterHydrationState

local reenterHydrationStateFromDehydratedSuspenseInstance = ReactFiberHydrationContextNew.reenterHydrationStateFromDehydratedSuspenseInstance

local tryToClaimNextHydratableInstance = ReactFiberHydrationContextNew.tryToClaimNextHydratableInstance
local warnIfHydrating = ReactFiberHydrationContextNew.warnIfHydrating

local ReactFiberClassComponentNew = require(script.Parent["ReactFiberClassComponent.new"])
local adoptClassInstance = ReactFiberClassComponentNew.adoptClassInstance
local applyDerivedStateFromProps = ReactFiberClassComponentNew.applyDerivedStateFromProps
local constructClassInstance = ReactFiberClassComponentNew.constructClassInstance
local mountClassInstance = ReactFiberClassComponentNew.mountClassInstance
local resumeMountClassInstance = ReactFiberClassComponentNew.resumeMountClassInstance
local updateClassInstance = ReactFiberClassComponentNew.updateClassInstance

local resolveDefaultProps = require(script.Parent["ReactFiberLazyComponent.new"]).resolveDefaultProps
local ReactFiberNew = require(script.Parent["ReactFiber.new"])
local resolveLazyComponentTag = ReactFiberNew.resolveLazyComponentTag
local createFiberFromFragment = ReactFiberNew.createFiberFromFragment
local createFiberFromOffscreen = ReactFiberNew.createFiberFromOffscreen

local createFiberFromTypeAndProps = ReactFiberNew.createFiberFromTypeAndProps
local isSimpleFunctionComponent = ReactFiberNew.isSimpleFunctionComponent
local createWorkInProgress = ReactFiberNew.createWorkInProgress
local ReactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])
local pushRenderLanes = ReactFiberWorkLoopNew.pushRenderLanes
local markSpawnedWork = ReactFiberWorkLoopNew.markSpawnedWork
local retryDehydratedSuspenseBoundary = ReactFiberWorkLoopNew.retryDehydratedSuspenseBoundary
local scheduleUpdateOnFiber = ReactFiberWorkLoopNew.scheduleUpdateOnFiber
local renderDidSuspendDelayIfPossible = ReactFiberWorkLoopNew.renderDidSuspendDelayIfPossible
local getWorkInProgressRoot = ReactFiberWorkLoopNew.getWorkInProgressRoot
local getExecutionContext = ReactFiberWorkLoopNew.getExecutionContext
local RetryAfterError = ReactFiberWorkLoopNew.RetryAfterError
local NoContext = ReactFiberWorkLoopNew.NoContext

local unstable_wrap = nil

local setWorkInProgressVersion = require(script.Parent["ReactMutableSource.new"]).setWorkInProgressVersion

local markSkippedUpdateLanes = require(script.Parent.ReactFiberWorkInProgress).markSkippedUpdateLanes
local ConsolePatchingDev = require(scriptParentParent.Shared).ConsolePatchingDev
local disableLogs = ConsolePatchingDev.disableLogs
local reenableLogs = ConsolePatchingDev.reenableLogs

local ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner

local module = {}

local bailoutOnAlreadyFinishedWork = nil
local updateFunctionComponent = nil

local bool1 = false

local tbl2 = {
    didWarnAboutBadClass = {},
    didWarnAboutModulePatternComponent = {},
    didWarnAboutContextTypeOnFunctionComponent = {},
    didWarnAboutGetDerivedStateOnFunctionComponent = {},
    didWarnAboutFunctionRefs = {},
    didWarnAboutDefaultPropsOnFunctionComponent = {}
}

local updateSimpleMemoComponent = nil

if __DEV__ then
    tbl2.didWarnAboutBadClass = {}
    tbl2.didWarnAboutModulePatternComponent = {}
    tbl2.didWarnAboutContextTypeOnFunctionComponent = {}
    tbl2.didWarnAboutGetDerivedStateOnFunctionComponent = {}
    tbl2.didWarnAboutFunctionRefs = {}
    module.didWarnAboutReassigningProps = false

    tbl2.didWarnAboutDefaultPropsOnFunctionComponent = {}
end

local function reconcileChildren(arg1, arg2, arg3, arg4) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        arg2.child = mountChildFibers(arg2, nil, arg3, arg4)
    elseif ReactFeatureFlags.enableWorkLoopTrims then
        local child = reconcileChildFibers(arg2, arg1.child, arg3, arg4)

        if child ~= nil or arg2.child ~= nil then
            arg2.child = child
        end
    else
        arg2.child = reconcileChildFibers(arg2, arg1.child, arg3, arg4)
    end
end

local function forceUnmountCurrentAndReconcile(arg1, current, arg2, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
    current.child = reconcileChildFibers(current, arg1.child, nil, arg3)

    current.child = reconcileChildFibers(current, nil, arg2, arg3)
end

local function updateForwardRef(arg1, current, arg2, arg3, arg4)
    if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and current.type ~= current.elementType then
        local propTypes = arg2.propTypes
        local validateProps = arg2.validateProps
        if propTypes or validateProps then
            checkPropTypes(propTypes, validateProps, arg3, "prop", getComponentName(arg2))
        end
    end

    local render = arg2.render
    local ref = current.ref

    prepareToReadContext(current, arg4, module.markWorkInProgressReceivedUpdate)
    local var1

    if __DEV__ then
        ReactCurrentOwner.current = current
        setIsRendering(true)

        var1 = renderWithHooks(arg1, current, render, arg3, ref, arg4)

        if debugRenderPhaseSideEffectsForStrictMode and bit32.band(current.mode, StrictMode) ~= 0 then
            disableLogs()
            local success, result = xpcall(renderWithHooks, describeError, arg1, current, render, arg3, ref, arg4)

            if success then
                var1 = result
            end

            reenableLogs()

            if not success then
                error(result)
            end
        end
        setIsRendering(false)
    else
        var1 = renderWithHooks(arg1, current, render, arg3, ref, arg4)
    end

    if arg1 ~= nil and not bool1 then
        bailoutHooks(arg1, current, arg4)
        return bailoutOnAlreadyFinishedWork(arg1, current, arg4)
    end

    current.flags = bit32.bor(current.flags, PerformedWork)
    reconcileChildren(arg1, current, var1, arg4)
    return current.child
end

local function updateMemoComponent(arg1, _return, arg2, arg3, lanes, arg4)
    if arg1 == nil then
        local type2 = arg2.type

        if isSimpleFunctionComponent(type2) and arg2.compare == nil and arg2.defaultProps == nil then
            local type = if __DEV__ then resolveFunctionForHotReloading(type2) else type2
            _return.tag = SimpleMemoComponent
            _return.type = type
            if __DEV__ then
                validateFunctionComponentInDev(_return, type2)
            end
            return updateSimpleMemoComponent(arg1, _return, type, arg3, lanes, arg4)
        end

        if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
            local propTypes, validateProps

            if type(type2) == "table" then
                propTypes = type2.propTypes
                validateProps = type2.validateProps
            else
                propTypes = nil
                validateProps = nil
            end

            if propTypes or validateProps then
                checkPropTypes(propTypes, validateProps, arg3, "prop", getComponentName(type2))
            end
        end

        local child = createFiberFromTypeAndProps(arg2.type, nil, arg3, _return, _return.mode, arg4)

        child.ref = _return.ref
        child.return_ = _return
        _return.child = child
        return child
    end

    if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        local type2 = arg2.type
        local propTypes, validateProps

        if type(type2) == "table" then
            propTypes = type2.propTypes
            validateProps = type2.validateProps
        else
            propTypes = nil
            validateProps = nil
        end

        if propTypes or validateProps then
            checkPropTypes(propTypes, validateProps, arg3, "prop", getComponentName(type2))
        end
    end

    local child = arg1.child
    if not ReactFiberLane.includesSomeLane(lanes, arg4) then
        local memoizedProps = child.memoizedProps

        local compare = arg2.compare
        if compare == nil then
            compare = shallowEqual
        end
        if compare(memoizedProps, arg3) and arg1.ref == _return.ref then
            return bailoutOnAlreadyFinishedWork(arg1, _return, arg4)
        end
    end

    _return.flags = bit32.bor(_return.flags, PerformedWork)
    local workInProgress = createWorkInProgress(child, arg3)
    workInProgress.ref = _return.ref
    workInProgress.return_ = _return
    _return.child = workInProgress
    return workInProgress
end

updateSimpleMemoComponent = function(arg1, arg2, arg3, arg4, arg5, arg6)
    if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and arg2.type ~= arg2.elementType then
        local elementType = arg2.elementType
        if elementType["$$typeof"] == REACT_LAZY_TYPE then
            local _payload = elementType._payload
            local success, result = xpcall(elementType._init, describeError, _payload)
            if not success then
                result = nil
            end

            local propTypes, validateProps

            if result == nil or type(result) ~= "table" then
                propTypes = nil
                validateProps = nil
            else
                propTypes = result.propTypes

                validateProps = result.validateProps
            end

            if propTypes or validateProps then
                checkPropTypes(propTypes, validateProps, arg4, "prop", getComponentName(result))
            end
        end
    end

    if arg1 ~= nil then
        local memoizedProps = arg1.memoizedProps

        local bool2 = not __DEV__ or arg2.type == arg1.type

        if shallowEqual(memoizedProps, arg4) and arg1.ref == arg2.ref and bool2 then
            bool1 = false
            if not ReactFiberLane.includesSomeLane(arg6, arg5) then
                arg2.lanes = arg1.lanes
                return bailoutOnAlreadyFinishedWork(arg1, arg2, arg6)
            end

            if bit32.band(arg1.flags, ForceUpdateForLegacySuspense) ~= NoFlags then
                bool1 = true
            end
        end
    end
    return updateFunctionComponent(arg1, arg2, arg3, arg4, arg6)
end

local function updateOffscreenComponent(arg1, arg2, baseLanes)
    local pendingProps = arg2.pendingProps
    local children = pendingProps.children
    local memoizedState = if arg1 == nil then nil else arg1.memoizedState

    if pendingProps.mode == "hidden" or pendingProps.mode == "unstable-defer-without-hiding" then
        if bit32.band(arg2.mode, ConcurrentMode) == NoMode then
            arg2.memoizedState = {
                baseLanes = ReactFiberLane.NoLanes
            }
            pushRenderLanes(arg2, baseLanes)
        else
            if not ReactFiberLane.includesSomeLane(baseLanes, ReactFiberLane.OffscreenLane) then
                if memoizedState ~= nil then
                    local baseLanes2 = memoizedState.baseLanes
                    baseLanes = ReactFiberLane.mergeLanes(baseLanes2, baseLanes)
                end

                if enableSchedulerTracing then
                    markSpawnedWork(ReactFiberLane.OffscreenLane)
                end

                arg2.childLanes = ReactFiberLane.laneToLanes(ReactFiberLane.OffscreenLane)
                arg2.lanes = arg2.childLanes

                arg2.memoizedState = { baseLanes = baseLanes }

                pushRenderLanes(arg2, baseLanes)
                return nil
            end

            arg2.memoizedState = {
                baseLanes = ReactFiberLane.NoLanes
            }
            local var1 = if memoizedState == nil then baseLanes else memoizedState.baseLanes
            pushRenderLanes(arg2, var1)
        end
    else
        local var1

        if memoizedState == nil then
            var1 = baseLanes
        else
            var1 = ReactFiberLane.mergeLanes(memoizedState.baseLanes, baseLanes)

            arg2.memoizedState = nil
        end

        pushRenderLanes(arg2, var1)
    end

    reconcileChildren(arg1, arg2, children, baseLanes)
    return arg2.child
end

function updateFragment(arg1, arg2, arg3)
    local pendingProps = arg2.pendingProps
    reconcileChildren(arg1, arg2, pendingProps, arg3)
    return arg2.child
end

function updateMode(arg1, arg2, arg3)
    local children = arg2.pendingProps.children
    reconcileChildren(arg1, arg2, children, arg3)
    return arg2.child
end

function updateProfiler(arg1, arg2, arg3)
    if enableProfilerTimer then
        local stateNode = arg2.stateNode
        stateNode.effectDuration = 0
        stateNode.passiveEffectDuration = 0
    end
    local children = arg2.pendingProps.children
    reconcileChildren(arg1, arg2, children, arg3)
    return arg2.child
end

local function markRef(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local ref = arg2.ref
    if arg1 == nil and ref ~= nil or arg1 ~= nil and arg1.ref ~= ref then
        arg2.flags = bit32.bor(arg2.flags, Ref)
    end
end

updateFunctionComponent = function(arg1, current, arg2, arg3, arg4)
    if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__)
        and type(arg2) ~= "function"
        and current.type ~= current.elementType
    then
        local propTypes, validateProps

        if type(arg2) == "table" then
            propTypes = arg2.propTypes
            validateProps = arg2.validateProps
        else
            propTypes = nil
            validateProps = nil
        end

        if propTypes or validateProps then
            checkPropTypes(propTypes, validateProps, arg3, "prop", getComponentName(arg2))
        end
    end

    local maskedContext

    if disableLegacyContext then
        maskedContext = nil
    else
        local unmaskedContext = getUnmaskedContext(current, arg2, true)
        maskedContext = getMaskedContext(current, unmaskedContext)
    end

    prepareToReadContext(current, arg4, module.markWorkInProgressReceivedUpdate)
    local var1

    if __DEV__ then
        ReactCurrentOwner.current = current
        setIsRendering(true)
        var1 = renderWithHooks(arg1, current, arg2, arg3, maskedContext, arg4)

        if debugRenderPhaseSideEffectsForStrictMode and bit32.band(current.mode, StrictMode) ~= 0 then
            disableLogs()
            local success, result = xpcall(renderWithHooks, describeError, arg1, current, arg2, arg3, maskedContext, arg4)

            reenableLogs()
            if success then
                var1 = result
            else
                error(result)
            end
        end
        setIsRendering(false)
    else
        var1 = renderWithHooks(arg1, current, arg2, arg3, maskedContext, arg4)
    end

    if arg1 ~= nil and not bool1 then
        bailoutHooks(arg1, current, arg4)
        return bailoutOnAlreadyFinishedWork(arg1, current, arg4)
    end

    current.flags = bit32.bor(current.flags, PerformedWork)
    reconcileChildren(arg1, current, var1, arg4)
    return current.child
end

local function updateClassComponent(arg1, arg2, arg3, props, arg4)
    if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and arg2.type ~= arg2.elementType then
        local propTypes = arg3.propTypes
        local validateProps = arg3.validateProps
        if propTypes or validateProps then
            checkPropTypes(propTypes, validateProps, props, "prop", getComponentName(arg3))
        end
    end

    local bool2

    if isContextProvider(arg3) then
        pushContextProvider(arg2)
        bool2 = true
    else
        bool2 = false
    end

    prepareToReadContext(arg2, arg4, module.markWorkInProgressReceivedUpdate)
    local var1

    if arg2.stateNode == nil then
        if arg1 ~= nil then
            arg1.alternate = nil
            arg2.alternate = nil

            arg2.flags = bit32.bor(arg2.flags, Placement)
        end

        constructClassInstance(arg2, arg3, props)
        mountClassInstance(arg2, arg3, props, arg4)
        var1 = true
    elseif arg1 == nil then
        var1 = resumeMountClassInstance(arg2, arg3, props, arg4)
    else
        var1 = updateClassInstance(arg1, arg2, arg3, props, arg4)
    end

    local var2 = finishClassComponent(arg1, arg2, arg3, var1, bool2, arg4)

    if __DEV__ then
        local stateNode = arg2.stateNode
        if var1 and stateNode.props ~= props then
            if not module.didWarnAboutReassigningProps then
                console.error(
                    "It looks like %s is reassigning its own `this.props` while rendering. This is not supported and can lead to confusing bugs.",
                    getComponentName(arg2.type) or "a component"
                )
            end
            module.didWarnAboutReassigningProps = true
        end
    end
    return var2
end

function finishClassComponent(arg1, current, arg2, bool2: boolean, bool3: boolean, arg3)
    markRef(arg1, current)
    local bool4 = bit32.band(current.flags, DidCapture) ~= NoFlags

    if not (bool2 or bool4) then
        if bool3 then
            invalidateContextProvider(current, arg2, false)
        end

        return bailoutOnAlreadyFinishedWork(arg1, current, arg3)
    end

    local stateNode = current.stateNode

    ReactCurrentOwner.current = current
    local var1

    if bool4 and (arg2.getDerivedStateFromError == nil or type(arg2.getDerivedStateFromError) ~= "function") then
        var1 = nil

        if enableProfilerTimer then
            stopProfilerTimerIfRunning(current)
        end
    elseif __DEV__ then
        setIsRendering(true)

        var1 = stateNode:render()

        if debugRenderPhaseSideEffectsForStrictMode and bit32.band(current.mode, StrictMode) ~= 0 then
            disableLogs()

            local success, result = xpcall(stateNode.render, describeError, stateNode)

            reenableLogs()
            if not success then
                error(result)
            end
        end
        setIsRendering(false)
    else
        var1 = stateNode:render()
    end

    current.flags = bit32.bor(current.flags, PerformedWork)
    if arg1 ~= nil and bool4 then
        forceUnmountCurrentAndReconcile(arg1, current, var1, arg3)
    else
        reconcileChildren(arg1, current, var1, arg3)
    end

    current.memoizedState = stateNode.state

    if bool3 then
        invalidateContextProvider(current, arg2, true)
    end

    return current.child
end

local function pushHostRootContext(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local stateNode = arg1.stateNode
    if stateNode.pendingContext then
        pushTopLevelContextObject(arg1, stateNode.pendingContext, stateNode.pendingContext ~= stateNode.context)
    elseif stateNode.context then
        pushTopLevelContextObject(arg1, stateNode.context, false)
    end
    pushHostContainer(arg1, stateNode.containerInfo)
end

local function updateHostRoot(arg1, arg2, arg3)
    pushHostRootContext(arg2)
    local updateQueue = arg2.updateQueue
    invariant(
        not (arg1 == nil) and updateQueue ~= nil,
        "If the root does not have an updateQueue, we should have already bailed out. This error is likely caused by a bug in React. Please file an issue."
    )

    local pendingProps = arg2.pendingProps
    local memoizedState = arg2.memoizedState
    local element = if memoizedState == nil then nil else memoizedState.element
    cloneUpdateQueue(arg1, arg2)
    processUpdateQueue(arg2, pendingProps, nil, arg3)
    local element2 = arg2.memoizedState.element
    if element2 == element then
        resetHydrationState()
        return bailoutOnAlreadyFinishedWork(arg1, arg2, arg3)
    end
    local stateNode = arg2.stateNode
    if stateNode.hydrate and enterHydrationState(arg2) then
        if supportsHydration then
            local mutableSourceEagerHydrationData = stateNode.mutableSourceEagerHydrationData
            if mutableSourceEagerHydrationData ~= nil then
                for i = 1, #mutableSourceEagerHydrationData, 2 do
                    local var1 = mutableSourceEagerHydrationData[i]
                    local var2 = mutableSourceEagerHydrationData[i + 1]
                    setWorkInProgressVersion(var1, var2)
                end
            end
        end

        local var1 = mountChildFibers(arg2, nil, element2, arg3)
        arg2.child = var1

        while var1 do
            local num1 = bit32.band(var1.flags, bit32.bnot(Placement))
            var1.flags = bit32.bor(num1, Hydrating)
            var1 = var1.sibling
        end
    else
        reconcileChildren(arg1, arg2, element2, arg3)
        resetHydrationState()
    end
    return arg2.child
end

local function updateHostComponent(arg1, arg2, arg3)
    pushHostContext(arg2)

    if arg1 == nil then
        tryToClaimNextHydratableInstance(arg2)
    end

    local type = arg2.type
    local pendingProps = arg2.pendingProps
    local memoizedProps = if arg1 == nil then nil else arg1.memoizedProps
    local children = pendingProps.children
    if shouldSetTextContent(type, pendingProps) then
        children = nil
    elseif memoizedProps ~= nil and shouldSetTextContent(type, memoizedProps) then
        arg2.flags = bit32.bor(arg2.flags, ContentReset)
    end

    arg2.flags = bit32.bor(arg2.flags, PerformedWork)
    markRef(arg1, arg2)
    reconcileChildren(arg1, arg2, children, arg3)
    return arg2.child
end

local function updateHostText(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        tryToClaimNextHydratableInstance(arg2)
    end

    return nil
end

local function mountLazyComponent(arg1, arg2, elementType, lanes, arg3)
    if arg1 ~= nil then
        arg1.alternate = nil
        arg2.alternate = nil

        arg2.flags = bit32.bor(arg2.flags, Placement)
    end

    local pendingProps = arg2.pendingProps

    local _payload = elementType._payload
    local var1 = elementType._init(_payload)

    arg2.type = var1
    arg2.tag = resolveLazyComponentTag(var1)
    local tag = arg2.tag
    local var2 = resolveDefaultProps(var1, pendingProps)

    if tag == FunctionComponent then
        if __DEV__ then
            validateFunctionComponentInDev(arg2, var1)
            var1 = resolveFunctionForHotReloading(var1)
            arg2.type = var1
        end
        return (updateFunctionComponent(nil, arg2, var1, var2, arg3))
    end

    if tag == ClassComponent then
        if __DEV__ then
            var1 = resolveClassForHotReloading(var1)
            arg2.type = var1
        end
        return (updateClassComponent(nil, arg2, var1, var2, arg3))
    end

    if tag == ForwardRef then
        if __DEV__ then
            var1 = resolveForwardRefForHotReloading(var1)
            arg2.type = var1
        end

        return (updateForwardRef(nil, arg2, var1, var2, arg3))
    end

    if tag == MemoComponent then
        if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and arg2.type ~= arg2.elementType then
            local propTypes = var1.propTypes
            local validateProps = var1.validateProps
            if propTypes or validateProps then
                checkPropTypes(propTypes, validateProps, var2, "prop", getComponentName(var1))
            end
        end

        return (updateMemoComponent(nil, arg2, var1, resolveDefaultProps(var1.type, var2), lanes, arg3))
    end

    local str1 = ""
    if __DEV__ then
        if var1 ~= nil and type(var1) == "table" and var1["$$typeof"] == REACT_LAZY_TYPE then
            str1 = " Did you wrap a component in React.lazy() more than once?"
        elseif type(var1) == "table" and var1["$$typeof"] == nil then
            str1 = "\n" .. inspect(var1)
        end
    end

    invariant(
        false,
        "Element type is invalid. Received a promise that resolves to: %s. Lazy element type must resolve to a class or function.%s",
        tostring(var1),
        str1
    )

    return nil
end

function mountIncompleteClassComponent(arg1, arg2, type, arg3, arg4)
    if arg1 ~= nil then
        arg1.alternate = nil
        arg2.alternate = nil

        arg2.flags = bit32.bor(arg2.flags, Placement)
    end

    arg2.tag = ClassComponent
    local bool2

    if isContextProvider(type) then
        pushContextProvider(arg2)
        bool2 = true
    else
        bool2 = false
    end

    prepareToReadContext(arg2, arg4, module.markWorkInProgressReceivedUpdate)

    constructClassInstance(arg2, type, arg3)
    mountClassInstance(arg2, type, arg3, arg4)

    return finishClassComponent(nil, arg2, type, true, bool2, arg4)
end

local function mountIndeterminateComponent(arg1, current, type2, arg2)
    if arg1 ~= nil then
        arg1.alternate = nil
        current.alternate = nil

        current.flags = bit32.bor(current.flags, Placement)
    end

    local pendingProps = current.pendingProps
    local maskedContext

    if disableLegacyContext then
        maskedContext = nil
    else
        local unmaskedContext = getUnmaskedContext(current, type2, false)
        maskedContext = getMaskedContext(current, unmaskedContext)
    end

    prepareToReadContext(current, arg2, module.markWorkInProgressReceivedUpdate)
    local var1

    if __DEV__ then
        if type(type2) == "table" and type(type2.render) == "function" then
            local componentName = getComponentName(type2) or "Unknown"

            if not tbl2.didWarnAboutBadClass[componentName] then
                console.error(
                    "The <%s /> component appears to have a render method, but doesn't extend React.Component. This is likely to cause errors. Change %s to extend React.Component instead.",
                    componentName,
                    componentName
                )

                tbl2.didWarnAboutBadClass[componentName] = true
            end
        end

        if bit32.band(current.mode, StrictMode) ~= 0 then
            ReactStrictModeWarningsNew.recordLegacyContextWarning(current)
        end

        setIsRendering(true)
        ReactCurrentOwner.current = current

        var1 = renderWithHooks(nil, current, type2, pendingProps, maskedContext, arg2)
        setIsRendering(false)
    else
        var1 = renderWithHooks(nil, current, type2, pendingProps, maskedContext, arg2)
    end

    current.flags = bit32.bor(current.flags, PerformedWork)

    local str1 = type(var1)

    if __DEV__ and var1 ~= nil and str1 == "table" and type(var1.render) == "function" and var1["$$typeof"] == nil then
        local componentName = getComponentName(type2) or "Unknown"
        if not tbl2.didWarnAboutModulePatternComponent[componentName] then
            console.error(
                "The <%s /> component appears to be a function component that returns a class instance. Change %s to a class that extends React.Component instead. ",
                componentName,
                componentName
            )

            tbl2.didWarnAboutModulePatternComponent[componentName] = true
        end
    end

    if disableModulePatternComponents
        or var1 == nil
        or str1 ~= "table"
        or type(var1.render) ~= "function"
        or var1["$$typeof"] ~= nil
    then
        current.tag = FunctionComponent
        if __DEV__ then
            if disableLegacyContext and type2.contextTypes then
                console.error(
                    "%s uses the legacy contextTypes API which is no longer supported. Use React.createContext() with React.useContext() instead.",
                    getComponentName(type2) or "Unknown"
                )
            end

            if debugRenderPhaseSideEffectsForStrictMode and bit32.band(current.mode, StrictMode) ~= 0 then
                disableLogs()
                local success, result = xpcall(renderWithHooks, describeError, nil, current, type2, pendingProps, maskedContext, arg2)

                reenableLogs()
                if success then
                    var1 = result
                else
                    error(result)
                end
            end
        end

        reconcileChildren(nil, current, var1, arg2)

        if __DEV__ then
            validateFunctionComponentInDev(current, type2)
        end
        return current.child
    end

    if __DEV__ then
        local componentName = getComponentName(type2) or "Unknown"
        if not tbl2.didWarnAboutModulePatternComponent[componentName] then
            console.error(
                "The <%s /> component appears to be a function component that returns a class instance. " .. "Change %s to a class that extends React.Component instead. " .. componentName,
                componentName
            )

            tbl2.didWarnAboutModulePatternComponent[componentName] = true
        end
    end

    current.tag = ClassComponent

    current.memoizedState = nil
    current.updateQueue = nil
    local bool2

    if isContextProvider(type2) then
        pushContextProvider(current)
        bool2 = true
    else
        bool2 = false
    end

    current.memoizedState = var1.state

    initializeUpdateQueue(current)
    local getDerivedStateFromProps = if type(type2) == "function" then nil else type2.getDerivedStateFromProps

    if getDerivedStateFromProps ~= nil and type(getDerivedStateFromProps) == "function" then
        applyDerivedStateFromProps(current, type2, getDerivedStateFromProps, pendingProps)
    end

    adoptClassInstance(current, var1)
    mountClassInstance(current, type2, pendingProps, arg2)
    return finishClassComponent(nil, current, type2, true, bool2, arg2)
end

function validateFunctionComponentInDev(arg1, arg2)
    if not __DEV__ then
        return
    end

    if arg1.ref ~= nil then
        local str1 = ""
        local currentFiberOwnerNameInDevOrNull = getCurrentFiberOwnerNameInDevOrNull()
        if currentFiberOwnerNameInDevOrNull then
            str1 ..= "\n\nCheck the render method of `" .. currentFiberOwnerNameInDevOrNull .. "`."
        end

        local var1 = currentFiberOwnerNameInDevOrNull or arg1._debugID or ""
        local _debugSource = arg1._debugSource
        if _debugSource then
            var1 = _debugSource.fileName .. ":" .. _debugSource.lineNumber
        end
        if not tbl2.didWarnAboutFunctionRefs[var1] then
            tbl2.didWarnAboutFunctionRefs[var1] = true
            console.error(
                "Function components cannot be given refs. Attempts to access this ref will fail. Did you mean to use React.forwardRef()?%s",
                str1
            )
        end
    end

    if warnAboutDefaultPropsOnFunctionComponents and type(arg2) ~= "function" and arg2.defaultProps ~= nil then
        local componentName = getComponentName(arg2) or "Unknown"

        if not tbl2.didWarnAboutDefaultPropsOnFunctionComponent[componentName] then
            console.error(
                "%s: Support for defaultProps will be removed from function components in a future major release.",
                componentName
            )

            tbl2.didWarnAboutDefaultPropsOnFunctionComponent[componentName] = true
        end
    end

    if type(arg2) ~= "function" and arg2.getDerivedStateFromProps ~= nil and type(arg2.getDerivedStateFromProps) == "function" then
        local componentName = getComponentName(arg2) or "Unknown"

        if not tbl2.didWarnAboutGetDerivedStateOnFunctionComponent[componentName] then
            console.error("%s: Function components do not support getDerivedStateFromProps.", componentName)

            tbl2.didWarnAboutGetDerivedStateOnFunctionComponent[componentName] = true
        end
    end

    if type(arg2) == "function" or arg2.contextType == nil or type(arg2.contextType) ~= "table" then
        return
    end
    local componentName = getComponentName(arg2) or "Unknown"

    if not tbl2.didWarnAboutContextTypeOnFunctionComponent[componentName] then
        console.error("%s: Function components do not support contextType.", componentName)

        tbl2.didWarnAboutContextTypeOnFunctionComponent[componentName] = true
    end
end

local memoizedState = {
    dehydrated = nil,
    retryLane = ReactFiberLane.NoLane
}

local function mountSuspenseOffscreenState(baseLanes) -- Luacid: Inlined by compiler; 5 call sites recovered
    return { baseLanes = baseLanes }
end

local function updateSuspenseOffscreenState(memoizedState, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        baseLanes = ReactFiberLane.mergeLanes(memoizedState.baseLanes, arg1)
    }
end

local function shouldRemainOnFallback(arg1, arg2, _, _) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg2 ~= nil and arg2.memoizedState == nil then
        return false
    end

    return hasSuspenseContext(arg1, ForceSuspenseFallback)
end

local function getRemainingWorkInPrimaryTree(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return ReactFiberLane.removeLanes(arg1.childLanes, arg2)
end

local updateSuspensePrimaryChildren = nil
local mountDehydratedSuspenseComponent = nil
local mountSuspensePrimaryChildren = nil
local updateSuspenseFallbackChildren = nil
local updateDehydratedSuspenseComponent = nil

local function updateSuspenseComponent(arg1, arg2, baseLanes)
    local pendingProps = arg2.pendingProps

    if __DEV__ then
        if not tbl1.shouldSuspendRef then
            tbl1.shouldSuspendRef = require(script.Parent.ReactFiberReconciler).shouldSuspend
        end
        if tbl1.shouldSuspendRef(arg2) then
            arg2.flags = bit32.bor(arg2.flags, DidCapture)
        end
    end

    local current = suspenseStackCursor.current

    local bool2 = false
    local bool3 = bit32.band(arg2.flags, DidCapture) ~= NoFlags

    if bool3 or (arg1 == nil or arg1.memoizedState ~= nil) and shouldRemainOnFallback(current, nil, nil, nil) then
        arg2.flags = bit32.band(arg2.flags, bit32.bnot(DidCapture))
        bool2 = true
    elseif (arg1 == nil or arg1.memoizedState ~= nil)
        and pendingProps.fallback ~= nil
        and pendingProps.unstable_avoidThisFallback ~= true
    then
        current = addSubtreeSuspenseContext(current, InvisibleParentSuspenseContext)
    end

    local var1 = setDefaultShallowSuspenseContext(current)

    pushSuspenseContext(arg2, var1)

    if arg1 == nil then
        if pendingProps.fallback ~= nil then
            tryToClaimNextHydratableInstance(arg2)

            if enableSuspenseServerRenderer then
                local memoizedState = arg2.memoizedState
                if memoizedState ~= nil then
                    local dehydrated = memoizedState.dehydrated
                    if dehydrated ~= nil then
                        return mountDehydratedSuspenseComponent(arg2, dehydrated, baseLanes)
                    end
                end
            end
        end

        local children = pendingProps.children
        local fallback = pendingProps.fallback
        if bool2 then
            local var2 = mountSuspenseFallbackChildren(arg2, children, fallback, baseLanes)
            local tbl3 = mountSuspenseOffscreenState(baseLanes)
            arg2.child.memoizedState = tbl3
            arg2.memoizedState = memoizedState
            return var2
        end
        if pendingProps.unstable_expectedLoadTime == nil or type(pendingProps.unstable_expectedLoadTime) ~= "number" then
            return mountSuspensePrimaryChildren(arg2, children, baseLanes)
        end

        local var2 = mountSuspenseFallbackChildren(arg2, children, fallback, baseLanes)
        local tbl3 = mountSuspenseOffscreenState(baseLanes)
        arg2.child.memoizedState = tbl3
        arg2.memoizedState = memoizedState

        arg2.lanes = ReactFiberLane.SomeRetryLane
        if enableSchedulerTracing then
            markSpawnedWork(ReactFiberLane.SomeRetryLane)
        end
        return var2
    end

    local memoizedState3 = arg1.memoizedState
    if memoizedState3 == nil then
        if not bool2 then
            local children = pendingProps.children
            local var2 = updateSuspensePrimaryChildren(arg1, arg2, children, baseLanes)

            arg2.memoizedState = nil
            return var2
        end

        local fallback = pendingProps.fallback
        local children = pendingProps.children
        local var2 = updateSuspenseFallbackChildren(arg1, arg2, children, fallback, baseLanes)

        local child = arg2.child
        local memoizedState2 = arg1.child.memoizedState

        if memoizedState2 == nil then
            child.memoizedState = mountSuspenseOffscreenState(baseLanes)
        else
            child.memoizedState = updateSuspenseOffscreenState(memoizedState2, baseLanes)
        end

        child.childLanes = getRemainingWorkInPrimaryTree(arg1, baseLanes)

        arg2.memoizedState = memoizedState
        return var2
    end

    if enableSuspenseServerRenderer then
        local dehydrated = memoizedState3.dehydrated

        if dehydrated ~= nil then
            if not bool3 then
                return updateDehydratedSuspenseComponent(arg1, arg2, dehydrated, memoizedState3, baseLanes)
            end

            if arg2.memoizedState ~= nil then
                arg2.child = arg1.child

                arg2.flags = bit32.bor(arg2.flags, DidCapture)
                return nil
            end

            local children = pendingProps.children
            local fallback = pendingProps.fallback

            local var2 = mountSuspenseFallbackAfterRetryWithoutHydrating(arg1, arg2, children, fallback, baseLanes)
            local tbl3 = mountSuspenseOffscreenState(baseLanes)
            arg2.child.memoizedState = tbl3

            arg2.memoizedState = memoizedState
            return var2
        end
    end

    if not bool2 then
        local children = pendingProps.children
        local var2 = updateSuspensePrimaryChildren(arg1, arg2, children, baseLanes)

        arg2.memoizedState = nil
        return var2
    end

    local fallback = pendingProps.fallback
    local children = pendingProps.children
    local var2 = updateSuspenseFallbackChildren(arg1, arg2, children, fallback, baseLanes)

    local child = arg2.child
    local memoizedState2 = arg1.child.memoizedState

    if memoizedState2 == nil then
        child.memoizedState = mountSuspenseOffscreenState(baseLanes)
    else
        child.memoizedState = updateSuspenseOffscreenState(memoizedState2, baseLanes)
    end

    child.childLanes = getRemainingWorkInPrimaryTree(arg1, baseLanes)

    arg2.memoizedState = memoizedState
    return var2
end

mountSuspensePrimaryChildren = function(_return, children, arg1)
    local mode = _return.mode
    local child = createFiberFromOffscreen({ mode = "visible", children = children }, mode, arg1, nil)
    child.return_ = _return
    _return.child = child
    return child
end

function mountSuspenseFallbackChildren(_return, children, fallback, arg1)
    local mode = _return.mode
    local child = _return.child

    local pendingProps = { mode = "hidden", children = children }
    local fiberFromFragment

    if bit32.band(mode, BlockingMode) == NoMode and child ~= nil then
        child.childLanes = ReactFiberLane.NoLanes
        child.pendingProps = pendingProps

        if enableProfilerTimer and bit32.band(_return.mode, ProfileMode) ~= 0 then
            child.actualDuration = 0
            child.actualStartTime = -1
            child.selfBaseDuration = 0
            child.treeBaseDuration = 0
        end

        fiberFromFragment = createFiberFromFragment(fallback, mode, arg1, nil)
    else
        child = createFiberFromOffscreen(pendingProps, mode, ReactFiberLane.NoLanes, nil)

        fiberFromFragment = createFiberFromFragment(fallback, mode, arg1, nil)
    end

    child.return_ = _return
    fiberFromFragment.return_ = _return
    child.sibling = fiberFromFragment
    _return.child = child
    return fiberFromFragment
end

local function createWorkInProgressOffscreenFiber(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return createWorkInProgress(arg1, arg2)
end

updateSuspensePrimaryChildren = function(arg1, _return, children, lanes)
    local child = arg1.child
    local sibling = child.sibling
    local workInProgressOffscreenFiber = createWorkInProgressOffscreenFiber(child, { mode = "visible", children = children })

    if bit32.band(_return.mode, BlockingMode) == NoMode then
        workInProgressOffscreenFiber.lanes = lanes
    end
    workInProgressOffscreenFiber.return_ = _return
    workInProgressOffscreenFiber.sibling = nil
    if sibling ~= nil then
        local deletions = _return.deletions
        if deletions == nil then
            _return.deletions = { sibling }

            _return.flags = bit32.bor(_return.flags, Deletion)
        else
            table.insert(deletions, sibling)
        end
    end

    _return.child = workInProgressOffscreenFiber
    return workInProgressOffscreenFiber
end

updateSuspenseFallbackChildren = function(arg1, _return, children, arg2, arg3)
    local mode = _return.mode
    local child = arg1.child
    local sibling = child.sibling

    local pendingProps = { mode = "hidden", children = children }
    local var1

    if bit32.band(mode, BlockingMode) == NoMode and _return.child ~= child then
        var1 = _return.child

        var1.childLanes = ReactFiberLane.NoLanes
        var1.pendingProps = pendingProps

        if enableProfilerTimer and bit32.band(_return.mode, ProfileMode) ~= 0 then
            var1.actualDuration = 0
            var1.actualStartTime = -1
            var1.selfBaseDuration = child.selfBaseDuration
            var1.treeBaseDuration = child.treeBaseDuration
        end

        _return.deletions = nil
    else
        var1 = createWorkInProgressOffscreenFiber(child, pendingProps)

        local subtreeFlags = child.subtreeFlags
        var1.subtreeFlags = bit32.band(subtreeFlags, StaticMask)
    end

    local var2

    if sibling ~= nil then
        var2 = createWorkInProgress(sibling, arg2)
    else
        var2 = createFiberFromFragment(arg2, mode, arg3, nil)

        local flags = var2.flags
        var2.flags = bit32.bor(flags, Placement)
    end

    var2.return_ = _return
    var1.return_ = _return
    var1.sibling = var2
    _return.child = var1

    return var2
end

local function retrySuspenseComponentWithoutHydrating(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 4 call sites recovered
    reconcileChildFibers(arg2, arg1.child, nil, arg3)

    local children = arg2.pendingProps.children

    local var1 = mountSuspensePrimaryChildren(arg2, children, arg3)

    var1.flags = bit32.bor(var1.flags, Placement)
    arg2.memoizedState = nil

    return var1
end

function mountSuspenseFallbackAfterRetryWithoutHydrating(arg1, _return, children, fallback, arg2)
    local mode = _return.mode

    local child = createFiberFromOffscreen(children, mode, ReactFiberLane.NoLanes, nil)

    local sibling = createFiberFromFragment(fallback, mode, arg2, nil)

    sibling.flags = bit32.bor(sibling.flags, Placement)

    child.return_ = _return
    sibling.return_ = _return
    child.sibling = sibling
    _return.child = child

    if bit32.band(_return.mode, BlockingMode) ~= NoMode then
        reconcileChildFibers(_return, arg1.child, nil, arg2)
    end

    return sibling
end

mountDehydratedSuspenseComponent = function(arg1, arg2, _)
    if bit32.band(arg1.mode, BlockingMode) == NoMode then
        if __DEV__ then
            console.error(
                "Cannot hydrate Suspense in legacy mode. Switch fromReactDOM.hydrate(element, container) to ReactDOM.createBlockingRoot(container, { hydrate: true }).render(element) or remove the Suspense componentsthe server rendered components."
            )
        end

        arg1.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.SyncLane)
    elseif isSuspenseInstanceFallback(arg2) then
        if enableSchedulerTracing then
            markSpawnedWork(ReactFiberLane.DefaultHydrationLane)
        end
        arg1.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.DefaultHydrationLane)
    else
        arg1.lanes = ReactFiberLane.laneToLanes(ReactFiberLane.OffscreenLane)
        if enableSchedulerTracing then
            markSpawnedWork(ReactFiberLane.OffscreenLane)
        end
    end
    return nil
end

updateDehydratedSuspenseComponent = function(arg1, arg2, arg3, arg4, arg5)
    warnIfHydrating()

    if bit32.band(getExecutionContext(), RetryAfterError) ~= NoContext then
        return retrySuspenseComponentWithoutHydrating(arg1, arg2, arg5)
    end

    if bit32.band(arg2.mode, BlockingMode) == NoMode then
        return retrySuspenseComponentWithoutHydrating(arg1, arg2, arg5)
    end

    if isSuspenseInstanceFallback(arg3) then
        return retrySuspenseComponentWithoutHydrating(arg1, arg2, arg5)
    end

    local var1 = ReactFiberLane.includesSomeLane(arg5, arg1.childLanes)
    if bool1 or var1 then
        local workInProgressRoot = getWorkInProgressRoot()
        if workInProgressRoot ~= nil then
            local retryLane = ReactFiberLane.getBumpedLaneForHydration(workInProgressRoot, arg5)

            if retryLane ~= ReactFiberLane.NoLane and retryLane ~= arg4.retryLane then
                arg4.retryLane = retryLane

                local noTimestamp = ReactFiberLane.NoTimestamp
                scheduleUpdateOnFiber(arg1, retryLane, noTimestamp)
            end
        end

        renderDidSuspendDelayIfPossible()
        return retrySuspenseComponentWithoutHydrating(arg1, arg2, arg5)
    end

    if not isSuspenseInstancePending(arg3) then
        reenterHydrationStateFromDehydratedSuspenseInstance(arg2, arg3)

        local children = arg2.pendingProps.children

        local var2 = mountSuspensePrimaryChildren(arg2, children, arg5)

        var2.flags = bit32.bor(var2.flags, Hydrating)
        return var2
    end

    arg2.flags = bit32.bor(arg2.flags, DidCapture)

    arg2.child = arg1.child

    local function func1()
        return retryDehydratedSuspenseBoundary(arg1)
    end

    if enableSchedulerTracing then
        if unstable_wrap == nil then
            unstable_wrap = require(scriptParentParent.Scheduler).tracing.unstable_wrap
        end
        func1 = unstable_wrap(func1)
    end

    registerSuspenseInstanceRetry(arg3, func1)
    return nil
end

function updatePortalComponent(arg1, arg2, arg3)
    pushHostContainer(arg2, arg2.stateNode.containerInfo)
    local pendingProps = arg2.pendingProps
    if arg1 == nil then
        arg2.child = reconcileChildFibers(arg2, nil, pendingProps, arg3)
    else
        reconcileChildren(arg1, arg2, pendingProps, arg3)
    end
    return arg2.child
end

local bool2 = false

local function updateContextProvider(arg1, arg2, arg3)
    local _context = arg2.type._context

    local pendingProps = arg2.pendingProps
    local memoizedProps = arg2.memoizedProps

    local value = pendingProps.value

    if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        if Array.indexOf(Object.keys(pendingProps), "value") < 1 and not bool2 then
            bool2 = true
            console.error("The `value` prop is required for the `<Context.Provider>`. Did you misspell it or forget to pass it?")
        end

        local propTypes = arg2.type.propTypes
        local validateProps = arg2.type.validateProps

        if propTypes or validateProps then
            checkPropTypes(propTypes, validateProps, pendingProps, "prop", "Context.Provider")
        end
    end

    pushProvider(arg2, value)

    if memoizedProps ~= nil then
        local value2 = memoizedProps.value
        local changedBits = calculateChangedBits(_context, value, value2)
        if changedBits == 0 then
            if memoizedProps.children == pendingProps.children and not hasContextChanged() then
                return bailoutOnAlreadyFinishedWork(arg1, arg2, arg3)
            end
        else
            propagateContextChange(arg2, _context, changedBits, arg3)
        end
    end

    local children = pendingProps.children
    reconcileChildren(arg1, arg2, children, arg3)
    return arg2.child
end

local tbl4 = { usingContextAsConsumer = false, usingLegacyConsumer = false }

function updateContextConsumer(arg1, current, arg2)
    local type2 = current.type

    if __DEV__ then
        if type2._context ~= nil then
            type2 = type2._context
        elseif type2 ~= type2.Consumer and not tbl4.usingContextAsConsumer then
            tbl4.usingContextAsConsumer = true
            console.error(
                "Rendering <Context> directly is not supported and will be removed in a future major release. Did you mean to render <Context.Consumer> instead?"
            )
        end
    end

    local pendingProps = current.pendingProps
    local var1

    if pendingProps.render then
        if __DEV__ and __COMPAT_WARNINGS__ and not tbl4.usingLegacyConsumer then
            tbl4.usingLegacyConsumer = true
            console.warn(
                "Your Context.Consumer component is using legacy Roact syntax, which won't be supported in future versions of Roact. \nPlease provide no props and supply the 'render' function as a child (the 3rd argument of createElement). For example: \n       createElement(ContextConsumer, {render = function(...) end})\nbecomes:\n       createElement(ContextConsumer, nil, function(...) end)\nFor more info, reference the React documentation here: \nhttps://reactjs.org/docs/context.html#contextconsumer"
            )
        end

        var1 = pendingProps.render
    else
        var1 = pendingProps.children
    end

    if __DEV__ and type(var1) ~= "function" then
        console.error(
            "A context consumer was rendered with multiple children, or a child that isn't a function. A context consumer expects a single child that is a function. If you did pass a function, make sure there is no trailing or leading whitespace around it."
        )
    end

    prepareToReadContext(current, arg2, module.markWorkInProgressReceivedUpdate)

    local var2 = readContext(type2, pendingProps.unstable_observedBits)
    local var3

    if __DEV__ then
        ReactCurrentOwner.current = current
        setIsRendering(true)
        var3 = var1(var2)
        setIsRendering(false)
    else
        var3 = var1(var2)
    end

    current.flags = bit32.bor(current.flags, PerformedWork)
    reconcileChildren(arg1, current, var3, arg2)
    return current.child
end

function module.markWorkInProgressReceivedUpdate()
    bool1 = true
end

bailoutOnAlreadyFinishedWork = function(arg1, arg2, arg3)
    if arg1 then
        arg2.dependencies = arg1.dependencies
    end

    if enableProfilerTimer then
        stopProfilerTimerIfRunning(arg2)
    end

    markSkippedUpdateLanes(arg2.lanes)

    if not ReactFiberLane.includesSomeLane(arg3, arg2.childLanes) then
        return nil
    end

    cloneChildFibers(arg1, arg2)
    return arg2.child
end

function remountFiber(arg1, arg2, arg3)
    if not __DEV__ then
        error("Did not expect this call in production. This is a bug in React. Please file an issue.")
        return
    end

    local _return = arg2.return_
    if _return == nil then
        error("Cannot swap the root fiber.")
    end

    assert(_return ~= nil, "returnFiber was nil in remountFiber")

    arg1.alternate = nil
    arg2.alternate = nil

    arg3.index = arg2.index
    arg3.sibling = arg2.sibling
    arg3.return_ = arg2.return_
    arg3.ref = arg2.ref

    if arg2 == _return.child then
        _return.child = arg3
    else
        local child = _return.child
        if child == nil then
            error("Expected parent to have a child.")
        end

        assert(child ~= nil, "prevSibling was nil in remountFiber")

        while child.sibling ~= arg2 do
            child = child.sibling
            if child == nil then
                error("Expected to find the previous sibling.")
            end
        end
        child.sibling = arg3
    end

    local deletions = _return.deletions
    if deletions == nil then
        _return.deletions = { arg1 }

        _return.flags = bit32.bor(_return.flags, Deletion)
    else
        table.insert(deletions, arg1)
    end

    arg3.flags = bit32.bor(arg3.flags, Placement)

    return arg3
end

function module.beginWork(arg1, arg2, baseLanes)
    local lanes = arg2.lanes

    if __DEV__ and arg2._debugNeedsRemount and arg1 ~= nil then
        return remountFiber(
            arg1,
            arg2,
            createFiberFromTypeAndProps(arg2.type, arg2.key, arg2.pendingProps, arg2._debugOwner or nil, arg2.mode, arg2.lanes)
        )
    end

    if arg1 ~= nil then
        if arg1.memoizedProps ~= arg2.pendingProps or hasContextChanged() or __DEV__ and arg2.type ~= arg1.type then
            bool1 = true
        else
            if not ReactFiberLane.includesSomeLane(baseLanes, lanes) then
                bool1 = false

                if arg2.tag == HostRoot then
                    pushHostRootContext(arg2)
                    resetHydrationState()
                elseif arg2.tag == HostComponent then
                    pushHostContext(arg2)
                elseif arg2.tag == ClassComponent then
                    local type = arg2.type
                    if isContextProvider(type) then
                        pushContextProvider(arg2)
                    end
                elseif arg2.tag == HostPortal then
                    pushHostContainer(arg2, arg2.stateNode.containerInfo)
                elseif arg2.tag == ContextProvider then
                    local value = arg2.memoizedProps.value
                    pushProvider(arg2, value)
                elseif arg2.tag == Profiler then
                    if enableProfilerTimer then
                        local stateNode = arg2.stateNode
                        stateNode.effectDuration = 0
                        stateNode.passiveEffectDuration = 0
                    end
                elseif arg2.tag == SuspenseComponent then
                    local memoizedState = arg2.memoizedState
                    if memoizedState ~= nil then
                        if enableSuspenseServerRenderer and memoizedState.dehydrated ~= nil then
                            pushSuspenseContext(arg2, setDefaultShallowSuspenseContext(suspenseStackCursor.current))

                            arg2.flags = bit32.bor(arg2.flags, DidCapture)

                            return nil
                        end

                        local childLanes = arg2.child.childLanes

                        if ReactFiberLane.includesSomeLane(baseLanes, childLanes) then
                            return updateSuspenseComponent(arg1, arg2, baseLanes)
                        end

                        pushSuspenseContext(arg2, setDefaultShallowSuspenseContext(suspenseStackCursor.current))

                        local var1 = bailoutOnAlreadyFinishedWork(arg1, arg2, baseLanes)

                        return if var1 == nil then nil else var1.sibling
                    end

                    pushSuspenseContext(arg2, setDefaultShallowSuspenseContext(suspenseStackCursor.current))
                elseif arg2.tag == SuspenseListComponent then
                    unimplemented("beginWork: SuspenseListComponent")
                elseif arg2.tag == OffscreenComponent or arg2.tag == LegacyHiddenComponent then
                    arg2.lanes = ReactFiberLane.NoLanes
                    return (updateOffscreenComponent(arg1, arg2, baseLanes))
                end
                return bailoutOnAlreadyFinishedWork(arg1, arg2, baseLanes)
            end
            if bit32.band(arg1.flags, ForceUpdateForLegacySuspense) ~= NoFlags then
                bool1 = true
            else
                bool1 = false
            end
        end
    else
        bool1 = false
    end

    arg2.lanes = ReactFiberLane.NoLanes

    if arg2.tag == ReactWorkTags.IndeterminateComponent then
        return mountIndeterminateComponent(arg1, arg2, arg2.type, baseLanes)
    end

    if arg2.tag == LazyComponent then
        local elementType = arg2.elementType
        return (mountLazyComponent(arg1, arg2, elementType, lanes, baseLanes))
    end

    if arg2.tag == FunctionComponent then
        local type = arg2.type
        local pendingProps = arg2.pendingProps

        if arg2.elementType ~= type then
            pendingProps = resolveDefaultProps(type, pendingProps)
        end
        return updateFunctionComponent(arg1, arg2, type, pendingProps, baseLanes)
    end

    if arg2.tag == ClassComponent then
        local type = arg2.type
        local pendingProps = arg2.pendingProps
        local var1 = arg2.elementType == type and pendingProps or resolveDefaultProps(type, pendingProps)
        return (updateClassComponent(arg1, arg2, type, var1, baseLanes))
    end

    if arg2.tag == HostRoot then
        return updateHostRoot(arg1, arg2, baseLanes)
    end

    if arg2.tag == HostComponent then
        return (updateHostComponent(arg1, arg2, baseLanes))
    end

    if arg2.tag == HostText then
        return updateHostText(arg1, arg2)
    end
    if arg2.tag == SuspenseComponent then
        return updateSuspenseComponent(arg1, arg2, baseLanes)
    end

    if arg2.tag == HostPortal then
        return updatePortalComponent(arg1, arg2, baseLanes)
    end

    if arg2.tag == ForwardRef then
        local type = arg2.type
        local pendingProps = arg2.pendingProps

        if arg2.elementType ~= type then
            pendingProps = resolveDefaultProps(type, pendingProps)
        end
        return updateForwardRef(arg1, arg2, type, pendingProps, baseLanes)
    end

    if arg2.tag == Fragment then
        return updateFragment(arg1, arg2, baseLanes)
    end

    if arg2.tag == Mode then
        return updateMode(arg1, arg2, baseLanes)
    end

    if arg2.tag == Profiler then
        return updateProfiler(arg1, arg2, baseLanes)
    end

    if arg2.tag == ContextProvider then
        return updateContextProvider(arg1, arg2, baseLanes)
    end

    if arg2.tag == ContextConsumer then
        return updateContextConsumer(arg1, arg2, baseLanes)
    end

    if arg2.tag == MemoComponent then
        local type2 = arg2.type
        local pendingProps = arg2.pendingProps

        local var1 = resolveDefaultProps(type2, pendingProps)
        if (__DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) and arg2.type ~= arg2.elementType then
            local propTypes, validateProps

            if type(type2) == "table" then
                propTypes = type2.propTypes
                validateProps = type2.validateProps
            else
                propTypes = nil
                validateProps = nil
            end
            if propTypes or validateProps then
                checkPropTypes(propTypes, validateProps, var1, "prop", getComponentName(type2))
            end
        end

        local var2 = resolveDefaultProps(type2.type, var1)
        return updateMemoComponent(arg1, arg2, type2, var2, lanes, baseLanes)
    end

    if arg2.tag == SimpleMemoComponent then
        return updateSimpleMemoComponent(arg1, arg2, arg2.type, arg2.pendingProps, lanes, baseLanes)
    end

    if arg2.tag == IncompleteClassComponent then
        local type = arg2.type
        local pendingProps = arg2.pendingProps
        local var1 = arg2.elementType == type and pendingProps or resolveDefaultProps(type, pendingProps)
        return mountIncompleteClassComponent(arg1, arg2, type, var1, baseLanes)
    end

    if arg2.tag == OffscreenComponent then
        return (updateOffscreenComponent(arg1, arg2, baseLanes))
    end

    if arg2.tag == LegacyHiddenComponent then
        return (updateOffscreenComponent(arg1, arg2, baseLanes))
    end
    invariant(
        false,
        "Unknown unit of work tag (%s). This error is likely caused by a bug in React. Please file an issue.",
        tostring(arg2.tag)
    )
    return nil
end
return module
