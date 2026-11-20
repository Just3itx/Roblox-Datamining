-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local console = require(scriptParentParent.Shared).console

local ReactFiberSchedulerPrioritiesRoblox = require(script.Parent["ReactFiberSchedulerPriorities.roblox"])

local var1 = require(scriptParentParent.SafeFlags).createGetFFlag("ReactInlineMergeLanes")()

local invariant = require(scriptParentParent.Shared).invariant

local ImmediatePriority = ReactFiberSchedulerPrioritiesRoblox.ImmediatePriority
local UserBlockingPriority = ReactFiberSchedulerPrioritiesRoblox.UserBlockingPriority
local NormalPriority = ReactFiberSchedulerPrioritiesRoblox.NormalPriority
local LowPriority = ReactFiberSchedulerPrioritiesRoblox.LowPriority
local IdlePriority = ReactFiberSchedulerPrioritiesRoblox.IdlePriority
local NoPriority = ReactFiberSchedulerPrioritiesRoblox.NoPriority

local module = {
    SyncLanePriority = 15,
    SyncBatchedLanePriority = 14,
    InputDiscreteLanePriority = 12,
    InputContinuousLanePriority = 10,
    DefaultLanePriority = 8,
    TransitionPriority = 6,
    NoLanePriority = 0,
    NoLanes = 0,
    NoLane = 0,
    SyncLane = 1,
    SyncBatchedLane = 2,
    InputDiscreteHydrationLane = 4,
    DefaultHydrationLane = 256,
    DefaultLanes = 3584,
    RetryLanes = 62914560,
    SomeRetryLane = 33554432,
    SelectiveHydrationLane = 67108864,
    IdleHydrationLane = 134217728,
    OffscreenLane = 1073741824,
    NoTimestamp = -1
}
local NoLanePriority = module.NoLanePriority

function module.getCurrentUpdateLanePriority()
    return NoLanePriority
end

function module.setCurrentUpdateLanePriority(arg1)
    NoLanePriority = arg1
end

local DefaultLanePriority = module.DefaultLanePriority

local function getHighestPriorityLanes(num1: number): number
    if bit32.band(1, num1) ~= 0 then
        DefaultLanePriority = 15
        return 1
    end
    if bit32.band(2, num1) ~= 0 then
        DefaultLanePriority = 14
        return 2
    end
    if bit32.band(4, num1) ~= 0 then
        DefaultLanePriority = 13
        return 4
    end
    local num2 = bit32.band(0x18, num1)
    if num2 ~= 0 then
        DefaultLanePriority = 12
        return num2
    end
    if bit32.band(num1, 0x20) ~= 0 then
        DefaultLanePriority = 11
        return 32
    end
    local num3 = bit32.band(0xC0, num1)
    if num3 ~= 0 then
        DefaultLanePriority = 10
        return num3
    end
    if bit32.band(num1, 0x100) ~= 0 then
        DefaultLanePriority = 9
        return 256
    end
    local num4 = bit32.band(0xE00, num1)
    if num4 ~= 0 then
        DefaultLanePriority = 8
        return num4
    end
    if bit32.band(num1, 0x1000) ~= 0 then
        DefaultLanePriority = 7
        return 4096
    end
    local num5 = bit32.band(0x3FE000, num1)
    if num5 ~= 0 then
        DefaultLanePriority = 6
        return num5
    end
    local num6 = bit32.band(0x3C00000, num1)
    if num6 ~= 0 then
        DefaultLanePriority = 5
        return num6
    end
    if bit32.band(num1, 0x4000000) ~= 0 then
        DefaultLanePriority = 4
        return 67108864
    end
    if bit32.band(num1, 0x8000000) ~= 0 then
        DefaultLanePriority = 3
        return 134217728
    end
    local num7 = bit32.band(0x30000000, num1)
    if num7 ~= 0 then
        DefaultLanePriority = 2
        return num7
    end
    if bit32.band(0x40000000, num1) ~= 0 then
        DefaultLanePriority = 1
        return 1073741824
    end
    if ReactGlobals.__DEV__ then
        console.error("Should have found matching lanes. This is a bug in React.")
    end

    DefaultLanePriority = 8
    return num1
