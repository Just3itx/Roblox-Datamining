-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:50:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local function __rest(tbl1, arg1)
    local tbl2 = ({})
    Array.forEach(arg1, function(arg2)
        tbl2[arg2] = Object.None
    end)
    return Object.assign({}, tbl1, tbl2)
end

local _policies_types = require(script.Parent.Parent.Parent.cache.inmemory.policies_types)

local _storeUtils = require(script.Parent.Parent.graphql.storeUtils)

local mergeDeep = require(script.Parent.Parent.common.mergeDeep).mergeDeep

local getExtras = nil
local makeEmptyData = nil
local var1 = nil

function module.concatPagination(keyArgs)
    if keyArgs == nil then
        keyArgs = false
    end

    return {
        keyArgs = keyArgs,
        merge = function(_, arg2, arg3)
            if arg2 then
                return (Array.concat(arg2, arg3))
            end

            return arg3
        end
    }
end

function module.offsetLimitPagination(keyArgs)
    if keyArgs == nil then
        keyArgs = false
    end

    return {
        keyArgs = keyArgs,
        merge = function(_, arg2, arg3, arg4)
            local args = arg4.args

            local var2 = arg2 == nil and {} or Array.slice(arg2, 1)

            if args == nil then
                return (Array.concat(var2, arg3))
            end

            local var3 = if args.offset == nil then 0 else args.offset

            for i = 1, #arg3 do
                var2[var3 + i] = arg3[i]
            end

            return var2
        end
    }
end

function module.relayStylePagination(keyArgs)
    if keyArgs == nil then
        keyArgs = false
    end

    return {
        keyArgs = keyArgs,
        read = function(_, arg2, arg3)
            if not arg2 then
                return
            end

            local edges = {}
            local str1 = ""
            local str2 = ""

            Array.forEach(arg2.edges, function(arg4)
                if not arg3:canRead(arg3:readField("node", arg4)) then
                    return
                end

                table.insert(edges, arg4)
                if arg4.cursor then
                    str1 = Boolean.toJSBoolean(str1) and str1 or arg4.cursor or ""

                    str2 = Boolean.toJSBoolean(arg4.cursor) and arg4.cursor or str2
                end
            end)

            local pageInfo = arg2.pageInfo
            local startCursor = pageInfo and pageInfo.startCursor
            local endCursor = pageInfo and pageInfo.endCursor

            return Object.assign({}, getExtras(arg2), {
                edges = edges,
                pageInfo = Object.assign({}, arg2.pageInfo, {
                    startCursor = Boolean.toJSBoolean(startCursor) and startCursor or str1,
                    endCursor = Boolean.toJSBoolean(endCursor) and endCursor or str2
                })
            })
        end,
        merge = function(_, arg2, arg3, arg4)
            if arg2 == nil then
                arg2 = makeEmptyData()
            end

            local args = arg4.args

            local var2 = not arg3.edges and {} or Array.map(arg3.edges, function(arg5)
                local var2 = Object.assign({ cursor = "" }, arg5)
                if arg4:isReference(var2) then
                    var2.cursor = arg4:readField("cursor", var2)
                end
                return var2
            end)

            if arg3.pageInfo then
                local pageInfo = arg3.pageInfo
                local startCursor = pageInfo.startCursor
                local endCursor = pageInfo.endCursor
                local var3 = var2[1]
                local var4 = var2[#var2]

                if var3 and startCursor then
                    var3.cursor = startCursor
                end
                if var4 and endCursor then
                    var4.cursor = endCursor
                end

                local cursor = var3 and var3.cursor

                if cursor and not startCursor then
                    arg3 = mergeDeep(arg3, { pageInfo = { startCursor = cursor } })
                end

                local cursor2 = var4 and var4.cursor

                if cursor2 and not endCursor then
                    arg3 = mergeDeep(arg3, { pageInfo = { endCursor = cursor2 } })
                end
            end

            local edges = arg2.edges
            local tbl1 = {}

            if args ~= nil and args.after then
                local index = Array.findIndex(edges, function(arg5): boolean
                    return arg5.cursor == args.after
                end)

                if index >= 1 then
                    edges = Array.slice(edges, 1, index + 1)
                end
            elseif args ~= nil and Boolean.toJSBoolean(args.before) then
                local index = Array.findIndex(edges, function(arg5): boolean
                    return arg5.cursor == args.before
                end)
                if index < 0 then
                    tbl1 = edges
                else
                    tbl1 = Array.slice(edges, index)
                end

                edges = {}
            elseif Boolean.toJSBoolean(arg3.edges) then
                edges = {}
            end

            local var3 = Array.concat(edges, var2, tbl1)

            local pageInfo = Object.assign({}, arg3.pageInfo, arg2.pageInfo)

            if arg3.pageInfo then
                local pageInfo2 = arg3.pageInfo

                local hasPreviousPage = pageInfo2.hasPreviousPage
                local hasNextPage = pageInfo2.hasNextPage
                local startCursor = pageInfo2.startCursor
                local endCursor = pageInfo2.endCursor
                local var5 = Object.assign(
                    {},
                    pageInfo2,
                    {
                        hasPreviousPage = Object.None,
                        hasNextPage = Object.None,
                        startCursor = Object.None,
                        endCursor = Object.None
                    }
                )

                Object.assign(pageInfo, var5)

                if not Boolean.toJSBoolean(#edges) then
                    if hasPreviousPage ~= nil then
                        pageInfo.hasPreviousPage = hasPreviousPage
                    end
                    if startCursor ~= nil then
                        pageInfo.startCursor = startCursor
                    end
                end

                if not Boolean.toJSBoolean(#tbl1) then
                    if hasNextPage ~= nil then
                        pageInfo.hasNextPage = hasNextPage
                    end
                    if endCursor ~= nil then
                        pageInfo.endCursor = endCursor
                    end
                end
            end

            return Object.assign({}, getExtras(arg2), getExtras(arg3), { edges = var3, pageInfo = pageInfo })
        end
    }
end

getExtras = function(tbl1)
    return __rest(tbl1, var1)
end
var1 = { "edges", "pageInfo" }

makeEmptyData = function()
    return {
        edges = {},
        pageInfo = { hasPreviousPage = false, hasNextPage = true, startCursor = "", endCursor = "" }
    }
end

return module
