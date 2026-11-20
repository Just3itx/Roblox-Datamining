-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Number = LuauPolyfill.Number
local Error = LuauPolyfill.Error

local console = require(scriptParentParent.Shared).console

local enableAllocationTrims = require(scriptParentParent.Shared).ReactFeatureFlags.enableAllocationTrims

local _Shared = require(scriptParentParent.Shared)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberStackNew = require(script.Parent["ReactFiberStack.new"])

local ReactFiberLane = require(script.Parent.ReactFiberLane)

local ReactUpdateQueueNew = require(script.Parent["ReactUpdateQueue.new"])

local isPrimaryRenderer = require(script.Parent.ReactFiberHostConfig).isPrimaryRenderer
local createCursor = ReactFiberStackNew.createCursor
local push = ReactFiberStackNew.push
local pop = ReactFiberStackNew.pop
local MAX_SIGNED_31_BIT_INT = require(script.Parent.MaxInts).MAX_SIGNED_31_BIT_INT
local ReactWorkTags = require(script.Parent.ReactWorkTags)
local ContextProvider = ReactWorkTags.ContextProvider
local ClassComponent = ReactWorkTags.ClassComponent

local NoLanes = ReactFiberLane.NoLanes
local NoTimestamp = ReactFiberLane.NoTimestamp
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes
local includesSomeLane = ReactFiberLane.includesSomeLane
local mergeLanes = ReactFiberLane.mergeLanes
local pickArbitraryLane = ReactFiberLane.pickArbitraryLane

local objectIs = require(scriptParentParent.Shared).objectIs
local createUpdate = ReactUpdateQueueNew.createUpdate
local ForceUpdate = ReactUpdateQueueNew.ForceUpdate

local module = {}

local cursor = createCursor(nil)

local var1 = nil
var1 = ReactGlobals.__DEV__ and {} or var1

local var2 = nil
local var3 = nil
local currentContext = nil

local bool1 = false

function module.resetContextDependencies()
    var2 = nil
    var3 = nil
    currentContext = nil
    if ReactGlobals.__DEV__ then
        bool1 = false
    end
end

function module.enterDisallowedContextReadInDEV()
    if ReactGlobals.__DEV__ then
        bool1 = true
    end
end

function module.exitDisallowedContextReadInDEV()
    if ReactGlobals.__DEV__ then
        bool1 = false
    end
end

function module.pushProvider(arg1, arg2)
    local _context = arg1.type._context

    if isPrimaryRenderer then
        push(cursor, _context._currentValue, arg1)

        _context._currentValue = arg2
        if ReactGlobals.__DEV__ then
            if _context._currentRenderer ~= nil and _context._currentRenderer ~= var1 then
                console.error(
                    "Detected multiple renderers concurrently rendering the same context provider. This is currently unsupported."
                )
            end

            _context._currentRenderer = var1
        end
    else
        push(cursor, _context._currentValue2, arg1)

        _context._currentValue2 = arg2
        if ReactGlobals.__DEV__ then
            if _context._currentRenderer2 ~= nil and _context._currentRenderer2 ~= var1 then
                console.error(
                    "Detected multiple renderers concurrently rendering the same context provider. This is currently unsupported."
                )
            end

            _context._currentRenderer2 = var1
        end
    end
end

function module.popProvider(arg1)
    local current = cursor.current

    pop(cursor, arg1)

    local _context = arg1.type._context
    if isPrimaryRenderer then
        _context._currentValue = current
        return
    end
    _context._currentValue2 = current
end

function module.calculateChangedBits(arg1, arg2, arg3): number
    if objectIs(arg3, arg2) then
        return 0
    end

    local var4 = MAX_SIGNED_31_BIT_INT
    if typeof(arg1._calculateChangedBits) == "function" then
        var4 = arg1._calculateChangedBits(arg3, arg2)
    end

    return math.floor(var4)
end

