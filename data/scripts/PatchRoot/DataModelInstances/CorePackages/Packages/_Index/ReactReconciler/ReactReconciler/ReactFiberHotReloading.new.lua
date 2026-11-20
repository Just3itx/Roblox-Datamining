-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local Set = LuauPolyfill.Set

local _Shared = require(scriptParentParent.Shared)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local _ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local ReactFiberLane = require(script.Parent.ReactFiberLane)
local SyncLane = ReactFiberLane.SyncLane
local NoTimestamp = ReactFiberLane.NoTimestamp
local ReactWorkTags = require(script.Parent.ReactWorkTags)
local ClassComponent = ReactWorkTags.ClassComponent
local FunctionComponent = ReactWorkTags.FunctionComponent
local ForwardRef = ReactWorkTags.ForwardRef
local HostComponent = ReactWorkTags.HostComponent
local HostPortal = ReactWorkTags.HostPortal
local HostRoot = ReactWorkTags.HostRoot
local MemoComponent = ReactWorkTags.MemoComponent
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE

local __DEV__ = ReactGlobals.__DEV__

local var1 = nil

local var2 = nil

local module = {}

local findChildHostInstancesForFiberShallowly = nil
local findHostInstancesForFiberShallowly = nil
local findHostInstancesForMatchingFibersRecursively = nil
local scheduleFibersWithFamiliesRecursively = nil

function module.setRefreshHandler(func1: ((...any) -> (...any))?)
    if __DEV__ then
        var1 = func1
    end
end

local function resolveFunctionForHotReloading(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not __DEV__ then
        return arg1
    end

    if var1 == nil then
        return arg1
    end
    local var3 = var1(arg1)
    return if var3 == nil then arg1 else var3.current
end

module.resolveFunctionForHotReloading = resolveFunctionForHotReloading

function module.resolveClassForHotReloading(arg1)
    return resolveFunctionForHotReloading(arg1)
end

function module.resolveForwardRefForHotReloading(arg1)
    if not __DEV__ then
        return arg1
    end

    if var1 == nil then
        return arg1
    end
    local var3 = var1(arg1)
    if var3 ~= nil then
        return var3.current
    end

    if arg1 ~= nil and typeof(arg1.render) == "function" then
        local render = resolveFunctionForHotReloading(arg1.render)
        if arg1.render ~= render then
            local tbl1 = {
                ["$$typeof"] = REACT_FORWARD_REF_TYPE,
                render = render,
                displayName = nil
            }
            if arg1.displayName ~= nil then
                tbl1.displayName = arg1.displayName
            end
            return tbl1
        end
    end
    return arg1
end

function module.isCompatibleFamilyForHotReloading(arg1, arg2)
    if not __DEV__ then
        return false
    end

    if var1 == nil then
        return false
    end

    local elementType = arg1.elementType
    local type = arg2.type

    local bool1 = false
    local typeof2 = if typeof(type) == "table" and type ~= nil then type["$$typeof"] else nil
    local tag = arg1.tag
    if tag == ClassComponent then
        if typeof(type) == "function" then
            bool1 = true
        end
    elseif tag == FunctionComponent then
        if typeof(type) == "function" or typeof2 == REACT_LAZY_TYPE then
            bool1 = true
        end
    elseif tag ~= ForwardRef then
        if tag ~= MemoComponent and tag ~= SimpleMemoComponent then
            return false
        end

        if typeof2 == REACT_MEMO_TYPE or typeof2 == REACT_LAZY_TYPE then
            bool1 = true
        end
    elseif typeof2 == REACT_FORWARD_REF_TYPE or typeof2 == REACT_LAZY_TYPE then
        bool1 = true
    end

    if bool1 then
        local var3 = var1(elementType)
        if var3 ~= nil and var3 == var1(type) then
            return true
        end
    end
    return false
end

function module.markFailedErrorBoundaryForHotReloading(arg1)
    if not __DEV__ then
        return
    end

    if var1 == nil then
        return
    end

    if var2 == nil then
        var2 = Set.new()
    end

    var2:add(arg1)
end

function module.scheduleRefresh(arg1, tbl1)
    if not __DEV__ then
        return
    end

    if var1 == nil then
        return
    end

    local staleFamilies = tbl1.staleFamilies
    local updatedFamilies = tbl1.updatedFamilies
    local reactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])
    local flushPassiveEffects = reactFiberWorkLoopNew.flushPassiveEffects
    local flushSync = reactFiberWorkLoopNew.flushSync
    flushPassiveEffects()
    flushSync(function()
        scheduleFibersWithFamiliesRecursively(arg1.current, updatedFamilies, staleFamilies)
    end)
end

