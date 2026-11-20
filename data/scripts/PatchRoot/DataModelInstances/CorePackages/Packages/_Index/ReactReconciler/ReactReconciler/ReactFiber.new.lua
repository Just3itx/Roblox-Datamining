-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local Array = LuauPolyfill.Array
local inspect = LuauPolyfill.util.inspect

local __DEV__ = ReactGlobals.__DEV__

local console = require(scriptParentParent.Shared).console

local _Shared = require(scriptParentParent.Shared)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactRootTags = require(script.Parent.ReactRootTags)

local ReactWorkTags = require(script.Parent.ReactWorkTags)

local ReactTypeOfMode = require(script.Parent.ReactTypeOfMode)

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local _ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local _ReactFiberOffscreenComponent = require(script.Parent.ReactFiberOffscreenComponent)

local invariant = require(scriptParentParent.Shared).invariant
local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer

local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local NoFlags = ReactFiberFlags.NoFlags
local Placement = ReactFiberFlags.Placement
local StaticMask = ReactFiberFlags.StaticMask
local ConcurrentRoot = ReactRootTags.ConcurrentRoot
local BlockingRoot = ReactRootTags.BlockingRoot
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent
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
local DehydratedFragment = ReactWorkTags.DehydratedFragment
local FunctionComponent = ReactWorkTags.FunctionComponent
local MemoComponent = ReactWorkTags.MemoComponent
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local LazyComponent = ReactWorkTags.LazyComponent
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local ScopeComponent = ReactWorkTags.ScopeComponent
local OffscreenComponent = ReactWorkTags.OffscreenComponent
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent
local getComponentName = require(scriptParentParent.Shared).getComponentName

local isDevToolsPresent = require(script.Parent["ReactFiberDevToolsHook.new"]).isDevToolsPresent
local ReactFiberHotReloadingNew = require(script.Parent["ReactFiberHotReloading.new"])
local resolveClassForHotReloading = ReactFiberHotReloadingNew.resolveClassForHotReloading

local resolveFunctionForHotReloading = ReactFiberHotReloadingNew.resolveFunctionForHotReloading

local resolveForwardRefForHotReloading = ReactFiberHotReloadingNew.resolveForwardRefForHotReloading
local NoLanes = ReactFiberLane.NoLanes
local NoMode = ReactTypeOfMode.NoMode
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode
local ProfileMode = ReactTypeOfMode.ProfileMode
local StrictMode = ReactTypeOfMode.StrictMode
local BlockingMode = ReactTypeOfMode.BlockingMode
local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local REACT_DEBUG_TRACING_MODE_TYPE = ReactSymbols.REACT_DEBUG_TRACING_MODE_TYPE
local REACT_STRICT_MODE_TYPE = ReactSymbols.REACT_STRICT_MODE_TYPE
local REACT_PROFILER_TYPE = ReactSymbols.REACT_PROFILER_TYPE
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE

local REACT_OFFSCREEN_TYPE = ReactSymbols.REACT_OFFSCREEN_TYPE
local REACT_LEGACY_HIDDEN_TYPE = ReactSymbols.REACT_LEGACY_HIDDEN_TYPE

local createFiberFromProfiler = nil
local createFiberFromFragment = nil
local createFiberFromSuspense = nil
local createFiberFromOffscreen = nil
local createFiberFromLegacyHidden = nil

local num1 = 1

local function createFiber(tag, pendingProps, key, mode, elementType, type, stateNode, lanes)
    local tbl1 = {
        tag = tag,
        key = key,
        elementType = elementType,
        type = type,
        stateNode = stateNode,
        index = 1,
        pendingProps = pendingProps,
        mode = mode,
        flags = NoFlags,
        subtreeFlags = NoFlags,
        lanes = lanes or NoLanes,
        childLanes = NoLanes
    }

    if enableProfilerTimer then
        tbl1.actualDuration = 0
        tbl1.actualStartTime = -1
        tbl1.selfBaseDuration = 0
        tbl1.treeBaseDuration = 0
    end

    if __DEV__ then
        tbl1._debugID = num1
        num1 += 1
        tbl1._debugSource = nil
        tbl1._debugOwner = nil
        tbl1._debugNeedsRemount = false
        tbl1._debugHookTypes = nil
    end

    return tbl1
