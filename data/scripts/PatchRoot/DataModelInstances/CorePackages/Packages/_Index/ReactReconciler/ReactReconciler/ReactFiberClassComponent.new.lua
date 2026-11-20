-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local Object = require(scriptParentParent.LuauPolyfill).Object

local __DEV__ = ReactGlobals.__DEV__

local console = require(scriptParentParent.Shared).console
local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local ReactUpdateQueueNew = require(script.Parent["ReactUpdateQueue.new"])

local _Shared = require(scriptParentParent.Shared)

local React = require(scriptParentParent.React)

local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local Update = ReactFiberFlags.Update
local Snapshot = ReactFiberFlags.Snapshot
local MountLayoutDev = ReactFiberFlags.MountLayoutDev

local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags

local debugRenderPhaseSideEffectsForStrictMode = ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode
local disableLegacyContext = ReactFeatureFlags.disableLegacyContext
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler
local warnAboutDeprecatedLifecycles = ReactFeatureFlags.warnAboutDeprecatedLifecycles
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects
local enableAllocationTrims = ReactFeatureFlags.enableAllocationTrims

local ReactStrictModeWarningsNew = require(script.Parent["ReactStrictModeWarnings.new"])
local isMounted = require(script.Parent.ReactFiberTreeReflection).isMounted
local ReactInstanceMap = require(scriptParentParent.Shared).ReactInstanceMap
local get = ReactInstanceMap.get
local set = ReactInstanceMap.set
local shallowEqual = require(scriptParentParent.Shared).shallowEqual
local getComponentName = require(scriptParentParent.Shared).getComponentName
local UninitializedState = require(scriptParentParent.Shared).UninitializedState
local describeError = require(scriptParentParent.Shared).describeError

local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE

local resolveDefaultProps = require(script.Parent["ReactFiberLazyComponent.new"]).resolveDefaultProps
local ReactTypeOfMode = require(script.Parent.ReactTypeOfMode)
local DebugTracingMode = ReactTypeOfMode.DebugTracingMode
local StrictMode = ReactTypeOfMode.StrictMode

local enqueueUpdate = ReactUpdateQueueNew.enqueueUpdate
local processUpdateQueue = ReactUpdateQueueNew.processUpdateQueue

local checkHasForceUpdateAfterProcessing = ReactUpdateQueueNew.checkHasForceUpdateAfterProcessing

local resetHasForceUpdateBeforeProcessing = ReactUpdateQueueNew.resetHasForceUpdateBeforeProcessing
local createUpdate = ReactUpdateQueueNew.createUpdate
local ReplaceState = ReactUpdateQueueNew.ReplaceState
local ForceUpdate = ReactUpdateQueueNew.ForceUpdate
local initializeUpdateQueue = ReactUpdateQueueNew.initializeUpdateQueue
local cloneUpdateQueue = ReactUpdateQueueNew.cloneUpdateQueue
local NoLanes = ReactFiberLane.NoLanes

local ReactFiberContextNew = require(script.Parent["ReactFiberContext.new"])
local cacheContext = ReactFiberContextNew.cacheContext
local getMaskedContext = ReactFiberContextNew.getMaskedContext
local getUnmaskedContext = ReactFiberContextNew.getUnmaskedContext
local hasContextChanged = ReactFiberContextNew.hasContextChanged
local emptyContextObject = ReactFiberContextNew.emptyContextObject

local readContext = require(script.Parent["ReactFiberNewContext.new"]).readContext

local DebugTracing = require(script.Parent.DebugTracing)
local logForceUpdateScheduled = DebugTracing.logForceUpdateScheduled
local logStateUpdateScheduled = DebugTracing.logStateUpdateScheduled

local ConsolePatchingDev = require(scriptParentParent.Shared).ConsolePatchingDev
local disableLogs = ConsolePatchingDev.disableLogs
local reenableLogs = ConsolePatchingDev.reenableLogs

local SchedulingProfiler = require(script.Parent.SchedulingProfiler)
local markForceUpdateScheduled = SchedulingProfiler.markForceUpdateScheduled
local markStateUpdateScheduled = SchedulingProfiler.markStateUpdateScheduled

local _reactInternalInstance = {}

local __refs = React.Component:extend("").__refs

local var1 = nil
local var2 = nil
local var3 = nil
local var4 = nil

