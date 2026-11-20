-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local _ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local _ReactFiberSuspenseComponentNew = require(script.Parent["ReactFiberSuspenseComponent.new"])

local invariant = require(scriptParentParent.Shared).invariant

local get = require(scriptParentParent.Shared).ReactInstanceMap.get
local ReactSharedInternals = require(scriptParentParent.Shared).ReactSharedInternals
local getComponentName = require(scriptParentParent.Shared).getComponentName
local ReactWorkTags = require(script.Parent.ReactWorkTags)
local ClassComponent = ReactWorkTags.ClassComponent
local HostComponent = ReactWorkTags.HostComponent
local HostRoot = ReactWorkTags.HostRoot
local HostPortal = ReactWorkTags.HostPortal
local HostText = ReactWorkTags.HostText
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local NoFlags = ReactFiberFlags.NoFlags
local Placement = ReactFiberFlags.Placement
local Hydrating = ReactFiberFlags.Hydrating

local enableFundamentalAPI = require(scriptParentParent.Shared).ReactFeatureFlags.enableFundamentalAPI

local ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner

local module = {}

local function getNearestMountedFiber(arg1)
    local _return

    if arg1.alternate then
        _return = arg1

        while arg1.return_ do
            arg1 = arg1.return_
        end
    else
        _return = arg1

        while true do
            if bit32.band(arg1.flags, bit32.bor(Placement, Hydrating)) ~= NoFlags then
                _return = arg1.return_
            end
            local _return2 = arg1.return_
            if not _return2 then
                break
            end

            arg1 = _return2
        end
    end
    return if arg1.tag == HostRoot then _return else nil
end
module.getNearestMountedFiber = getNearestMountedFiber

function module.getSuspenseInstanceFromFiber(arg1)
    if arg1.tag == SuspenseComponent then
        local memoizedState = arg1.memoizedState
        if memoizedState == nil then
            local alternate = arg1.alternate
            if alternate ~= nil then
                memoizedState = alternate.memoizedState
            end
        end
        if memoizedState then
            return memoizedState.dehydrated
        end
    end
    return nil
end

function module.getContainerFromFiber(arg1)
    return if arg1.tag == HostRoot then arg1.stateNode.containerInfo else nil
end

function module.isFiberMounted(arg1): boolean
    return getNearestMountedFiber(arg1) == arg1
end

function module.isMounted(arg1): boolean
    if ReactGlobals.__DEV__ then
        local current = ReactCurrentOwner.current
        if current ~= nil and current.tag == ClassComponent then
            local stateNode = current.stateNode
            if not stateNode._warnedAboutRefsInRender then
                console.error(
                    "%s is accessing isMounted inside its render() function. render() should be a pure function of props and state. It should never access something that requires stale data from the previous render, such as refs. Move this logic to componentDidMount and componentDidUpdate instead.",
                    getComponentName(current.type) or "A component"
                )
            end
            stateNode._warnedAboutRefsInRender = true
        end
    end

    local var1 = get(arg1)
    return if var1 then getNearestMountedFiber(var1) == var1 else false
end

