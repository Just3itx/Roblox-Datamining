-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console

local function unimplemented(str1: string) -- Luacid: unused: defined but never referenced
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: " .. str1)
    error("FIXME (roblox): " .. str1 .. " is unimplemented", 2)
end

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local _ReactFiberSuspenseComponentNew = require(script.Parent["ReactFiberSuspenseComponent.new"])

local ReactWorkTags = require(script.Parent.ReactWorkTags)
local HostComponent = ReactWorkTags.HostComponent
local HostText = ReactWorkTags.HostText
local HostRoot = ReactWorkTags.HostRoot
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local Placement = ReactFiberFlags.Placement
local Hydrating = ReactFiberFlags.Hydrating

local invariant = require(scriptParentParent.Shared).invariant

local createFiberFromDehydratedFragment = require(script.Parent["ReactFiber.new"]).createFiberFromDehydratedFragment

local supportsHydration = ReactFiberHostConfig.supportsHydration
local getNextHydratableSibling = ReactFiberHostConfig.getNextHydratableSibling
local getFirstHydratableChild = ReactFiberHostConfig.getFirstHydratableChild
local canHydrateInstance = ReactFiberHostConfig.canHydrateInstance
local canHydrateTextInstance = ReactFiberHostConfig.canHydrateTextInstance
local canHydrateSuspenseInstance = ReactFiberHostConfig.canHydrateSuspenseInstance
local hydrateInstance = ReactFiberHostConfig.hydrateInstance
local hydrateTextInstance = ReactFiberHostConfig.hydrateTextInstance
local hydrateSuspenseInstance = ReactFiberHostConfig.hydrateSuspenseInstance

local getNextHydratableInstanceAfterSuspenseInstance = ReactFiberHostConfig.getNextHydratableInstanceAfterSuspenseInstance

local didNotMatchHydratedContainerTextInstance = ReactFiberHostConfig.didNotMatchHydratedContainerTextInstance

local didNotMatchHydratedTextInstance = ReactFiberHostConfig.didNotMatchHydratedTextInstance
local shouldSetTextContent = ReactFiberHostConfig.shouldSetTextContent

local enableSuspenseServerRenderer = require(scriptParentParent.Shared).ReactFeatureFlags.enableSuspenseServerRenderer
local OffscreenLane = require(script.Parent.ReactFiberLane).OffscreenLane

local var1 = nil
local var2 = nil
local bool1 = false

function warnIfHydrating()
    if ReactGlobals.__DEV__ and bool1 then
        console.error("We should not be hydrating here. This is a bug in React. Please file a bug.")
    end
end

function enterHydrationState(arg1): boolean
    if not supportsHydration then
        return false
    end

    local containerInfo = arg1.stateNode.containerInfo
    var2 = getFirstHydratableChild(containerInfo)
    var1 = arg1
    bool1 = true
    return true
end

function reenterHydrationStateFromDehydratedSuspenseInstance(arg1, arg2): boolean
    if not supportsHydration then
        return false
    end

    var2 = getNextHydratableSibling(arg2)
    popToNextHostParent(arg1)
    bool1 = true
    return true
end

function deleteHydratableInstance(_, _)
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: deleteHydratableInstance")
    error("FIXME (roblox): deleteHydratableInstance is unimplemented", 2)
end

function insertNonHydratedInstance(_, arg1)
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: insertNonHydratedInstance")
    error("FIXME (roblox): insertNonHydratedInstance is unimplemented", 2)

    arg1.flags = bit32.bor(bit32.band(arg1.flags, bit32.bnot(Hydrating)), Placement)
    if ReactGlobals.__DEV__ then
    end
end

function tryHydrate(_return, arg1)
    if _return.tag == HostComponent then
        local type = _return.type
        local pendingProps = _return.pendingProps
        local stateNode = canHydrateInstance(arg1, type, pendingProps)
        if stateNode == nil then
            return false
        end

        _return.stateNode = stateNode
        return true
    end

    if _return.tag == HostText then
        local pendingProps = _return.pendingProps
        local stateNode = canHydrateTextInstance(arg1, pendingProps)
        if stateNode == nil then
            return false
        end

        _return.stateNode = stateNode
        return true
    end

    if _return.tag ~= SuspenseComponent then
        return false
    end

    if enableSuspenseServerRenderer then
        local dehydrated = canHydrateSuspenseInstance(arg1)
        if dehydrated ~= nil then
            _return.memoizedState = { dehydrated = dehydrated, retryLane = OffscreenLane }

            local child = createFiberFromDehydratedFragment(dehydrated)
            child.return_ = _return
            _return.child = child
            return true
        end
    end
    return false
end

function tryToClaimNextHydratableInstance(arg1)
    if not bool1 then
        return
    end
    local var3 = var2
    if not var3 then
        insertNonHydratedInstance(var1, arg1)
        bool1 = false
        var1 = arg1
        return
    end

    local nextHydratableSibling

    if tryHydrate(arg1, var3) then
        nextHydratableSibling = var3
    else
        nextHydratableSibling = getNextHydratableSibling(var3)
        if not (nextHydratableSibling and tryHydrate(arg1, nextHydratableSibling)) then
            insertNonHydratedInstance(var1, arg1)
            bool1 = false
            var1 = arg1
            return
        end

        deleteHydratableInstance(var1, var3)
    end
    var1 = arg1
    var2 = getFirstHydratableChild(nextHydratableSibling)
