-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local Object = require(scriptParentParent.LuauPolyfill).Object

local __DEV__ = ReactGlobals.__DEV__
local __YOLO__ = ReactGlobals.__YOLO__

local console = require(scriptParentParent.Shared).console

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberLane = require(script.Parent.ReactFiberLane)
local NoLane = ReactFiberLane.NoLane
local NoLanes = ReactFiberLane.NoLanes
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes
local mergeLanes = ReactFiberLane.mergeLanes

local var1 = nil

local function enterDisallowedContextReadInDEV() -- Luacid: Inlined by compiler; 2 call sites recovered
    var1 = var1 or require(script.Parent["ReactFiberNewContext.new"])

    var1.enterDisallowedContextReadInDEV()
end

local function exitDisallowedContextReadInDEV() -- Luacid: Inlined by compiler; 2 call sites recovered
    var1 = var1 or require(script.Parent["ReactFiberNewContext.new"])

    var1.exitDisallowedContextReadInDEV()
end
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local Callback = ReactFiberFlags.Callback
local ShouldCapture = ReactFiberFlags.ShouldCapture
local DidCapture = ReactFiberFlags.DidCapture

local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags

local debugRenderPhaseSideEffectsForStrictMode = ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode
local enableAllocationTrims = ReactFeatureFlags.enableAllocationTrims

local StrictMode = require(script.Parent.ReactTypeOfMode).StrictMode

local markSkippedUpdateLanes = require(script.Parent.ReactFiberWorkInProgress).markSkippedUpdateLanes

local describeError = require(scriptParentParent.Shared).describeError

local ConsolePatchingDev = require(scriptParentParent.Shared).ConsolePatchingDev
local disableLogs = ConsolePatchingDev.disableLogs
local reenableLogs = ConsolePatchingDev.reenableLogs

local module = { UpdateState = 0, ReplaceState = 1, ForceUpdate = 2, CaptureUpdate = 3 }

local checkHasForceUpdateAfterProcessing = false

local bool2 = nil
local shared = nil

if __DEV__ then
    bool2 = false
    shared = nil
    function module.resetCurrentlyProcessingQueue()
        shared = nil
    end
end

local var2 = table.create(210)
local num1 = 210
for i = 1, 210 do
    var2[i] = { eventTime = -1, lane = -1, tag = -1, payload = nil, callback = nil, next = nil }
end

function module.initializeUpdateQueue(arg1)
    arg1.updateQueue = {
        baseState = arg1.memoizedState,
        firstBaseUpdate = nil,
        lastBaseUpdate = nil,
        shared = { pending = nil },
        effects = nil
    }
end

function module.cloneUpdateQueue(arg1, arg2)
    local updateQueue = arg2.updateQueue
    local updateQueue2 = arg1.updateQueue
    if updateQueue == updateQueue2 then
        arg2.updateQueue = table.clone(updateQueue2)
    end
end

function module.createUpdate(eventTime: number, lane, payload, callback: ((...any) -> (...any))?)
    if not (num1 > 0) then
        return {
            eventTime = eventTime,
            lane = lane,
            tag = 0,
            payload = payload,
            callback = callback,
            next = nil
        }
    end

    local var3 = var2[num1]
    var2[num1] = nil
    num1 -= 1

    var3.eventTime = eventTime
    var3.lane = lane
    var3.tag = 0
    var3.payload = payload
    var3.callback = callback

    return var3
end

function module.enqueueUpdate(arg1, arg2)
    local updateQueue = arg1.updateQueue
    if updateQueue == nil then
        return
    end

    local shared2 = updateQueue.shared
    local pending = shared2.pending
    if pending == nil then
        arg2.next = arg2
    else
        arg2.next = pending.next
        pending.next = arg2
    end
    shared2.pending = arg2

    if __DEV__ and shared == shared2 and not bool2 then
        console.error(
            "An update (setState, replaceState, or forceUpdate) was scheduled from inside an update function. Update functions should be pure, with zero side-effects. Consider using componentDidUpdate or a callback."
        )

        bool2 = true
    end
end