local function assertIsMounted(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    invariant(getNearestMountedFiber(arg1) == arg1, "Unable to find node on an unmounted component.")
end

local function findCurrentFiberUsingSlowPath(arg1)
    local alternate = arg1.alternate
    if not alternate then
        local nearestMountedFiber = getNearestMountedFiber(arg1)
        invariant(nearestMountedFiber ~= nil, "Unable to find node on an unmounted component.")
        return if nearestMountedFiber == arg1 then arg1 else nil
    end

    local var1 = alternate
    local var2 = arg1

    while true do
        local _return = arg1.return_
        if _return == nil then
            break
        end

        local alternate2 = _return.alternate
        if alternate2 == nil then
            _return = _return.return_
            if _return == nil then
                break
            end

            alternate2 = _return
        else
            if _return.child == alternate2.child then
                local child = _return.child
                while child do
                    if child == arg1 then
                        assertIsMounted(_return)
                        return var2
                    end
                    if child == alternate then
                        assertIsMounted(_return)
                        return var1
                    end
                    child = child.sibling
                end

                invariant(false, "Unable to find node on an unmounted component.")
            end

            if arg1.return_ == alternate.return_ then
                local child = _return.child
                local bool1 = false

                while child do
                    if child == arg1 then
                        alternate = alternate2
                        arg1 = _return
                        bool1 = true
                        break
                    end

                    if child == alternate then
                        alternate = _return
                        arg1 = alternate2
                        bool1 = true
                        break
                    end

                    child = child.sibling
                end
                if bool1 then
                    alternate2 = alternate
                    _return = arg1
                else
                    local child2 = alternate2.child

                    while true do
                        if not child2 then
                            alternate2 = alternate
                            _return = arg1
                            break
                        end

                        if child2 == arg1 then
                            local var3 = alternate2
                            alternate2 = _return
                            _return = var3
                            bool1 = true
                            break
                        end

                        if child2 == alternate then
                            bool1 = true
                            break
                        end

                        child2 = child2.sibling
                    end
                    invariant(
                        bool1,
                        "Child was not found in either parent set. This indicates a bug in React related to the return pointer. Please file an issue."
                    )
                end
            end

            invariant(
                _return.alternate == alternate2,
                "Return fibers should always be each others' alternates. This error is likely caused by a bug in React. Please file an issue."
            )
        end

        alternate = alternate2
        arg1 = _return
    end

    invariant(arg1.tag == HostRoot, "Unable to find node on an unmounted component.")
    return if arg1.stateNode.current == arg1 then var2 else var1
end
module.findCurrentFiberUsingSlowPath = findCurrentFiberUsingSlowPath

function module.findCurrentHostFiber(arg1)
    local currentFiberUsingSlowPath = findCurrentFiberUsingSlowPath(arg1)
    if not currentFiberUsingSlowPath then
        return nil
    end

    local var1 = currentFiberUsingSlowPath

    while true do
        local child = currentFiberUsingSlowPath.child
        if currentFiberUsingSlowPath.tag == HostComponent or currentFiberUsingSlowPath.tag == HostText then
            break
        end
        if child then
            child.return_ = currentFiberUsingSlowPath
        else
            if currentFiberUsingSlowPath == var1 then
                return nil
            end
            local _return = currentFiberUsingSlowPath.return_
            child = currentFiberUsingSlowPath.sibling
            while not child do
                if not _return or _return == var1 then
                    return nil
                end
            end

            child.return_ = _return
        end

        currentFiberUsingSlowPath = child
    end

    return currentFiberUsingSlowPath
end

function module.findCurrentHostFiberWithNoPortals(arg1)
    local currentFiberUsingSlowPath = findCurrentFiberUsingSlowPath(arg1)
    if not currentFiberUsingSlowPath then
        return nil
    end

    local var1 = currentFiberUsingSlowPath

    while true do
        local child = currentFiberUsingSlowPath.child

        if currentFiberUsingSlowPath.tag == HostComponent
            or currentFiberUsingSlowPath.tag == HostText
            or enableFundamentalAPI and currentFiberUsingSlowPath.tag == FundamentalComponent
        then
            break
        end

        if child and currentFiberUsingSlowPath.tag ~= HostPortal then
            child.return_ = currentFiberUsingSlowPath
            currentFiberUsingSlowPath = child
        else
            if currentFiberUsingSlowPath == var1 then
                return nil
            end
            local _return = currentFiberUsingSlowPath.return_
            currentFiberUsingSlowPath = currentFiberUsingSlowPath.sibling
            while not currentFiberUsingSlowPath do
                if not _return or _return == var1 then
                    return nil
                end
            end

            currentFiberUsingSlowPath.return_ = _return
        end
    end

    return currentFiberUsingSlowPath
end

function module.isFiberSuspenseAndTimedOut(arg1): boolean
    local memoizedState = arg1.memoizedState

    return arg1.tag == SuspenseComponent and memoizedState ~= nil and memoizedState.dehydrated == nil
end

function module.doesFiberContain(arg1, arg2)
    local alternate = arg1.alternate
    while arg2 ~= nil do
        if arg2 == arg1 or arg2 == alternate then
            return true
        end

        arg2 = arg2.return_
    end
    return false
end

return module