end

function module.schedulerPriorityToLanePriority(arg1): number
    if arg1 == ImmediatePriority then
        return 15
    end

    if arg1 == UserBlockingPriority then
        return 10
    end

    if arg1 == NormalPriority or arg1 == LowPriority then
        return 8
    end

    if arg1 == IdlePriority then
        return 2
    end

    return 0
end

function module.lanePriorityToSchedulerPriority(arg1)
    if arg1 == 15 or arg1 == 14 then
        return ImmediatePriority
    end

    if arg1 == 13 or arg1 == 12 or arg1 == 11 or arg1 == 10 then
        return UserBlockingPriority
    end

    if arg1 == 9 or arg1 == 8 or arg1 == 7 or arg1 == 6 or arg1 == 4 or arg1 == 5 then
        return NormalPriority
    end

    if arg1 == 3 or arg1 == 2 or arg1 == 1 then
        return IdlePriority
    end

    if arg1 == 0 then
        return NoPriority
    end
    invariant(false, "Invalid update priority: %s. This is a bug in React.", arg1)

    error("unreachable")
end

local pickArbitraryLaneIndex = nil
local getLowestPriorityLane = nil

function module.getNextLanes(arg1, arg2)
    local pendingLanes = arg1.pendingLanes
    if pendingLanes == 0 then
        DefaultLanePriority = 0
        return 0
    end

    local num1 = 0
    local num2 = 0

    local expiredLanes = arg1.expiredLanes
    local suspendedLanes = arg1.suspendedLanes
    local pingedLanes = arg1.pingedLanes

    if expiredLanes ~= 0 then
        DefaultLanePriority = 15
        num1 = expiredLanes
        num2 = 15
    else
        local num3 = bit32.band(pendingLanes, 0x7FFFFFF)
        if num3 ~= 0 then
            local num4 = bit32.band(num3, bit32.bnot(suspendedLanes))
            if num4 ~= 0 then
                num1 = getHighestPriorityLanes(num4)
                num2 = DefaultLanePriority
            else
                local num5 = bit32.band(num3, pingedLanes)
                if num5 ~= 0 then
                    num1 = getHighestPriorityLanes(num5)
                    num2 = DefaultLanePriority
                end
            end
        else
            local num4 = bit32.band(pendingLanes, bit32.bnot(suspendedLanes))
            if num4 ~= 0 then
                num1 = getHighestPriorityLanes(num4)
                num2 = DefaultLanePriority
            elseif pingedLanes ~= 0 then
                num1 = getHighestPriorityLanes(pingedLanes)
                num2 = DefaultLanePriority
            end
        end
    end

    if num1 == 0 then
        return 0
    end

    local num3 = bit32.band(pendingLanes, bit32.lshift(getLowestPriorityLane(num1), 1) - 1)

    if arg2 ~= 0 and arg2 ~= num3 and bit32.band(arg2, suspendedLanes) == 0 then
        getHighestPriorityLanes(arg2)
        if num2 <= DefaultLanePriority then
            return arg2
        end
        DefaultLanePriority = num2
    end

    local entangledLanes = arg1.entangledLanes
    if entangledLanes ~= 0 then
        local entanglements = arg1.entanglements
        local num4 = bit32.band(num3, entangledLanes)
        while num4 > 0 do
            local var2 = pickArbitraryLaneIndex(num4)
            local num5 = bit32.lshift(1, var2)

            num3 = bit32.bor(num3, entanglements[var2])

            num4 = bit32.band(num4, bit32.bnot(num5))
        end
    end

    return num3
end