local warnOnUndefinedDerivedState = nil
local warnOnInvalidCallback = nil
local var5 = nil
local var6 = nil
local var7 = nil

if __DEV__ then
    var1 = {}
    var2 = {}
    var3 = {}
    var4 = {}
    var5 = {}

    var6 = {}
    var7 = {}

    local tbl2 = ({})

    warnOnInvalidCallback = function(arg1, str1: string)
        if arg1 == nil or type(arg1) == "function" then
            return
        end
        local str2 = str1 .. "_" .. tostring(arg1)
        if not tbl2[str2] then
            tbl2[str2] = true
            console.error(
                "%s(...): Expected the last optional `callback` argument to be a function. Instead received: %s.",
                str1,
                tostring(arg1)
            )
        end
    end

    warnOnUndefinedDerivedState = function(_, _) end
end

local function applyDerivedStateFromProps(arg1, arg2, callback: (...any) -> (...any), arg3)
    local memoizedState = arg1.memoizedState

    if __DEV__ and debugRenderPhaseSideEffectsForStrictMode and bit32.band(arg1.mode, StrictMode) ~= 0 then
        disableLogs()

        local success, result = xpcall(callback, describeError, arg3, memoizedState)

        reenableLogs()

        if not success then
            error(result)
        end
    end

    local var8 = callback(arg3, memoizedState)

    if __DEV__ then
        warnOnUndefinedDerivedState(arg2, var8)
    end

    if enableAllocationTrims then
        if var8 ~= nil then
            if type(memoizedState) == "table" and getmetatable(memoizedState) == nil then
                memoizedState = Object.assign(table.clone(memoizedState), var8)
            else
                memoizedState = Object.assign({}, memoizedState, var8)
            end
        end
    elseif var8 ~= nil then
        memoizedState = Object.assign({}, memoizedState, var8)
    end
    arg1.memoizedState = memoizedState

    if arg1.lanes == NoLanes then
        arg1.updateQueue.baseState = memoizedState
    end
end

local var8 = nil
local function initializeClassComponentUpdater()
    local reactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])
    local requestEventTime = reactFiberWorkLoopNew.requestEventTime
    local requestUpdateLane = reactFiberWorkLoopNew.requestUpdateLane
    local scheduleUpdateOnFiber = reactFiberWorkLoopNew.scheduleUpdateOnFiber

    var8 = {
        isMounted = isMounted,
        enqueueSetState = function(arg1, arg2, func1: ((...any) -> (...any))?)
            local var9 = get(arg1)
            local var10 = requestEventTime()
            local var11 = requestUpdateLane(var9)

            local update = createUpdate(var10, var11, arg2, func1)

            if func1 ~= nil and __DEV__ then
                warnOnInvalidCallback(func1, "setState")
            end

            enqueueUpdate(var9, update)
            scheduleUpdateOnFiber(var9, var11, var10)

            if __DEV__ and enableDebugTracing and bit32.band(var9.mode, DebugTracingMode) ~= 0 then
                local componentName = getComponentName(var9.type) or "Unknown"
                logStateUpdateScheduled(componentName, var11, arg2)
            end

            if enableSchedulingProfiler then
                markStateUpdateScheduled(var9, var11)
            end
        end,
        enqueueReplaceState = function(arg1, arg2, arg3)
            local var9 = get(arg1)
            local var10 = requestEventTime()
            local var11 = requestUpdateLane(var9)

            local update = createUpdate(var10, var11, arg2, arg3)
            update.tag = ReplaceState

            if arg3 ~= nil and __DEV__ then
                warnOnInvalidCallback(arg3, "replaceState")
            end

            enqueueUpdate(var9, update)
            scheduleUpdateOnFiber(var9, var11, var10)

            if __DEV__ and enableDebugTracing and bit32.band(var9.mode, DebugTracingMode) ~= 0 then
                local componentName = getComponentName(var9.type) or "Unknown"
                logStateUpdateScheduled(componentName, var11, arg2)
            end

            if enableSchedulingProfiler then
                markStateUpdateScheduled(var9, var11)
            end
        end,
        enqueueForceUpdate = function(arg1, arg2)
            local var9 = get(arg1)
            local var10 = requestEventTime()
            local var11 = requestUpdateLane(var9)

            local update = createUpdate(var10, var11, nil, arg2)
            update.tag = ForceUpdate

            if arg2 ~= nil and __DEV__ then
                warnOnInvalidCallback(arg2, "forceUpdate")
            end

            enqueueUpdate(var9, update)
            scheduleUpdateOnFiber(var9, var11, var10)

            if __DEV__ and enableDebugTracing and bit32.band(var9.mode, DebugTracingMode) ~= 0 then
                local componentName = getComponentName(var9.type) or "Unknown"
                logForceUpdateScheduled(componentName, var11)
            end

            if enableSchedulingProfiler then
                markForceUpdateScheduled(var9, var11)
            end
        end
    }
