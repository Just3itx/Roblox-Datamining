-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local _Shared = require(scriptParentParent.Shared)

local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local __DEV__ = ReactGlobals.__DEV__

local console = require(scriptParentParent.Shared).console

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactRootTags = require(script.Parent.ReactRootTags)

local ReactFiberFlags = require(script.Parent.ReactFiberFlags)

local _ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local ReactWorkTags = require(script.Parent.ReactWorkTags)
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local _Shared2 = require(scriptParentParent.Shared)

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local _ReactFiberSuspenseComponentNew = require(script.Parent["ReactFiberSuspenseComponent.new"])

local ReactFiberTreeReflection = require(script.Parent.ReactFiberTreeReflection)
local findCurrentHostFiber = ReactFiberTreeReflection.findCurrentHostFiber

local findCurrentHostFiberWithNoPortals = ReactFiberTreeReflection.findCurrentHostFiberWithNoPortals
local get = require(scriptParentParent.Shared).ReactInstanceMap.get
local HostComponent = ReactWorkTags.HostComponent
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local getComponentName = require(scriptParentParent.Shared).getComponentName
local invariant = require(scriptParentParent.Shared).invariant
local describeError = require(scriptParentParent.Shared).describeError

local enableSchedulingProfiler = require(scriptParentParent.Shared).ReactFeatureFlags.enableSchedulingProfiler
local ReactSharedInternals = require(scriptParentParent.Shared).ReactSharedInternals
local getPublicInstance = require(script.Parent.ReactFiberHostConfig).getPublicInstance
local ReactFiberContextNew = require(script.Parent["ReactFiberContext.new"])
local findCurrentUnmaskedContext = ReactFiberContextNew.findCurrentUnmaskedContext
local processChildContext = ReactFiberContextNew.processChildContext
local emptyContextObject = ReactFiberContextNew.emptyContextObject
local isContextProvider = ReactFiberContextNew.isContextProvider
local createFiberRoot = require(script.Parent["ReactFiberRoot.new"]).createFiberRoot
local ReactFiberDevToolsHookNew = require(script.Parent["ReactFiberDevToolsHook.new"])
local injectInternals = ReactFiberDevToolsHookNew.injectInternals
local onScheduleRoot = ReactFiberDevToolsHookNew.onScheduleRoot
local ReactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])
local requestEventTime = ReactFiberWorkLoopNew.requestEventTime
local requestUpdateLane = ReactFiberWorkLoopNew.requestUpdateLane
local scheduleUpdateOnFiber = ReactFiberWorkLoopNew.scheduleUpdateOnFiber
local flushRoot = ReactFiberWorkLoopNew.flushRoot
local batchedEventUpdates = ReactFiberWorkLoopNew.batchedEventUpdates
local batchedUpdates = ReactFiberWorkLoopNew.batchedUpdates
local unbatchedUpdates = ReactFiberWorkLoopNew.unbatchedUpdates
local flushSync = ReactFiberWorkLoopNew.flushSync
local flushControlled = ReactFiberWorkLoopNew.flushControlled
local deferredUpdates = ReactFiberWorkLoopNew.deferredUpdates
local discreteUpdates = ReactFiberWorkLoopNew.discreteUpdates
local flushDiscreteUpdates = ReactFiberWorkLoopNew.flushDiscreteUpdates
local flushPassiveEffects = ReactFiberWorkLoopNew.flushPassiveEffects
local warnIfNotScopedWithMatchingAct = ReactFiberWorkLoopNew.warnIfNotScopedWithMatchingAct
local warnIfUnmockedScheduler = ReactFiberWorkLoopNew.warnIfUnmockedScheduler
local IsThisRendererActing = ReactFiberWorkLoopNew.IsThisRendererActing
local act = ReactFiberWorkLoopNew.act
local ReactUpdateQueueNew = require(script.Parent["ReactUpdateQueue.new"])
local createUpdate = ReactUpdateQueueNew.createUpdate
local enqueueUpdate = ReactUpdateQueueNew.enqueueUpdate
local ReactCurrentFiber = require(script.Parent.ReactCurrentFiber)
local isRendering = ReactCurrentFiber.isRendering