function module.getMostRecentEventTime(arg1, arg2)
    local eventTimes = arg1.eventTimes
    local num1 = -1

    while arg2 > 0 do
        local var2 = pickArbitraryLaneIndex(arg2)
        local num2 = bit32.lshift(1, var2)

        local var3 = eventTimes[var2]
        if not (num1 < var3) then
            var3 = num1
        end

        arg2 = bit32.band(arg2, bit32.bnot(num2))
        num1 = var3
    end

    return num1
end

local function computeExpirationTime(arg1, num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    getHighestPriorityLanes(arg1)
    local num2 = DefaultLanePriority
    return if num2 >= 10 then num1 + 250 elseif num2 >= 6 then num1 + 5000 else -1
end

module.computeExpirationTime = computeExpirationTime

function module.markStarvedLanesAsExpired(arg1, num1: number)
    local pendingLanes = arg1.pendingLanes
    local suspendedLanes = arg1.suspendedLanes
    local pingedLanes = arg1.pingedLanes
    local expirationTimes = arg1.expirationTimes

    while pendingLanes > 0 do
        local var2 = pickArbitraryLaneIndex(pendingLanes)
        local num2 = bit32.lshift(1, var2)

        local var3 = expirationTimes[var2]
        if var3 == -1 then
            if bit32.band(num2, suspendedLanes) == 0 or bit32.band(num2, pingedLanes) ~= 0 then
                expirationTimes[var2] = computeExpirationTime(num2, num1)
            end
        elseif var3 <= num1 then
            arg1.expiredLanes = bit32.bor(arg1.expiredLanes, num2)
        end

        pendingLanes = bit32.band(pendingLanes, bit32.bnot(num2))
    end
end

function module.getHighestPriorityPendingLanes(arg1)
    return (getHighestPriorityLanes(arg1.pendingLanes))
end

function module.getLanesToRetrySynchronouslyOnError(arg1): number
    local num1 = bit32.band(arg1.pendingLanes, 0xBFFFFFFF)

    if num1 == 0 then
        if bit32.band(num1, 0x40000000) == 0 then
            return 0
        end

        return 1073741824
    end

    return num1
end

function module.returnNextLanesPriority()
    return DefaultLanePriority
end

function module.includesNonIdleWork(arg1): boolean
    return bit32.band(arg1, 0x7FFFFFF) ~= 0
end

function module.includesOnlyRetries(arg1): boolean
    return bit32.band(arg1, 0x3C00000) == arg1
end

function module.includesOnlyTransitions(arg1): boolean
    return bit32.band(arg1, 0x3FE000) == arg1
end

local pickArbitraryLane = nil

local function findUpdateLane(arg1, arg2)
    if arg1 ~= 0 then
        if arg1 == 15 then
            return 1
        elseif arg1 == 14 then
            return 2
        elseif arg1 == 12 then
            local var2 = pickArbitraryLane(bit32.band(0x18, bit32.bnot(arg2)))
            if var2 == 0 then
                return findUpdateLane(10, arg2)
            end
            return var2
        elseif arg1 == 10 then
            local var2 = pickArbitraryLane(bit32.band(0xC0, bit32.bnot(arg2)))
            if var2 == 0 then
                return findUpdateLane(8, arg2)
            end
            return var2
        elseif arg1 == 8 then
            local var2 = pickArbitraryLane(bit32.band(0xE00, bit32.bnot(arg2)))
            if var2 == 0 then
                var2 = pickArbitraryLane(bit32.band(0x3FE000, bit32.bnot(arg2)))
                if var2 == 0 then
                    var2 = pickArbitraryLane(3584)
                end
            end
            return var2
        end

        if arg1 ~= 6 and arg1 ~= 5 and arg1 == 2 then
            local var2 = pickArbitraryLane(bit32.band(0x30000000, bit32.bnot(arg2)))
            if var2 == 0 then
                var2 = pickArbitraryLane(805306368)
            end
            return var2
        end
    end

    invariant(false, "Invalid update priority: %s. This is a bug in React.", arg1)

    error("unreachable")
end
module.findUpdateLane = findUpdateLane

function module.findTransitionLane(arg1, arg2)
    local var2 = pickArbitraryLane(bit32.band(0x3FE000, bit32.bnot(arg2)))
    if var2 == 0 then
        var2 = pickArbitraryLane(bit32.band(0x3FE000, bit32.bnot(arg1)))
        if var2 == 0 then
            var2 = pickArbitraryLane(4186112)
        end
    end
    return var2
end

function module.findRetryLane(arg1)
    local var2 = pickArbitraryLane(bit32.band(0x3C00000, bit32.bnot(arg1)))
    if var2 == 0 then
        var2 = pickArbitraryLane(62914560)
    end
    return var2
end

local function getHighestPriorityLane(arg1): number -- Luacid: Inlined by compiler; 1 call site recovered
    return bit32.band(arg1, -arg1)
end

getLowestPriorityLane = function(arg1): number
    local num1 = 31 - bit32.countlz(arg1)
    if num1 < 0 then
        return 0
    end
    return bit32.lshift(1, num1)
end

local function getEqualOrHigherPriorityLanes(arg1): number -- Luacid: unused: defined but never referenced
    return bit32.lshift(getLowestPriorityLane(arg1), 1) - 1
end

pickArbitraryLane = function(arg1): number
    return getHighestPriorityLane(arg1)
end

module.pickArbitraryLane = pickArbitraryLane

pickArbitraryLaneIndex = function(arg1): number
    return 31 - bit32.countlz(arg1)
end

function module.includesSomeLane(arg1, arg2): boolean
    return bit32.band(arg1, arg2) ~= 0
end

function module.isSubsetOfLanes(arg1, arg2): boolean
    return bit32.band(arg1, arg2) == arg2
end

module.mergeLanes = not var1 and function(arg1, arg2): number -- name: mergeLanes
    return bit32.bor(arg1, arg2)
end or bit32.bor

function module.removeLanes(arg1, arg2): number
    return bit32.band(arg1, bit32.bnot(arg2))
end

function module.laneToLanes<T>(arg1: T): T
    return arg1
end

function module.higherPriorityLane(arg1, arg2)
    return if arg1 == 0 or arg2 == 0 then if arg1 == 0 then arg2 else arg1 elseif arg1 < arg2 then arg1 else arg2
end

function module.higherLanePriority(arg1, arg2)
    return if arg1 == 0 or not (arg2 < arg1) then arg2 else arg1
end

function module.createLaneMap<T>(arg1: T): {T}
    return {
        [0] = arg1,
        [1] = arg1,
        [2] = arg1,
        [3] = arg1,
        [4] = arg1,
        [5] = arg1,
        [6] = arg1,
        [7] = arg1,
        [8] = arg1,
        [9] = arg1,
        [10] = arg1,
        [11] = arg1,
        [12] = arg1,
        [13] = arg1,
        [14] = arg1,
        [15] = arg1,
        [16] = arg1,
        [17] = arg1,
        [18] = arg1,
        [19] = arg1,
        [20] = arg1,
        [21] = arg1,
        [22] = arg1,
        [23] = arg1,
        [24] = arg1,
        [25] = arg1,
        [26] = arg1,
        [27] = arg1,
        [28] = arg1,
        [29] = arg1,
        [30] = arg1,
        [31] = arg1
    }
end

function module.markRootUpdated(arg1, arg2, num1: number)
    arg1.pendingLanes = bit32.bor(arg1.pendingLanes, arg2)

    local var2 = arg2 - 1

    arg1.suspendedLanes = bit32.band(arg1.suspendedLanes, var2)
    arg1.pingedLanes = bit32.band(arg1.pingedLanes, var2)

    arg1.eventTimes[31 - bit32.countlz(arg2)] = num1
end

function module.markRootSuspended(arg1, arg2)
    arg1.suspendedLanes = bit32.bor(arg1.suspendedLanes, arg2)
    arg1.pingedLanes = bit32.band(arg1.pingedLanes, bit32.bnot(arg2))

    local expirationTimes = arg1.expirationTimes

    while arg2 > 0 do
        local num1 = pickArbitraryLaneIndex(arg2)
        local num2 = bit32.lshift(1, num1)

        expirationTimes[num1] = -1

        arg2 = bit32.band(arg2, bit32.bnot(num2))
    end
end

function module.markRootPinged(arg1, arg2, _: number)
    arg1.pingedLanes = bit32.bor(arg1.pingedLanes, bit32.band(arg1.suspendedLanes, arg2))
end

function module.markRootExpired(arg1, arg2)
    arg1.expiredLanes = bit32.bor(arg1.expiredLanes, bit32.band(arg2, arg1.pendingLanes))
end

function module.markDiscreteUpdatesExpired(arg1)
    arg1.expiredLanes = bit32.bor(arg1.expiredLanes, bit32.band(0x18, arg1.pendingLanes))
end

function module.hasDiscreteLanes(arg1): boolean
    return bit32.band(arg1, 0x18) ~= 0
end

function module.markRootMutableRead(arg1, arg2)
    arg1.mutableReadLanes = bit32.bor(arg1.mutableReadLanes, bit32.band(arg2, arg1.pendingLanes))
end

function module.markRootFinished(arg1, pendingLanes)
    local num1 = bit32.band(arg1.pendingLanes, bit32.bnot(pendingLanes))

    arg1.pendingLanes = pendingLanes

    arg1.suspendedLanes = 0
    arg1.pingedLanes = 0

    arg1.expiredLanes = bit32.band(arg1.expiredLanes, pendingLanes)
    arg1.mutableReadLanes = bit32.band(arg1.mutableReadLanes, pendingLanes)

    arg1.entangledLanes = bit32.band(arg1.entangledLanes, pendingLanes)

    local entanglements = arg1.entanglements
    local eventTimes = arg1.eventTimes
    local expirationTimes = arg1.expirationTimes

    while num1 > 0 do
        local num2 = pickArbitraryLaneIndex(num1)
        local num3 = bit32.lshift(1, num2)

        entanglements[num2] = 0
        eventTimes[num2] = -1
        expirationTimes[num2] = -1

        num1 = bit32.band(num1, bit32.bnot(num3))
    end
end

function module.markRootEntangled(arg1, arg2)
    arg1.entangledLanes = bit32.bor(arg1.entangledLanes, arg2)

    local entanglements = arg1.entanglements
    local var2 = arg2

    while arg2 > 0 do
        local num1 = pickArbitraryLaneIndex(arg2)
        local num2 = bit32.lshift(1, num1)

        entanglements[num1] = bit32.bor(entanglements[num1], var2)

        arg2 = bit32.band(arg2, bit32.bnot(num2))
    end
end

function module.getBumpedLaneForHydration(arg1, arg2)
    getHighestPriorityLanes(arg2)
    local num1 = DefaultLanePriority

    local var2 = nil

    if num1 == 15 or num1 == 14 then
        var2 = 0
    elseif num1 == 13 or num1 == 12 then
        var2 = 4
    elseif num1 == 11 or num1 == 10 then
        var2 = 32
    elseif num1 == 9 or num1 == 8 then
        var2 = 256
    elseif num1 == 7 or num1 == 6 or num1 == 5 then
        var2 = 4096
    elseif num1 == 4 then
        var2 = 67108864
    elseif num1 == 3 or num1 == 2 then
        var2 = 134217728
    elseif num1 == 1 or num1 == 0 then
        var2 = 0
    else
        invariant(false, "Invalid lane: %s. This is a bug in React.", tostring(var2))
    end

    return if bit32.band(var2, bit32.bor(arg1.suspendedLanes, arg2)) == 0 then var2 else 0
end
return module