function module.scheduleRoot(arg1, arg2)
    if not __DEV__ then
        return
    end
    local emptyContextObject = require(script.Parent["ReactFiberContext.new"]).emptyContextObject
    if arg1.context ~= emptyContextObject then
        return
    end
    local reactFiberWorkLoopNew = require(script.Parent["ReactFiberWorkLoop.new"])
    local flushPassiveEffects = reactFiberWorkLoopNew.flushPassiveEffects
    local flushSync = reactFiberWorkLoopNew.flushSync
    flushPassiveEffects()
    flushSync(function()
        require(script.Parent["ReactFiberReconciler.new"]).updateContainer(arg2, arg1, nil, nil)
    end)
end

scheduleFibersWithFamiliesRecursively = function(arg1, arg2, arg3)
    if not __DEV__ then
        return
    end
    local alternate = arg1.alternate
    local child = arg1.child
    local sibling = arg1.sibling
    local tag = arg1.tag
    local type = arg1.type
    local render = nil

    if tag == FunctionComponent or tag == SimpleMemoComponent or tag == ClassComponent then
        render = type
    elseif tag == ForwardRef then
        render = type.render
    end

    if var1 == nil then
        error(Error.new("Expected resolveFamily to be set during hot reload."))
    end
    local bool1 = false
    local bool2 = false
    if render ~= nil then
        local var3 = var1(render)
        if var3 ~= nil then
            if arg3:has(var3) then
                bool2 = true
            elseif arg2:has(var3) then
                if tag == ClassComponent then
                    bool2 = true
                else
                    bool1 = true
                end
            end
        end
    end

    if var2 ~= nil and (var2:has(arg1) or alternate ~= nil and var2:has(alternate)) then
        bool2 = true
    end

    if bool2 then
        arg1._debugNeedsRemount = true
    end
    if bool2 or bool1 then
        require(script.Parent["ReactFiberWorkLoop.new"]).scheduleUpdateOnFiber(arg1, SyncLane, NoTimestamp)
    end
    if child ~= nil and not bool2 then
        scheduleFibersWithFamiliesRecursively(child, arg2, arg3)
    end
    if sibling ~= nil then
        scheduleFibersWithFamiliesRecursively(sibling, arg2, arg3)
    end
end

function module.findHostInstancesForRefresh(arg1, arg2)
    if not __DEV__ then
        error(Error.new("Did not expect findHostInstancesForRefresh to be called in production."))
        return
    end

    local set = Set.new()
    local set2 = Set.new(Array.map(arg2, function(arg3)
        return arg3.current
    end))
    findHostInstancesForMatchingFibersRecursively(arg1.current, set2, set)
    return set
end

findHostInstancesForMatchingFibersRecursively = function(arg1, arg2, arg3)
    if not __DEV__ then
        return
    end
    local child = arg1.child
    local sibling = arg1.sibling
    local tag = arg1.tag
    local type = arg1.type
    local render = nil

    if tag == FunctionComponent or tag == SimpleMemoComponent or tag == ClassComponent then
        render = type
    elseif tag == ForwardRef then
        render = type.render
    end

    if render ~= nil and arg2:has(render) then
        findHostInstancesForFiberShallowly(arg1, arg3)
    elseif child ~= nil then
        findHostInstancesForMatchingFibersRecursively(child, arg2, arg3)
    end

    if sibling ~= nil then
        findHostInstancesForMatchingFibersRecursively(sibling, arg2, arg3)
    end
end

findHostInstancesForFiberShallowly = function(arg1, arg2)
    if not __DEV__ then
        return
    end

    if findChildHostInstancesForFiberShallowly(arg1, arg2) then
        return
    end

    while true do
        local tag = arg1.tag
        if tag == HostComponent then
            break
        end

        if tag == HostPortal then
            arg2:add(arg1.stateNode.containerInfo)
            return
        end

        if tag == HostRoot then
            arg2:add(arg1.stateNode.containerInfo)
            return
        end
        if arg1.return_ == nil then
            error(Error.new("Expected to reach root first."))
        end
        arg1 = arg1.return_
    end

    arg2:add(arg1.stateNode)
end

findChildHostInstancesForFiberShallowly = function(arg1, arg2)
    if not __DEV__ then
        return false
    end

    local var3 = arg1
    local bool1 = false

    while true do
        if arg1.tag == HostComponent then
            arg2:add(arg1.stateNode)
            bool1 = true
        elseif arg1.child ~= nil then
            arg1.child.return_ = arg1
            arg1 = arg1.child
            continue
        end

        if arg1 == var3 then
            return bool1
        end
        while arg1.sibling == nil do
            if arg1.return_ == nil or arg1.return_ == var3 then
                return bool1
            end
            arg1 = arg1.return_
        end

        assert(arg1.sibling ~= nil, "should be non-nil")
        arg1.sibling.return_ = arg1.return_
        arg1 = arg1.sibling
    end
end
return module