end

local function getClassComponentUpdater() -- Luacid: Inlined by compiler; 4 call sites recovered
    if var8 == nil then
        initializeClassComponentUpdater()
    end
    return var8
end

function checkShouldComponentUpdate(arg1, arg2, arg3, arg4, memoizedState, arg5, arg6): boolean
    local stateNode = arg1.stateNode

    if stateNode.shouldComponentUpdate == nil or type(stateNode.shouldComponentUpdate) ~= "function" then
        return not (type(arg2) == "table" and arg2.isPureReactComponent)
            or not (shallowEqual(arg3, arg4) and shallowEqual(memoizedState, arg5))
    end

    if __DEV__ and debugRenderPhaseSideEffectsForStrictMode and bit32.band(arg1.mode, StrictMode) ~= 0 then
        disableLogs()

        local success, result = xpcall(stateNode.shouldComponentUpdate, describeError, stateNode, arg4, arg5, arg6)

        reenableLogs()
        if not success then
            error(result)
        end
    end

    local var9 = stateNode:shouldComponentUpdate(arg4, arg5, arg6)

    if __DEV__ and var9 == nil then
        console.error(
            "%s.shouldComponentUpdate(): Returned nil instead of a boolean value. Make sure to return true or false.",
            getComponentName(arg2) or "Component"
        )
    end

    return var9
end

