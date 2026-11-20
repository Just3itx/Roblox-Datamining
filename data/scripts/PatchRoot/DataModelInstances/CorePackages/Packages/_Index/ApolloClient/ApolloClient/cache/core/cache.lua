-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local Boolean = LuauPolyfill.Boolean

local tbl1 = {}

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local wrap = require(scriptParentParentParent.optimism).wrap
local getFragmentQueryDocument = require(script.Parent.Parent.Parent.utilities).getFragmentQueryDocument
local _DataProxy = require(script.Parent.types.DataProxy)

local _Cache = require(script.Parent.types.Cache)

local ApolloCache = {}
ApolloCache.__index = ApolloCache
function ApolloCache.new()
    local self = setmetatable({}, ApolloCache)

    self.getFragmentDoc = wrap(getFragmentQueryDocument)

    return self
end

function ApolloCache:read(_)
    error("not implemented abstract method")
end

function ApolloCache:write(_)
    error("not implemented abstract method")
end

function ApolloCache.diff(_, _)
    error("not implemented abstract method")
end

function ApolloCache.watch(_, _)
    error("not implemented abstract method")
end

function ApolloCache.reset(_)
    error("not implemented abstract method")
end

function ApolloCache.evict(_, _)
    error("not implemented abstract method")
end

function ApolloCache.restore(_, _)
    error("not implemented abstract method")
end

function ApolloCache.extract(_, _: boolean?)
    error("not implemented abstract method")
end

function ApolloCache.removeOptimistic(_, _: string)
    error("not implemented abstract method")
end

function ApolloCache.batch(arg1, arg2)
    local optimistic = arg2.optimistic
    local optimistic2

    if typeof(optimistic) == "string" then
        optimistic2 = arg2.optimistic
    else
        if arg2.optimistic == false then
        end

        optimistic2 = nil
    end

    arg1:performTransaction(arg2.update, optimistic2)
end

function ApolloCache.performTransaction(_, _: (...any) -> (...any), _: string?)
    error("not implemented abstract method")
end

function ApolloCache.recordOptimisticTransaction(tbl3, func1: (...any) -> (...any), str1: string)
    tbl3:performTransaction(func1, str1)
end

function ApolloCache.transformDocument<T>(_, arg1: T): T
    return arg1
end

function ApolloCache.identify(_, _) end

function ApolloCache.gc(_)
    return {}
end

function ApolloCache.modify(_, _): boolean
    return false
end

function ApolloCache.transformForLink<T>(_, arg1: T): T
    return arg1
end

function ApolloCache.readQuery(tbl3, arg1, optimistic: boolean?)
    if optimistic == nil then
        optimistic = not not arg1.optimistic
    end

    return tbl3:read(
        Object.assign(
            table.clone(arg1),
            {
                rootId = Boolean.toJSBoolean(arg1.id) and arg1.id or "ROOT_QUERY",
                optimistic = optimistic
            }
        )
    )
end

function ApolloCache:readFragment(arg1, optimistic: boolean?)
    if optimistic == nil then
        optimistic = not not arg1.optimistic
    end

    return self:read(
        Object.assign(
            {},
            arg1,
            {
                query = self.getFragmentDoc(arg1.fragment, arg1.fragmentName),
                rootId = arg1.id,
                optimistic = optimistic
            }
        )
    )
end

function ApolloCache.writeQuery(arg1, arg2)
    local id = arg2.id
    local data = arg2.data
    local var1 = Object.assign(table.clone(arg2), { id = Object.None, data = Object.None })

    return arg1:write(Object.assign(var1, { dataId = id or "ROOT_QUERY", result = data }))
end

function ApolloCache:writeFragment(arg1)
    local id = arg1.id
    local data = arg1.data
    local fragment = arg1.fragment
    local fragmentName = arg1.fragmentName
    local var1 = Object.assign(
        table.clone(arg1),
        {
            id = Object.None,
            data = Object.None,
            fragment = Object.None,
            fragmentName = Object.None
        }
    )
    return self:write(Object.assign(var1, { query = self.getFragmentDoc(fragment, fragmentName), dataId = id, result = data }))
end

tbl1.ApolloCache = ApolloCache

return tbl1
