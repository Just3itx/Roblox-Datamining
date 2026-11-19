-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Promise = require(scriptParentParentParentParentParent.Promise)
local LuauPolyfill = require(scriptParentParentParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local React = require(scriptParentParentParentParentParent.React)
local useContext = React.useContext
local useEffect = React.useEffect
local useReducer = React.useReducer
local useRef = React.useRef

local _GraphQL = require(scriptParentParentParentParentParent.GraphQL)

local _typedDocumentNode = require(scriptParentParentParentParent.jsutils.typedDocumentNode)

local _types = require(script.Parent.Parent.Parent.types.types)

local QueryData = require(script.Parent.Parent.Parent.data).QueryData

local useDeepMemo = require(script.Parent.useDeepMemo).useDeepMemo
local _core = require(script.Parent.Parent.Parent.Parent.core)

local getApolloContext = require(script.Parent.Parent.Parent.context).getApolloContext

local useAfterFastRefresh = require(script.Parent.useAfterFastRefresh).useAfterFastRefresh

local tbl1 = { __value = "nil placeholder" }

function module.useBaseQuery(query, arg1, lazy: boolean?)
    if lazy == nil then
        lazy = false
    end
    local context = useContext(getApolloContext())

    local tick, var3 = useReducer(function(num1: number): number
        return num1 + 1
    end, 0)
    local options = not Boolean.toJSBoolean(arg1) and { query = query } or Object.assign({}, arg1, { query = query }) or {
        query = query
    }
    local var5 = useRef(nil)
    local var6 = nil
    local current = var5.current

    if not current then
        var5.current = QueryData.new({
            options = options,
            context = context,
            onNewData = function(_)
                if Boolean.toJSBoolean(var6:ssrInitiated()) then
                    var3(nil)

                    return
                end

                Promise.delay(0):andThen(function()
                    if var5.current ~= nil and var5.current.isMounted then
                        return var3(nil)
                    end
                end)
            end
        })

        current = var5.current
    end

    var6 = current

    var6:setOptions(options)
    var6.context = context

    local tbl2 = {
        options = Object.assign({}, options, { onError = Object.None, onCompleted = Object.None }),
        context = context,
        tick = tick
    }

    local var7 = useDeepMemo(function()
        if lazy then
            return var6:executeLazy()
        end
        return var6:execute()
    end, tbl2)

    local var8 = if lazy then var7[2] else var7

    if _G.__DEV__ then
        useAfterFastRefresh(var3)
    end

    useEffect(function()
        return function()
            var6:cleanup()

            var5.current = nil
        end
    end, {})

    useEffect(function()
        return var6:afterExecute({ lazy = lazy })
    end, {
        var8.loading ~= nil and var8.loading or tbl1,
        var8.networkStatus ~= nil and var8.networkStatus or tbl1,
        var8.error ~= nil and var8.error or tbl1,
        var8.data ~= nil and var8.data or tbl1
    })

    return var7
end

return module