end

function _shouldConstruct(arg1): boolean
    return not (type(arg1) == "function") and not not arg1.isReactComponent
end

local function createFiberFromTypeAndProps(elementType, key: string?, pendingProps, _debugOwner, arg1, lanes)
    local var1 = IndeterminateComponent

    local str1 = type(elementType)
    local var2

    if str1 == "function" then
        if __DEV__ then
            var2 = resolveFunctionForHotReloading(elementType)
        else
            var2 = elementType
        end
    elseif str1 == "table" and elementType.isReactComponent then
        var1 = ClassComponent
        if __DEV__ then
            var2 = resolveClassForHotReloading(elementType)
        else
            var2 = elementType
        end
    elseif str1 == "string" then
        var1 = HostComponent
        var2 = elementType
    else
        if elementType == REACT_FRAGMENT_TYPE then
            return createFiberFromFragment(pendingProps.children, arg1, lanes, key)
        end

        if elementType == REACT_DEBUG_TRACING_MODE_TYPE then
            var1 = Mode
            arg1 = bit32.bor(arg1, DebugTracingMode)
            var2 = elementType
        elseif elementType == REACT_STRICT_MODE_TYPE then
            var1 = Mode
            arg1 = bit32.bor(arg1, StrictMode)
            var2 = elementType
        else
            if elementType == REACT_PROFILER_TYPE then
                return createFiberFromProfiler(pendingProps, arg1, lanes, key)
            end

            if elementType == REACT_SUSPENSE_TYPE then
                return createFiberFromSuspense(pendingProps, arg1, lanes, key)
            end

            if elementType == REACT_OFFSCREEN_TYPE then
                return createFiberFromOffscreen(pendingProps, arg1, lanes, key)
            end

            if elementType == REACT_LEGACY_HIDDEN_TYPE then
                return createFiberFromLegacyHidden(pendingProps, arg1, lanes, key)
            end

            local bool1 = false
            local typeof

            if str1 == "table" then
                typeof = elementType["$$typeof"]
                if typeof == REACT_PROVIDER_TYPE then
                    var1 = ContextProvider
                    var2 = elementType
                    bool1 = true
                elseif typeof == REACT_CONTEXT_TYPE then
                    var1 = ContextConsumer
                    var2 = elementType
                    bool1 = true
                elseif typeof == REACT_FORWARD_REF_TYPE then
                    var1 = ForwardRef
                    if __DEV__ then
                        var2 = resolveForwardRefForHotReloading(elementType)
                    else
                        var2 = elementType
                    end

                    bool1 = true
                elseif typeof == REACT_MEMO_TYPE then
                    var1 = MemoComponent
                    var2 = elementType
                    bool1 = true
                elseif typeof == REACT_LAZY_TYPE then
                    var1 = LazyComponent
                    bool1 = true
                    var2 = nil
                else
                    var2 = elementType
                end
            else
                var2 = elementType
                typeof = nil
            end

            if not bool1 then
                local str2 = ""
                if __DEV__ then
                    if elementType == nil or str1 == "table" and #Object.keys(elementType) == 0 then
                        str2 ..= " You likely forgot to export your component from the file it's defined in, or you might have mixed up default and named imports."
                    elseif elementType ~= nil and str1 == "table" then
                        str2 ..= "\n" .. inspect(elementType)
                    end

                    local componentName = if _debugOwner then getComponentName(_debugOwner.type) else nil

                    if componentName ~= nil and componentName ~= "" then
                        str2 ..= "\n\nCheck the render method of `" .. componentName .. "`."
                    elseif _debugOwner then
                        str2 ..= "\n" .. inspect(_debugOwner)
                    end
                end

                if elementType == nil then
                    str1 = "nil"
                elseif Array.isArray(elementType) then
                    str1 = "array"
                elseif str1 == "table" and typeof == REACT_ELEMENT_TYPE then
                    str1 = string.format("<%s />", getComponentName(elementType.type) or "Unknown")
                    str2 = " Did you accidentally export a JSX literal or Element instead of a component?"
                end

                invariant(
                    false,
                    "Element type is invalid: expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s",
                    str1,
                    str2
                )
            end
        end
    end

    local fiber = createFiber(var1, pendingProps, key, arg1, elementType, var2, nil, lanes)

    if __DEV__ then
        fiber._debugOwner = _debugOwner
    end

    return fiber
