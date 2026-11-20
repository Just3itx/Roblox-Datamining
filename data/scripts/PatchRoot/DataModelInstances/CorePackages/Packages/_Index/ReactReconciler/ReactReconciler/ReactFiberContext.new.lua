-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local Error = LuauPolyfill.Error

local __DEV__ = ReactGlobals.__DEV__

local __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ = ReactGlobals.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__

local console = require(scriptParentParent.Shared).console

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberStackNew = require(script.Parent["ReactFiberStack.new"])

local isFiberMounted = require(script.Parent.ReactFiberTreeReflection).isFiberMounted

local disableLegacyContext = require(scriptParentParent.Shared).ReactFeatureFlags.disableLegacyContext
local ReactWorkTags = require(script.Parent.ReactWorkTags)
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local getComponentName = require(scriptParentParent.Shared).getComponentName
local checkPropTypes = require(scriptParentParent.Shared).checkPropTypes

local createCursor = ReactFiberStackNew.createCursor
local push = ReactFiberStackNew.push
local pop = ReactFiberStackNew.pop

local var1 = nil

var1 = __DEV__ and {} or var1

local emptyContextObject = {}
if __DEV__ then
    Object.freeze(emptyContextObject)
end

local cursor = createCursor(emptyContextObject)

local cursor2 = createCursor(false)

local tbl2 = emptyContextObject

local isContextProvider = nil

local function getUnmaskedContext(_, arg1, bool1: boolean)
    return if bool1 and isContextProvider(arg1) then tbl2 else cursor.current
end

local function cacheContext(arg1, tbl3, tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
    local stateNode = arg1.stateNode
    stateNode.__reactInternalMemoizedUnmaskedChildContext = tbl3
    stateNode.__reactInternalMemoizedMaskedChildContext = tbl4
end

isContextProvider = function(arg1): boolean
    return not (type(arg1) == "function") and arg1.childContextTypes ~= nil
end

local function processChildContext(arg1, arg2, tbl3)
    local stateNode = arg1.stateNode
    local childContextTypes = arg2.childContextTypes

    if stateNode.getChildContext == nil or type(stateNode.getChildContext) ~= "function" then
        if __DEV__ then
            local componentName = getComponentName(arg2) or "Unknown"

            if not var1[componentName] then
                var1[componentName] = true
                console.error(
                    "%s.childContextTypes is specified but there is no getChildContext() method on the instance. You can either define getChildContext() on %s or remove childContextTypes from it.",
                    componentName,
                    componentName
                )
            end
        end

        return tbl3
    end

    local childContext = stateNode:getChildContext()
    for value, _ in childContext do
        if childContextTypes[value] == nil then
            local componentName = getComponentName(arg2) or "Unknown"
            error(
                Error.new(string.format("%s.getChildContext(): key \"%s\" is not defined in childContextTypes.", componentName, value))
            )
        end
    end

    if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        local componentName = getComponentName(arg2) or "Unknown"

        checkPropTypes(childContextTypes, nil, childContext, "child context", componentName)
    end

    return Object.assign({}, tbl3, childContext)
end

return {
    emptyContextObject = emptyContextObject,
    getUnmaskedContext = getUnmaskedContext,
    cacheContext = cacheContext,
    getMaskedContext = function(arg1, __reactInternalMemoizedUnmaskedChildContext)
        local type2 = arg1.type

        if type(type2) == "function" then
            return __reactInternalMemoizedUnmaskedChildContext
        end

        local contextTypes = type2.contextTypes
        if not contextTypes then
            return emptyContextObject
        end

        local stateNode = arg1.stateNode
        if stateNode and stateNode.__reactInternalMemoizedUnmaskedChildContext == __reactInternalMemoizedUnmaskedChildContext then
            return stateNode.__reactInternalMemoizedMaskedChildContext
        end

        local maskedContext = ({})
        for value, _ in contextTypes do
            maskedContext[value] = __reactInternalMemoizedUnmaskedChildContext[value]
        end

        if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
            local componentName = getComponentName(type2) or "Unknown"

            checkPropTypes(contextTypes, nil, maskedContext, "context", componentName)
        end

        if stateNode then
            cacheContext(arg1, __reactInternalMemoizedUnmaskedChildContext, maskedContext)
        end

        return maskedContext
    end,
    hasContextChanged = function()
        return not disableLegacyContext and cursor2.current
    end,
    popContext = function(arg1)
        pop(cursor2, arg1)
        pop(cursor, arg1)
    end,
    popTopLevelContextObject = function(arg1)
        pop(cursor2, arg1)
        pop(cursor, arg1)
    end,
    pushTopLevelContextObject = function(arg1, tbl3, bool1: boolean)
        if cursor.current ~= emptyContextObject then
            error(
                Error.new("Unexpected context found on stack. This error is likely caused by a bug in React. Please file an issue.")
            )
        end

        push(cursor, tbl3, arg1)
        push(cursor2, bool1, arg1)
    end,
    processChildContext = processChildContext,
    isContextProvider = isContextProvider,
    pushContextProvider = function(arg1): boolean
        local stateNode = arg1.stateNode

        local var2 = stateNode and stateNode.__reactInternalMemoizedMergedChildContext or emptyContextObject

        tbl2 = cursor.current
        push(cursor, var2, arg1)
        push(cursor2, cursor2.current, arg1)

        return true
    end,
    invalidateContextProvider = function(arg1, arg2, bool1: boolean)
        local stateNode = arg1.stateNode

        if not stateNode then
            error(
                Error.new(
                    "Expected to have an instance by this point. This error is likely caused by a bug in React. Please file an issue."
                )
            )
        end

        if not bool1 then
            pop(cursor2, arg1)
            push(cursor2, bool1, arg1)

            return
        end

        local var2 = processChildContext(arg1, arg2, tbl2)
        stateNode.__reactInternalMemoizedMergedChildContext = var2

        pop(cursor2, arg1)
        pop(cursor, arg1)

        push(cursor, var2, arg1)
        push(cursor2, bool1, arg1)
    end,
    findCurrentUnmaskedContext = function(arg1)
        if arg1.tag ~= ClassComponent or not isFiberMounted(arg1) then
            error(
                Error.new(
                    "Expected subtree parent to be a mounted class component. This error is likely caused by a bug in React. Please file an issue."
                )
            )
        end

        while arg1.tag ~= HostRoot do
            if arg1.tag == ClassComponent and arg1.type.childContextTypes ~= nil then
                return arg1.stateNode.__reactInternalMemoizedMergedChildContext
            end

            arg1 = arg1.return_
            if arg1 == nil then
                error(
                    Error.new(
                        "Found unexpected detached subtree parent. This error is likely caused by a bug in React. Please file an issue."
                    )
                )

                return
            end
        end

        return arg1.stateNode.context
    end
}