local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber
local ReactTypeOfMode = require(script.Parent.ReactTypeOfMode)
local StrictMode = ReactTypeOfMode.StrictMode
local SyncLane = ReactFiberLane.SyncLane
local InputDiscreteHydrationLane = ReactFiberLane.InputDiscreteHydrationLane
local SelectiveHydrationLane = ReactFiberLane.SelectiveHydrationLane
local NoTimestamp = ReactFiberLane.NoTimestamp
local getHighestPriorityPendingLanes = ReactFiberLane.getHighestPriorityPendingLanes
local higherPriorityLane = ReactFiberLane.higherPriorityLane
local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority
local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority
local ReactFiberHotReloadingNew = require(script.Parent["ReactFiberHotReloading.new"])
local scheduleRefresh = ReactFiberHotReloadingNew.scheduleRefresh
local scheduleRoot = ReactFiberHotReloadingNew.scheduleRoot
local setRefreshHandler = ReactFiberHotReloadingNew.setRefreshHandler
local findHostInstancesForRefresh = ReactFiberHotReloadingNew.findHostInstancesForRefresh
local SchedulingProfiler = require(script.Parent.SchedulingProfiler)
local markRenderScheduled = SchedulingProfiler.markRenderScheduled

local module = {
    ReactRootTags = ReactRootTags,
    ReactWorkTags = ReactWorkTags,
    ReactTypeOfMode = ReactTypeOfMode,
    ReactFiberFlags = ReactFiberFlags,
    getNearestMountedFiber = ReactFiberTreeReflection.getNearestMountedFiber,
    findCurrentFiberUsingSlowPath = ReactFiberTreeReflection.findCurrentFiberUsingSlowPath,
    createPortal = require(script.Parent.ReactPortal).createPortal
}

local bool1 = nil
local var1 = nil

if __DEV__ then
    bool1 = false
    var1 = {}
end

