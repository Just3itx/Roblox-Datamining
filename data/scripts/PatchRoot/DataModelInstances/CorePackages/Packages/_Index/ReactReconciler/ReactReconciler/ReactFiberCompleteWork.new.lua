-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function unimplemented(str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: " .. tostring(str1))
    error("FIXME (roblox): " .. str1 .. " is unimplemented", 2)
end

local scriptParentParent = script.Parent.Parent

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local OffscreenLane = ReactFiberLane.OffscreenLane

local ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local _ReactFiberOffscreenComponent = require(script.Parent.ReactFiberOffscreenComponent)

local resetWorkInProgressVersions = require(script.Parent["ReactMutableSource.new"]).resetWorkInProgressVersions

local ReactWorkTags = require(script.Parent.ReactWorkTags)
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent
local FunctionComponent = ReactWorkTags.FunctionComponent
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local HostComponent = ReactWorkTags.HostComponent
local HostText = ReactWorkTags.HostText
local HostPortal = ReactWorkTags.HostPortal
local ContextProvider = ReactWorkTags.ContextProvider
local ContextConsumer = ReactWorkTags.ContextConsumer
local ForwardRef = ReactWorkTags.ForwardRef
local Fragment = ReactWorkTags.Fragment
local Mode = ReactWorkTags.Mode
local Profiler = ReactWorkTags.Profiler
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local MemoComponent = ReactWorkTags.MemoComponent
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local LazyComponent = ReactWorkTags.LazyComponent
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local ScopeComponent = ReactWorkTags.ScopeComponent
local Block = ReactWorkTags.Block
local OffscreenComponent = ReactWorkTags.OffscreenComponent
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent

local _ReactFiberSuspenseComponentNew = require(script.Parent["ReactFiberSuspenseComponent.new"])

local ReactTypeOfMode = require(script.Parent.ReactTypeOfMode)
local NoMode = ReactTypeOfMode.NoMode
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode
local BlockingMode = ReactTypeOfMode.BlockingMode
local ProfileMode = ReactTypeOfMode.ProfileMode

local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local Ref = ReactFiberFlags.Ref
local Update = ReactFiberFlags.Update
local HostUpdate = ReactFiberFlags.HostUpdate
local Callback = ReactFiberFlags.Callback
local Passive = ReactFiberFlags.Passive
local Deletion = ReactFiberFlags.Deletion
local NoFlags = ReactFiberFlags.NoFlags
local DidCapture = ReactFiberFlags.DidCapture
local Snapshot = ReactFiberFlags.Snapshot
local MutationMask = ReactFiberFlags.MutationMask
local LayoutMask = ReactFiberFlags.LayoutMask
local PassiveMask = ReactFiberFlags.PassiveMask
local StaticMask = ReactFiberFlags.StaticMask
local PerformedWork = ReactFiberFlags.PerformedWork

local invariant = require(scriptParentParent.Shared).invariant

local createInstance = ReactFiberHostConfig.createInstance
local createTextInstance = ReactFiberHostConfig.createTextInstance
local appendInitialChild = ReactFiberHostConfig.appendInitialChild
local finalizeInitialChildren = ReactFiberHostConfig.finalizeInitialChildren
local prepareUpdate = ReactFiberHostConfig.prepareUpdate
local supportsMutation = ReactFiberHostConfig.supportsMutation
local supportsPersistence = ReactFiberHostConfig.supportsPersistence

local createContainerChildSet = ReactFiberHostConfig.createContainerChildSet

local finalizeContainerChildren = ReactFiberHostConfig.finalizeContainerChildren

local preparePortalMount = ReactFiberHostConfig.preparePortalMount

local ReactFiberHostContextNew = require(script.Parent["ReactFiberHostContext.new"])
local getRootHostContainer = ReactFiberHostContextNew.getRootHostContainer
local popHostContext = ReactFiberHostContextNew.popHostContext
local getHostContext = ReactFiberHostContextNew.getHostContext
local popHostContainer = ReactFiberHostContextNew.popHostContainer

local ReactFiberSuspenseContextNew = require(script.Parent["ReactFiberSuspenseContext.new"])
local popSuspenseContext = ReactFiberSuspenseContextNew.popSuspenseContext
local suspenseStackCursor = ReactFiberSuspenseContextNew.suspenseStackCursor

local InvisibleParentSuspenseContext = ReactFiberSuspenseContextNew.InvisibleParentSuspenseContext
local hasSuspenseContext = ReactFiberSuspenseContextNew.hasSuspenseContext

local ReactFiberContextNew = require(script.Parent["ReactFiberContext.new"])
local isContextProvider = ReactFiberContextNew.isContextProvider
local popContext = ReactFiberContextNew.popContext
local popTopLevelContextObject = ReactFiberContextNew.popTopLevelContextObject
local popProvider = require(script.Parent["ReactFiberNewContext.new"]).popProvider

local ReactFiberHydrationContextNew = require(script.Parent["ReactFiberHydrationContext.new"])

local prepareToHydrateHostSuspenseInstance = ReactFiberHydrationContextNew.prepareToHydrateHostSuspenseInstance
local popHydrationState = ReactFiberHydrationContextNew.popHydrationState
local resetHydrationState = ReactFiberHydrationContextNew.resetHydrationState

local prepareToHydrateHostInstance = ReactFiberHydrationContextNew.prepareToHydrateHostInstance

local prepareToHydrateHostTextInstance = ReactFiberHydrationContextNew.prepareToHydrateHostTextInstance
local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer
local enableFundamentalAPI = ReactFeatureFlags.enableFundamentalAPI

local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer

local ReactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])