end

function prepareToHydrateHostInstance(arg1, arg2, arg3): boolean
    if not supportsHydration then
        invariant(
            false,
            "Expected prepareToHydrateHostInstance() to never be called. This error is likely caused by a bug in React. Please file an issue."
        )
    end

    local stateNode = arg1.stateNode
    local updateQueue = hydrateInstance(stateNode, arg1.type, arg1.memoizedProps, arg2, arg3, arg1)

    arg1.updateQueue = updateQueue

    return updateQueue ~= nil
end

function prepareToHydrateHostTextInstance(arg1)
    if not supportsHydration then
        invariant(
            false,
            "Expected prepareToHydrateHostTextInstance() to never be called. This error is likely caused by a bug in React. Please file an issue."
        )
    end

    local stateNode = arg1.stateNode
    local memoizedProps = arg1.memoizedProps
    local var3 = hydrateTextInstance(stateNode, memoizedProps, arg1)
    if ReactGlobals.__DEV__ and var3 then
        local var4 = var1
        if var4 ~= nil then
            if var4.tag == HostRoot then
                local containerInfo = var4.stateNode.containerInfo
                didNotMatchHydratedContainerTextInstance(containerInfo, stateNode, memoizedProps)
                return var3
            end

            if var4.tag == HostComponent then
                local type = var4.type
                local memoizedProps2 = var4.memoizedProps
                local stateNode2 = var4.stateNode
                didNotMatchHydratedTextInstance(type, memoizedProps2, stateNode2, stateNode, memoizedProps)
            end
        end
    end

    return var3
end

function prepareToHydrateHostSuspenseInstance(arg1)
    if not supportsHydration then
        invariant(
            false,
            "Expected prepareToHydrateHostSuspenseInstance() to never be called. This error is likely caused by a bug in React. Please file an issue."
        )
    end

    local memoizedState = arg1.memoizedState
    local dehydrated = if memoizedState == nil then nil else memoizedState.dehydrated
    invariant(
        dehydrated,
        "Expected to have a hydrated suspense instance. This error is likely caused by a bug in React. Please file an issue."
    )

    hydrateSuspenseInstance(dehydrated, arg1)
end

function skipPastDehydratedSuspenseInstance(arg1)
    if not supportsHydration then
        invariant(
            false,
            "Expected skipPastDehydratedSuspenseInstance() to never be called. This error is likely caused by a bug in React. Please file an issue."
        )
    end

    local memoizedState = arg1.memoizedState
    local dehydrated = if memoizedState == nil then nil else memoizedState.dehydrated
    invariant(
        dehydrated,
        "Expected to have a hydrated suspense instance. This error is likely caused by a bug in React. Please file an issue."
    )

    return getNextHydratableInstanceAfterSuspenseInstance(dehydrated)
end

function popToNextHostParent(arg1)
    local _return = arg1.return_

    while _return ~= nil and _return.tag ~= HostComponent and _return.tag ~= HostRoot and _return.tag ~= SuspenseComponent do
        _return = _return.return_
    end
    var1 = _return
end

function popHydrationState(arg1): boolean
    if not supportsHydration then
        return false
    end
    if arg1 ~= var1 then
        return false
    end
    if not bool1 then
        popToNextHostParent(arg1)
        bool1 = true
        return false
    end

    local type = arg1.type

    if arg1.tag ~= HostComponent or type ~= "head" and type ~= "body" and not shouldSetTextContent(type, arg1.memoizedProps) then
        local var3 = var2
        while var3 do
            deleteHydratableInstance(arg1, var3)
            var3 = getNextHydratableSibling(var3)
        end
    end

    popToNextHostParent(arg1)
    if arg1.tag == SuspenseComponent then
        var2 = skipPastDehydratedSuspenseInstance(arg1)
    elseif var1 then
        var2 = getNextHydratableSibling(arg1.stateNode)
    else
        var2 = nil
    end

    return true
end

function resetHydrationState()
    if not supportsHydration then
        return
    end

    var1 = nil
    var2 = nil
    bool1 = false
end

function getIsHydrating()
    return bool1
end

return {
    warnIfHydrating = warnIfHydrating,
    enterHydrationState = enterHydrationState,
    getIsHydrating = getIsHydrating,
    reenterHydrationStateFromDehydratedSuspenseInstance = reenterHydrationStateFromDehydratedSuspenseInstance,
    resetHydrationState = resetHydrationState,
    tryToClaimNextHydratableInstance = tryToClaimNextHydratableInstance,
    prepareToHydrateHostInstance = prepareToHydrateHostInstance,
    prepareToHydrateHostTextInstance = prepareToHydrateHostTextInstance,
    prepareToHydrateHostSuspenseInstance = prepareToHydrateHostSuspenseInstance,
    popHydrationState = popHydrationState
}