local function checkClassInstance(arg1, arg2, props)
    local stateNode = arg1.stateNode
    if not __DEV__ then
        return
    end

    local componentName = getComponentName(arg2) or "Component"
    if not stateNode.render then
        if type(arg2.render) == "function" then
            console.error(
                "%s(...): No `render` method found on the returned component instance: did you accidentally return an object from the constructor?",
                componentName
            )
        else
            console.error(
                "%s(...): No `render` method found on the returned component instance: you may have forgotten to define `render`.",
                componentName
            )
        end
    end

    if stateNode.getInitialState and not (stateNode.getInitialState.isReactClassApproved or stateNode.state) then
        console.error(
            "getInitialState was defined on %s, a plain JavaScript class. This is only supported for classes created using React.createClass. Did you mean to define a state property instead?",
            componentName
        )
    end

    if stateNode.getDefaultProps and not stateNode.getDefaultProps.isReactClassApproved then
        console.error(
            "getDefaultProps was defined on %s, a plain JavaScript class. This is only supported for classes created using React.createClass. Use a static property to define defaultProps instead.",
            componentName
        )
    end

    if stateNode.propTypes and not arg2.propTypes then
        console.error(
            "propTypes was defined as an instance property on %s. Use a static property to define propTypes instead.",
            componentName
        )
    end

    if stateNode.contextType and not arg2.contextType then
        console.error(
            "contextType was defined as an instance property on %s. Use a static property to define contextType instead.",
            componentName
        )
    end

    if disableLegacyContext then
        if arg2.childContextTypes then
            console.error(
                "%s uses the legacy childContextTypes API which is no longer supported. Use React.createContext() instead.",
                componentName
            )
        end

        if arg2.contextTypes then
            console.error(
                "%s uses the legacy contextTypes API which is no longer supported. Use React.createContext() with static contextType instead.",
                componentName
            )
        end
    else
        if stateNode.contextTypes and not arg2.contextTypes then
            console.error(
                "contextTypes was defined as an instance property on %s. Use a static property to define contextTypes instead.",
                componentName
            )
        end

        if type(arg2) == "table" and arg2.contextType and arg2.contextTypes and not var6[arg2] then
            var6[arg2] = true
            console.error(
                "%s declares both contextTypes and contextType static properties. The legacy contextTypes property will be ignored.",
                componentName
            )
        end
    end

    if type(stateNode.componentShouldUpdate) == "function" then
        console.error(
            "%s has a method called componentShouldUpdate(). Did you mean shouldComponentUpdate()? The name is phrased as a question because the function is expected to return a value.",
            componentName
        )
    end

    if type(arg2) == "table" and arg2.isPureReactComponent and stateNode.shouldComponentUpdate ~= nil then
        console.error(
            "%s has a method called shouldComponentUpdate(). shouldComponentUpdate should not be used when extending React.PureComponent. Please extend React.Component if shouldComponentUpdate is used.",
            getComponentName(arg2) or "A pure component"
        )
    end
    if type(stateNode.componentDidUnmount) == "function" then
        console.error(
            "%s has a method called componentDidUnmount(). But there is no such lifecycle method. Did you mean componentWillUnmount()?",
            componentName
        )
    end

    if type(stateNode.componentDidReceiveProps) == "function" then
        console.error(
            "%s has a method called componentDidReceiveProps(). But there is no such lifecycle method. If you meant to update the state in response to changing props, use componentWillReceiveProps(). If you meant to fetch data or run side-effects or mutations after React has updated the UI, use componentDidUpdate().",
            componentName
        )
    end

    if type(stateNode.componentWillRecieveProps) == "function" then
        console.error(
            "%s has a method called componentWillRecieveProps(). Did you mean componentWillReceiveProps()?",
            componentName
        )
    end

    if type(stateNode.UNSAFE_componentWillRecieveProps) == "function" then
        console.error(
            "%s has a method called UNSAFE_componentWillRecieveProps(). Did you mean UNSAFE_componentWillReceiveProps()?",
            componentName
        )
    end

    local bool1 = stateNode.props ~= props
    if stateNode.props ~= nil and bool1 then
        console.error(
            "%s(...): When calling super() in `%s`, make sure to pass up the same props that your component's constructor was passed.",
            componentName,
            componentName
        )
    end

    if rawget(stateNode, "defaultProps") then
        console.error(
            "Setting defaultProps as an instance property on %s is not supported and will be ignored. Instead, define defaultProps as a static property on %s.",
            componentName,
            componentName
        )
    end

    if type(stateNode.getSnapshotBeforeUpdate) == "function"
        and type(stateNode.componentDidUpdate) ~= "function"
        and not var3[arg2]
    then
        var3[arg2] = true
        console.error(
            "%s: getSnapshotBeforeUpdate() should be used with componentDidUpdate(). This component defines getSnapshotBeforeUpdate() only.",
            getComponentName(arg2)
        )
    end

    local state = stateNode.state

    if state ~= nil and type(state) ~= "table" then
        console.error("%s.state: must be set to an object or nil", componentName)
    end

    if type(arg2) == "table" and type(stateNode.getChildContext) == "function" and type(arg2.childContextTypes) ~= "table" then
        console.error(
            "%s.getChildContext(): childContextTypes must be defined in order to use getChildContext().",
            componentName
        )
    end
end

local function adoptClassInstance(arg1, stateNode) -- Luacid: Inlined by compiler; 1 call site recovered
    stateNode.__updater = getClassComponentUpdater()
    arg1.stateNode = stateNode

    set(stateNode, arg1)
    if __DEV__ then
        stateNode._reactInternalInstance = _reactInternalInstance
    end
end

