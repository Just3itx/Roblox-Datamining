-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error

local invariant = require(scriptParentParentParent.jsutils.invariant)
local InvariantError = invariant.InvariantError
local invariant2 = invariant.invariant
local Observable = require(scriptParentParentParent.utilities).Observable

local _types = require(script.Parent.types)

local utils = require(script.Parent.Parent.utils)
local validateOperation = utils.validateOperation
local createOperation = utils.createOperation
local transformOperation = utils.transformOperation

local ApolloLink = {}
ApolloLink.__index = ApolloLink

local function passthrough(_, arg1, arg2)
    if Boolean.toJSBoolean(arg2) then
        return (arg2(arg1))
    end
    return Observable.of()
end

local function toLink(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if typeof(arg1) == "function" then
        return ApolloLink.new(arg1)
    end
    return arg1
end

local function isTerminating(tbl3): boolean -- Luacid: unused: defined but never referenced
    local var1, _ = debug.info(tbl3.request, "a")
    return var1 <= 2
end

local var1 = setmetatable({}, { __index = Error })
var1.__index = var1

function var1.new(str1: string?, link)
    local error = Error.new(str1)
    error.link = link

    return (setmetatable(error, var1))
end

function ApolloLink.empty()
    return ApolloLink.new(function(_)
        return Observable.of()
    end)
end

function ApolloLink.from(arg1)
    if #arg1 == 0 then
        return ApolloLink.empty()
    end
    return (Array.reduce(Array.map(arg1, toLink, nil), function(arg2, arg3)
        return arg2:concat(arg3)
    end))
end

function ApolloLink.split_(func1: (...any) -> (...any), arg1, arg2)
    local var2 = toLink(arg1)
    local var3

    if Boolean.toJSBoolean(arg2) and arg2 ~= nil then
        if typeof(arg2) == "function" then
            var3 = ApolloLink.new(arg2)
        else
            var3 = arg2
        end
    else
        local var4 = ApolloLink.new(passthrough)

        if typeof(var4) == "function" then
            var3 = ApolloLink.new(var4)
        else
            var3 = var4
        end
    end

    local var4, _ = debug.info(var2.request, "a")
    if var4 <= 2 then
        local var5, _ = debug.info(var3.request, "a")

        if var5 <= 2 then
            return ApolloLink.new(function(_, arg3)
                if func1(arg3) then
                    local var6 = var2:request(arg3)
                    return Boolean.toJSBoolean(var6) and var6 or Observable.of()
                end
                local var6 = var3:request(arg3)
                return Boolean.toJSBoolean(var6) and var6 or Observable.of()
            end)
        end
    end
    return ApolloLink.new(function(_, arg3, arg4)
        if func1(arg3) then
            local var5 = var2:request(arg3, arg4)
            return Boolean.toJSBoolean(var5) and var5 or Observable.of()
        end
        local var5 = var3:request(arg3, arg4)
        return Boolean.toJSBoolean(var5) and var5 or Observable.of()
    end)
end

function ApolloLink.execute(tbl3, arg1)
    local var2 = tbl3:request(createOperation(arg1.context, transformOperation(validateOperation(arg1))))
    return Boolean.toJSBoolean(var2) and var2 or Observable.of()
end

function ApolloLink.concat_(arg1, arg2)
    local var2 = toLink(arg1)
    local var3, _ = debug.info(var2.request, "a")
    if var3 <= 2 then
        invariant2.warn(var1.new("You are calling concat on a terminating link, which will have no effect", var2))

        return var2
    end

    local var4 = toLink(arg2)
    local var5, _ = debug.info(var4.request, "a")
    if var5 <= 2 then
        return ApolloLink.new(function(_, arg3)
            local var6 = var2:request(arg3, function(arg4)
                local var6 = var4:request(arg4)
                return Boolean.toJSBoolean(var6) and var6 or Observable.of()
            end)
            return Boolean.toJSBoolean(var6) and var6 or Observable.of()
        end)
    end
    return ApolloLink.new(function(_, arg3, arg4)
        local var6 = var2:request(arg3, function(arg5)
            local var6 = var4:request(arg5, arg4)
            return Boolean.toJSBoolean(var6) and var6 or Observable.of()
        end)
        return Boolean.toJSBoolean(var6) and var6 or Observable.of()
    end)
end

function ApolloLink.new(request)
    local tbl3 = {}
    if Boolean.toJSBoolean(request) then
        tbl3.request = request
    end
    return (setmetatable(tbl3, ApolloLink))
end

function ApolloLink.split(tbl3, func1: (...any) -> (...any), arg1, arg2)
    return tbl3:concat(ApolloLink.split_(func1, arg1, Boolean.toJSBoolean(arg2) and arg2 or ApolloLink.new(passthrough)))
end

function ApolloLink.concat(arg1, arg2)
    return ApolloLink.concat_(arg1, arg2)
end

function ApolloLink.request(_, _, _)
    error(InvariantError.new("request is not implemented"))
end

function ApolloLink.onError(_, arg1, arg2): boolean
    if Boolean.toJSBoolean(arg2) and arg2 ~= nil and Boolean.toJSBoolean(arg2.error) then
        arg2:error(arg1)

        return false
    end

    error(arg1)
end

function ApolloLink.setOnError(arg1, onError)
    arg1.onError = onError
    return arg1
end

tbl1.ApolloLink = ApolloLink
return tbl1