function module.enqueueCapturedUpdate(arg1, arg2)
    local updateQueue = arg1.updateQueue

    local alternate = arg1.alternate
    if alternate ~= nil then
        local updateQueue2 = alternate.updateQueue
        if updateQueue == updateQueue2 then
            local firstBaseUpdate = updateQueue.firstBaseUpdate
            local var3

            if firstBaseUpdate == nil then
                var3 = arg2
            else
                local var4 = nil
                var3 = nil
                local tbl1

                while true do
                    tbl1 = {
                        eventTime = firstBaseUpdate.eventTime,
                        lane = firstBaseUpdate.lane,
                        tag = firstBaseUpdate.tag,
                        payload = firstBaseUpdate.payload,
                        callback = firstBaseUpdate.callback,
                        next = nil
                    }

                    if var4 == nil then
                        var3 = tbl1
                    else
                        var4.next = tbl1
                    end

                    firstBaseUpdate = firstBaseUpdate.next
                    if firstBaseUpdate == nil then
                        break
                    end

                    var4 = tbl1
                end

                if tbl1 == nil then
                    var3 = arg2
                else
                    tbl1.next = arg2
                end
            end

            arg1.updateQueue = {
                baseState = updateQueue2.baseState,
                firstBaseUpdate = var3,
                lastBaseUpdate = arg2,
                shared = updateQueue2.shared,
                effects = updateQueue2.effects
            }
            return
        end
    end

    local lastBaseUpdate = updateQueue.lastBaseUpdate
    if lastBaseUpdate == nil then
        updateQueue.firstBaseUpdate = arg2
    else
        lastBaseUpdate.next = arg2
    end
    updateQueue.lastBaseUpdate = arg2
end

local function getStateFromUpdate(arg1, _, arg2, arg3, arg4, _)
    local tag = arg2.tag
    if tag == 1 then
        local payload = arg2.payload
        if type(payload) ~= "function" then
            return payload
        end

        if __DEV__ then
            enterDisallowedContextReadInDEV()
        end

        local var3 = payload(arg3, arg4)
        if __DEV__ then
            if debugRenderPhaseSideEffectsForStrictMode and bit32.band(arg1.mode, StrictMode) ~= 0 then
                disableLogs()

                local result = nil
                local success

                if not __YOLO__ then
                    success, result = xpcall(payload, describeError, arg3, arg4)
                else
                    payload(arg3, arg4)
                    success = true
                end

                reenableLogs()

                if not success then
                    error(result)
                end
            end

            exitDisallowedContextReadInDEV()
        end

        return var3
    end

    if tag ~= 3 and tag ~= 0 then
        if tag ~= 2 then
            return arg3
        end

        checkHasForceUpdateAfterProcessing = true
        return arg3
    end

    if tag == 3 then
        arg1.flags = bit32.bor(bit32.band(arg1.flags, bit32.bnot(ShouldCapture)), DidCapture)
    end

    local payload = arg2.payload
    local var3

    if type(payload) == "function" then
        if __DEV__ then
            enterDisallowedContextReadInDEV()
        end

        var3 = payload(arg3, arg4)
        if __DEV__ then
            if debugRenderPhaseSideEffectsForStrictMode and bit32.band(arg1.mode, StrictMode) ~= 0 then
                disableLogs()

                local result = nil
                local success

                if not __YOLO__ then
                    success, result = xpcall(payload, describeError, arg3, arg4)
                else
                    payload(arg3, arg4)
                    success = true
                end

                reenableLogs()

                if not success then
                    error(result)
                end
            end

            exitDisallowedContextReadInDEV()
        end
    else
        var3 = payload
    end

    if var3 == nil then
        return arg3
    end

    if not enableAllocationTrims then
        return Object.assign({}, arg3, var3)
    end

    local var4 = if type(arg3) == "table" and getmetatable(arg3) == nil then table.clone(arg3) else Object.assign({}, arg3)
    return Object.assign(var4, var3)
end
module.getStateFromUpdate = getStateFromUpdate