end

createFiberFromFragment = function(pendingProps, mode, lanes, key: string?)
    return (createFiber(Fragment, pendingProps, key, mode, nil, nil, nil, lanes))
end

local function createFiberFromScope(arg1, pendingProps, mode, lanes, key: string?) -- Luacid: unused: defined but never referenced
    return (createFiber(ScopeComponent, pendingProps, key, mode, arg1, arg1, nil, lanes))
end

createFiberFromProfiler = function(pendingProps, arg1, lanes, key: string?)
    if __DEV__ and typeof(pendingProps.id) ~= "string" then
        console.error("Profiler must specify an \"id\" as a prop")
    end

    return (createFiber(
        Profiler,
        pendingProps,
        key,
        bit32.bor(arg1, ProfileMode),
        REACT_PROFILER_TYPE,
        REACT_PROFILER_TYPE,
        enableProfilerTimer and { effectDuration = 0, passiveEffectDuration = 0 } or nil,
        lanes
    ))
end

createFiberFromSuspense = function(pendingProps, mode, lanes, key: string?)
    return (createFiber(SuspenseComponent, pendingProps, key, mode, REACT_SUSPENSE_TYPE, REACT_SUSPENSE_TYPE, nil, lanes))
end

createFiberFromOffscreen = function(pendingProps, mode, lanes, key: string?)
    return (createFiber(
        OffscreenComponent,
        pendingProps,
        key,
        mode,
        REACT_OFFSCREEN_TYPE,
        if __DEV__ then REACT_OFFSCREEN_TYPE else nil,
        nil,
        lanes
    ))
end

createFiberFromLegacyHidden = function(pendingProps, mode, lanes, key: string?)
    return (createFiber(
        LegacyHiddenComponent,
        pendingProps,
        key,
        mode,
        REACT_LEGACY_HIDDEN_TYPE,
        if __DEV__ then REACT_LEGACY_HIDDEN_TYPE else nil,
        nil,
        lanes
    ))
end