local function constructClassInstance(arg1, arg2, arg3)
    local bool1 = false
    local var9 = emptyContextObject
    local var10 = emptyContextObject
    local contextType = arg2.contextType

    if __DEV__ and arg2.contextType ~= nil then
        local bool2 = contextType == nil or contextType["$$typeof"] == REACT_CONTEXT_TYPE and contextType._context == nil

        if not (bool2 or var7[arg2]) then
            var7[arg2] = true

            local str1 = ""
            local var11

            if contextType == nil then
                var11 = " However, it is set to nil. This can be caused by a typo or by mixing up named and default imports. This can also happen due to a circular dependency, so try moving the createContext() call to a separate file."
            elseif type(contextType) ~= "table" then
                var11 = " However, it is set to a " .. type(contextType) .. "."
            elseif contextType["$$typeof"] == REACT_PROVIDER_TYPE then
                var11 = " Did you accidentally pass the Context.Provider instead?"
            elseif contextType._context == nil then
                local str2 = str1 .. " However, it is set to an object with keys {"
                for value, _ in contextType do
                    str2 ..= value .. ", "
                end
                var11 = str2 .. "}."
            else
                var11 = " Did you accidentally pass the Context.Consumer instead?"
            end
            console.error(
                "%s defines an invalid contextType. contextType should point to the Context object returned by React.createContext().%s",
                getComponentName(arg2) or "Component",
                var11
            )
        end
    end

    if contextType ~= nil and type(contextType) == "table" then
        var10 = readContext(contextType)
    elseif not disableLegacyContext then
        var9 = getUnmaskedContext(arg1, arg2, true)
        bool1 = arg2.contextTypes ~= nil
        var10 = bool1 and getMaskedContext(arg1, var9) or emptyContextObject
    end

    if __DEV__ and debugRenderPhaseSideEffectsForStrictMode and bit32.band(arg1.mode, StrictMode) ~= 0 then
        disableLogs()

        local success, result = xpcall(arg2.__ctor, describeError, arg3, var10)

        reenableLogs()

        if not success then
            error(result)
        end
    end

    local stateNode = arg2.__ctor(arg3, var10)

    arg1.memoizedState = stateNode.state
    local memoizedState = arg1.memoizedState
    adoptClassInstance(arg1, stateNode)

    if __DEV__ then
        if type(arg2.getDerivedStateFromProps) == "function" and memoizedState == UninitializedState then
            local componentName = getComponentName(arg2) or "Component"
            if not var2[componentName] then
                var2[componentName] = true

                console.error(
                    "`%s` uses `getDerivedStateFromProps` but its initial state has not been initialized. This is not recommended. Instead, define the initial state by passing an object to `self:setState` in the `init` method of `%s`. This ensures that `getDerivedStateFromProps` arguments have a consistent shape.",
                    componentName,
                    componentName
                )
            end
        end

        if type(arg2.getDerivedStateFromProps) == "function" or type(stateNode.getSnapshotBeforeUpdate) == "function" then
            local var11 = nil
            local var12 = nil
            local var13 = nil

            if type(stateNode.componentWillMount) == "function" then
                var11 = "componentWillMount"
            elseif type(stateNode.UNSAFE_componentWillMount) == "function" then
                var11 = "UNSAFE_componentWillMount"
            end

            if type(stateNode.componentWillReceiveProps) == "function" then
                var12 = "componentWillReceiveProps"
            elseif type(stateNode.UNSAFE_componentWillReceiveProps) == "function" then
                var12 = "UNSAFE_componentWillReceiveProps"
            end

            if type(stateNode.componentWillUpdate) == "function" then
                var13 = "componentWillUpdate"
            elseif type(stateNode.UNSAFE_componentWillUpdate) == "function" then
                var13 = "UNSAFE_componentWillUpdate"
            end

            if var11 ~= nil or var12 ~= nil or var13 ~= nil then
                local componentName = getComponentName(arg2) or "Component"

                local str1 = if type(arg2.getDerivedStateFromProps) == "function" then "getDerivedStateFromProps()" else "getSnapshotBeforeUpdate()"

                local lifecycles = if var11 == nil then "" else "\n  " .. tostring(var11)

                local str2 = if var12 == nil then "" else "\n  " .. tostring(var12)

                local str3 = if var13 == nil then "" else "\n  " .. tostring(var13)

                if not var4[componentName] then
                    var4[componentName] = true
                    console.error(
                        "Unsafe legacy lifecycles will not be called for components using new component APIs.\n\n%s uses %s but also contains the following legacy lifecycles:%s%s%s\n\nThe above lifecycles should be removed. Learn more about this warning here:\nhttps://reactjs.org/link/unsafe-component-lifecycles",
                        componentName,
                        str1,
                        lifecycles,
                        str2,
                        str3
                    )
                end
            end
        end
    end

    if bool1 then
        cacheContext(arg1, var9, var10)
    end

    return stateNode
end

local function callComponentWillMount(arg1, stateNode)
    local state = stateNode.state

    if stateNode.componentWillMount ~= nil and type(stateNode.componentWillMount) == "function" then
        stateNode:componentWillMount()
    end

    if stateNode.UNSAFE_componentWillMount ~= nil and type(stateNode.UNSAFE_componentWillMount) == "function" then
        stateNode:UNSAFE_componentWillMount()
    end

    if state == stateNode.state then
        return
    end

    if __DEV__ then
        console.error(
            "%s.componentWillMount(): Assigning directly to this.state is deprecated (except inside a component's constructor). Use setState instead.",
            getComponentName(arg1.type) or "Component"
        )
    end
    getClassComponentUpdater().enqueueReplaceState(stateNode, stateNode.state)
