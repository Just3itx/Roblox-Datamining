-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set

local module = {}

local visit = require(scriptParentParentParentParent.GraphQL).visit

local ApolloLink = require(script.Parent.Parent.core).ApolloLink
local Observable = require(script.Parent.Parent.Parent.utilities).Observable
local serializeFetchParameter = require(script.Parent.serializeFetchParameter).serializeFetchParameter
local selectURI = require(script.Parent.selectURI).selectURI
local parseAndCheckHttpResponse = require(script.Parent.parseAndCheckHttpResponse).parseAndCheckHttpResponse
local checkFetcher = require(script.Parent.checkFetcher).checkFetcher
local selectHttpOptionsAndBody = require(script.Parent.selectHttpOptionsAndBody)
local selectHttpOptionsAndBody2 = selectHttpOptionsAndBody.selectHttpOptionsAndBody
local fallbackHttpConfig = selectHttpOptionsAndBody.fallbackHttpConfig

local createSignalIfSupported = require(script.Parent.createSignalIfSupported).createSignalIfSupported
local rewriteURIForGET = require(script.Parent.rewriteURIForGET).rewriteURIForGET
local fromError = require(script.Parent.Parent.utils).fromError

function module.createHttpLink(arg1)
    local var1 = arg1 == nil and {} or arg1

    local var2 = if var1.uri == nil then "/graphql" else var1.uri or "/graphql"
    local fetch = var1.fetch
    local includeExtensions = var1.includeExtensions
    local useGetForQueries = var1.useGETForQueries
    local includeUnusedVariables = not (var1.includeUnusedVariables == nil) and (var1.includeUnusedVariables or false)
    local var3 = Object.assign({}, var1, {
        uri = Object.None,
        fetch = Object.None,
        includeExtensions = Object.None,
        useGETForQueries = Object.None,
        includeUnusedVariables = Object.None
    })

    checkFetcher(fetch)

    if not Boolean.toJSBoolean(fetch) then
        fetch = _G.fetch
    end

    local tbl1 = {
        http = { includeExtensions = includeExtensions },
        options = var3.fetchOptions,
        credentials = var3.credentials,
        headers = var3.headers
    }

    return ApolloLink.new(function(_, arg2)
        local var4 = selectURI(arg2, var2)

        local context = arg2:getContext()

        local tbl2 = {}

        if Boolean.toJSBoolean(context.clientAwareness) then
            local name = context.clientAwareness.name
            local version = context.clientAwareness.version
            if Boolean.toJSBoolean(name) then
                tbl2["apollographql-client-name"] = name
            end
            if Boolean.toJSBoolean(version) then
                tbl2["apollographql-client-version"] = version
            end
        end

        local headers = Object.assign({}, tbl2, context.headers)

        local tbl3 = {
            http = context.http,
            options = context.fetchOptions,
            credentials = context.credentials,
            headers = headers
        }

        local var6 = selectHttpOptionsAndBody2(arg2, fallbackHttpConfig, tbl1, tbl3)
        local options = var6.options
        local body = var6.body

        if body.variables ~= nil and not includeUnusedVariables then
            local set = Set.new(Object.keys(body.variables))
            visit(arg2.query, {
                Variable = function(_, arg3, _, arg4)
                    if Boolean.toJSBoolean(arg4) and arg4.kind ~= "VariableDefinition" then
                        set:delete(arg3.name.value)
                    end
                end
            })
            if Boolean.toJSBoolean(set.size) then
                body.variables = Object.assign({}, body.variables)
                set:forEach(function(arg3)
                    body.variables[arg3] = nil
                end)
            end
        end

        local var7 = nil
        if not Boolean.toJSBoolean(options.signal) then
            local signalIfSupported = createSignalIfSupported()
            local controller = signalIfSupported.controller
            local signal = signalIfSupported.signal
            var7 = controller
            if Boolean.toJSBoolean(var7) then
                options.signal = signal
            end
        end

        if Boolean.toJSBoolean(useGetForQueries) and not Array.some(arg2.query.definitions, function(arg3): boolean -- name: definitionIsMutation
            return arg3.kind == "OperationDefinition" and arg3.operation == "mutation"
        end) then
            options.method = "GET"
        end

        if options.method == "GET" then
            local var8 = rewriteURIForGET(var4, body)
            local newUri = var8.newURI
            local parseError = var8.parseError
            if Boolean.toJSBoolean(parseError) then
                return fromError(parseError)
            end
            var4 = newUri
        else
            local success, result = pcall(function()
                options.body = serializeFetchParameter(body, "Payload")
            end)
            if not success then
                return fromError(result)
            end
        end
        return Observable.new(function(arg3)
            fetch(var4, options):andThen(function<T>(response: T): T
                arg2:setContext({ response = response })
                return response
            end):andThen(parseAndCheckHttpResponse(arg2)):andThen(function<T>(arg4: T): T
                arg3:next(arg4)
                arg3:complete()
                return arg4
            end):catch(function(arg4)
                if arg4.name == "AbortError" then
                    return
                end

                if Boolean.toJSBoolean(arg4.result) and Boolean.toJSBoolean(arg4.result.errors) and Boolean.toJSBoolean(arg4.result.data) then
                    arg3:next(arg4.result)
                end
                arg3:error(arg4)
            end)

            return function()
                if Boolean.toJSBoolean(var7) then
                    var7:abort()
                end
            end
        end)
    end)
end

return module