local popRenderLanes = ReactFiberWorkLoopNew.popRenderLanes

local markSpawnedWork = ReactFiberWorkLoopNew.markSpawnedWork
local renderDidSuspend = ReactFiberWorkLoopNew.renderDidSuspend
local renderDidSuspendDelayIfPossible = ReactFiberWorkLoopNew.renderDidSuspendDelayIfPossible

local NoLanes = ReactFiberLane.NoLanes
local includesSomeLane = ReactFiberLane.includesSomeLane
local mergeLanes = ReactFiberLane.mergeLanes

local transferActualDuration = require(script.Parent["ReactProfilerTimer.new"]).transferActualDuration

local function markUpdate(arg1) -- Luacid: Inlined by compiler; 7 call sites recovered
    arg1.flags = bit32.bor(arg1.flags, Update)
end

local function markRef(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    arg1.flags = bit32.bor(arg1.flags, Ref)
end

local function hadNoMutationsEffects(arg1, arg2)
    if arg1 ~= nil and arg1.child == arg2.child then
        return true
    end

    local child = arg2.child
    while child ~= nil do
        if bit32.band(child.flags, MutationMask) ~= NoFlags then
            return false
        end
        if bit32.band(child.subtreeFlags, MutationMask) ~= NoFlags then
            return false
        end
        child = child.sibling
    end
    return true
end

local var1 = nil

local updateHostComponent = nil
local updateHostText = nil
local func1

if supportsMutation then
    var1 = function(arg1, _return, _: boolean, _: boolean)
        local child = _return.child

        while true do
            if child == nil then
                return
            end

            if child.tag == HostComponent or child.tag == HostText then
                appendInitialChild(arg1, child.stateNode)
            elseif enableFundamentalAPI and child.tag == FundamentalComponent then
                appendInitialChild(arg1, child.stateNode.instance)
            elseif child.tag ~= HostPortal and child.child ~= nil then
                child.child.return_ = child
                child = child.child
                continue
            end

            if child == _return then
                return
            end
            while child.sibling == nil do
                if child.return_ == nil or child.return_ == _return then
                    return
                end
                child = child.return_
            end

            child.sibling.return_ = child.return_
            child = child.sibling
        end
    end

    func1 = function(_, _) end

    updateHostComponent = function(arg1, arg2, arg3, arg4, arg5)
        local memoizedProps = arg1.memoizedProps
        if memoizedProps == arg4 then
            return
        end

        local stateNode = arg2.stateNode
        local hostContext = getHostContext()

        local updateQueue = prepareUpdate(stateNode, arg3, memoizedProps, arg4, arg5, hostContext)

        if not ReactFeatureFlags.enableWorkLoopTrims or updateQueue ~= nil or arg2.updateQueue ~= nil then
            arg2.updateQueue = updateQueue
        end

        if not updateQueue then
            return
        end

        if ReactFeatureFlags.enableCommitTraversalTrims then
            arg2.flags = bit32.bor(arg2.flags, HostUpdate)
            return
        end

        markUpdate(arg2)
    end

    updateHostText = function(_, arg1, str1: string, str2: string)
        if str1 ~= str2 then
            markUpdate(arg1)
        end
    end
elseif supportsPersistence then
    var1 = function(_, _, _: boolean, _: boolean)
        unimplemented("appendAllChildren")
    end

    local function appendAllChildrenToContainer(_, _, _: boolean, _: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        unimplemented("appendAllChildrenToContainer")
    end

    func1 = function(arg1, arg2) -- name: updateHostContainer
        local stateNode = arg2.stateNode
        if hadNoMutationsEffects(arg1, arg2) then
            return
        end

        local containerInfo = stateNode.containerInfo
        local pendingChildren = createContainerChildSet(containerInfo)
        appendAllChildrenToContainer(nil, nil, nil, nil)
        stateNode.pendingChildren = pendingChildren
        markUpdate(arg2)
        finalizeContainerChildren(containerInfo, pendingChildren)
    end
else
    func1 = function(_, _) end
end

local function bubbleProperties(_return): boolean
    local bool1 = not (_return.alternate == nil) and _return.alternate.child == _return.child
    local var2 = NoLanes
    local var3 = NoFlags

    if not bool1 then
        if enableProfilerTimer and bit32.band(_return.mode, ProfileMode) ~= NoMode then
            local actualDuration = _return.actualDuration
            local selfBaseDuration = _return.selfBaseDuration

            local child = _return.child

            while child ~= nil do
                var2 = mergeLanes(var2, mergeLanes(child.lanes, child.childLanes))

                var3 = bit32.bor(bit32.bor(var3, child.subtreeFlags), child.flags)

                actualDuration += child.actualDuration

                selfBaseDuration += child.treeBaseDuration
                child = child.sibling
            end

            _return.actualDuration = actualDuration
            _return.treeBaseDuration = selfBaseDuration
        else
            local child = _return.child

            while child ~= nil do
                var2 = bit32.bor(var2, bit32.bor(child.lanes, child.childLanes))

                var3 = bit32.bor(bit32.bor(var3, child.subtreeFlags), child.flags)

                child.return_ = _return

                child = child.sibling
            end
        end

        _return.subtreeFlags = bit32.bor(_return.subtreeFlags, var3)
    else
        if enableProfilerTimer and bit32.band(_return.mode, ProfileMode) ~= NoMode then
            local selfBaseDuration = _return.selfBaseDuration

            local child = _return.child

            while child ~= nil do
                var2 = mergeLanes(var2, mergeLanes(child.lanes, child.childLanes))

                var3 = bit32.bor(bit32.bor(var3, bit32.band(child.subtreeFlags, StaticMask)), bit32.band(child.flags, StaticMask))

                selfBaseDuration += child.treeBaseDuration
                child = child.sibling
            end

            _return.treeBaseDuration = selfBaseDuration
        else
            local child = _return.child

            while child ~= nil do
                var2 = bit32.bor(var2, bit32.bor(child.lanes, child.childLanes))

                var3 = bit32.bor(bit32.bor(var3, bit32.band(child.subtreeFlags, StaticMask)), bit32.band(child.flags, StaticMask))

                child.return_ = _return

                child = child.sibling
            end
        end

        _return.subtreeFlags = bit32.bor(_return.subtreeFlags, var3)
    end

    _return.childLanes = var2

    return bool1
end

return {
    completeWork = function(arg1, _return, lanes)
        local pendingProps = _return.pendingProps

        if _return.tag == IndeterminateComponent
            or _return.tag == LazyComponent
            or _return.tag == SimpleMemoComponent
            or _return.tag == FunctionComponent
            or _return.tag == ForwardRef
            or _return.tag == Fragment
            or _return.tag == Mode
            or _return.tag == ContextConsumer
            or _return.tag == MemoComponent
        then
            bubbleProperties(_return)
            return nil
        end

        if _return.tag == ClassComponent then
            local type = _return.type
            if isContextProvider(type) then
                popContext(_return)
            end
            bubbleProperties(_return)
            return nil
        end

        if _return.tag == HostRoot then
            popHostContainer(_return)
            popTopLevelContextObject(_return)
            resetWorkInProgressVersions()

            local stateNode = _return.stateNode
            if stateNode.pendingContext then
                stateNode.context = stateNode.pendingContext
                stateNode.pendingContext = nil
            end
            if arg1 == nil or arg1.child == nil then
                if popHydrationState(_return) then
                    markUpdate(_return)
                elseif not stateNode.hydrate then
                    _return.flags = bit32.bor(_return.flags, Snapshot)
                end
            end
            func1(arg1, _return)
            bubbleProperties(_return)
            return nil
        end

        if _return.tag == HostComponent then
            popHostContext(_return)
            local rootHostContainer = getRootHostContainer()
            local type = _return.type
            if arg1 ~= nil and _return.stateNode ~= nil then
                updateHostComponent(arg1, _return, type, pendingProps, rootHostContainer)

                if arg1.ref ~= _return.ref then
                    markRef(_return)
                end
            else
                if not pendingProps then
                    invariant(
                        _return.stateNode ~= nil,
                        "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue."
                    )

                    bubbleProperties(_return)
                    return nil
                end

                local hostContext = getHostContext()

                if popHydrationState(_return) then
                    if prepareToHydrateHostInstance(_return, rootHostContainer, hostContext) then
                        markUpdate(_return)
                    end
                else
                    local stateNode = createInstance(type, pendingProps, rootHostContainer, hostContext, _return)

                    var1(stateNode, _return, false, false)

                    _return.stateNode = stateNode

                    if finalizeInitialChildren(stateNode, type, pendingProps, rootHostContainer, hostContext) then
                        markUpdate(_return)
                    end
                end

                if _return.ref ~= nil then
                    markRef(_return)
                end
            end

            bubbleProperties(_return)
            return nil
        end

        if _return.tag == HostText then
            if arg1 and _return.stateNode ~= nil then
                local memoizedProps = arg1.memoizedProps

                updateHostText(arg1, _return, memoizedProps, pendingProps)
            else
                if typeof(pendingProps) ~= "string" then
                    invariant(
                        _return.stateNode ~= nil,
                        "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue."
                    )
                end

                local rootHostContainer = getRootHostContainer()
                local hostContext = getHostContext()
                if popHydrationState(_return) then
                    if prepareToHydrateHostTextInstance(_return) then
                        markUpdate(_return)
                    end
                else
                    _return.stateNode = createTextInstance(pendingProps, rootHostContainer, hostContext, _return)
                end
            end

            bubbleProperties(_return)
            return nil
        end

        if _return.tag == Profiler then
            if not bubbleProperties(_return) then
                local var2 = Update
                local var3 = Callback
                local var4 = Passive
                local subtreeFlags = _return.subtreeFlags
                local flags = _return.flags
                local var5 = if bit32.band(flags, PerformedWork) == NoFlags and bit32.band(subtreeFlags, PerformedWork) == NoFlags then flags else bit32.bor(flags, var2)

                if ReactFeatureFlags.enableCommitTraversalTrims then
                    local num1 = bit32.bor(LayoutMask, Deletion, HostUpdate)

                    if bit32.band(flags, num1) ~= NoFlags or bit32.band(subtreeFlags, bit32.bor(LayoutMask, Deletion, HostUpdate)) ~= NoFlags then
                        var5 = bit32.bor(var5, var3)
                    end
                else
                    local num1 = bit32.bor(LayoutMask, Deletion)

                    if bit32.band(flags, num1) ~= NoFlags or bit32.band(subtreeFlags, bit32.bor(LayoutMask, Deletion)) ~= NoFlags then
                        var5 = bit32.bor(var5, var3)
                    end
                end

                if bit32.band(flags, PassiveMask) ~= NoFlags or bit32.band(subtreeFlags, PassiveMask) ~= NoFlags then
                    var5 = bit32.bor(var5, var4)
                end
                _return.flags = var5
            end

            return nil
        end

        if _return.tag ~= SuspenseComponent then
            if _return.tag == HostPortal then
                popHostContainer(_return)
                func1(arg1, _return)
                if arg1 == nil then
                    preparePortalMount(_return.stateNode.containerInfo)
                end
                bubbleProperties(_return)
                return nil
            end

            if _return.tag == ContextProvider then
                popProvider(_return)
                bubbleProperties(_return)
                return nil
            end

            if _return.tag == IncompleteClassComponent then
                local type = _return.type
                if isContextProvider(type) then
                    popContext(_return)
                end
                bubbleProperties(_return)
                return nil
            end

            if _return.tag == SuspenseListComponent then
                unimplemented("SuspenseListComponent")
            elseif _return.tag == FundamentalComponent then
                unimplemented("FundamentalComponent")
            elseif _return.tag == ScopeComponent then
                unimplemented("ScopeComponent")
            elseif _return.tag == Block then
                unimplemented("Block")
            elseif _return.tag == OffscreenComponent or _return.tag == LegacyHiddenComponent then
                popRenderLanes(_return)
                local bool1 = _return.memoizedState ~= nil

                if arg1 ~= nil and arg1.memoizedState ~= nil ~= bool1 and pendingProps.mode ~= "unstable-defer-without-hiding" then
                    _return.flags = bit32.bor(_return.flags, Update)
                end

                if not bool1
                    or includesSomeLane(ReactFiberWorkLoopNew.subtreeRenderLanes, OffscreenLane)
                    or bit32.band(_return.mode, ConcurrentMode) == NoMode
                then
                    bubbleProperties(_return)
                end

                return nil
            end
            invariant(
                false,
                "Unknown unit of work tag (%s). This error is likely caused by a bug in React. Please file an issue.",
                tostring(_return.tag)
            )
            return nil
        end

        popSuspenseContext(_return)
        local memoizedState = _return.memoizedState

        if enableSuspenseServerRenderer and memoizedState ~= nil and memoizedState.dehydrated ~= nil then
            if arg1 == nil then
                local var2 = popHydrationState(_return)
                invariant(
                    var2,
                    "A dehydrated suspense component was completed without a hydrated node. This is probably a bug in React."
                )

                prepareToHydrateHostSuspenseInstance(_return)
                if enableSchedulerTracing then
                    markSpawnedWork(OffscreenLane)
                end
                bubbleProperties(_return)
                if enableProfilerTimer and bit32.band(_return.mode, ProfileMode) ~= NoMode and memoizedState ~= nil then
                    local child = _return.child
                    if child ~= nil then
                        _return.treeBaseDuration = child.treeBaseDuration
                    end
                end

                return nil
            end

            resetHydrationState()
            if bit32.band(_return.flags, DidCapture) == NoFlags then
                _return.memoizedState = nil
            end

            _return.flags = bit32.bor(_return.flags, Update)
            bubbleProperties(_return)
            if enableProfilerTimer and bit32.band(_return.mode, ProfileMode) ~= NoMode and memoizedState ~= nil then
                local child = _return.child
                if child ~= nil then
                    _return.treeBaseDuration -= child.treeBaseDuration
                end
            end

            return nil
        end

        if bit32.band(_return.flags, DidCapture) ~= NoFlags then
            _return.lanes = lanes

            if enableProfilerTimer and bit32.band(_return.mode, ProfileMode) ~= NoMode then
                transferActualDuration(_return)
            end

            return _return
        end

        local bool1 = memoizedState ~= nil
        local bool2 = false
        if arg1 ~= nil then
            bool2 = arg1.memoizedState ~= nil
        elseif _return.memoizedProps.fallback ~= nil then
            popHydrationState(_return)
        end

        if bool1 and not bool2 and bit32.band(_return.mode, BlockingMode) ~= NoMode then
            local bool3 = arg1 == nil and _return.memoizedProps.unstable_avoidThisFallback ~= true

            if bool3 or hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext) then
                renderDidSuspend()
            else
                renderDidSuspendDelayIfPossible()
            end
        end

        if supportsPersistence and bool1 then
            _return.flags = bit32.bor(_return.flags, Update)
        end

        if supportsMutation and (bool1 or bool2) then
            _return.flags = bit32.bor(_return.flags, Update)
        end

        if enableSuspenseCallback and _return.updateQueue ~= nil and _return.memoizedProps.suspenseCallback ~= nil then
            _return.flags = bit32.bor(_return.flags, Update)
        end
        bubbleProperties(_return)
        if enableProfilerTimer and bit32.band(_return.mode, ProfileMode) ~= NoMode and bool1 then
            local child = _return.child
            if child ~= nil then
                _return.treeBaseDuration -= child.treeBaseDuration
            end
        end

        return nil
    end
}