end

function callComponentWillReceiveProps(arg1, stateNode, arg2, arg3)
    local state = stateNode.state

    if stateNode.componentWillReceiveProps ~= nil and type(stateNode.componentWillReceiveProps) == "function" then
        stateNode:componentWillReceiveProps(arg2, arg3)
    end

    if stateNode.UNSAFE_componentWillReceiveProps ~= nil and type(stateNode.UNSAFE_componentWillReceiveProps) == "function" then
        stateNode:UNSAFE_componentWillReceiveProps(arg2, arg3)
    end

    if stateNode.state == state then
        return
    end

    if __DEV__ then
        local componentName = getComponentName(arg1.type) or "Component"
        if not var1[componentName] then
            var1[componentName] = true
            console.error(
                "%s.componentWillReceiveProps(): Assigning directly to this.state is deprecated (except inside a component's constructor). Use setState instead.",
                componentName
            )
        end
    end

    getClassComponentUpdater().enqueueReplaceState(stateNode, stateNode.state)
end

local function mountClassInstance(arg1, arg2, props, arg3)
    if __DEV__ then
        checkClassInstance(arg1, arg2, props)
    end

    local stateNode = arg1.stateNode
    stateNode.props = props
    stateNode.state = arg1.memoizedState

    stateNode.__refs = __refs

    initializeUpdateQueue(arg1)
    local contextType = if type(arg2) == "table" then arg2.contextType else nil

    if contextType ~= nil and type(contextType) == "table" then
        stateNode.context = readContext(contextType)
    elseif disableLegacyContext then
        stateNode.context = emptyContextObject
    else
        local unmaskedContext = getUnmaskedContext(arg1, arg2, true)
        stateNode.context = getMaskedContext(arg1, unmaskedContext)
    end

    if __DEV__ then
        if stateNode.state == props then
            local componentName = getComponentName(arg2) or "Component"
            if not var5[componentName] then
                var5[componentName] = true
                console.error(
                    "%s: It is not recommended to assign props directly to state because updates to props won't be reflected in state. In most cases, it is better to use props directly.",
                    componentName
                )
            end
        end

        if bit32.band(arg1.mode, StrictMode) ~= 0 then
            ReactStrictModeWarningsNew.recordLegacyContextWarning(arg1, stateNode)
        end

        if warnAboutDeprecatedLifecycles then
            ReactStrictModeWarningsNew.recordUnsafeLifecycleWarnings(arg1, stateNode)
        end
    end

    processUpdateQueue(arg1, props, stateNode, arg3)
    stateNode.state = arg1.memoizedState

    local str1 = type(arg2)
    local getDerivedStateFromProps = if type(arg2) == "table" then arg2.getDerivedStateFromProps else nil

    if getDerivedStateFromProps ~= nil and type(getDerivedStateFromProps) == "function" then
        applyDerivedStateFromProps(arg1, arg2, getDerivedStateFromProps, props)

        stateNode.state = arg1.memoizedState
    end

    if str1 == "table"
        and type(arg2.getDerivedStateFromProps) ~= "function"
        and type(stateNode.getSnapshotBeforeUpdate) ~= "function"
        and (type(stateNode.UNSAFE_componentWillMount) == "function" or type(stateNode.componentWillMount) == "function")
    then
        callComponentWillMount(arg1, stateNode)

        processUpdateQueue(arg1, props, stateNode, arg3)
        stateNode.state = arg1.memoizedState
    end

    if type(stateNode.componentDidMount) ~= "function" then
        return
    end

    if __DEV__ and enableDoubleInvokingEffects then
        arg1.flags = bit32.bor(arg1.flags, bit32.bor(MountLayoutDev, Update))
        return
    end
    arg1.flags = bit32.bor(arg1.flags, Update)
end