return {
    isSimpleFunctionComponent = function(arg1): boolean
        return type(arg1) == "function"
    end,
    resolveLazyComponentTag = function(arg1)
        local str1 = typeof(arg1)
        if str1 == "function" then
            return FunctionComponent
        end

        if str1 == "table" then
            if arg1.isReactComponent then
                return ClassComponent
            end
            local typeof = arg1["$$typeof"]
            if typeof == REACT_FORWARD_REF_TYPE then
                return ForwardRef
            end
            if typeof == REACT_MEMO_TYPE then
                return MemoComponent
            end
        end

        return IndeterminateComponent
    end,
    createWorkInProgress = function(alternate, pendingProps)
        local alternate2 = alternate.alternate
        if alternate2 == nil then
            alternate2 = createFiber(
                alternate.tag,
                pendingProps,
                alternate.key,
                alternate.mode,
                alternate.elementType,
                alternate.type,
                alternate.stateNode
            )

            if __DEV__ then
                alternate2._debugID = alternate._debugID
                alternate2._debugSource = alternate._debugSource
                alternate2._debugOwner = alternate._debugOwner
                alternate2._debugHookTypes = alternate._debugHookTypes
            end

            alternate2.alternate = alternate
            alternate.alternate = alternate2
        else
            alternate2.pendingProps = pendingProps

            alternate2.type = alternate.type

            if ReactFeatureFlags.enableWorkLoopTrims then
                alternate2.subtreeFlags = NoFlags
                if alternate2.deletions ~= nil then
                    alternate2.deletions = nil
                end
            else
                alternate2.flags = NoFlags

                alternate2.subtreeFlags = NoFlags
                alternate2.deletions = nil
            end

            if enableProfilerTimer then
                alternate2.actualDuration = 0
                alternate2.actualStartTime = -1
            end
        end

        local flags = alternate.flags
        alternate2.flags = bit32.band(flags, StaticMask)
        alternate2.childLanes = alternate.childLanes
        alternate2.lanes = alternate.lanes

        if ReactFeatureFlags.enableWorkLoopTrims then
            if alternate.child ~= nil or alternate2.child ~= nil then
                alternate2.child = alternate.child
            end
            alternate2.memoizedProps = alternate.memoizedProps
            if alternate.memoizedState ~= nil or alternate2.memoizedState ~= nil then
                alternate2.memoizedState = alternate.memoizedState
            end
            if alternate.updateQueue ~= nil or alternate2.updateQueue ~= nil then
                alternate2.updateQueue = alternate.updateQueue
            end

            local dependencies = alternate.dependencies
            if dependencies ~= nil then
                alternate2.dependencies = {
                    lanes = dependencies.lanes,
                    firstContext = dependencies.firstContext
                }
            elseif alternate2.dependencies ~= nil then
                alternate2.dependencies = nil
            end

            if alternate.sibling ~= nil or alternate2.sibling ~= nil then
                alternate2.sibling = alternate.sibling
            end
            alternate2.index = alternate.index
            if alternate.ref ~= nil or alternate2.ref ~= nil then
                alternate2.ref = alternate.ref
            end
        else
            alternate2.child = alternate.child
            alternate2.memoizedProps = alternate.memoizedProps
            alternate2.memoizedState = alternate.memoizedState
            alternate2.updateQueue = alternate.updateQueue

            local dependencies = alternate.dependencies
            if dependencies == nil then
                alternate2.dependencies = nil
            else
                alternate2.dependencies = {
                    lanes = dependencies.lanes,
                    firstContext = dependencies.firstContext
                }
            end

            alternate2.sibling = alternate.sibling
            alternate2.index = alternate.index
            alternate2.ref = alternate.ref
        end

        if enableProfilerTimer then
            alternate2.selfBaseDuration = alternate.selfBaseDuration
            alternate2.treeBaseDuration = alternate.treeBaseDuration
        end

        if __DEV__ then
            alternate2._debugNeedsRemount = alternate._debugNeedsRemount

            if alternate2.tag == IndeterminateComponent
                or alternate2.tag == FunctionComponent
                or alternate2.tag == SimpleMemoComponent
            then
                alternate2.type = resolveFunctionForHotReloading(alternate.type)
                return alternate2
            end

            if alternate2.tag == ClassComponent then
                alternate2.type = resolveClassForHotReloading(alternate.type)
                return alternate2
            end

            if alternate2.tag == ForwardRef then
                alternate2.type = resolveForwardRefForHotReloading(alternate.type)
            end
        end

        return alternate2
    end,
    resetWorkInProgress = function(arg1, lanes)
        arg1.flags = bit32.band(arg1.flags, bit32.bor(StaticMask, Placement))

        local alternate = arg1.alternate
        if alternate == nil then
            arg1.childLanes = NoLanes
            arg1.lanes = lanes

            arg1.child = nil
            arg1.subtreeFlags = NoFlags
            arg1.memoizedProps = nil
            arg1.memoizedState = nil
            arg1.updateQueue = nil

            arg1.dependencies = nil

            arg1.stateNode = nil

            if enableProfilerTimer then
                arg1.selfBaseDuration = 0
                arg1.treeBaseDuration = 0
                return arg1
            end
        else
            arg1.childLanes = alternate.childLanes
            arg1.lanes = alternate.lanes

            arg1.child = alternate.child
            arg1.subtreeFlags = alternate.subtreeFlags
            arg1.deletions = nil
            arg1.memoizedProps = alternate.memoizedProps
            arg1.memoizedState = alternate.memoizedState
            arg1.updateQueue = alternate.updateQueue

            arg1.type = alternate.type

            local dependencies = alternate.dependencies
            if dependencies == nil then
                arg1.dependencies = nil
            else
                arg1.dependencies = {
                    lanes = dependencies.lanes,
                    firstContext = dependencies.firstContext
                }
            end

            if enableProfilerTimer then
                arg1.selfBaseDuration = alternate.selfBaseDuration
                arg1.treeBaseDuration = alternate.treeBaseDuration
            end
        end

        return arg1
    end,
    createHostRootFiber = function(arg1)
        local var1 = if arg1 == ConcurrentRoot then bit32.bor(ConcurrentMode, BlockingMode, StrictMode) elseif arg1 == BlockingRoot then bit32.bor(BlockingMode, StrictMode) else NoMode

        if enableProfilerTimer and isDevToolsPresent() then
            var1 = bit32.bor(var1, ProfileMode)
        end

        return (createFiber(HostRoot, nil, nil, var1))
    end,
    createFiberFromTypeAndProps = createFiberFromTypeAndProps,
    createFiberFromElement = function(arg1, arg2, lanes)
        local _owner = if __DEV__ then arg1._owner else nil
        local type = arg1.type
        local key = arg1.key
        local props = arg1.props
        local fiberFromTypeAndProps = createFiberFromTypeAndProps(type, key, props, _owner, arg2, lanes)

        if __DEV__ then
            fiberFromTypeAndProps._debugSource = arg1._source
            fiberFromTypeAndProps._debugOwner = arg1._owner
        end
        return fiberFromTypeAndProps
    end,
    createFiberFromFragment = createFiberFromFragment,
    createFiberFromFundamental = function(arg1, pendingProps, mode, lanes, key: string?)
        return (createFiber(FundamentalComponent, pendingProps, key, mode, arg1, arg1, nil, lanes))
    end,
    createFiberFromSuspense = createFiberFromSuspense,
    createFiberFromSuspenseList = function(pendingProps, mode, lanes, key: string?)
        return (createFiber(
            SuspenseListComponent,
            pendingProps,
            key,
            mode,
            REACT_SUSPENSE_LIST_TYPE,
            if __DEV__ then REACT_SUSPENSE_LIST_TYPE else nil,
            nil,
            lanes
        ))
    end,
    createFiberFromOffscreen = createFiberFromOffscreen,
    createFiberFromLegacyHidden = createFiberFromLegacyHidden,
    createFiberFromText = function(pendingProps: string, mode, lanes)
        return (createFiber(HostText, pendingProps, nil, mode, nil, nil, nil, lanes))
    end,
    createFiberFromHostInstanceForDeletion = function()
        return (createFiber(HostComponent, nil, nil, NoMode, "DELETED", "DELETED"))
    end,
    createFiberFromDehydratedFragment = function(stateNode)
        return (createFiber(DehydratedFragment, nil, nil, NoMode, nil, nil, stateNode))
    end,
    createFiberFromPortal = function(arg1, mode, lanes)
        local pendingProps = arg1.children == nil and {} or arg1.children

        return (createFiber(
            HostPortal,
            pendingProps,
            arg1.key,
            mode,
            nil,
            nil,
            {
                containerInfo = arg1.containerInfo,
                pendingChildren = nil,
                implementation = arg1.implementation
            },
            lanes
        ))
    end,
    assignFiberPropertiesInDEV = function(arg1, arg2)
        if arg1 == nil then
            arg1 = createFiber(IndeterminateComponent, nil, nil, NoMode)
        end

        arg1.tag = arg2.tag
        arg1.key = arg2.key
        arg1.elementType = arg2.elementType
        arg1.type = arg2.type
        arg1.stateNode = arg2.stateNode
        arg1.return_ = arg2.return_
        arg1.child = arg2.child
        arg1.sibling = arg2.sibling
        arg1.index = arg2.index
        arg1.ref = arg2.ref
        arg1.pendingProps = arg2.pendingProps
        arg1.memoizedProps = arg2.memoizedProps
        arg1.updateQueue = arg2.updateQueue
        arg1.memoizedState = arg2.memoizedState
        arg1.dependencies = arg2.dependencies
        arg1.mode = arg2.mode
        arg1.flags = arg2.flags
        arg1.subtreeFlags = arg2.subtreeFlags
        arg1.deletions = arg2.deletions
        arg1.lanes = arg2.lanes
        arg1.childLanes = arg2.childLanes
        arg1.alternate = arg2.alternate
        if enableProfilerTimer then
            arg1.actualDuration = arg2.actualDuration
            arg1.actualStartTime = arg2.actualStartTime
            arg1.selfBaseDuration = arg2.selfBaseDuration
            arg1.treeBaseDuration = arg2.treeBaseDuration
        end
        arg1._debugID = arg2._debugID
        arg1._debugSource = arg2._debugSource
        arg1._debugOwner = arg2._debugOwner
        arg1._debugNeedsRemount = arg2._debugNeedsRemount
        arg1._debugHookTypes = arg2._debugHookTypes
        return arg1
    end
}
