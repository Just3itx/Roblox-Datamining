-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function unimplemented(str1: string)
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: " .. tostring(str1))
    error("FIXME (roblox): " .. str1 .. " is unimplemented", 2)
end

local num1 = 0

local function isCallable(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(arg1) == "function" then
        return true
    end
    if typeof(arg1) == "table" then
        local var1 = getmetatable(arg1)
        if var1 and rawget(var1, "__call") then
            return true
        end
        if arg1._isMockFunction then
            return true
        end
    end
    return false
end

local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Error = LuauPolyfill.Error
local Set = LuauPolyfill.Set

local __DEV__ = ReactGlobals.__DEV__
local __YOLO__ = ReactGlobals.__YOLO__

local ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local _ReactFiberSuspenseComponentNew = require(script.Parent["ReactFiberSuspenseComponent.new"])

local ReactUpdateQueueNew = require(script.Parent["ReactUpdateQueue.new"])

local _Shared = require(scriptParentParent.Shared)

local _ReactFiberOffscreenComponent = require(script.Parent.ReactFiberOffscreenComponent)

local ReactHookEffectTags = require(script.Parent.ReactHookEffectTags)

local unstable_wrap = require(scriptParentParent.Scheduler).tracing.unstable_wrap
local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer
local enableProfilerCommitHooks = ReactFeatureFlags.enableProfilerCommitHooks

local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback

local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects
local enableNewTreeCleanupPath = ReactFeatureFlags.enableNewTreeCleanupPath
local ReactWorkTags = require(script.Parent.ReactWorkTags)
local FunctionComponent = ReactWorkTags.FunctionComponent
local ForwardRef = ReactWorkTags.ForwardRef
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local HostComponent = ReactWorkTags.HostComponent
local HostText = ReactWorkTags.HostText
local HostPortal = ReactWorkTags.HostPortal
local Profiler = ReactWorkTags.Profiler
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local DehydratedFragment = ReactWorkTags.DehydratedFragment
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent
local MemoComponent = ReactWorkTags.MemoComponent
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local ScopeComponent = ReactWorkTags.ScopeComponent
local Block = ReactWorkTags.Block
local OffscreenComponent = ReactWorkTags.OffscreenComponent
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent
local ReactErrorUtils = require(scriptParentParent.Shared).ReactErrorUtils
local invokeGuardedCallback = ReactErrorUtils.invokeGuardedCallback
local hasCaughtError = ReactErrorUtils.hasCaughtError
local clearCaughtError = ReactErrorUtils.clearCaughtError
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local NoFlags = ReactFiberFlags.NoFlags
local ContentReset = ReactFiberFlags.ContentReset
local Placement = ReactFiberFlags.Placement
local Snapshot = ReactFiberFlags.Snapshot
local Update = ReactFiberFlags.Update
local Callback = ReactFiberFlags.Callback
local LayoutMask = ReactFiberFlags.LayoutMask
local PassiveMask = ReactFiberFlags.PassiveMask
local Ref = ReactFiberFlags.Ref
local getComponentName = require(scriptParentParent.Shared).getComponentName
local invariant = require(scriptParentParent.Shared).invariant
local describeError = require(scriptParentParent.Shared).describeError
local ReactCurrentFiber = require(script.Parent.ReactCurrentFiber)

local current = ReactCurrentFiber.current
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber

local onCommitUnmount = require(script.Parent["ReactFiberDevToolsHook.new"]).onCommitUnmount

local resolveDefaultProps = require(script.Parent["ReactFiberLazyComponent.new"]).resolveDefaultProps
local ReactProfilerTimerNew = require(script.Parent["ReactProfilerTimer.new"])
local startLayoutEffectTimer = ReactProfilerTimerNew.startLayoutEffectTimer
local recordPassiveEffectDuration = ReactProfilerTimerNew.recordPassiveEffectDuration
local recordLayoutEffectDuration = ReactProfilerTimerNew.recordLayoutEffectDuration
local startPassiveEffectTimer = ReactProfilerTimerNew.startPassiveEffectTimer
local getCommitTime = ReactProfilerTimerNew.getCommitTime
local ProfileMode = require(script.Parent.ReactTypeOfMode).ProfileMode
local commitUpdateQueue = ReactUpdateQueueNew.commitUpdateQueue
local getPublicInstance = ReactFiberHostConfig.getPublicInstance
local supportsMutation = ReactFiberHostConfig.supportsMutation

local var1 = ReactFeatureFlags.enableSkipHostSiblingLookup and ReactFiberHostConfig.supportsChildOrdering == false
local supportsPersistence = ReactFiberHostConfig.supportsPersistence
local supportsHydration = ReactFiberHostConfig.supportsHydration
local commitMount = ReactFiberHostConfig.commitMount
local commitUpdate = ReactFiberHostConfig.commitUpdate
local resetTextContent = ReactFiberHostConfig.resetTextContent
local commitTextUpdate = ReactFiberHostConfig.commitTextUpdate
local appendChild = ReactFiberHostConfig.appendChild
local appendChildToContainer = ReactFiberHostConfig.appendChildToContainer
local insertBefore = ReactFiberHostConfig.insertBefore
local insertInContainerBefore = ReactFiberHostConfig.insertInContainerBefore
local removeChild = ReactFiberHostConfig.removeChild
local removeChildFromContainer = ReactFiberHostConfig.removeChildFromContainer

local hideInstance = ReactFiberHostConfig.hideInstance
local hideTextInstance = ReactFiberHostConfig.hideTextInstance
local unhideInstance = ReactFiberHostConfig.unhideInstance
local unhideTextInstance = ReactFiberHostConfig.unhideTextInstance

local commitHydratedSuspenseInstance = ReactFiberHostConfig.commitHydratedSuspenseInstance
local clearContainer = ReactFiberHostConfig.clearContainer

local var2 = nil

local function resolveRetryWakeable(arg1, arg2)
    var2 = var2 or require(script.Parent["ReactFiberWorkLoop.new"])

    var2.resolveRetryWakeable(arg1, arg2)
end

local function markCommitTimeOfFallback() -- Luacid: Inlined by compiler; 1 call site recovered
    var2 = var2 or require(script.Parent["ReactFiberWorkLoop.new"])

    var2.markCommitTimeOfFallback()
end

local function schedulePassiveEffectCallback()
    console.warn("ReactFiberCommitWork: schedulePassiveEffectCallback causes a dependency cycle\n" .. debug.traceback())
end

local function captureCommitPhaseError(_, _, arg1)
    console.warn("ReactFiberCommitWork: captureCommitPhaseError causes a dependency cycle")

    error(arg1)
end

local NoFlags2 = ReactHookEffectTags.NoFlags
local HasEffect = ReactHookEffectTags.HasEffect
local Layout = ReactHookEffectTags.Layout
local Passive = ReactHookEffectTags.Passive

local var3 = nil
local function func1()
    var3 = var3 or require(script.Parent["ReactFiberBeginWork.new"]).didWarnAboutReassigningProps

    return var3
end

local isHostParent = nil
local insertOrAppendPlacementNode = nil
local insertOrAppendPlacementNodeIntoContainer = nil
local commitLayoutEffectsForHostRoot = nil
local commitLayoutEffectsForHostComponent = nil
local commitLayoutEffectsForClassComponent = nil
local unmountHostComponents = nil

local var4 = nil

local function callComponentWillUnmountWithTimer(arg1, arg2)
    arg2.props = arg1.memoizedProps
    arg2.state = arg1.memoizedState

    if not enableProfilerTimer or not enableProfilerCommitHooks or bit32.band(arg1.mode, ProfileMode) == 0 then
        arg2:componentWillUnmount()
        return
    end

    local success, result = xpcall(function()
        startLayoutEffectTimer()

        arg2:componentWillUnmount()
    end, describeError)

    recordLayoutEffectDuration(arg1)

    if not success then
        error(result)
    end
end

function safelyCallComponentWillUnmount(arg1, stateNode, arg2)
    local success, result = xpcall(callComponentWillUnmountWithTimer, describeError, arg1, stateNode)

    if not success then
        captureCommitPhaseError(arg1, arg2, result)
    end
end

local function safelyDetachRef(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local ref = arg1.ref
    if ref == nil then
        return
    end

    if typeof(ref) == "function" then
        local success, result = xpcall(ref, describeError)
        if not success then
            captureCommitPhaseError(arg1, arg2, result)
        end
    else
        ref.current = nil
    end
end

local function safelyCallDestroy(arg1, arg2, callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
    local success, result = xpcall(callback, describeError)
    if not success then
        captureCommitPhaseError(arg1, arg2, result)
    end
end

local function commitHookEffectListUnmount(arg1, arg2, arg3)
    local updateQueue = arg2.updateQueue
    local lastEffect = if updateQueue == nil then nil else updateQueue.lastEffect

    if lastEffect == nil then
        return
    end

    local next = lastEffect.next

    repeat
        if bit32.band(next.tag, arg1) == arg1 then
            local destroy = next.destroy
            if not ReactFeatureFlags.enableWorkLoopTrims or destroy ~= nil then
                next.destroy = nil
            end
            if destroy ~= nil then
                safelyCallDestroy(arg2, arg3, destroy)
            end
        end

        next = next.next
    until next == next
end

local function commitHookEffectListMount(arg1, arg2)
    local updateQueue = arg2.updateQueue
    local lastEffect = if updateQueue == nil then nil else updateQueue.lastEffect

    if lastEffect == nil then
        return
    end

    local next = lastEffect.next

    repeat
        if bit32.band(next.tag, arg1) == arg1 then
            local create = next.create
            if ReactFeatureFlags.enableWorkLoopTrims then
                local destroy = create()
                if destroy ~= nil or next.destroy ~= nil then
                    next.destroy = destroy
                end
            else
                next.destroy = create()
            end

            if __DEV__ then
                local destroy = next.destroy
                if destroy ~= nil and typeof(destroy) ~= "function" then
                    local var5 = if destroy == nil then " You returned nil. If your effect does not require clean up, return nil (or nothing)." elseif typeof(destroy.andThen) == "function" then "\n\nIt looks like you wrote useEffect(Promise.new(function() --[[...]] end) or returned a Promise. Instead, write the async function inside your effect and call it immediately:\n\nuseEffect(function()\n  function fetchData()\n    -- You can await here\n    local response = MyAPI.getData(someId):await()\n    -- ...\n  end\n  fetchData()\nend, {someId}) -- Or {} if effect doesn't need props or state\n\nLearn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching" else " You returned: " .. destroy
                    console.error("An effect function must not return anything besides a function, which is used for clean-up.%s", var5)
                end
            end
        end

        next = next.next
    until next == next
end

function commitProfilerPassiveEffect(arg1, arg2)
    if not enableProfilerTimer or not enableProfilerCommitHooks or arg2.tag ~= Profiler then
        return
    end

    local passiveEffectDuration = arg2.stateNode.passiveEffectDuration

    local id = arg2.memoizedProps.id
    local onPostCommit = arg2.memoizedProps.onPostCommit

    local commitTime = getCommitTime()

    if typeof(onPostCommit) ~= "function" then
        return
    end

    if enableSchedulerTracing then
        onPostCommit(
            id,
            if arg2.alternate == nil then "mount" else "update",
            passiveEffectDuration,
            commitTime,
            arg1.memoizedInteractions
        )
        return
    end

    onPostCommit(id, if arg2.alternate == nil then "mount" else "update", passiveEffectDuration, commitTime)
end

local function recursivelyCommitLayoutEffects(arg1, arg2, func2: (...any) -> (...any), func3: (...any) -> (...any))
    if func2 ~= nil then
        captureCommitPhaseError = func2
    end
    if func3 ~= nil then
        schedulePassiveEffectCallback = func3
    end
    local flags = arg1.flags
    local tag = arg1.tag
    if tag == Profiler then
        local var5

        if enableProfilerTimer and enableProfilerCommitHooks then
            var5 = var4
            var4 = arg1
        else
            var5 = nil
        end

        if ReactFeatureFlags.enableCommitTraversalTrims then
            local child = if bit32.band(arg1.subtreeFlags, LayoutMask) == NoFlags then nil else arg1.child

            while child ~= nil do
                if bit32.band(bit32.bor(child.flags, child.subtreeFlags), LayoutMask) ~= NoFlags or child.tag == Profiler then
                    if __DEV__ then
                        local var6 = current
                        setCurrentFiber(child)
                        invokeGuardedCallback(
                            nil,
                            recursivelyCommitLayoutEffects,
                            nil,
                            child,
                            arg2,
                            captureCommitPhaseError,
                            schedulePassiveEffectCallback
                        )
                        if hasCaughtError() then
                            local var7 = clearCaughtError()
                            captureCommitPhaseError(child, arg1, var7)
                        end
                        if var6 ~= nil then
                            setCurrentFiber(var6)
                        else
                            resetCurrentFiber()
                        end
                    else
                        local success, result = xpcall(
                            recursivelyCommitLayoutEffects,
                            describeError,
                            child,
                            arg2,
                            captureCommitPhaseError,
                            schedulePassiveEffectCallback
                        )
                        if not success then
                            captureCommitPhaseError(child, arg1, result)
                        end
                    end
                end
                child = child.sibling
            end
        else
            local child = arg1.child

            while child ~= nil do
                if bit32.band(arg1.subtreeFlags, LayoutMask) ~= NoFlags then
                    if __DEV__ then
                        local var6 = current
                        setCurrentFiber(child)
                        invokeGuardedCallback(
                            nil,
                            recursivelyCommitLayoutEffects,
                            nil,
                            child,
                            arg2,
                            captureCommitPhaseError,
                            schedulePassiveEffectCallback
                        )
                        if hasCaughtError() then
                            local var7 = clearCaughtError()
                            captureCommitPhaseError(child, arg1, var7)
                        end
                        if var6 ~= nil then
                            setCurrentFiber(var6)
                        else
                            resetCurrentFiber()
                        end
                    else
                        local success, result = xpcall(
                            recursivelyCommitLayoutEffects,
                            describeError,
                            child,
                            arg2,
                            captureCommitPhaseError,
                            schedulePassiveEffectCallback
                        )
                        if not success then
                            captureCommitPhaseError(child, arg1, result)
                        end
                    end
                end
                child = child.sibling
            end
        end

        if bit32.band(flags, bit32.bor(Update, Callback)) ~= NoFlags and enableProfilerTimer then
            if __DEV__ then
                local var6 = current
                setCurrentFiber(arg1)
                invokeGuardedCallback(nil, commitLayoutEffectsForProfiler, nil, arg1, arg2)

                if hasCaughtError() then
                    local var7 = clearCaughtError()
                    captureCommitPhaseError(arg1, arg1.return_, var7)
                end

                if var6 ~= nil then
                    setCurrentFiber(var6)
                else
                    resetCurrentFiber()
                end
            else
                local success, result = xpcall(commitLayoutEffectsForProfiler, describeError, arg1, arg2)

                if not success then
                    captureCommitPhaseError(arg1, arg1.return_, result)
                end
            end
        end

        if enableProfilerTimer and enableProfilerCommitHooks then
            if var5 ~= nil then
                local stateNode = var5.stateNode
                stateNode.effectDuration += arg1.stateNode.effectDuration
            end

            var4 = var5
        end
    else
        if ReactFeatureFlags.enableCommitTraversalTrims then
            local child = if bit32.band(arg1.subtreeFlags, LayoutMask) == NoFlags then nil else arg1.child

            while child ~= nil do
                if bit32.band(bit32.bor(child.flags, child.subtreeFlags), LayoutMask) ~= NoFlags or child.tag == Profiler then
                    if __DEV__ then
                        local current2 = ReactCurrentFiber.current
                        setCurrentFiber(child)

                        if num1 < 20 then
                            num1 += 1
                            invokeGuardedCallback(
                                nil,
                                recursivelyCommitLayoutEffects,
                                nil,
                                child,
                                arg2,
                                captureCommitPhaseError,
                                schedulePassiveEffectCallback
                            )
                            num1 -= 1

                            if hasCaughtError() then
                                local var5 = clearCaughtError()
                                captureCommitPhaseError(child, arg1, var5)
                            end
                        else
                            recursivelyCommitLayoutEffects(child, arg2, captureCommitPhaseError, schedulePassiveEffectCallback)
                        end

                        if current2 ~= nil then
                            setCurrentFiber(current2)
                        else
                            resetCurrentFiber()
                        end
                    else
                        local result = nil
                        local success

                        if not __YOLO__ and num1 < 20 then
                            num1 += 1

                            success, result = xpcall(
                                recursivelyCommitLayoutEffects,
                                describeError,
                                child,
                                arg2,
                                captureCommitPhaseError,
                                schedulePassiveEffectCallback
                            )

                            num1 -= 1
                        else
                            recursivelyCommitLayoutEffects(child, arg2, captureCommitPhaseError, schedulePassiveEffectCallback)
                            success = true
                        end

                        if not success then
                            captureCommitPhaseError(child, arg1, result)
                        end
                    end
                end
                child = child.sibling
            end
        else
            local child = arg1.child

            while child ~= nil do
                if bit32.band(arg1.subtreeFlags, LayoutMask) ~= NoFlags then
                    if __DEV__ then
                        local current2 = ReactCurrentFiber.current
                        setCurrentFiber(child)

                        if num1 < 20 then
                            num1 += 1
                            invokeGuardedCallback(
                                nil,
                                recursivelyCommitLayoutEffects,
                                nil,
                                child,
                                arg2,
                                captureCommitPhaseError,
                                schedulePassiveEffectCallback
                            )
                            num1 -= 1

                            if hasCaughtError() then
                                local var5 = clearCaughtError()
                                captureCommitPhaseError(child, arg1, var5)
                            end
                        else
                            recursivelyCommitLayoutEffects(child, arg2, captureCommitPhaseError, schedulePassiveEffectCallback)
                        end

                        if current2 ~= nil then
                            setCurrentFiber(current2)
                        else
                            resetCurrentFiber()
                        end
                    else
                        local result = nil
                        local success

                        if not __YOLO__ and num1 < 20 then
                            num1 += 1

                            success, result = xpcall(
                                recursivelyCommitLayoutEffects,
                                describeError,
                                child,
                                arg2,
                                captureCommitPhaseError,
                                schedulePassiveEffectCallback
                            )

                            num1 -= 1
                        else
                            recursivelyCommitLayoutEffects(child, arg2, captureCommitPhaseError, schedulePassiveEffectCallback)
                            success = true
                        end

                        if not success then
                            captureCommitPhaseError(child, arg1, result)
                        end
                    end
                end
                child = child.sibling
            end
        end

        if bit32.band(flags, bit32.bor(Update, Callback)) ~= NoFlags then
            if tag == FunctionComponent or tag == ForwardRef or tag == SimpleMemoComponent or tag == Block then
                if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(arg1.mode, ProfileMode) ~= 0 then
                    local success, result = xpcall(function()
                        startLayoutEffectTimer()
                        commitHookEffectListMount(bit32.bor(Layout, HasEffect), arg1)
                    end, describeError)

                    recordLayoutEffectDuration(arg1)
                    if not success then
                        error(result)
                    end
                else
                    commitHookEffectListMount(bit32.bor(Layout, HasEffect), arg1)
                end

                if bit32.band(arg1.subtreeFlags, PassiveMask) ~= NoFlags then
                    schedulePassiveEffectCallback()
                end
            elseif tag == ClassComponent then
                commitLayoutEffectsForClassComponent(arg1)
            elseif tag == HostRoot then
                commitLayoutEffectsForHostRoot(arg1)
            elseif tag == HostComponent then
                commitLayoutEffectsForHostComponent(arg1)
            elseif tag == SuspenseComponent then
                commitSuspenseHydrationCallbacks(arg2, arg1)
            elseif tag ~= FundamentalComponent
                and tag ~= HostPortal
                and tag ~= HostText
                and tag ~= IncompleteClassComponent
                and tag ~= LegacyHiddenComponent
                and tag ~= OffscreenComponent
                and tag ~= ScopeComponent
                and tag ~= SuspenseListComponent
            then
                invariant(
                    false,
                    "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
                )
            end
        end

        if bit32.band(flags, Ref) ~= 0 then
            commitAttachRef(arg1)
        end
    end
end

function commitLayoutEffectsForProfiler(arg1, arg2)
    if not enableProfilerTimer then
        return
    end

    local flags = arg1.flags
    local alternate = arg1.alternate

    local onCommit = arg1.memoizedProps.onCommit
    local onRender = arg1.memoizedProps.onRender
    local effectDuration = arg1.stateNode.effectDuration

    local commitTime = getCommitTime()

    local var5 = Callback

    if bit32.band(flags, Update) ~= NoFlags and isCallable(onRender) then
        if enableSchedulerTracing then
            onRender(
                arg1.memoizedProps.id,
                if alternate == nil then "mount" else "update",
                arg1.actualDuration,
                arg1.treeBaseDuration,
                arg1.actualStartTime,
                commitTime,
                arg2.memoizedInteractions
            )
        else
            onRender(
                arg1.memoizedProps.id,
                if alternate == nil then "mount" else "update",
                arg1.actualDuration,
                arg1.treeBaseDuration,
                arg1.actualStartTime,
                commitTime
            )
        end
    end

    if not enableProfilerCommitHooks or bit32.band(flags, var5) == NoFlags or not isCallable(onCommit) then
        return
    end

    if enableSchedulerTracing then
        onCommit(
            arg1.memoizedProps.id,
            if alternate == nil then "mount" else "update",
            effectDuration,
            commitTime,
            arg2.memoizedInteractions
        )
        return
    end

    onCommit(arg1.memoizedProps.id, if alternate == nil then "mount" else "update", effectDuration, commitTime)
end

commitLayoutEffectsForClassComponent = function(arg1)
    local stateNode = arg1.stateNode
    local alternate = arg1.alternate
    if bit32.band(arg1.flags, Update) ~= 0 then
        if alternate == nil then
            if __DEV__ and arg1.type == arg1.elementType and not func1 then
                if stateNode.props ~= arg1.memoizedProps then
                    console.error(
                        "Expected %s props to match memoized props before componentDidMount. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.",
                        getComponentName(arg1.type) or "instance"
                    )
                end
                if stateNode.state ~= arg1.memoizedState then
                    console.error(
                        "Expected %s state to match memoized state before componentDidMount. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.",
                        getComponentName(arg1.type) or "instance"
                    )
                end
            end

            if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(arg1.mode, ProfileMode) ~= 0 then
                local success, result = xpcall(function()
                    startLayoutEffectTimer()

                    stateNode:componentDidMount()
                end, describeError)

                recordLayoutEffectDuration(arg1)
                if not success then
                    error(result)
                end
            else
                stateNode:componentDidMount()
            end
        else
            local var5 = arg1.elementType == arg1.type and alternate.memoizedProps or resolveDefaultProps(arg1.type, alternate.memoizedProps)
            local memoizedState = alternate.memoizedState

            if __DEV__ and arg1.type == arg1.elementType and not func1 then
                if stateNode.props ~= arg1.memoizedProps then
                    console.error(
                        "Expected %s props to match memoized props before componentDidUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.",
                        getComponentName(arg1.type) or "instance"
                    )
                end
                if stateNode.state ~= arg1.memoizedState then
                    console.error(
                        "Expected %s state to match memoized state before componentDidUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.",
                        getComponentName(arg1.type) or "instance"
                    )
                end
            end

            if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(arg1.mode, ProfileMode) ~= 0 then
                local success, result = xpcall(function()
                    startLayoutEffectTimer()

                    stateNode:componentDidUpdate(var5, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate)
                end, describeError)

                recordLayoutEffectDuration(arg1)
                if not success then
                    error(result)
                end
            else
                stateNode:componentDidUpdate(var5, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate)
            end
        end
    end

    local updateQueue = arg1.updateQueue
    if updateQueue == nil then
        return
    end

    if __DEV__ and arg1.type == arg1.elementType and not func1 then
        if stateNode.props ~= arg1.memoizedProps then
            console.error(
                "Expected %s props to match memoized props before processing the update queue. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.",
                getComponentName(arg1.type) or "instance"
            )
        end
        if stateNode.state ~= arg1.memoizedState then
            console.error(
                "Expected %s state to match memoized state before processing the update queue. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.",
                getComponentName(arg1.type) or "instance"
            )
        end
    end

    commitUpdateQueue(arg1, updateQueue, stateNode)
end

commitLayoutEffectsForHostRoot = function(arg1)
    local updateQueue = arg1.updateQueue
    if updateQueue == nil then
        return
    end

    local var5 = nil
    if arg1.child ~= nil then
        local child = arg1.child
        if child.tag == HostComponent then
            var5 = getPublicInstance(child.stateNode)
        elseif child.tag == ClassComponent then
            var5 = child.stateNode
        end
    end
    commitUpdateQueue(arg1, updateQueue, var5)
end

commitLayoutEffectsForHostComponent = function(arg1)
    local stateNode = arg1.stateNode
    if arg1.alternate == nil and bit32.band(arg1.flags, Update) ~= 0 then
        local type = arg1.type
        local memoizedProps = arg1.memoizedProps
        commitMount(stateNode, type, memoizedProps, arg1)
    end
end

local function hideOrUnhideAllChildren(arg1, bool1: boolean)
    if not supportsMutation then
        return
    end

    local var5 = arg1

    while true do
        if arg1.tag == HostComponent then
            local stateNode = arg1.stateNode
            if bool1 then
                hideInstance(stateNode)
            else
                unhideInstance(arg1.stateNode, arg1.memoizedProps)
            end
        elseif arg1.tag == HostText then
            local stateNode = arg1.stateNode
            if bool1 then
                hideTextInstance(stateNode)
            else
                unhideTextInstance(stateNode, arg1.memoizedProps)
            end
        elseif (arg1.tag ~= OffscreenComponent and arg1.tag ~= LegacyHiddenComponent or arg1.memoizedState == nil or arg1 == var5)
            and arg1.child ~= nil
        then
            arg1.child.return_ = arg1
            arg1 = arg1.child
            continue
        end

        if arg1 == var5 then
            return
        end
        while arg1.sibling == nil do
            if arg1.return_ == nil or arg1.return_ == var5 then
                return
            end
            arg1 = arg1.return_
        end

        arg1.sibling.return_ = arg1.return_

        arg1 = arg1.sibling
    end
end

function commitAttachRef(arg1)
    local ref = arg1.ref
    if ref == nil then
        return
    end

    local stateNode = arg1.stateNode

    if arg1.tag == HostComponent then
        stateNode = getPublicInstance(stateNode)
    end

    if typeof(ref) == "function" then
        ref(stateNode)
        return
    end
    if __DEV__ and typeof(ref) ~= "table" then
        console.error(
            "Unexpected ref object provided for %s. Use either a ref-setter function or React.createRef().",
            getComponentName(arg1.type) or "instance"
        )
        return
    end

    ref.current = stateNode
end

function commitDetachRef(arg1)
    local ref = arg1.ref
    if ref == nil then
        return
    end

    if typeof(ref) == "function" then
        ref(nil)
        return
    end
    ref.current = nil
end

local function commitUnmount(arg1, arg2, arg3, arg4)
    onCommitUnmount(arg2)

    if arg2.tag ~= FunctionComponent
        and arg2.tag ~= ForwardRef
        and arg2.tag ~= MemoComponent
        and arg2.tag ~= SimpleMemoComponent
        and arg2.tag ~= Block
    then
        if arg2.tag == ClassComponent then
            safelyDetachRef(arg2, arg3)
            local stateNode = arg2.stateNode
            if typeof(stateNode.componentWillUnmount) == "function" then
                safelyCallComponentWillUnmount(arg2, stateNode, arg3)
            end
            return
        elseif arg2.tag == HostComponent then
            safelyDetachRef(arg2, arg3)
            return
        elseif arg2.tag == HostPortal then
            if supportsMutation then
                unmountHostComponents(arg1, arg2, arg3, arg4)
                return
            end

            if supportsPersistence then
                unimplemented("emptyPortalContainer")
            end

            return
        else
            return
        end
    end

    local updateQueue = arg2.updateQueue
    if updateQueue == nil then
        return
    end

    local lastEffect = updateQueue.lastEffect
    if lastEffect == nil then
        return
    end

    local next = lastEffect.next

    repeat
        if next.destroy ~= nil and bit32.band(next.tag, Layout) ~= NoFlags2 then
            if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(arg2.mode, ProfileMode) ~= 0 then
                startLayoutEffectTimer()

                safelyCallDestroy(arg2, arg3, next.destroy)

                recordLayoutEffectDuration(arg2)
            else
                safelyCallDestroy(arg2, arg3, next.destroy)
            end
        end

        next = next.next
    until next == next
end

local function commitNestedUnmounts(arg1, arg2, arg3, arg4)
    local var5 = arg2

    while true do
        commitUnmount(arg1, arg2, arg3, arg4)

        if arg2.child == nil or supportsMutation and arg2.tag == HostPortal then
            if arg2 == var5 then
                return
            end
            while arg2.sibling == nil do
                if arg2.return_ == nil or arg2.return_ == var5 then
                    return
                end
                arg2 = arg2.return_
            end
            arg2.sibling.return_ = arg2.return_
            arg2 = arg2.sibling
            continue
        end

        arg2.child.return_ = arg2
        arg2 = arg2.child
    end
end

local function detachFiberMutation(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local alternate = arg1.alternate
    if alternate ~= nil then
        alternate.return_ = nil
        if not enableNewTreeCleanupPath then
            arg1.alternate = nil
        end
    end
    arg1.return_ = nil
end

local function getHostParentFiber(arg1)
    local _return = arg1.return_
    while _return ~= nil do
        if isHostParent(_return) then
            return _return
        end
        _return = _return.return_
    end

    error(Error.new("Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue."))
end

isHostParent = function(arg1): boolean
    return arg1.tag == HostComponent or arg1.tag == HostRoot or arg1.tag == HostPortal
end

local function getHostSibling(arg1)
    repeat
        local bool1 = false

        while arg1.sibling == nil do
            if arg1.return_ == nil or isHostParent(arg1.return_) then
                return nil
            end
            arg1 = arg1.return_
        end
        arg1.sibling.return_ = arg1.return_
        arg1 = arg1.sibling

        while arg1.tag ~= HostComponent and arg1.tag ~= HostText and arg1.tag ~= DehydratedFragment do
            if bit32.band(arg1.flags, Placement) ~= 0 or arg1.child == nil or arg1.tag == HostPortal then
                bool1 = true
                break
            end

            arg1.child.return_ = arg1
            arg1 = arg1.child
        end
    until not bool1 and bit32.band(arg1.flags, Placement) == 0

    return arg1.stateNode
end

local function commitPlacement(arg1)
    if not supportsMutation then
        return
    end

    local hostParentFiber = getHostParentFiber(arg1)

    local containerInfo = nil
    local var5 = nil
    local stateNode = hostParentFiber.stateNode
    if hostParentFiber.tag == HostComponent then
        containerInfo = stateNode
        var5 = false
    elseif hostParentFiber.tag == HostRoot or hostParentFiber.tag == HostPortal then
        containerInfo = stateNode.containerInfo
        var5 = true
    else
        invariant(false, "Invalid host parent fiber. This error is likely caused by a bug in React. Please file an issue.")
    end

    if bit32.band(hostParentFiber.flags, ContentReset) ~= 0 then
        resetTextContent(containerInfo)

        hostParentFiber.flags = bit32.band(hostParentFiber.flags, bit32.bnot(ContentReset))
    end

    local hostSibling = if var1 then nil else getHostSibling(arg1)

    if var5 then
        insertOrAppendPlacementNodeIntoContainer(arg1, hostSibling, containerInfo)
        return
    end
    insertOrAppendPlacementNode(arg1, hostSibling, containerInfo)
end

insertOrAppendPlacementNodeIntoContainer = function(arg1, arg2, arg3)
    local tag = arg1.tag
    if tag == HostComponent or tag == HostText then
        local stateNode = arg1.stateNode
        if arg2 then
            insertInContainerBefore(arg3, stateNode, arg2)
            return
        end
        appendChildToContainer(arg3, stateNode)
        return
    end
    if tag == HostPortal then
        return
    end

    local child = arg1.child
    if child == nil then
        return
    end

    insertOrAppendPlacementNodeIntoContainer(child, arg2, arg3)
    local sibling = child.sibling
    while sibling ~= nil do
        insertOrAppendPlacementNodeIntoContainer(sibling, arg2, arg3)
        sibling = sibling.sibling
    end
end

insertOrAppendPlacementNode = function(arg1, arg2, arg3)
    local tag = arg1.tag
    if tag == HostComponent or tag == HostText then
        local stateNode = arg1.stateNode
        if arg2 then
            insertBefore(arg3, stateNode, arg2)
            return
        end
        appendChild(arg3, stateNode)
        return
    end
    if tag == HostPortal then
        return
    end

    local child = arg1.child
    if child == nil then
        return
    end

    insertOrAppendPlacementNode(child, arg2, arg3)
    local sibling = child.sibling
    while sibling ~= nil do
        insertOrAppendPlacementNode(sibling, arg2, arg3)
        sibling = sibling.sibling
    end
end

unmountHostComponents = function(arg1, arg2, arg3, arg4)
    local var5 = arg2
    local bool1 = false
    local bool2 = nil
    local var6 = nil
    local num2 = 18
    local _return

    while true do
        if num2 < 10 then
            if num2 < 5 then
                if num2 < 3 then
                    if num2 < 2 then
                        _return = arg2.return_
                        num2 = 10
                    elseif arg2.tag == HostComponent or arg2.tag == HostText then
                        num2 = 11
                    else
                        num2 = 12
                    end
                elseif num2 < 4 then
                    bool2 = false
                    num2 = 5
                elseif _return.tag == HostRoot then
                    num2 = 6
                else
                    num2 = 7
                end
            elseif num2 < 7 then
                if num2 < 6 then
                    bool1 = true
                    num2 = 2
                else
                    var6 = var6.containerInfo
                    bool2 = true
                    num2 = 5
                end
            elseif num2 < 8 then
                if _return.tag == HostPortal then
                    num2 = 8
                else
                    num2 = 9
                end
            elseif num2 < 9 then
                var6 = var6.containerInfo
                bool2 = true
                num2 = 5
            else
                _return = _return.return_
                num2 = 10
            end
        elseif num2 < 14 then
            if num2 < 12 then
                if num2 < 11 then
                    if _return == nil then
                        error(Error.new("Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue."))
                    end

                    var6 = _return.stateNode
                    if _return.tag == HostComponent then
                        num2 = 3
                    else
                        num2 = 4
                    end
                else
                    commitNestedUnmounts(arg1, arg2, arg3, arg4)

                    if bool2 then
                        removeChildFromContainer(var6, arg2.stateNode)
                    else
                        removeChild(var6, arg2.stateNode)
                    end

                    num2 = 13
                end
            elseif num2 < 13 then
                if arg2.tag == HostPortal then
                    num2 = 14
                else
                    num2 = 15
                end
            else
                if arg2 == var5 then
                    return
                end
                while arg2.sibling == nil do
                    if arg2.return_ == nil or arg2.return_ == var5 then
                        return
                    end

                    arg2 = arg2.return_
                    if arg2.tag == HostPortal then
                        bool1 = false
                    end
                end

                arg2.sibling.return_ = arg2.return_
                arg2 = arg2.sibling
                num2 = 18
            end
        elseif num2 < 16 then
            if num2 < 15 then
                if arg2.child == nil then
                    num2 = 13
                else
                    num2 = 16
                end
            else
                commitUnmount(arg1, arg2, arg3, arg4)

                if arg2.child == nil then
                    num2 = 13
                else
                    num2 = 17
                end
            end
        elseif num2 < 17 then
            var6 = arg2.stateNode.containerInfo

            arg2.child.return_ = arg2
            arg2 = arg2.child
            bool2 = true
            num2 = 18
        elseif num2 < 18 then
            arg2.child.return_ = arg2
            arg2 = arg2.child
            num2 = 18
        elseif bool1 then
            num2 = 2
        else
            num2 = 1
        end
    end
end

local function commitDeletion(arg1, arg2, arg3, arg4)
    unmountHostComponents(arg1, arg2, arg3, arg4)
    local alternate = if enableNewTreeCleanupPath then nil else arg2.alternate
    detachFiberMutation(arg2)

    if not enableNewTreeCleanupPath and alternate ~= nil then
        detachFiberMutation(alternate)
    end
end

function commitSuspenseComponent(arg1)
    local memoizedState = arg1.memoizedState

    if memoizedState ~= nil then
        markCommitTimeOfFallback()

        if supportsMutation then
            local child = arg1.child
            hideOrUnhideAllChildren(child, true)
        end
    end

    if not enableSuspenseCallback or memoizedState == nil then
        return
    end

    local suspenseCallback = arg1.memoizedProps.suspenseCallback
    if typeof(suspenseCallback) == "function" then
        local updateQueue = arg1.updateQueue
        if updateQueue ~= nil then
            suspenseCallback(table.clone(updateQueue))
        end
    elseif __DEV__ and suspenseCallback ~= nil then
        console.error("Unexpected type for suspenseCallback: %s", tostring(suspenseCallback))
    end
end

function commitSuspenseHydrationCallbacks(arg1, arg2)
    if not supportsHydration then
        return
    end
    if arg2.memoizedState ~= nil then
        return
    end

    local alternate = arg2.alternate
    if alternate == nil then
        return
    end

    local memoizedState = alternate.memoizedState
    if memoizedState == nil then
        return
    end

    local dehydrated = memoizedState.dehydrated
    if dehydrated == nil then
        return
    end

    commitHydratedSuspenseInstance(dehydrated)
    if not enableSuspenseCallback then
        return
    end

    local hydrationCallbacks = arg1.hydrationCallbacks
    if hydrationCallbacks == nil then
        return
    end

    local onHydrated = hydrationCallbacks.onHydrated
    if onHydrated then
        onHydrated(dehydrated)
    end
end

function attachSuspenseRetryListeners(arg1)
    local updateQueue = arg1.updateQueue
    if updateQueue == nil then
        return
    end

    arg1.updateQueue = nil
    local stateNode = arg1.stateNode
    if stateNode == nil then
        arg1.stateNode = Set.new()
        stateNode = arg1.stateNode
    end
    for value, _ in updateQueue do
        local function func2()
            return resolveRetryWakeable(arg1, value)
        end

        if stateNode:has(value) then
            continue
        end

        if enableSchedulerTracing and value.__reactDoNotTraceInteractions ~= true then
            func2 = unstable_wrap(func2)
        end

        stateNode:add(value)
        value:andThen(function()
            return func2()
        end, function()
            return func2()
        end)
    end
end

function isSuspenseBoundaryBeingHidden(arg1, arg2)
    if arg1 ~= nil then
        local memoizedState = arg1.memoizedState
        if memoizedState == nil or memoizedState.dehydrated ~= nil then
            local memoizedState2 = arg2.memoizedState
            return not (memoizedState2 == nil) and memoizedState2.dehydrated == nil
        end
    end
    return false
end

function commitResetTextContent(arg1)
    if not supportsMutation then
        return
    end
    resetTextContent(arg1.stateNode)
end

function invokeLayoutEffectMountInDEV(arg1)
    if __DEV__ and enableDoubleInvokingEffects then
        if arg1.tag == FunctionComponent or arg1.tag == ForwardRef or arg1.tag == SimpleMemoComponent or arg1.tag == Block then
            invokeGuardedCallback(nil, commitHookEffectListMount, nil, bit32.bor(Layout, HasEffect), arg1)

            if hasCaughtError() then
                local var5 = clearCaughtError()
                captureCommitPhaseError(arg1, arg1.return_, var5)
            end
        end
    elseif arg1.tag == ClassComponent then
        local stateNode = arg1.stateNode
        invokeGuardedCallback(nil, stateNode.componentDidMount, stateNode)
        if hasCaughtError() then
            local var5 = clearCaughtError()
            captureCommitPhaseError(arg1, arg1.return_, var5)
        end
    end
end

function invokePassiveEffectMountInDEV(arg1)
    if not __DEV__
        or not enableDoubleInvokingEffects
        or arg1.tag ~= FunctionComponent and arg1.tag ~= ForwardRef and arg1.tag ~= SimpleMemoComponent and arg1.tag ~= Block
    then
        return
    end

    invokeGuardedCallback(nil, commitHookEffectListMount, nil, bit32.bor(Passive, HasEffect), arg1)

    if hasCaughtError() then
        local var5 = clearCaughtError()
        captureCommitPhaseError(arg1, arg1.return_, var5)
    end
end

function invokeLayoutEffectUnmountInDEV(arg1)
    if __DEV__ and enableDoubleInvokingEffects then
        if arg1.tag == FunctionComponent or arg1.tag == ForwardRef or arg1.tag == SimpleMemoComponent or arg1.tag == Block then
            invokeGuardedCallback(nil, commitHookEffectListUnmount, nil, bit32.bor(Layout, HasEffect), arg1, arg1.return_)

            if hasCaughtError() then
                local var5 = clearCaughtError()
                captureCommitPhaseError(arg1, arg1.return_, var5)
            end
        end
    elseif arg1.tag == ClassComponent then
        local stateNode = arg1.stateNode
        if typeof(stateNode.componentWillUnmount) == "function" then
            safelyCallComponentWillUnmount(arg1, stateNode, arg1.return_)
        end
    end
end

function invokePassiveEffectUnmountInDEV(arg1)
    if not __DEV__
        or not enableDoubleInvokingEffects
        or arg1.tag ~= FunctionComponent and arg1.tag ~= ForwardRef and arg1.tag ~= SimpleMemoComponent and arg1.tag ~= Block
    then
        return
    end

    invokeGuardedCallback(nil, commitHookEffectListUnmount, nil, bit32.bor(Passive, HasEffect), arg1, arg1.return_)

    if hasCaughtError() then
        local var5 = clearCaughtError()
        captureCommitPhaseError(arg1, arg1.return_, var5)
    end
end

return {
    safelyCallDestroy = safelyCallDestroy,
    commitBeforeMutationLifeCycles = function(arg1, arg2)
        if arg2.tag == FunctionComponent or arg2.tag == ForwardRef or arg2.tag == SimpleMemoComponent or arg2.tag == Block then
            return
        end

        if arg2.tag ~= ClassComponent then
            if arg2.tag == HostRoot then
                if supportsMutation and bit32.band(arg2.flags, Snapshot) ~= 0 then
                    local stateNode = arg2.stateNode
                    clearContainer(stateNode.containerInfo)
                end
            elseif arg2.tag ~= HostComponent and arg2.tag ~= HostText and arg2.tag ~= HostPortal and arg2.tag ~= IncompleteClassComponent then
                invariant(
                    false,
                    "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
                )
            end

            return
        end

        if bit32.band(arg2.flags, Snapshot) == 0 or arg1 == nil then
            return
        end

        local memoizedProps = arg1.memoizedProps
        local memoizedState = arg1.memoizedState
        local stateNode = arg2.stateNode

        if __DEV__ and arg2.type == arg2.elementType and not func1 then
            if stateNode.props ~= arg2.memoizedProps then
                console.error(
                    "Expected %s props to match memoized props before getSnapshotBeforeUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.",
                    getComponentName(arg2.type) or "instance"
                )
            end
            if stateNode.state ~= arg2.memoizedState then
                console.error(
                    "Expected %s state to match memoized state before getSnapshotBeforeUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.",
                    getComponentName(arg2.type) or "instance"
                )
            end
        end

        stateNode.__reactInternalSnapshotBeforeUpdate = stateNode:getSnapshotBeforeUpdate(
            arg2.elementType == arg2.type and memoizedProps or resolveDefaultProps(arg2.type, memoizedProps),
            memoizedState
        )
    end,
    commitResetTextContent = commitResetTextContent,
    commitPlacement = commitPlacement,
    commitDeletion = commitDeletion,
    commitWork = function(arg1, arg2)
        if arg2.tag == FunctionComponent
            or arg2.tag == ForwardRef
            or arg2.tag == MemoComponent
            or arg2.tag == SimpleMemoComponent
            or arg2.tag == Block
        then
            if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(arg2.mode, ProfileMode) ~= 0 then
                local success, result = xpcall(function()
                    startLayoutEffectTimer()
                    commitHookEffectListUnmount(bit32.bor(Layout, HasEffect), arg2, arg2.return_)
                end, describeError)

                recordLayoutEffectDuration(arg2)
                if not success then
                    error(result)
                end
            else
                commitHookEffectListUnmount(bit32.bor(Layout, HasEffect), arg2, arg2.return_)
            end

            return
        end

        if arg2.tag == ClassComponent then
            return
        end
        if arg2.tag == HostComponent then
            local stateNode = arg2.stateNode
            if stateNode ~= nil then
                local memoizedProps = arg2.memoizedProps
                local var5 = if arg1 then arg1.memoizedProps else memoizedProps
                local type = arg2.type

                local updateQueue = arg2.updateQueue
                arg2.updateQueue = nil
                if updateQueue ~= nil then
                    commitUpdate(stateNode, updateQueue, type, var5, memoizedProps, arg2)
                end
            end

            return
        end

        if arg2.tag == HostText then
            invariant(
                arg2.stateNode ~= nil,
                "This should have a text node initialized. This error is likely caused by a bug in React. Please file an issue."
            )

            local stateNode = arg2.stateNode
            local memoizedProps = arg2.memoizedProps
            local var5

            if arg1 == nil then
                var5 = nil
            else
                local _memoizedProps = arg1.memoizedProps
                var5 = memoizedProps
            end

            commitTextUpdate(stateNode, var5, memoizedProps)
            return
        end
        if arg2.tag == HostRoot then
            if supportsHydration then
                local stateNode = arg2.stateNode
                if stateNode.hydrate then
                    stateNode.hydrate = false
                    unimplemented("commitWork: HostRoot: commitHydratedContainer")
                end
            end

            return
        end

        if arg2.tag == Profiler then
            return
        end
        if arg2.tag == SuspenseComponent then
            commitSuspenseComponent(arg2)
            attachSuspenseRetryListeners(arg2)
            return
        end
        if arg2.tag == SuspenseListComponent then
            unimplemented("commitWork: SuspenseListComponent")
        else
            if arg2.tag == IncompleteClassComponent then
                return
            end

            if arg2.tag == OffscreenComponent or arg2.tag == LegacyHiddenComponent then
                local bool1 = arg2.memoizedState ~= nil
                hideOrUnhideAllChildren(arg2, bool1)
                return
            end
        end

        invariant(
            false,
            "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
        )
    end,
    commitAttachRef = commitAttachRef,
    commitDetachRef = commitDetachRef,
    commitPassiveUnmount = function(arg1)
        if arg1.tag ~= FunctionComponent and arg1.tag ~= ForwardRef and arg1.tag ~= SimpleMemoComponent and arg1.tag ~= Block then
            return
        end

        if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(arg1.mode, ProfileMode) ~= 0 then
            startPassiveEffectTimer()
            commitHookEffectListUnmount(bit32.bor(Passive, HasEffect), arg1, arg1.return_)

            recordPassiveEffectDuration(arg1)
            return
        end
        commitHookEffectListUnmount(bit32.bor(Passive, HasEffect), arg1, arg1.return_)
    end,
    commitPassiveUnmountInsideDeletedTree = function(arg1, arg2)
        if arg1.tag ~= FunctionComponent and arg1.tag ~= ForwardRef and arg1.tag ~= SimpleMemoComponent and arg1.tag ~= Block then
            return
        end

        if enableProfilerTimer and enableProfilerCommitHooks and bit32.band(arg1.mode, ProfileMode) ~= 0 then
            startPassiveEffectTimer()
            commitHookEffectListUnmount(Passive, arg1, arg2)
            recordPassiveEffectDuration(arg1)
            return
        end
        commitHookEffectListUnmount(Passive, arg1, arg2)
    end,
    commitPassiveMount = function(arg1, arg2)
        if arg2.tag ~= FunctionComponent and arg2.tag ~= ForwardRef and arg2.tag ~= SimpleMemoComponent and arg2.tag ~= Block then
            if arg2.tag == Profiler then
                commitProfilerPassiveEffect(arg1, arg2)
            end

            return
        end

        if not enableProfilerTimer or not enableProfilerCommitHooks or bit32.band(arg2.mode, ProfileMode) == 0 then
            commitHookEffectListMount(bit32.bor(Passive, HasEffect), arg2)
            return
        end

        startPassiveEffectTimer()

        local success, result = xpcall(commitHookEffectListMount, describeError, bit32.bor(Passive, HasEffect), arg2)

        recordPassiveEffectDuration(arg2)
        if not success then
            error(result)
        end
    end,
    invokeLayoutEffectMountInDEV = invokeLayoutEffectMountInDEV,
    invokeLayoutEffectUnmountInDEV = invokeLayoutEffectUnmountInDEV,
    invokePassiveEffectMountInDEV = invokePassiveEffectMountInDEV,
    invokePassiveEffectUnmountInDEV = invokePassiveEffectUnmountInDEV,
    isSuspenseBoundaryBeingHidden = isSuspenseBoundaryBeingHidden,
    recursivelyCommitLayoutEffects = recursivelyCommitLayoutEffects
}