function resumeMountClassInstance(arg1, arg2, arg3, arg4): boolean
    local stateNode = arg1.stateNode

    local memoizedProps = arg1.memoizedProps
    stateNode.props = memoizedProps

    local context = stateNode.context
    local contextType = arg2.contextType
    local var9 = emptyContextObject

    if contextType ~= nil and type(contextType) == "table" then
        var9 = readContext(contextType)
    elseif not disableLegacyContext then
        local unmaskedContext = getUnmaskedContext(arg1, arg2, true)
        var9 = getMaskedContext(arg1, unmaskedContext)
    end

    local getDerivedStateFromProps = arg2.getDerivedStateFromProps
    local bool1 = type(getDerivedStateFromProps) == "function" or type(stateNode.getSnapshotBeforeUpdate) == "function"

    if not bool1
        and (type(stateNode.UNSAFE_componentWillReceiveProps) == "function"
            or type(stateNode.componentWillReceiveProps) == "function")
        and (memoizedProps ~= arg3 or context ~= var9)
    then
        callComponentWillReceiveProps(arg1, stateNode, arg3, var9)
    end

    resetHasForceUpdateBeforeProcessing()

    local memoizedState = arg1.memoizedState
    stateNode.state = memoizedState

    processUpdateQueue(arg1, arg3, stateNode, arg4)
    local memoizedState2 = arg1.memoizedState
    if memoizedProps == arg3
        and memoizedState == memoizedState2
        and not (hasContextChanged() or checkHasForceUpdateAfterProcessing())
    then
        if type(stateNode.componentDidMount) == "function" then
            if __DEV__ and enableDoubleInvokingEffects then
                arg1.flags = bit32.bor(arg1.flags, MountLayoutDev, Update)
            else
                arg1.flags = bit32.bor(arg1.flags, Update)
            end
        end
        return false
    end

    if getDerivedStateFromProps ~= nil and type(getDerivedStateFromProps) == "function" then
        applyDerivedStateFromProps(arg1, arg2, getDerivedStateFromProps, arg3)

        memoizedState2 = arg1.memoizedState
    end

    local var10 = checkHasForceUpdateAfterProcessing()
        or checkShouldComponentUpdate(arg1, arg2, memoizedProps, arg3, memoizedState, memoizedState2, var9)

    if var10 then
        if not bool1
            and (type(stateNode.UNSAFE_componentWillMount) == "function" or type(stateNode.componentWillMount) == "function")
        then
            if type(stateNode.componentWillMount) == "function" then
                stateNode:componentWillMount()
            end
            if type(stateNode.UNSAFE_componentWillMount) == "function" then
                stateNode:UNSAFE_componentWillMount()
            end
        end
        if type(stateNode.componentDidMount) == "function" then
            if __DEV__ and enableDoubleInvokingEffects then
                arg1.flags = bit32.bor(arg1.flags, MountLayoutDev, Update)
            else
                arg1.flags = bit32.bor(arg1.flags, Update)
            end
        end
    else
        if type(stateNode.componentDidMount) == "function" then
            if __DEV__ and enableDoubleInvokingEffects then
                arg1.flags = bit32.bor(arg1.flags, MountLayoutDev, Update)
            else
                arg1.flags = bit32.bor(arg1.flags, Update)
            end
        end

        arg1.memoizedProps = arg3
        arg1.memoizedState = memoizedState2
    end

    stateNode.props = arg3
    stateNode.state = memoizedState2
    stateNode.context = var9

    return var10
end