function module.processUpdateQueue(arg1, arg2, arg3, arg4)
    local updateQueue = arg1.updateQueue

    checkHasForceUpdateAfterProcessing = false

    if __DEV__ then
        shared = updateQueue.shared
    end

    local firstBaseUpdate = updateQueue.firstBaseUpdate
    local lastBaseUpdate = updateQueue.lastBaseUpdate

    local pending = updateQueue.shared.pending
    if pending ~= nil then
        updateQueue.shared.pending = nil

        local next = pending.next
        pending.next = nil

        if lastBaseUpdate == nil then
            firstBaseUpdate = next
        else
            lastBaseUpdate.next = next
        end

        local alternate = arg1.alternate
        if alternate ~= nil then
            local updateQueue2 = alternate.updateQueue
            local lastBaseUpdate2 = updateQueue2.lastBaseUpdate
            if lastBaseUpdate2 ~= pending then
                if lastBaseUpdate2 == nil then
                    updateQueue2.firstBaseUpdate = next
                else
                    lastBaseUpdate2.next = next
                end
                updateQueue2.lastBaseUpdate = pending
            end
        end
    end

    if firstBaseUpdate ~= nil then
        local baseState = updateQueue.baseState

        local var3 = NoLanes
        local var4 = nil
        local var5 = nil
        local var6 = nil
        local tbl1

        while true do
            local lane = firstBaseUpdate.lane
            local eventTime = firstBaseUpdate.eventTime
            if not isSubsetOfLanes(arg4, lane) then
                tbl1 = {
                    eventTime = eventTime,
                    lane = lane,
                    tag = firstBaseUpdate.tag,
                    payload = firstBaseUpdate.payload,
                    callback = firstBaseUpdate.callback,
                    next = nil
                }

                if var4 == nil then
                    var6 = tbl1
                    var5 = baseState
                else
                    var4.next = tbl1
                end

                var3 = mergeLanes(var3, lane)
            else
                if var4 == nil then
                    tbl1 = var4
                else
                    tbl1 = {
                        eventTime = eventTime,
                        lane = NoLane,
                        tag = firstBaseUpdate.tag,
                        payload = firstBaseUpdate.payload,
                        callback = firstBaseUpdate.callback,
                        next = nil
                    }

                    var4.next = tbl1
                end

                baseState = getStateFromUpdate(arg1, updateQueue, firstBaseUpdate, baseState, arg2, arg3)

                if firstBaseUpdate.callback ~= nil and firstBaseUpdate.lane ~= NoLane then
                    arg1.flags = bit32.bor(arg1.flags, Callback)
                    local effects = updateQueue.effects
                    if effects == nil then
                        updateQueue.effects = { firstBaseUpdate }
                    else
                        table.insert(effects, firstBaseUpdate)
                    end
                end
            end

            firstBaseUpdate = firstBaseUpdate.next
            if firstBaseUpdate == nil then
                local pending2 = updateQueue.shared.pending
                if pending2 == nil then
                    break
                end

                firstBaseUpdate = pending2.next

                pending2.next = nil

                updateQueue.lastBaseUpdate = pending2
                updateQueue.shared.pending = nil
            end

            var4 = tbl1
        end

        if tbl1 == nil then
            var5 = baseState
        end

        updateQueue.baseState = var5
        updateQueue.firstBaseUpdate = var6
        updateQueue.lastBaseUpdate = tbl1

        markSkippedUpdateLanes(var3)
        arg1.lanes = var3
        arg1.memoizedState = baseState
    end

    if __DEV__ then
        shared = nil
    end
end

local function callCallback(received, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(received) ~= "function" then
        error(
            string.format("Invalid argument passed as callback. Expected a function. Instead received: %s", tostring(received))
        )
    end

    received(arg1)
end

function module.resetHasForceUpdateBeforeProcessing()
    checkHasForceUpdateAfterProcessing = false
end

function module.checkHasForceUpdateAfterProcessing()
    return checkHasForceUpdateAfterProcessing
end

function module.commitUpdateQueue(_, arg1, arg2)
    local effects = arg1.effects
    arg1.effects = nil
    if effects == nil then
        return
    end

    for _, effect in effects do
        local callback = effect.callback
        if callback ~= nil then
            callCallback(callback, arg2)
        end

        table.clear(effect)
        table.insert(var2, effect)
        num1 += 1
    end
end

return module