local function getContextForSubtree(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not arg1 then
        return emptyContextObject
    end

    local var2 = get(arg1)
    local currentUnmaskedContext = findCurrentUnmaskedContext(var2)

    if var2.tag == ClassComponent then
        local type = var2.type
        if isContextProvider(type) then
            return processChildContext(var2, type, currentUnmaskedContext)
        end
    end

    return currentUnmaskedContext
end

local function findHostInstance(tbl1)
    local var2 = get(tbl1)
    if var2 == nil then
        if typeof(tbl1.render) == "function" then
            invariant(false, "Unable to find node on an unmounted component.")
        else
            invariant(false, "Argument appears to not be a ReactComponent. Keys: %s", table.concat(Object.keys(tbl1)))
        end
    end

    local currentHostFiber = findCurrentHostFiber(var2)
    return if currentHostFiber == nil then nil else currentHostFiber.stateNode
end

local function findHostInstanceWithWarning(tbl1, str1: string)
    if not __DEV__ then
        return (findHostInstance(tbl1))
    end

    local var2 = get(tbl1)
    if var2 == nil then
        if typeof(tbl1.render) == "function" then
            invariant(false, "Unable to find node on an unmounted component.")
        else
            invariant(false, "Argument appears to not be a ReactComponent. Keys: %s", table.concat(Object.keys(tbl1)))
        end
    end

    local currentHostFiber = findCurrentHostFiber(var2)
    if currentHostFiber == nil then
        return nil
    end
    if bit32.band(currentHostFiber.mode, StrictMode) ~= 0 then
        local componentName = getComponentName(var2.type) or "Component"
        if not var1[componentName] then
            var1[componentName] = true

            local current = ReactCurrentFiber.current
            local success, result = xpcall(function()
                setCurrentFiber(currentHostFiber)
                if bit32.band(var2.mode, StrictMode) ~= 0 then
                    console.error(
                        "%s is deprecated in StrictMode. %s was passed an instance of %s which is inside StrictMode. Instead, add a ref directly to the element you want to reference. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-find-node",
                        str1,
                        str1,
                        componentName
                    )
                    return
                end

                console.error(
                    "%s is deprecated in StrictMode. %s was passed an instance of %s which renders StrictMode children. Instead, add a ref directly to the element you want to reference. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-find-node",
                    str1,
                    str1,
                    componentName
                )
            end, describeError)

            if current then
                setCurrentFiber(current)
            else
                resetCurrentFiber()
            end

            if not success then
                error(result)
            end
        end
    end
    return currentHostFiber.stateNode
end

function module.createContainer(arg1, arg2, bool2: boolean, arg3)
    return createFiberRoot(arg1, arg2, bool2, arg3)
end

function module.updateContainer(element, arg2, arg3, callback: ((...any) -> (...any))?)
    if __DEV__ then
        onScheduleRoot(arg2, element)
    end
    local current = arg2.current
    local var2 = requestEventTime()
    if __DEV__ and ReactGlobals.__TESTEZ_RUNNING_TEST__ then
        warnIfUnmockedScheduler(current)
        warnIfNotScopedWithMatchingAct(current)
    end

    local var3 = requestUpdateLane(current)

    if enableSchedulingProfiler then
        markRenderScheduled(var3)
    end

    local contextForSubtree = getContextForSubtree(arg3)

    if arg2.context == nil then
        arg2.context = contextForSubtree
    else
        arg2.pendingContext = contextForSubtree
    end

    if __DEV__ and isRendering and ReactCurrentFiber.current ~= nil and not bool1 then
        bool1 = true
        console.error(
            "Render methods should be a pure function of props and state; triggering nested component updates from render is not allowed. If necessary, trigger nested updates in componentDidUpdate.\n\nCheck the render method of %s.",
            getComponentName(ReactCurrentFiber.current.type) or "Unknown"
        )
    end

    local update = createUpdate(var2, var3)

    if element == nil then
        element = Object.None
    end

    update.payload = { element = element }

    if callback ~= nil then
        if __DEV__ and typeof(callback) ~= "function" then
            console.error(
                "render(...): Expected the last optional `callback` argument to be a function. Instead received: %s.",
                tostring(callback)
            )
        end

        update.callback = callback
    end

    enqueueUpdate(current, update)
    scheduleUpdateOnFiber(current, var3, var2)

    return var3
end

module.batchedEventUpdates = batchedEventUpdates
module.batchedUpdates = batchedUpdates
module.unbatchedUpdates = unbatchedUpdates
module.deferredUpdates = deferredUpdates
module.discreteUpdates = discreteUpdates
module.flushDiscreteUpdates = flushDiscreteUpdates
module.flushControlled = flushControlled
module.flushSync = flushSync
module.flushPassiveEffects = flushPassiveEffects
module.IsThisRendererActing = IsThisRendererActing
module.act = act

function module.getPublicRootInstance(arg1)
    local current = arg1.current
    if not current.child then
        return nil
    elseif current.child.tag == HostComponent then
        return getPublicInstance(current.child.stateNode)
    end
    return current.child.stateNode
end

local var2 = nil

function module.attemptSynchronousHydration(arg1)
    if arg1.tag == HostRoot then
        local stateNode = arg1.stateNode
        if stateNode.hydrate then
            local highestPriorityPendingLanes = getHighestPriorityPendingLanes(stateNode)
            flushRoot(stateNode, highestPriorityPendingLanes)
        end
    elseif arg1.tag == SuspenseComponent then
        local var3 = requestEventTime()
        flushSync(function()
            return scheduleUpdateOnFiber(arg1, SyncLane, var3)
        end)

        var2(arg1, InputDiscreteHydrationLane)
    end
end

local function markRetryLaneImpl(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local memoizedState = arg1.memoizedState
    if memoizedState and memoizedState ~= nil and memoizedState.dehydrated ~= nil then
        memoizedState.retryLane = higherPriorityLane(memoizedState.retryLane, arg2)
    end
end

var2 = function(arg1, arg2)
    markRetryLaneImpl(arg1, arg2)
    local alternate = arg1.alternate
    if alternate then
        markRetryLaneImpl(alternate, arg2)
    end
end

function module.attemptUserBlockingHydration(arg1)
    if arg1.tag ~= SuspenseComponent then
        return
    end
    local var3 = requestEventTime()
    local var4 = InputDiscreteHydrationLane
    scheduleUpdateOnFiber(arg1, var4, var3)
    var2(arg1, var4)
end

function module.attemptContinuousHydration(arg1)
    if arg1.tag ~= SuspenseComponent then
        return
    end
    local var3 = requestEventTime()
    local var4 = SelectiveHydrationLane
    scheduleUpdateOnFiber(arg1, var4, var3)
    var2(arg1, var4)
end

function module.attemptHydrationAtCurrentPriority(arg1)
    if arg1.tag ~= SuspenseComponent then
        return
    end
    local var3 = requestEventTime()
    local var4 = requestUpdateLane(arg1)
    scheduleUpdateOnFiber(arg1, var4, var3)
    var2(arg1, var4)
end

function module.runWithPriority(arg1, callback: (...any) -> (...any))
    local currentUpdateLanePriority = getCurrentUpdateLanePriority()

    setCurrentUpdateLanePriority(arg1)
    local success, result = xpcall(callback, describeError)
    setCurrentUpdateLanePriority(currentUpdateLanePriority)
    if not success then
        error(result)
    end
    return result
end

module.getCurrentUpdateLanePriority = getCurrentUpdateLanePriority

module.findHostInstance = findHostInstance

module.findHostInstanceWithWarning = findHostInstanceWithWarning

function module.findHostInstanceWithNoPortals(arg1)
    local currentHostFiberWithNoPortals = findCurrentHostFiberWithNoPortals(arg1)

    if currentHostFiberWithNoPortals == nil then
        return nil
    end

    if currentHostFiberWithNoPortals.tag == FundamentalComponent then
        return currentHostFiberWithNoPortals.stateNode.instance
    end

    return currentHostFiberWithNoPortals.stateNode
end

local function shouldSuspendImpl(_): boolean
    return false
end

function module.shouldSuspend(arg1): boolean
    return shouldSuspendImpl(arg1)
end

local var3 = nil
local var4 = nil
local var5 = nil
local var6 = nil
local var7 = nil
local var8 = nil
local var9 = nil
local var10 = nil

if __DEV__ then
    local function copyWithDeleteImpl(tbl1, tbl2, num1: number)
        local var11 = tbl2[num1]
        local var12 = if Array.isArray(tbl1) then Array.slice(tbl1) else table.clone(tbl1)

        if num1 + 1 ~= #tbl2 then
            var12[var11] = copyWithDeleteImpl(tbl1[var11], tbl2, num1 + 1)
            return var12
        end

        if Array.isArray(var12) then
            Array.splice(var12, var11, 1)
        else
            var12[var11] = nil
        end
        return var12
    end

    local function copyWithDelete(tbl1, tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
        return (copyWithDeleteImpl(tbl1, tbl2, 0))
    end

    local function copyWithRenameImpl(tbl1, tbl2, tbl3, num1: number)
        local var11 = tbl2[num1]
        local var12 = if Array.isArray(tbl1) then Array.slice(tbl1) else table.clone(tbl1)

        if num1 + 1 ~= #tbl2 then
            var12[var11] = copyWithRenameImpl(tbl1[var11], tbl2, tbl3, num1 + 1)

            return var12
        end

        var12[tbl3[num1]] = var12[var11]
        if Array.isArray(var12) then
            Array.splice(var12, var11, 1)
        else
            var12[var11] = nil
        end

        return var12
    end

    local function copyWithRename(tbl1, tbl2, tbl3)
        if #tbl2 ~= #tbl3 then
            console.warn("copyWithRename() expects paths of the same length")
            return nil
        end
        for i = 1, #tbl3 do
            if tbl2[i] ~= tbl3[i] then
                console.warn("copyWithRename() expects paths to be the same except for the deepest key")

                return nil
            end
        end

        return (copyWithRenameImpl(tbl1, tbl2, tbl3, 0))
    end

    local function copyWithSetImpl(tbl1, tbl2, num1: number, arg1)
        if #tbl2 + 1 <= num1 then
            return arg1
        end
        local var11 = tbl2[num1]
        local var12 = if Array.isArray(tbl1) then Array.slice(tbl1) else table.clone(tbl1)
        var12[var11] = copyWithSetImpl(tbl1[var11], tbl2, num1 + 2, arg1)
        return var12
    end

    local function copyWithSet(tbl1, tbl2, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        return (copyWithSetImpl(tbl1, tbl2, 1, arg1))
    end

    local function findHook(arg1, num1: number) -- Luacid: unused: defined but never referenced
        local memoizedState = arg1.memoizedState
        while memoizedState ~= nil and num1 > 1 do
            memoizedState = memoizedState.next
            num1 -= 1
        end
        return memoizedState
    end

    var3 = function(arg1, num1: number, tbl1, arg2)
        local memoizedState = arg1.memoizedState
        while memoizedState ~= nil and num1 > 1 do
            memoizedState = memoizedState.next
            num1 -= 1
        end

        if memoizedState == nil then
            return
        end

        local var11 = copyWithSet(memoizedState.memoizedState, tbl1, arg2)
        memoizedState.memoizedState = var11
        memoizedState.baseState = var11

        arg1.memoizedProps = table.clone(arg1.memoizedProps)

        scheduleUpdateOnFiber(arg1, SyncLane, NoTimestamp)
    end

    var4 = function(arg1, num1: number, tbl1)
        local memoizedState = arg1.memoizedState
        while memoizedState ~= nil and num1 > 1 do
            memoizedState = memoizedState.next
            num1 -= 1
        end

        if memoizedState == nil then
            return
        end

        local var11 = copyWithDelete(memoizedState.memoizedState, tbl1)
        memoizedState.memoizedState = var11
        memoizedState.baseState = var11

        arg1.memoizedProps = table.clone(arg1.memoizedProps)

        scheduleUpdateOnFiber(arg1, SyncLane, NoTimestamp)
    end

    var5 = function(arg1, num1: number, tbl1, tbl2)
        local memoizedState = arg1.memoizedState
        while memoizedState ~= nil and num1 > 1 do
            memoizedState = memoizedState.next
            num1 -= 1
        end

        if memoizedState == nil then
            return
        end

        local var11 = copyWithRename(memoizedState.memoizedState, tbl1, tbl2)
        memoizedState.memoizedState = var11
        memoizedState.baseState = var11

        arg1.memoizedProps = table.clone(arg1.memoizedProps)

        scheduleUpdateOnFiber(arg1, SyncLane, NoTimestamp)
    end

    var6 = function(arg1, tbl1, arg2)
        arg1.pendingProps = copyWithSet(arg1.memoizedProps, tbl1, arg2)

        local alternate = arg1.alternate
        if alternate then
            alternate.pendingProps = arg1.pendingProps
        end
        scheduleUpdateOnFiber(arg1, SyncLane, NoTimestamp)
    end
    var7 = function(arg1, tbl1)
        arg1.pendingProps = copyWithDelete(arg1.memoizedProps, tbl1)

        local alternate = arg1.alternate
        if alternate then
            alternate.pendingProps = arg1.pendingProps
        end
        scheduleUpdateOnFiber(arg1, SyncLane, NoTimestamp)
    end
    var8 = function(arg1, tbl1, tbl2)
        arg1.pendingProps = copyWithRename(arg1.memoizedProps, tbl1, tbl2)

        local alternate = arg1.alternate
        if alternate then
            alternate.pendingProps = arg1.pendingProps
        end
        scheduleUpdateOnFiber(arg1, SyncLane, NoTimestamp)
    end

    var9 = function(arg1)
        scheduleUpdateOnFiber(arg1, SyncLane, NoTimestamp)
    end

    var10 = function(func1: (...any) -> (...any))
        shouldSuspendImpl = func1
    end
end

function findHostInstanceByFiber(arg1)
    local currentHostFiber = findCurrentHostFiber(arg1)
    return if currentHostFiber == nil then nil else currentHostFiber.stateNode
end

function emptyFindFiberByHostInstance(_)
    return nil
end

function getCurrentFiberForDevTools()
    return ReactCurrentFiber.current
end

function module.injectIntoDevTools(tbl1)
    local findFiberByHostInstance = tbl1.findFiberByHostInstance
    local reactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher
    local getCurrentFiberForDevTools = if __DEV__ then getCurrentFiberForDevTools else nil
    return injectInternals({
        bundleType = tbl1.bundleType,
        version = tbl1.version,
        rendererPackageName = tbl1.rendererPackageName,
        rendererConfig = tbl1.rendererConfig,
        overrideHookState = var3,
        overrideHookStateDeletePath = var4,
        overrideHookStateRenamePath = var5,
        overrideProps = var6,
        overridePropsDeletePath = var7,
        overridePropsRenamePath = var8,
        setSuspenseHandler = var10,
        scheduleUpdate = var9,
        currentDispatcherRef = reactCurrentDispatcher,
        findHostInstanceByFiber = findHostInstanceByFiber,
        findFiberByHostInstance = findFiberByHostInstance or emptyFindFiberByHostInstance,
        findHostInstancesForRefresh = if __DEV__ then findHostInstancesForRefresh else nil,
        scheduleRefresh = if __DEV__ then scheduleRefresh else nil,
        scheduleRoot = if __DEV__ then scheduleRoot else nil,
        setRefreshHandler = if __DEV__ then setRefreshHandler else nil,
        getCurrentFiber = getCurrentFiberForDevTools
    })
end

module.robloxReactProfiling = require(script.Parent.RobloxReactProfiling)
module.schedulingProfiler = {
    profilerEventTypes = SchedulingProfiler.profilerEventTypes,
    registerProfilerEventCallback = SchedulingProfiler.registerProfilerEventCallback
}

return module
