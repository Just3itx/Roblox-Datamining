-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function unimplemented(str1: string) -- Luacid: unused: defined but never referenced
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: " .. str1)
    error("FIXME (roblox): " .. str1 .. " is unimplemented")
end
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local Object = LuauPolyfill.Object

local __DEV__ = ReactGlobals.__DEV__

local createRef = require(scriptParentParent.React).createRef
local createBinding = require(scriptParentParent.React).createBinding

local console = require(scriptParentParent.Shared).console
local MemoValues = require(scriptParentParent.Shared).MemoValues

local _Shared = require(scriptParentParent.Shared)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local ReactHookEffectTags = require(script.Parent.ReactHookEffectTags)

local ReactSharedInternals = require(scriptParentParent.Shared).ReactSharedInternals
local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler
local enableNewReconciler = ReactFeatureFlags.enableNewReconciler

local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects
local enableAllocationTrims = ReactFeatureFlags.enableAllocationTrims
local enableHookDoubleBuffering = ReactFeatureFlags.enableHookDoubleBuffering

local DebugTracingMode = require(script.Parent.ReactTypeOfMode).DebugTracingMode
local NoLane = ReactFiberLane.NoLane
local NoLanes = ReactFiberLane.NoLanes

local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes
local mergeLanes = ReactFiberLane.mergeLanes
local removeLanes = ReactFiberLane.removeLanes
local markRootEntangled = ReactFiberLane.markRootEntangled
local markRootMutableRead = ReactFiberLane.markRootMutableRead

local readContext = require(script.Parent["ReactFiberNewContext.new"]).readContext
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local Update = ReactFiberFlags.Update
local Passive = ReactFiberFlags.Passive
local PassiveStatic = ReactFiberFlags.PassiveStatic
local MountLayoutDev = ReactFiberFlags.MountLayoutDev
local MountPassiveDev = ReactFiberFlags.MountPassiveDev
local HasEffect = ReactHookEffectTags.HasEffect
local Layout = ReactHookEffectTags.Layout
local Passive2 = ReactHookEffectTags.Passive
local ReactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])

local warnIfNotCurrentlyActingUpdatesInDEV = ReactFiberWorkLoopNew.warnIfNotCurrentlyActingUpdatesInDEV
local scheduleUpdateOnFiber = ReactFiberWorkLoopNew.scheduleUpdateOnFiber
local warnIfNotScopedWithMatchingAct = ReactFiberWorkLoopNew.warnIfNotScopedWithMatchingAct
local requestEventTime = ReactFiberWorkLoopNew.requestEventTime
local requestUpdateLane = ReactFiberWorkLoopNew.requestUpdateLane
local markSkippedUpdateLanes = ReactFiberWorkLoopNew.markSkippedUpdateLanes
local getWorkInProgressRoot = ReactFiberWorkLoopNew.getWorkInProgressRoot

local warnIfNotCurrentlyActingEffectsInDEV = ReactFiberWorkLoopNew.warnIfNotCurrentlyActingEffectsInDEV

local invariant = require(scriptParentParent.Shared).invariant
local getComponentName = require(scriptParentParent.Shared).getComponentName

