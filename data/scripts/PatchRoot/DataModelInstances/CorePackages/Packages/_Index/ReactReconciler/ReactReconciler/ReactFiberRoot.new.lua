-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Set = LuauPolyfill.Set
local Map = LuauPolyfill.Map

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactRootTags = require(script.Parent.ReactRootTags)

local ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)
local noTimeout = ReactFiberHostConfig.noTimeout
local supportsHydration = ReactFiberHostConfig.supportsHydration
local createHostRootFiber = require(script.Parent["ReactFiber.new"]).createHostRootFiber
local ReactFiberLane = require(script.Parent.ReactFiberLane)
local NoLanes = ReactFiberLane.NoLanes
local NoLanePriority = ReactFiberLane.NoLanePriority
local NoTimestamp = ReactFiberLane.NoTimestamp
local createLaneMap = ReactFiberLane.createLaneMap
local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback

local unstable_getThreadID = require(scriptParentParent.Scheduler).tracing.unstable_getThreadID
local initializeUpdateQueue = require(script.Parent["ReactUpdateQueue.new"]).initializeUpdateQueue
local LegacyRoot = ReactRootTags.LegacyRoot
local BlockingRoot = ReactRootTags.BlockingRoot
local ConcurrentRoot = ReactRootTags.ConcurrentRoot

local module = {}

local function FiberRootNode(containerInfo, tag, hydrate: boolean)
    local tbl1 = {
        tag = tag,
        containerInfo = containerInfo,
        pendingChildren = nil,
        current = nil,
        pingCache = nil,
        finishedWork = nil,
        timeoutHandle = noTimeout,
        context = nil,
        pendingContext = nil,
        hydrate = hydrate,
        callbackNode = nil,
        callbackPriority = NoLanePriority,
        eventTimes = createLaneMap(NoLanes),
        expirationTimes = createLaneMap(NoTimestamp),
        pendingLanes = NoLanes,
        suspendedLanes = NoLanes,
        pingedLanes = NoLanes,
        expiredLanes = NoLanes,
        mutableReadLanes = NoLanes,
        finishedLanes = NoLanes,
        entangledLanes = NoLanes,
        entanglements = createLaneMap(NoLanes)
    }

    if supportsHydration then
        tbl1.mutableSourceEagerHydrationData = nil
    end

    if enableSchedulerTracing then
        tbl1.interactionThreadID = unstable_getThreadID()
        tbl1.memoizedInteractions = Set.new()
        tbl1.pendingInteractionMap = Map.new()
    end
    if enableSuspenseCallback then
        tbl1.hydrationCallbacks = nil
    end

    if ReactGlobals.__DEV__ then
        if tag == BlockingRoot then
            tbl1._debugRootType = "createBlockingRoot()"
            return tbl1
        end

        if tag == ConcurrentRoot then
            tbl1._debugRootType = "createRoot()"
            return tbl1
        end

        if tag == LegacyRoot then
            tbl1._debugRootType = "createLegacyRoot()"
        end
    end

    return tbl1
end

function module.createFiberRoot(containerInfo, tag, hydrate: boolean, hydrationCallbacks)
    local stateNode = FiberRootNode(containerInfo, tag, hydrate)
    if enableSuspenseCallback then
        stateNode.hydrationCallbacks = hydrationCallbacks
    end

    local current = createHostRootFiber(tag)
    stateNode.current = current
    current.stateNode = stateNode

    initializeUpdateQueue(current)

    return stateNode
end

return module