function module.scheduleWorkOnParentPath(arg1, arg2)
    while arg1 ~= nil do
        local alternate = arg1.alternate
        if not isSubsetOfLanes(arg1.childLanes, arg2) then
            arg1.childLanes = mergeLanes(arg1.childLanes, arg2)
            if alternate ~= nil then
                alternate.childLanes = mergeLanes(alternate.childLanes, arg2)
            end
        else
            if alternate == nil or isSubsetOfLanes(alternate.childLanes, arg2) then
                break
            end
            alternate.childLanes = mergeLanes(alternate.childLanes, arg2)
        end

        arg1 = arg1.return_
    end
end

function module.propagateContextChange(_return, context, num1: number, arg1)
    local child = _return.child
    if child ~= nil then
        child.return_ = _return
    end

    while true do
        if child == nil then
            return
        end

        local dependencies = child.dependencies
        local var4

        if dependencies ~= nil then
            var4 = child.child

            local firstContext = dependencies.firstContext

            while firstContext ~= nil do
                if firstContext.context == context and bit32.band(firstContext.observedBits, num1) ~= 0 then
                    if child.tag == ClassComponent then
                        local update = createUpdate(NoTimestamp, pickArbitraryLane(arg1))
                        update.tag = ForceUpdate

                        local updateQueue = child.updateQueue
                        if updateQueue ~= nil then
                            local shared = updateQueue.shared
                            local pending = shared.pending
                            if pending == nil then
                                update.next = update
                            else
                                update.next = pending.next
                                pending.next = update
                            end
                            shared.pending = update
                        end
                    end

                    local lanes = child.lanes
                    child.lanes = bit32.bor(lanes, arg1)
                    local alternate = child.alternate
                    if alternate ~= nil then
                        alternate.lanes = bit32.bor(alternate.lanes, arg1)
                    end
                    module.scheduleWorkOnParentPath(child.return_, arg1)

                    dependencies.lanes = bit32.bor(dependencies.lanes, arg1)
                    break
                end

                firstContext = firstContext.next
            end
        elseif child.tag ~= ContextProvider then
            var4 = child.child
        elseif child.type == _return.type then
            var4 = nil
        else
            var4 = child.child
        end

        if var4 ~= nil then
            var4.return_ = child
        else
            while true do
                if child == nil then
                    var4 = child
                    break
                end

                if child == _return then
                    var4 = nil
                    break
                end

                var4 = child.sibling
                if var4 ~= nil then
                    var4.return_ = child.return_
                    break
                end

                child = child.return_
            end
        end

        child = var4
    end
end

function module.prepareToReadContext(arg1, arg2, callback: (...any) -> (...any))
    var2 = arg1
    var3 = nil
    currentContext = nil

    local dependencies = arg1.dependencies
    if dependencies == nil or dependencies.firstContext == nil then
        return
    end

    if includesSomeLane(dependencies.lanes, arg2) then
        callback()
    end

    dependencies.firstContext = nil
end

function module.readContext(context, observedBits)
    if ReactGlobals.__DEV__ and bool1 then
        console.error(
            "Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()."
        )
    end

    if currentContext ~= context and observedBits ~= false and observedBits ~= 0 then
        if typeof(observedBits) ~= "number" or observedBits == Number.MAX_SAFE_INTEGER then
            currentContext = context
            observedBits = Number.MAX_SAFE_INTEGER
        end

        local var4 = enableAllocationTrims and { context = context, observedBits = observedBits }
            or { context = context, observedBits = observedBits, next = nil }

        if var3 == nil then
            if var2 == nil then
                error(
                    Error.new(
                        "Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()."
                    )
                )
            end

            var3 = var4
            if enableAllocationTrims then
                local dependencies = var2.dependencies
                if dependencies ~= nil then
                    dependencies.lanes = NoLanes
                    dependencies.firstContext = var4
                else
                    var2.dependencies = { lanes = NoLanes, firstContext = var4 }
                end
            else
                var2.dependencies = { lanes = NoLanes, firstContext = var4, responders = nil }
            end
        else
            var3.next = var4
            var3 = var4
        end
    end
    return if isPrimaryRenderer then context._currentValue else context._currentValue2
end

return module