local function is(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1 == arg2 and (arg1 ~= 0 or 1 / arg1 == 1 / arg2) or not (arg1 == arg1) and arg2 ~= arg2
end

local markWorkInProgressReceivedUpdate = require(script.Parent["ReactFiberBeginWork.new"]).markWorkInProgressReceivedUpdate

local getIsHydrating = require(script.Parent["ReactFiberHydrationContext.new"]).getIsHydrating

local makeClientId = require(script.Parent.ReactFiberHostConfig).makeClientId

local ReactMutableSourceNew = require(script.Parent["ReactMutableSource.new"])
local warnAboutMultipleRenderersDEV = ReactMutableSourceNew.warnAboutMultipleRenderersDEV
local getWorkInProgressVersion = ReactMutableSourceNew.getWorkInProgressVersion
local setWorkInProgressVersion = ReactMutableSourceNew.setWorkInProgressVersion
local markSourceAsDirty = ReactMutableSourceNew.markSourceAsDirty

local logStateUpdateScheduled = require(script.Parent.DebugTracing).logStateUpdateScheduled

local markStateUpdateScheduled = require(script.Parent.SchedulingProfiler).markStateUpdateScheduled

local ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher

local var1 = require(scriptParentParent.SafeFlags).createGetFFlag("ReactCleanQueueOnUpdateBailout")()

local var2 = nil

var2 = __DEV__ and {} or var2

local module = {}

local var3 = NoLanes

local var4 = nil

local var5 = nil

local var6 = nil

local next = nil
local var7 = nil

local bool1 = false

local bool2 = false

local var8 = nil

local var9 = nil
local num1 = 0

local var10 = nil
local var11 = nil
local var12 = nil
local var13 = nil
local var14 = nil
local var15 = nil
local var16 = nil

local function getHighestIndex(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local num2 = 0
    for value, _ in tbl1 do
        if num2 < value then
            num2 = value
        end
    end

    return num2
end

local function isArrayOrSparseArray(arg1) -- Luacid: unused: defined but never referenced
    if type(arg1) ~= "table" then
        return false
    end
    for value, _ in arg1 do
        if type(value) ~= "number" then
            return false
        end
    end
    return true
end

local function mountHookTypesDev() -- Luacid: unused: defined but never referenced
    if not __DEV__ then
        return
    end

    local var17 = var8

    if var9 == nil then
        var9 = { var17 }
        return
    end
    table.insert(var9, var17)
end

function updateHookTypesDev()
    if not __DEV__ then
        return
    end
    local var17 = var8

    if var9 == nil then
        return
    end

    num1 += 1
    if var9[num1] ~= var17 then
        warnOnHookMismatchInDev(var17)
    end
end

local function checkDepsAreArrayDev(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    if not __DEV__ or arg1 == nil then
        return
    end

    local bool3

    if type(arg1) == "table" then
        bool3 = true

        for value, _ in arg1 do
            if type(value) ~= "number" then
                bool3 = false
                break
            end
        end
    else
        bool3 = false
    end

    if not bool3 then
        console.error(
            "%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.",
            var8,
            type(arg1)
        )
    end
end

function warnOnHookMismatchInDev(arg1)
    if not __DEV__ then
        return
    end
    local componentName = getComponentName(var4.type) or "Component"

    if var2[componentName] then
        return
    end

    var2[componentName] = true

    if var9 == nil then
        return
    end

    local str1 = ""

    for i = 1, num1 do
        local var17 = var9[i]
        local var18 = if i == num1 then arg1 else var17
        local var19 = tostring(i) .. ". " .. (var17 or "undefined")

        while string.len(var19) < 30 do
            var19 ..= " "
        end

        str1 ..= var19 .. var18 .. "\n"
    end

    console.error(
        "React has detected a change in the order of Hooks called by %s. This will lead to bugs and errors if not fixed. For more information, read the Rules of Hooks: https://reactjs.org/link/rules-of-hooks\n\n   Previous render            Next render\n   ------------------------------------------------------\n%s   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n",
        componentName,
        str1
    )
end

local function throwInvalidHookError()
    error(
        Error.new(
            "Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem."
        )
    )
end

local function areHookInputsEqual(tbl1, tbl2)
    if tbl2 == nil then
        if __DEV__ then
            console.error(
                "%s received a final argument during this render, but not during the previous render. Even though the final argument is optional, its type cannot change between renders.",
                var8
            )
        end
        return false
    end

    local highestIndex = getHighestIndex(tbl1)
    local highestIndex2 = getHighestIndex(tbl2)

    if highestIndex ~= highestIndex2 then
        return false
    end

    for i = 1, math.min(highestIndex2, highestIndex) do
        local var17 = tbl1[i]
        local var18 = tbl2[i]

        if (var17 ~= var18 or var17 == 0 and 1 / var17 ~= 1 / var18) and (var17 == var17 or var18 == var18) then
            return false
        end
    end

    return true
end

function module.bailoutHooks(arg1, arg2, arg3)
    if enableHookDoubleBuffering and arg1.updateQueue ~= nil then
        arg1.updateQueue.alternate = nil
    end

    arg2.updateQueue = arg1.updateQueue
    if __DEV__ and enableDoubleInvokingEffects then
        arg2.flags = bit32.band(arg2.flags, bit32.bnot(bit32.bor(MountPassiveDev, Passive, MountLayoutDev, Update)))
    else
        arg2.flags = bit32.band(arg2.flags, bit32.bnot(bit32.bor(Passive, Update)))
    end

    arg1.lanes = removeLanes(arg1.lanes, arg3)
end

local bool3 = false
function module.resetHooksAfterThrow()
    ReactCurrentDispatcher.current = module.ContextOnlyDispatcher

    if bool1 then
        local memoizedState = var4.memoizedState
        while memoizedState ~= nil do
            local queue = memoizedState.queue
            if queue ~= nil then
                queue.pending = nil
            end
            memoizedState = memoizedState.next
        end
        bool1 = false
    end

    var3 = NoLanes
    var4 = nil

    var5 = nil
    var6 = nil
    if enableHookDoubleBuffering then
        next = nil
        var7 = nil
    end

    if __DEV__ then
        var9 = nil
        num1 = 0

        var8 = nil

        bool3 = false
    end

    bool2 = false
end

local function mountWorkInProgressHook(): {baseQueue: nil, baseState: nil, memoizedState: nil, next: nil, queue: nil} | {baseState: nil, memoizedState: nil, next: nil, queue: nil}
    local var17 = enableAllocationTrims and {
        memoizedState = nil,
        baseState = nil,
        queue = nil,
        next = nil
    }
        or { memoizedState = nil, baseState = nil, baseQueue = nil, queue = nil, next = nil }

    if var6 == nil then
        var4.memoizedState = var17
        var6 = var17
    else
        var6.next = var17
        var6 = var17
    end
    return var6
end

local function updateWorkInProgressHook()
    local var17

    if var5 == nil then
        local alternate = var4.alternate
        if alternate == nil then
            var17 = nil
        else
            var17 = alternate.memoizedState
        end
    else
        var17 = var5.next
    end

    local var18 = if var6 == nil then var4.memoizedState else var6.next

    if var18 ~= nil then
        var6 = var18
        local _next = var6.next

        var5 = var17
    else
        if var17 == nil then
            error(Error.new("Rendered more hooks than during the previous render."))
        end

        var5 = var17
        local alternate

        if enableHookDoubleBuffering then
            alternate = var5.alternate
            if alternate ~= nil then
                local memoizedState = var5.memoizedState
                if memoizedState ~= nil or alternate.memoizedState ~= nil then
                    alternate.memoizedState = memoizedState
                end
                local baseState = var5.baseState
                if baseState ~= nil or alternate.baseState ~= nil then
                    alternate.baseState = baseState
                end
                local baseQueue = var5.baseQueue
                if baseQueue ~= nil or alternate.baseQueue ~= nil then
                    alternate.baseQueue = baseQueue
                end
                local queue = var5.queue
                if queue ~= nil or alternate.queue ~= nil then
                    alternate.queue = queue
                end
                if alternate.next ~= nil then
                    alternate.next = nil
                end
            else
                alternate = {
                    memoizedState = var5.memoizedState,
                    baseState = var5.baseState,
                    baseQueue = var5.baseQueue,
                    queue = var5.queue,
                    next = nil
                }

                alternate.alternate = var5
                var5.alternate = alternate
            end
        elseif enableAllocationTrims then
            local baseQueue = var5.baseQueue
            alternate = baseQueue == nil and {
                memoizedState = var5.memoizedState,
                baseState = var5.baseState,
                queue = var5.queue,
                next = nil
            }
                or {
                    memoizedState = var5.memoizedState,
                    baseState = var5.baseState,
                    baseQueue = baseQueue,
                    queue = var5.queue,
                    next = nil
                }
        else
            alternate = {
                memoizedState = var5.memoizedState,
                baseState = var5.baseState,
                baseQueue = var5.baseQueue,
                queue = var5.queue,
                next = nil
            }
        end

        if var6 == nil then
            var6 = alternate
            var4.memoizedState = alternate
        else
            var6.next = alternate
            var6 = alternate
        end
    end
    return var6
end

function basicStateReducer(arg1, arg2)
    if type(arg2) == "function" then
        return arg2(arg1)
    end
    return arg2
end

function mountReducer(lastRenderedReducer: (...any) -> (...any), arg1, func1: ((...any) -> (...any))?)
    local var17 = mountWorkInProgressHook()

    if func1 ~= nil then
        arg1 = func1(arg1)
    end

    var17.baseState = arg1
    var17.memoizedState = var17.baseState

    local queue = {
        pending = nil,
        dispatch = nil,
        lastRenderedReducer = lastRenderedReducer,
        lastRenderedState = arg1
    }
    var17.queue = queue

    local var18 = var4

    local function dispatch(arg2, ...)
        dispatchAction(var18, queue, arg2, ...)
    end
    queue.dispatch = dispatch

    return var17.memoizedState, dispatch
end

function updateReducer(lastRenderedReducer: (...any) -> (...any), _, _: ((...any) -> (...any))?)
    local var17 = updateWorkInProgressHook()
    local queue = var17.queue

    assert(queue ~= nil, "Should have a queue. This is likely a bug in React. Please file an issue.")

    queue.lastRenderedReducer = lastRenderedReducer

    local var18 = var5

    local baseQueue = var18.baseQueue

    local pending = queue.pending
    if pending == nil then
        pending = baseQueue
    else
        if baseQueue ~= nil then
            local next2 = baseQueue.next
            baseQueue.next = pending.next
            pending.next = next2
        end

        var18.baseQueue = pending
        queue.pending = nil
    end

    if pending ~= nil then
        local next2 = pending.next
        local baseState = var18.baseState
        local var19 = next2
        local next3 = nil
        local var20 = nil
        local var21 = nil

        repeat
            local lane = next2.lane

            if bit32.band(var3, lane) ~= lane then
                local tbl1 = {
                    lane = lane,
                    action = next2.action,
                    eagerReducer = next2.eagerReducer,
                    eagerState = next2.eagerState,
                    next = nil
                }

                if next3 == nil then
                    var21 = baseState
                    var20 = tbl1
                    next3 = var20
                else
                    next3.next = tbl1
                    next3 = next3.next
                end

                var4.lanes = mergeLanes(var4.lanes, lane)
                markSkippedUpdateLanes(lane)
            else
                if next3 ~= nil then
                    local tbl1 = {
                        lane = NoLane,
                        action = next2.action,
                        eagerReducer = next2.eagerReducer,
                        eagerState = next2.eagerState,
                        next = nil
                    }

                    next3.next = tbl1
                    next3 = next3.next
                end

                if next2.eagerReducer == lastRenderedReducer then
                    baseState = next2.eagerState
                else
                    baseState = lastRenderedReducer(baseState, next2.action)
                end
            end
            next2 = next2.next
        until next2 == nil or next2 == var19

        if next3 == nil then
            var21 = baseState
        else
            next3.next = var20
        end

        local memoizedState = var17.memoizedState

        if (baseState ~= memoizedState or baseState == 0 and 1 / baseState ~= 1 / memoizedState)
            and (baseState == baseState or memoizedState == memoizedState)
        then
            markWorkInProgressReceivedUpdate()
        end

        var17.memoizedState = baseState
        var17.baseState = var21
        var17.baseQueue = next3

        queue.lastRenderedState = baseState
    end

    local dispatch = queue.dispatch

    return var17.memoizedState, dispatch
end

function rerenderReducer(lastRenderedReducer: (...any) -> (...any), _, _: ((...any) -> (...any))?)
    local var17 = updateWorkInProgressHook()
    local queue = var17.queue

    assert(queue ~= nil, "Should have a queue. This is likely a bug in React. Please file an issue.")

    queue.lastRenderedReducer = lastRenderedReducer

    local dispatch = queue.dispatch
    local pending = queue.pending
    local memoizedState = var17.memoizedState
    if pending ~= nil then
        queue.pending = nil

        local next2 = pending.next

        repeat
            memoizedState = lastRenderedReducer(memoizedState, next2.action)
            next2 = next2.next
        until next2 == next2

        local memoizedState2 = var17.memoizedState

        if (memoizedState ~= memoizedState2 or memoizedState == 0 and 1 / memoizedState ~= 1 / memoizedState2)
            and (memoizedState == memoizedState or memoizedState2 == memoizedState2)
        then
            markWorkInProgressReceivedUpdate()
        end

        var17.memoizedState = memoizedState

        if var17.baseQueue == nil then
            var17.baseState = memoizedState
        end

        queue.lastRenderedState = memoizedState
    end

    return memoizedState, dispatch
end

function readFromUnsubcribedMutableSource(arg1, arg2, arg3)
    if __DEV__ then
        warnAboutMultipleRenderersDEV(arg2)
    end

    local var17 = arg2._getVersion(arg2._source)

    local workInProgressVersion = getWorkInProgressVersion(arg2)
    local bool4

    if workInProgressVersion ~= nil then
        bool4 = workInProgressVersion == var17
    else
        bool4 = isSubsetOfLanes(var3, arg1.mutableReadLanes)

        if bool4 then
            setWorkInProgressVersion(arg2, var17)
        end
    end

    if bool4 then
        local var18 = arg3(arg2._source)
        if __DEV__ and type(var18) == "function" then
            console.error(
                "Mutable source should not return a function as the snapshot value. Functions may close over mutable values and cause tearing."
            )
        end

        return var18
    end

    markSourceAsDirty(arg2)

    error(
        Error.new(
            "Cannot read from mutable source during the current render without tearing. This is a bug in React. Please file an issue."
        )
    )
end

function useMutableSource(tbl1, arg1, arg2, arg3)
    local workInProgressRoot = getWorkInProgressRoot()
    invariant(workInProgressRoot ~= nil, "Expected a work-in-progress root. This is a bug in React. Please file an issue.")

    local _getVersion = arg1._getVersion
    local var17 = _getVersion(arg1._source)

    local current = ReactCurrentDispatcher.current

    assert(current ~= nil, "dispatcher was nil, this is a bug in React")

    local var18, func1 = current.useState(function()
        return readFromUnsubcribedMutableSource(workInProgressRoot, arg1, arg2)
    end)
    local var19 = var18

    local var20 = var6

    local memoizedState = tbl1.memoizedState
    if memoizedState.refs == nil then
        error(tostring(debug.traceback()))
    end
    local refs = memoizedState.refs
    local getSnapshot = refs.getSnapshot
    local source = memoizedState.source
    local subscribe = memoizedState.subscribe

    local var21 = var4

    tbl1.memoizedState = { refs = refs, source = arg1, subscribe = arg3 }

    current.useEffect(function()
        refs.getSnapshot = arg2

        refs.setSnapshot = func1

        local var22 = _getVersion(arg1._source)
        local var23 = var17

        if var23 == var22 and (var23 ~= 0 or 1 / var23 == 1 / var22) or var23 ~= var23 and var22 ~= var22 then
            return
        end

        local var24 = arg2(arg1._source)
        if __DEV__ and type(var24) == "function" then
            console.error(
                "Mutable source should not return a function as the snapshot value. Functions may close over mutable values and cause tearing."
            )
        end

        local var25 = var19

        if (var25 ~= var24 or var25 == 0 and 1 / var25 ~= 1 / var24) and (var25 == var25 or var24 == var24) then
            func1(var24)

            local var26 = requestUpdateLane(var21)
            markRootMutableRead(workInProgressRoot, var26)
        end

        markRootEntangled(workInProgressRoot, workInProgressRoot.mutableReadLanes)
    end, { arg2, arg1, arg3 })

    current.useEffect(function()
        local var22 = arg3(arg1._source, function()
            local getSnapshot2 = refs.getSnapshot
            local setSnapshot = refs.setSnapshot

            local success, result = pcall(function()
                setSnapshot(getSnapshot2(arg1._source))

                local var22 = requestUpdateLane(var21)

                markRootMutableRead(workInProgressRoot, var22)
            end)

            if not success then
                setSnapshot(function()
                    error(result)
                end)
            end
        end)

        if __DEV__ and type(var22) ~= "function" then
            console.error("Mutable source subscribe function must return an unsubscribe function.")
        end

        return var22
    end, { arg1, arg3 })

    local bool4 = is(getSnapshot, arg2)
    local bool5 = false

    if bool4 then
        local bool6 = source == arg1 and (source ~= 0 or 1 / source == 1 / arg1) or not (source == source) and arg1 ~= arg1
        local bool7 = if bool6 then is(subscribe, arg3) else false
        bool5 = bool7
    end

    if not bool5 then
        local queue = {
            pending = nil,
            dispatch = nil,
            lastRenderedReducer = basicStateReducer,
            lastRenderedState = var19
        }

        local var22 = var4

        func1 = function(...)
            dispatchAction(var22, queue, ...)
        end
        queue.dispatch = func1
        var20.queue = queue
        var20.baseQueue = nil
        var19 = readFromUnsubcribedMutableSource(workInProgressRoot, arg1, arg2)
        var20.baseState = var19
        var20.memoizedState = var20.baseState
    end

    return var19
end

function mountMutableSource(source, getSnapshot, subscribe)
    local var17 = mountWorkInProgressHook()
    var17.memoizedState = {
        refs = { getSnapshot = getSnapshot, setSnapshot = nil },
        source = source,
        subscribe = subscribe
    }
    return useMutableSource(var17, source, getSnapshot, subscribe)
end

function updateMutableSource(arg1, arg2, arg3)
    local var17 = updateWorkInProgressHook()
    return useMutableSource(var17, arg1, arg2, arg3)
end

function mountState(arg1)
    local var17 = mountWorkInProgressHook()
    if type(arg1) == "function" then
        arg1 = arg1()
    end
    var17.baseState = arg1
    var17.memoizedState = var17.baseState
    local queue = {
        pending = nil,
        dispatch = nil,
        lastRenderedReducer = nil,
        lastRenderedState = arg1
    }

    queue.lastRenderedReducer = basicStateReducer
    var17.queue = queue

    local var18 = var4
    local function dispatch(arg2, ...)
        dispatchAction(var18, queue, arg2, ...)
    end
    queue.dispatch = dispatch

    return var17.memoizedState, dispatch
end

function updateState(arg1)
    return updateReducer(basicStateReducer, arg1)
end

function rerenderState(arg1)
    return rerenderReducer(basicStateReducer, arg1)
end

local function reuseFunctionComponentUpdateQueue()
    local alternate = var4.alternate
    local updateQueue = if alternate == nil then nil else alternate.updateQueue
    local alternate2 = if updateQueue == nil then nil else updateQueue.alternate

    if alternate2 ~= nil then
        local lastEffect = alternate2.lastEffect
        var7 = lastEffect
        next = if lastEffect == nil then nil else lastEffect.next
        alternate2.lastEffect = nil
        return alternate2
    end
    next = nil
    var7 = nil

    if updateQueue == nil then
        return { lastEffect = nil }
    end

    local tbl1 = { lastEffect = nil, alternate = updateQueue }

    updateQueue.alternate = tbl1
    return tbl1
end

local function pushEffect(tag, create, destroy, deps)
    if not enableHookDoubleBuffering then
        local tbl1 = { tag = tag, create = create, destroy = destroy, deps = deps, next = nil }

        local updateQueue = var4.updateQueue
        if updateQueue == nil then
            local tbl2 = { lastEffect = nil }

            var4.updateQueue = tbl2
            tbl1.next = tbl1
            tbl2.lastEffect = tbl1
            return tbl1
        end
        local lastEffect = updateQueue.lastEffect
        if lastEffect == nil then
            updateQueue.lastEffect = tbl1
            tbl1.next = tbl1
            return tbl1
        end
        local next2 = lastEffect.next
        lastEffect.next = tbl1
        tbl1.next = next2
        updateQueue.lastEffect = tbl1

        return tbl1
    end

    local updateQueue = var4.updateQueue
    if updateQueue == nil then
        updateQueue = reuseFunctionComponentUpdateQueue()
        var4.updateQueue = updateQueue
    end
    local var17 = next
    if var17 == nil then
        var17 = { tag = tag, create = create, destroy = destroy, deps = deps, next = nil }
    else
        next = if var17 == var7 then nil else var17.next
        var17.tag = tag
        var17.create = create

        if destroy ~= nil or var17.destroy ~= nil then
            var17.destroy = destroy
        end
        var17.deps = deps
    end

    local lastEffect = updateQueue.lastEffect
    if lastEffect == nil then
        var17.next = var17
    else
        var17.next = lastEffect.next
        lastEffect.next = var17
    end
    updateQueue.lastEffect = var17
    return var17
end

function mountBinding(arg1)
    local var17 = mountWorkInProgressHook()
    local memoizedState, baseState = createBinding(arg1)

    if not enableAllocationTrims then
        var17.memoizedState = { memoizedState, baseState }
    else
        var17.memoizedState = memoizedState
        var17.baseState = baseState
    end

    return memoizedState, baseState
end

function updateBinding(_)
    local var17 = updateWorkInProgressHook()
    if enableAllocationTrims then
        return var17.memoizedState, var17.baseState
    end
    return unpack(var17.memoizedState)
end

function mountRef(current)
    local var17 = mountWorkInProgressHook()

    local memoizedState = createRef()
    memoizedState.current = current

    var17.memoizedState = memoizedState
    return memoizedState
end

function updateRef(_)
    return updateWorkInProgressHook().memoizedState
end

local function mountEffectImpl(arg1, layout, create, deps)
    local var17 = mountWorkInProgressHook()

    local var18 = var4
    var18.flags = bit32.bor(var4.flags, arg1)

    var17.memoizedState = pushEffect(bit32.bor(HasEffect, layout), create, nil, deps)
end

function updateEffectImpl(arg1, tag, create, deps)
    local var17 = updateWorkInProgressHook()
    local destroy

    if var5 == nil then
        destroy = nil
    else
        local memoizedState = var5.memoizedState
        destroy = memoizedState.destroy
        if deps ~= nil then
            local deps2 = memoizedState.deps
            if areHookInputsEqual(deps, deps2) then
                var17.memoizedState = pushEffect(tag, create, destroy, deps)
                return
            end
        end
    end

    local var18 = var4
    var18.flags = bit32.bor(var4.flags, arg1)

    var17.memoizedState = pushEffect(bit32.bor(HasEffect, tag), create, destroy, deps)
end

local function mountEffect(create: (...any) -> (...any), deps)
    if __DEV__ and (type(_G.jest) ~= "nil" or ReactGlobals.__TESTEZ_RUNNING_TEST__) then
        warnIfNotCurrentlyActingEffectsInDEV(var4)
    end

    if __DEV__ and enableDoubleInvokingEffects then
        local num2 = bit32.bor(MountPassiveDev, Passive, PassiveStatic)
        local var17 = Passive2
        local var18 = mountWorkInProgressHook()

        local var19 = var4
        var19.flags = bit32.bor(var4.flags, num2)

        var18.memoizedState = pushEffect(bit32.bor(HasEffect, var17), create, nil, deps)
        return
    end

    local num2 = bit32.bor(Passive, PassiveStatic)
    local var17 = Passive2
    local var18 = mountWorkInProgressHook()

    local var19 = var4
    var19.flags = bit32.bor(var4.flags, num2)

    var18.memoizedState = pushEffect(bit32.bor(HasEffect, var17), create, nil, deps)
end

local function updateEffect(func1: (...any) -> (...any), tbl1)
    if __DEV__ and (type(_G.jest) ~= "nil" or ReactGlobals.__TESTEZ_RUNNING_TEST__) then
        warnIfNotCurrentlyActingEffectsInDEV(var4)
    end

    updateEffectImpl(Passive, Passive2, func1, tbl1)
end

local function mountLayoutEffect(create: (...any) -> (...any), deps)
    if __DEV__ and enableDoubleInvokingEffects then
        local num2 = bit32.bor(MountLayoutDev, Update)
        local var17 = Layout
        local var18 = mountWorkInProgressHook()

        local var19 = var4
        var19.flags = bit32.bor(var4.flags, num2)

        var18.memoizedState = pushEffect(bit32.bor(HasEffect, var17), create, nil, deps)
        return
    end

    local var17 = Update
    local var18 = Layout
    local var19 = mountWorkInProgressHook()

    local var20 = var4
    var20.flags = bit32.bor(var4.flags, var17)

    var19.memoizedState = pushEffect(bit32.bor(HasEffect, var18), create, nil, deps)
end

local function updateLayoutEffect(func1: (...any) -> (...any), tbl1)
    updateEffectImpl(Update, Layout, func1, tbl1)
end

function imperativeHandleEffect(func1: (...any) -> (...any), arg1)
    if arg1 ~= nil and type(arg1) == "function" then
        arg1((func1()))
        return function()
            return arg1(nil)
        end
    end

    if arg1 == nil then
        return nil
    end

    if __DEV__ and (getmetatable(arg1) == nil or #Object.keys(arg1) ~= 0) then
        console.error(
            "Expected useImperativeHandle() first argument to either be a ref callback or React.createRef() object. Instead received: %s.",
            "an object with keys {" .. Array.join(Object.keys(arg1), ", ") .. "}"
        )
    end

    arg1.current = func1()
    return function()
        arg1.current = nil
    end
end

function mountImperativeHandle(arg1, func1: (...any) -> (...any), tbl1)
    if __DEV__ and type(func1) ~= "function" then
        console.error(
            "Expected useImperativeHandle() second argument to be a function that creates a handle. Instead received: %s.",
            if func1 == nil then "nil" else type(func1)
        )
    end

    local var17 = if tbl1 == nil then nil else Array.concat(tbl1, { arg1 })

    if __DEV__ and enableDoubleInvokingEffects then
        return mountEffectImpl(bit32.bor(MountLayoutDev, Update), Layout, function()
            return imperativeHandleEffect(func1, arg1)
        end, var17)
    end

    return mountEffectImpl(Update, Layout, function()
        return imperativeHandleEffect(func1, arg1)
    end, var17)
end

function updateImperativeHandle(arg1, func1: (...any) -> (...any), tbl1)
    if __DEV__ and type(func1) ~= "function" then
        local received = if func1 then type(func1) else "nil"

        console.error(
            "Expected useImperativeHandle() second argument to be a function that creates a handle. Instead received: %s.",
            received
        )
    end

    local var17

    if tbl1 == nil then
        var17 = nil
    else
        var17 = table.clone(tbl1)
        table.insert(var17, arg1)
    end

    return updateEffectImpl(Update, Layout, function()
        return imperativeHandleEffect(func1, arg1)
    end, var17)
end

function mountDebugValue(_, _: ((...any) -> (...any))?) end

local mountDebugValue2 = mountDebugValue

function mountCallback(memoizedState, baseState)
    local var17 = mountWorkInProgressHook()

    if not enableAllocationTrims then
        var17.memoizedState = { memoizedState, baseState }
    else
        var17.memoizedState = memoizedState
        var17.baseState = baseState
    end

    return memoizedState
end

function updateCallback(arg1, baseState)
    local var17 = updateWorkInProgressHook()

    if enableAllocationTrims then
        if baseState ~= nil then
            local baseState2 = var17.baseState
            if areHookInputsEqual(baseState, baseState2) then
                return var17.memoizedState
            end
        end
        var17.memoizedState = arg1
        var17.baseState = baseState
        return arg1
    end
    local memoizedState = var17.memoizedState
    if memoizedState ~= nil and baseState ~= nil then
        local var18 = memoizedState[2]
        if areHookInputsEqual(baseState, var18) then
            return memoizedState[1]
        end
    end

    var17.memoizedState = { arg1, baseState }
    return arg1
end

function mountMemo(func1: (...any) -> (...any), baseState)
    local var17 = mountWorkInProgressHook()

    if enableAllocationTrims then
        local memoizedState = MemoValues.pack(func1())
        var17.memoizedState = memoizedState
        var17.baseState = baseState
        return MemoValues.unpack(memoizedState)
    end

    local tbl2 = { func1() }
    var17.memoizedState = { tbl2, baseState }
    return unpack(tbl2)
end

function updateMemo(func1: (...any) -> (...any), baseState)
    local var17 = updateWorkInProgressHook()

    if enableAllocationTrims then
        if baseState ~= nil then
            local baseState2 = var17.baseState
            if areHookInputsEqual(baseState, baseState2) then
                return MemoValues.unpack(var17.memoizedState)
            end
        end

        local memoizedState = MemoValues.pack(func1())
        var17.memoizedState = memoizedState
        var17.baseState = baseState
        return MemoValues.unpack(memoizedState)
    end
    local memoizedState = var17.memoizedState
    if memoizedState ~= nil and baseState ~= nil then
        local var18 = memoizedState[2]
        if areHookInputsEqual(baseState, var18) then
            return unpack(memoizedState[1])
        end
    end

    local tbl2 = { func1() }
    var17.memoizedState = { tbl2, baseState }
    return unpack(tbl2)
end

function module.getIsUpdatingOpaqueValueInRenderPhaseInDEV(): boolean?
    return not __DEV__ and nil
end

function mountOpaqueIdentifier()
    local var17 = nil
    if __DEV__ then
        console.warn("!!! unimplemented: warnOnOpaqueIdentifierAccessInDEV")
    else
        var17 = makeClientId
    end

    if not getIsHydrating() then
        local var18 = var17()
        mountState(var18)
        return var18
    end

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: ReactFiberHooks: getIsHydrating() true")
    error("FIXME (roblox): ReactFiberHooks: getIsHydrating() true is unimplemented")

    return nil
end

function updateOpaqueIdentifier()
    local var17, _ = updateState(nil)
    return var17
end

function rerenderOpaqueIdentifier()
    local var17, _ = rerenderState(nil)
    return var17
end

function dispatchAction(arg1, tbl1, action, ...)
    if __DEV__ then
        local select2 = select
        local var17

        if select2("#", ...) == 1 then
            local select = select
            var17 = select(1, ...)
        else
            var17 = nil
        end
        if type(var17) == "function" then
            console.error(
                "State updates from the useState() and useReducer() Hooks don't support the second callback argument. To execute a side effect after rendering, declare it in the component body with useEffect()."
            )
        end
    end

    local var17 = requestEventTime()
    local lane = requestUpdateLane(arg1)

    local tbl2 = { lane = lane, action = action, eagerReducer = nil, eagerState = nil, next = nil }

    local pending = tbl1.pending
    if pending == nil then
        tbl2.next = tbl2
    else
        tbl2.next = pending.next
        pending.next = tbl2
    end
    tbl1.pending = tbl2

    local alternate = arg1.alternate

    if arg1 == var4 or alternate ~= nil and alternate == var4 then
        bool1 = true
        bool2 = true
    else
        if arg1.lanes == NoLanes and (alternate == nil or alternate.lanes == NoLanes) then
            local lastRenderedReducer = tbl1.lastRenderedReducer
            if lastRenderedReducer ~= nil then
                local current

                if __DEV__ then
                    current = ReactCurrentDispatcher.current
                    ReactCurrentDispatcher.current = var15
                else
                    current = nil
                end

                local lastRenderedState = tbl1.lastRenderedState

                local success, result = pcall(lastRenderedReducer, lastRenderedState, action)

                if success then
                    tbl2.eagerReducer = lastRenderedReducer
                    tbl2.eagerState = result
                end

                if __DEV__ then
                    ReactCurrentDispatcher.current = current
                end

                if ReactFeatureFlags.fixEagerReducerError then
                    if success
                        and (result == lastRenderedState and (result ~= 0 or 1 / result == 1 / lastRenderedState)
                            or result ~= result and lastRenderedState ~= lastRenderedState)
                    then
                        if var1 then
                            if pending == nil then
                                tbl1.pending = nil
                                return
                            end
                            pending.next = tbl2.next
                            tbl1.pending = pending
                        end

                        return
                    end
                elseif result == lastRenderedState and (result ~= 0 or 1 / result == 1 / lastRenderedState)
                    or result ~= result and lastRenderedState ~= lastRenderedState
                then
                    if var1 then
                        if pending == nil then
                            tbl1.pending = nil
                            return
                        end
                        pending.next = tbl2.next
                        tbl1.pending = pending
                    end

                    return
                end
            end
        end

        if __DEV__ and (type(_G.jest) ~= "nil" or ReactGlobals.__TESTEZ_RUNNING_TEST__) then
            warnIfNotScopedWithMatchingAct(arg1)
            warnIfNotCurrentlyActingUpdatesInDEV(arg1)
        end

        scheduleUpdateOnFiber(arg1, lane, var17)
    end

    if __DEV__ and enableDebugTracing and bit32.band(arg1.mode, DebugTracingMode) ~= 0 then
        local componentName = getComponentName(arg1.type) or "Unknown"
        logStateUpdateScheduled(componentName, lane, action)
    end

    if enableSchedulingProfiler then
        markStateUpdateScheduled(arg1, lane)
    end
end

local tbl1 = {
    readContext = readContext,
    useCallback = throwInvalidHookError,
    useContext = throwInvalidHookError,
    useEffect = throwInvalidHookError,
    useImperativeHandle = throwInvalidHookError,
    useLayoutEffect = throwInvalidHookError,
    useMemo = throwInvalidHookError,
    useReducer = throwInvalidHookError,
    useRef = throwInvalidHookError,
    useBinding = throwInvalidHookError,
    useState = throwInvalidHookError,
    useDebugValue = throwInvalidHookError,
    useMutableSource = throwInvalidHookError,
    useOpaqueIdentifier = throwInvalidHookError,
    unstable_isNewReconciler = enableNewReconciler
}
module.ContextOnlyDispatcher = tbl1

local tbl2 = {
    readContext = readContext,
    useCallback = mountCallback,
    useContext = readContext,
    useEffect = mountEffect,
    useImperativeHandle = mountImperativeHandle,
    useLayoutEffect = mountLayoutEffect,
    useMemo = mountMemo,
    useReducer = mountReducer,
    useRef = mountRef,
    useBinding = mountBinding,
    useState = mountState,
    useDebugValue = mountDebugValue,
    useMutableSource = mountMutableSource,
    useOpaqueIdentifier = mountOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
}

local tbl3 = {
    readContext = readContext,
    useCallback = updateCallback,
    useContext = readContext,
    useEffect = updateEffect,
    useImperativeHandle = updateImperativeHandle,
    useLayoutEffect = updateLayoutEffect,
    useMemo = updateMemo,
    useReducer = updateReducer,
    useRef = updateRef,
    useBinding = updateBinding,
    useState = updateState,
    useDebugValue = mountDebugValue2,
    useMutableSource = updateMutableSource,
    useOpaqueIdentifier = updateOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
}

local tbl4 = {
    readContext = readContext,
    useCallback = updateCallback,
    useContext = readContext,
    useEffect = updateEffect,
    useImperativeHandle = updateImperativeHandle,
    useLayoutEffect = updateLayoutEffect,
    useMemo = updateMemo,
    useReducer = rerenderReducer,
    useRef = updateRef,
    useBinding = updateBinding,
    useState = rerenderState,
    useDebugValue = mountDebugValue2,
    useMutableSource = updateMutableSource,
    useOpaqueIdentifier = rerenderOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
}

if __DEV__ then
    local function _() -- Luacid: unused: defined but never referenced
        console.error(
            "Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()."
        )
    end

    local function restoreDispatcherAndReturn(current, bool4: boolean, ...)
        ReactCurrentDispatcher.current = current
        if not bool4 then
            error((...))
        end
        return ...
    end

    local function _() -- Luacid: unused: defined but never referenced
        console.error(
            "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
        )
    end

    var10 = {
        readContext = function(arg1, arg2)
            return readContext(arg1, arg2)
        end,
        useCallback = function(arg1, tbl5)
            var8 = "useCallback"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            checkDepsAreArrayDev(tbl5)
            return mountCallback(arg1, tbl5)
        end,
        useContext = function(arg1, arg2)
            var8 = "useContext"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return readContext(arg1, arg2)
        end,
        useEffect = function(create: (...any) -> (...any), deps)
            var8 = "useEffect"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            checkDepsAreArrayDev(deps)
            return mountEffect(create, deps)
        end,
        useImperativeHandle = function(arg1, func1: (...any) -> (...any), tbl5)
            var8 = "useImperativeHandle"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            checkDepsAreArrayDev(tbl5)
            return mountImperativeHandle(arg1, func1, tbl5)
        end,
        useLayoutEffect = function(create: (...any) -> (...any), deps)
            var8 = "useLayoutEffect"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            checkDepsAreArrayDev(deps)
            return mountLayoutEffect(create, deps)
        end,
        useMemo = function(func1: (...any) -> (...any), tbl5)
            var8 = "useMemo"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            checkDepsAreArrayDev(tbl5)
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14

            if enableAllocationTrims then
                return restoreDispatcherAndReturn(current, pcall(mountMemo, func1, tbl5))
            end

            local tbl6 = { pcall(mountMemo, func1, tbl5) }
            ReactCurrentDispatcher.current = current
            if not tbl6[1] then
                error(tbl6[2])
            end

            return unpack(tbl6, 2)
        end,
        useReducer = function(func1: (...any) -> (...any), arg1, func2: ((...any) -> (...any))?)
            var8 = "useReducer"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14
            local success, result, result2 = pcall(mountReducer, func1, arg1, func2)

            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useRef = function(arg1)
            var8 = "useRef"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountRef(arg1)
        end,
        useBinding = function(arg1)
            var8 = "useBinding"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountBinding(arg1)
        end,
        useState = function(arg1)
            var8 = "useState"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14

            local success, result, result2 = pcall(mountState, arg1)
            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useDebugValue = function(arg1, func1: ((...any) -> (...any))?)
            var8 = "useDebugValue"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountDebugValue(arg1, func1)
        end,
        useMutableSource = function(arg1, arg2, arg3)
            var8 = "useMutableSource"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountMutableSource(arg1, arg2, arg3)
        end,
        useOpaqueIdentifier = function()
            var8 = "useOpaqueIdentifier"

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountOpaqueIdentifier()
        end,
        unstable_isNewReconciler = enableNewReconciler
    }

    var11 = {
        readContext = function(arg1, arg2)
            return readContext(arg1, arg2)
        end,
        useCallback = function(arg1, tbl5)
            var8 = "useCallback"
            updateHookTypesDev()
            checkDepsAreArrayDev(tbl5)
            return mountCallback(arg1, tbl5)
        end,
        useContext = function(arg1, arg2)
            var8 = "useContext"
            updateHookTypesDev()
            return readContext(arg1, arg2)
        end,
        useEffect = function(create: (...any) -> (...any), deps)
            var8 = "useEffect"
            updateHookTypesDev()
            return mountEffect(create, deps)
        end,
        useImperativeHandle = function(arg1, func1: (...any) -> (...any), tbl5)
            var8 = "useImperativeHandle"
            updateHookTypesDev()
            return mountImperativeHandle(arg1, func1, tbl5)
        end,
        useLayoutEffect = function(create: (...any) -> (...any), deps)
            var8 = "useLayoutEffect"
            updateHookTypesDev()
            return mountLayoutEffect(create, deps)
        end,
        useMemo = function(func1: (...any) -> (...any), tbl5)
            var8 = "useMemo"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14

            if enableAllocationTrims then
                return restoreDispatcherAndReturn(current, pcall(mountMemo, func1, tbl5))
            end

            local tbl6 = { pcall(mountMemo, func1, tbl5) }
            ReactCurrentDispatcher.current = current
            if not tbl6[1] then
                error(tbl6[2])
            end
            return unpack(tbl6, 2)
        end,
        useReducer = function(func1: (...any) -> (...any), arg1, func2: ((...any) -> (...any))?)
            var8 = "useReducer"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14
            local success, result, result2 = pcall(mountReducer, func1, arg1, func2)

            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useRef = function(arg1)
            var8 = "useRef"
            updateHookTypesDev()
            return mountRef(arg1)
        end,
        useBinding = function(arg1)
            var8 = "useBinding"
            updateHookTypesDev()
            return mountBinding(arg1)
        end,
        useState = function(arg1)
            var8 = "useState"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14

            local success, result, result2 = pcall(mountState, arg1)
            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useDebugValue = function(arg1, func1: ((...any) -> (...any))?)
            var8 = "useDebugValue"
            updateHookTypesDev()
            return mountDebugValue(arg1, func1)
        end,
        useMutableSource = function(arg1, arg2, arg3)
            var8 = "useMutableSource"
            updateHookTypesDev()
            return mountMutableSource(arg1, arg2, arg3)
        end,
        useOpaqueIdentifier = function()
            var8 = "useOpaqueIdentifier"
            updateHookTypesDev()
            return mountOpaqueIdentifier()
        end,
        unstable_isNewReconciler = enableNewReconciler
    }

    var12 = {
        readContext = function(arg1, arg2)
            return readContext(arg1, arg2)
        end,
        useCallback = function(arg1, tbl5)
            var8 = "useCallback"
            updateHookTypesDev()
            return updateCallback(arg1, tbl5)
        end,
        useContext = function(arg1, arg2)
            var8 = "useContext"
            updateHookTypesDev()
            return readContext(arg1, arg2)
        end,
        useEffect = function(func1: (...any) -> (...any), tbl5)
            var8 = "useEffect"
            updateHookTypesDev()
            return updateEffect(func1, tbl5)
        end,
        useImperativeHandle = function(arg1, func1: (...any) -> (...any), tbl5)
            var8 = "useImperativeHandle"
            updateHookTypesDev()
            return updateImperativeHandle(arg1, func1, tbl5)
        end,
        useLayoutEffect = function(func1: (...any) -> (...any), tbl5)
            var8 = "useLayoutEffect"
            updateHookTypesDev()
            return updateLayoutEffect(func1, tbl5)
        end,
        useMemo = function(func1: (...any) -> (...any), tbl5)
            var8 = "useMemo"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15

            if enableAllocationTrims then
                return restoreDispatcherAndReturn(current, pcall(updateMemo, func1, tbl5))
            end

            local tbl6 = { pcall(updateMemo, func1, tbl5) }
            ReactCurrentDispatcher.current = current
            if not tbl6[1] then
                error(tbl6[2])
            end
            return unpack(tbl6, 2)
        end,
        useReducer = function(func1: (...any) -> (...any), arg1, func2: ((...any) -> (...any))?)
            var8 = "useReducer"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15
            local success, result, result2 = pcall(updateReducer, func1, arg1, func2)

            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useRef = function(arg1)
            var8 = "useRef"
            updateHookTypesDev()
            return updateRef(arg1)
        end,
        useBinding = function(arg1)
            var8 = "useBinding"
            updateHookTypesDev()
            return updateBinding(arg1)
        end,
        useState = function(arg1)
            var8 = "useState"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15

            local success, result, result2 = pcall(updateState, arg1)
            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useDebugValue = function(arg1, func1: ((...any) -> (...any))?)
            var8 = "useDebugValue"
            updateHookTypesDev()
            return mountDebugValue2(arg1, func1)
        end,
        useMutableSource = function(arg1, arg2, arg3)
            var8 = "useMutableSource"
            updateHookTypesDev()
            return updateMutableSource(arg1, arg2, arg3)
        end,
        useOpaqueIdentifier = function()
            var8 = "useOpaqueIdentifier"
            updateHookTypesDev()
            return updateOpaqueIdentifier()
        end,
        unstable_isNewReconciler = enableNewReconciler
    }

    var13 = {
        readContext = function(arg1, arg2)
            return readContext(arg1, arg2)
        end,
        useCallback = function(arg1, tbl5)
            var8 = "useCallback"
            updateHookTypesDev()
            return updateCallback(arg1, tbl5)
        end,
        useContext = function(arg1, arg2)
            var8 = "useContext"
            updateHookTypesDev()
            return readContext(arg1, arg2)
        end,
        useEffect = function(func1: (...any) -> (...any), tbl5)
            var8 = "useEffect"
            updateHookTypesDev()
            return updateEffect(func1, tbl5)
        end,
        useImperativeHandle = function(arg1, func1: (...any) -> (...any), tbl5)
            var8 = "useImperativeHandle"
            updateHookTypesDev()
            return updateImperativeHandle(arg1, func1, tbl5)
        end,
        useLayoutEffect = function(func1: (...any) -> (...any), tbl5)
            var8 = "useLayoutEffect"
            updateHookTypesDev()
            return updateLayoutEffect(func1, tbl5)
        end,
        useMemo = function(func1: (...any) -> (...any), tbl5)
            var8 = "useMemo"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var16

            if enableAllocationTrims then
                return restoreDispatcherAndReturn(current, pcall(updateMemo, func1, tbl5))
            end

            local tbl6 = { pcall(updateMemo, func1, tbl5) }
            ReactCurrentDispatcher.current = current
            if not tbl6[1] then
                error(tbl6[2])
            end
            return unpack(tbl6, 2)
        end,
        useReducer = function(func1: (...any) -> (...any), arg1, func2: ((...any) -> (...any))?)
            var8 = "useReducer"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var16

            local success, result, result2 = pcall(rerenderReducer, func1, arg1, func2)

            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useRef = function(arg1)
            var8 = "useRef"
            updateHookTypesDev()
            return updateRef(arg1)
        end,
        useBinding = function(arg1)
            var8 = "useBinding"
            updateHookTypesDev()
            return updateBinding(arg1)
        end,
        useState = function(arg1)
            var8 = "useState"
            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var16

            local success, result, result2 = pcall(rerenderState, arg1)
            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useDebugValue = function(arg1, func1: ((...any) -> (...any))?)
            var8 = "useDebugValue"
            updateHookTypesDev()
            return mountDebugValue2(arg1, func1)
        end,
        useMutableSource = function(arg1, arg2, arg3)
            var8 = "useMutableSource"
            updateHookTypesDev()
            return updateMutableSource(arg1, arg2, arg3)
        end,
        useOpaqueIdentifier = function()
            var8 = "useOpaqueIdentifier"
            updateHookTypesDev()
            return rerenderOpaqueIdentifier()
        end,
        unstable_isNewReconciler = enableNewReconciler
    }

    var14 = {
        readContext = function(arg1, arg2)
            console.error(
                "Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()."
            )

            return readContext(arg1, arg2)
        end,
        useCallback = function(arg1, tbl5)
            var8 = "useCallback"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountCallback(arg1, tbl5)
        end,
        useContext = function(arg1, arg2)
            var8 = "useContext"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return readContext(arg1, arg2)
        end,
        useEffect = function(create: (...any) -> (...any), deps)
            var8 = "useEffect"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountEffect(create, deps)
        end,
        useImperativeHandle = function(arg1, func1: (...any) -> (...any), tbl5)
            var8 = "useImperativeHandle"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountImperativeHandle(arg1, func1, tbl5)
        end,
        useLayoutEffect = function(create: (...any) -> (...any), deps)
            var8 = "useLayoutEffect"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountLayoutEffect(create, deps)
        end,
        useMemo = function(func1: (...any) -> (...any), tbl5)
            var8 = "useMemo"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14

            if enableAllocationTrims then
                return restoreDispatcherAndReturn(current, pcall(mountMemo, func1, tbl5))
            end

            local tbl6 = { pcall(mountMemo, func1, tbl5) }
            ReactCurrentDispatcher.current = current
            if not tbl6[1] then
                error(tbl6[2])
            end
            return unpack(tbl6, 2)
        end,
        useReducer = function(func1: (...any) -> (...any), arg1, func2: ((...any) -> (...any))?)
            var8 = "useReducer"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14
            local success, result, result2 = pcall(mountReducer, func1, arg1, func2)

            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useRef = function(arg1)
            var8 = "useRef"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountRef(arg1)
        end,
        useBinding = function(arg1)
            var8 = "useBinding"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountBinding(arg1)
        end,
        useState = function(arg1)
            var8 = "useState"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var14

            local success, result, result2 = pcall(mountState, arg1)
            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useDebugValue = function(arg1, func1: ((...any) -> (...any))?)
            var8 = "useDebugValue"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountDebugValue(arg1, func1)
        end,
        useMutableSource = function(arg1, arg2, arg3)
            var8 = "useMutableSource"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountMutableSource(arg1, arg2, arg3)
        end,
        useOpaqueIdentifier = function()
            var8 = "useOpaqueIdentifier"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            if __DEV__ then
                local str1 = var8

                if var9 == nil then
                    var9 = { str1 }
                else
                    table.insert(var9, str1)
                end
            end

            return mountOpaqueIdentifier()
        end,
        unstable_isNewReconciler = enableNewReconciler
    }

    var15 = {
        readContext = function(arg1, arg2)
            console.error(
                "Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()."
            )

            return readContext(arg1, arg2)
        end,
        useCallback = function(arg1, tbl5)
            var8 = "useCallback"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return mountCallback(arg1, tbl5)
        end,
        useContext = function(arg1, arg2)
            var8 = "useContext"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return readContext(arg1, arg2)
        end,
        useEffect = function(func1: (...any) -> (...any), tbl5)
            var8 = "useEffect"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateEffect(func1, tbl5)
        end,
        useImperativeHandle = function(arg1, func1: (...any) -> (...any), tbl5)
            var8 = "useImperativeHandle"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateImperativeHandle(arg1, func1, tbl5)
        end,
        useLayoutEffect = function(func1: (...any) -> (...any), tbl5)
            var8 = "useLayoutEffect"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateLayoutEffect(func1, tbl5)
        end,
        useMemo = function(func1: (...any) -> (...any), tbl5)
            var8 = "useMemo"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15

            if enableAllocationTrims then
                return restoreDispatcherAndReturn(current, pcall(updateMemo, func1, tbl5))
            end

            local tbl6 = { pcall(updateMemo, func1, tbl5) }
            ReactCurrentDispatcher.current = current
            if not tbl6[1] then
                error(tbl6[2])
            end
            return unpack(tbl6, 2)
        end,
        useReducer = function(func1: (...any) -> (...any), arg1, func2: ((...any) -> (...any))?)
            var8 = "useReducer"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15
            local success, result, result2 = pcall(updateReducer, func1, arg1, func2)

            ReactCurrentDispatcher.current = current

            if not success then
                error(result)
            end

            return result, result2
        end,
        useRef = function(arg1)
            var8 = "useRef"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateRef(arg1)
        end,
        useBinding = function(arg1)
            var8 = "useBinding"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateBinding(arg1)
        end,
        useState = function(arg1)
            var8 = "useState"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15

            local success, result, result2 = pcall(updateState, arg1)
            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useDebugValue = function(arg1, func1: ((...any) -> (...any))?)
            var8 = "useDebugValue"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return mountDebugValue2(arg1, func1)
        end,
        useMutableSource = function(arg1, arg2, arg3)
            var8 = "useMutableSource"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateMutableSource(arg1, arg2, arg3)
        end,
        useOpaqueIdentifier = function()
            var8 = "useOpaqueIdentifier"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateOpaqueIdentifier()
        end,
        unstable_isNewReconciler = enableNewReconciler
    }

    var16 = {
        readContext = function(arg1, arg2)
            console.error(
                "Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()."
            )

            return readContext(arg1, arg2)
        end,
        useCallback = function(arg1, tbl5)
            var8 = "useCallback"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateCallback(arg1, tbl5)
        end,
        useContext = function(arg1, arg2)
            var8 = "useContext"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return readContext(arg1, arg2)
        end,
        useEffect = function(func1: (...any) -> (...any), tbl5)
            var8 = "useEffect"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateEffect(func1, tbl5)
        end,
        useImperativeHandle = function(arg1, func1: (...any) -> (...any), tbl5)
            var8 = "useImperativeHandle"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateImperativeHandle(arg1, func1, tbl5)
        end,
        useLayoutEffect = function(func1: (...any) -> (...any), tbl5)
            var8 = "useLayoutEffect"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateLayoutEffect(func1, tbl5)
        end,
        useMemo = function(func1: (...any) -> (...any), tbl5)
            var8 = "useMemo"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15

            if enableAllocationTrims then
                return restoreDispatcherAndReturn(current, pcall(updateMemo, func1, tbl5))
            end

            local tbl6 = { pcall(updateMemo, func1, tbl5) }
            ReactCurrentDispatcher.current = current
            if not tbl6[1] then
                error(tbl6[2])
            end
            return unpack(tbl6, 2)
        end,
        useReducer = function(func1: (...any) -> (...any), arg1, func2: ((...any) -> (...any))?)
            var8 = "useReducer"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15

            local success, result, result2 = pcall(rerenderReducer, func1, arg1, func2)

            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useRef = function(arg1)
            var8 = "useRef"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateRef(arg1)
        end,
        useBinding = function(arg1)
            var8 = "useBinding"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateBinding(arg1)
        end,
        useState = function(arg1)
            var8 = "useState"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            local current = ReactCurrentDispatcher.current
            ReactCurrentDispatcher.current = var15

            local success, result, result2 = pcall(rerenderState, arg1)
            ReactCurrentDispatcher.current = current
            if not success then
                error(result)
            end

            return result, result2
        end,
        useDebugValue = function(arg1, func1: ((...any) -> (...any))?)
            var8 = "useDebugValue"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return mountDebugValue2(arg1, func1)
        end,
        useMutableSource = function(arg1, arg2, arg3)
            var8 = "useMutableSource"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return updateMutableSource(arg1, arg2, arg3)
        end,
        useOpaqueIdentifier = function()
            var8 = "useOpaqueIdentifier"
            console.error(
                "Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks"
            )

            updateHookTypesDev()
            return rerenderOpaqueIdentifier()
        end,
        unstable_isNewReconciler = enableNewReconciler
    }
end

function module.renderWithHooks(arg1, nil1: nil, func1: (...any) -> (...any), arg2, arg3, arg4)
    var3 = arg4
    var4 = nil1

    if __DEV__ then
        var9 = if arg1 == nil then nil else arg1._debugHookTypes

        num1 = 0
    end

    if ReactFeatureFlags.enableWorkLoopTrims then
        if nil1.memoizedState ~= nil then
            nil1.memoizedState = nil
        end
        if nil1.updateQueue ~= nil then
            nil1.updateQueue = nil
        end
    else
        nil1.memoizedState = nil

        nil1.updateQueue = nil
    end
    nil1.lanes = NoLanes

    if __DEV__ then
        if arg1 ~= nil and arg1.memoizedState ~= nil then
            ReactCurrentDispatcher.current = var12
        elseif var9 ~= nil then
            ReactCurrentDispatcher.current = var11
        else
            ReactCurrentDispatcher.current = var10
        end
    else
        ReactCurrentDispatcher.current = (arg1 == nil or arg1.memoizedState == nil) and tbl2 or tbl3
    end

    local var17 = func1(arg2, arg3)

    if bool2 then
        local num2 = 0

        repeat
            bool2 = false

            if num2 >= 25 then
                error(Error.new("Too many re-renders. React limits the number of renders to prevent an infinite loop."))
            end

            num2 += 1

            var5 = nil
            var6 = nil

            nil1.updateQueue = nil

            if __DEV__ then
                num1 = 0
            end

            ReactCurrentDispatcher.current = __DEV__ and var13 or tbl4

            var17 = func1(arg2, arg3)
        until not bool2
    end

    ReactCurrentDispatcher.current = tbl1

    if __DEV__ then
        nil1._debugHookTypes = var9
    end

    local bool4 = not (var5 == nil) and var5.next ~= nil
    var3 = NoLanes
    var4 = nil

    var5 = nil
    var6 = nil
    if enableHookDoubleBuffering then
        next = nil
        var7 = nil
    end

    if __DEV__ then
        var8 = nil
        var9 = nil
        num1 = 0
    end

    bool1 = false

    if bool4 then
        local str1 = "unknown"
        if var17 and var17.type then
            str1 = getComponentName(var17.type) or str1
        end
        error(
            Error.new(
                "Rendered fewer hooks than expected. This may be caused by an accidental " .. "early return statement. Inside '" .. str1 .. "'"
            )
        )
    end

    return var17
end
return module