return {
    adoptClassInstance = adoptClassInstance,
    constructClassInstance = constructClassInstance,
    mountClassInstance = mountClassInstance,
    resumeMountClassInstance = resumeMountClassInstance,
    updateClassInstance = function(arg1, arg2, arg3, arg4, arg5): boolean
        local stateNode = arg2.stateNode

        cloneUpdateQueue(arg1, arg2)

        local memoizedProps = arg2.memoizedProps
        local props = if arg2.type == arg2.elementType then memoizedProps else resolveDefaultProps(arg2.type, memoizedProps)
        stateNode.props = props
        local pendingProps = arg2.pendingProps

        local context = stateNode.context
        local contextType, getDerivedStateFromProps

        if type(arg3) == "table" then
            contextType = arg3.contextType
            getDerivedStateFromProps = arg3.getDerivedStateFromProps
        else
            contextType = nil
            getDerivedStateFromProps = nil
        end
        local var10 = emptyContextObject
        if type(contextType) == "table" then
            var10 = readContext(contextType)
        elseif not disableLegacyContext then
            local unmaskedContext = getUnmaskedContext(arg2, arg3, true)
            var10 = getMaskedContext(arg2, unmaskedContext)
        end

        local bool1 = getDerivedStateFromProps ~= nil and type(getDerivedStateFromProps) == "function"
            or not (stateNode.getSnapshotBeforeUpdate == nil) and type(stateNode.getSnapshotBeforeUpdate) == "function"

        if not bool1
            and (stateNode.UNSAFE_componentWillReceiveProps ~= nil and type(stateNode.UNSAFE_componentWillReceiveProps) == "function"
                or stateNode.componentWillReceiveProps ~= nil and type(stateNode.componentWillReceiveProps) == "function")
            and (memoizedProps ~= pendingProps or context ~= var10)
        then
            callComponentWillReceiveProps(arg2, stateNode, arg4, var10)
        end

        resetHasForceUpdateBeforeProcessing()

        local memoizedState = arg2.memoizedState
        stateNode.state = memoizedState
        local _state = stateNode.state
        processUpdateQueue(arg2, arg4, stateNode, arg5)
        local memoizedState2 = arg2.memoizedState

        if memoizedProps == pendingProps
            and memoizedState == memoizedState2
            and not (hasContextChanged() or checkHasForceUpdateAfterProcessing())
        then
            if stateNode.componentDidUpdate ~= nil
                and type(stateNode.componentDidUpdate) == "function"
                and (memoizedProps ~= arg1.memoizedProps or memoizedState ~= arg1.memoizedState)
            then
                arg2.flags = bit32.bor(arg2.flags, Update)
            end

            if stateNode.getSnapshotBeforeUpdate ~= nil
                and type(stateNode.getSnapshotBeforeUpdate) == "function"
                and (memoizedProps ~= arg1.memoizedProps or memoizedState ~= arg1.memoizedState)
            then
                arg2.flags = bit32.bor(arg2.flags, Snapshot)
            end

            return false
        end

        if getDerivedStateFromProps ~= nil and type(getDerivedStateFromProps) == "function" then
            applyDerivedStateFromProps(arg2, arg3, getDerivedStateFromProps, arg4)

            memoizedState2 = arg2.memoizedState
        end

        local var11 = checkHasForceUpdateAfterProcessing()
            or checkShouldComponentUpdate(arg2, arg3, props, arg4, memoizedState, memoizedState2, var10)

        if var11 then
            if not bool1
                and (stateNode.UNSAFE_componentWillUpdate ~= nil and type(stateNode.UNSAFE_componentWillUpdate) == "function"
                    or stateNode.componentWillUpdate ~= nil and type(stateNode.componentWillUpdate) == "function")
            then
                if stateNode.componentWillUpdate ~= nil and type(stateNode.componentWillUpdate) == "function" then
                    stateNode:componentWillUpdate(arg4, memoizedState2, var10)
                end

                if stateNode.UNSAFE_componentWillUpdate ~= nil and type(stateNode.UNSAFE_componentWillUpdate) == "function" then
                    stateNode:UNSAFE_componentWillUpdate(arg4, memoizedState2, var10)
                end
            end

            if stateNode.componentDidUpdate ~= nil and type(stateNode.componentDidUpdate) == "function" then
                arg2.flags = bit32.bor(arg2.flags, Update)
            end

            if stateNode.getSnapshotBeforeUpdate ~= nil and type(stateNode.getSnapshotBeforeUpdate) == "function" then
                arg2.flags = bit32.bor(arg2.flags, Snapshot)
            end
        else
            if stateNode.componentDidUpdate ~= nil
                and type(stateNode.componentDidUpdate) == "function"
                and (memoizedProps ~= arg1.memoizedProps or memoizedState ~= arg1.memoizedState)
            then
                arg2.flags = bit32.bor(arg2.flags, Update)
            end

            if stateNode.getSnapshotBeforeUpdate ~= nil
                and type(stateNode.getSnapshotBeforeUpdate) == "function"
                and (memoizedProps ~= arg1.memoizedProps or memoizedState ~= arg1.memoizedState)
            then
                arg2.flags = bit32.bor(arg2.flags, Snapshot)
            end

            arg2.memoizedProps = arg4
            arg2.memoizedState = memoizedState2
        end

        stateNode.props = arg4
        stateNode.state = memoizedState2
        stateNode.context = var10

        return var11
    end,
    applyDerivedStateFromProps = applyDerivedStateFromProps,
    emptyRefsObject = __refs
}
