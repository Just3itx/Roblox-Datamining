-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local Boolean = LuauPolyfill.Boolean
local String = LuauPolyfill.String
local Promise = require(scriptParentParentParent.Promise)

local NULL = require(scriptParentParent.utilities.globals.null).NULL

local tbl1 = {}
local GraphQL = require(scriptParentParentParent.GraphQL)

local visit = GraphQL.visit
local BREAK = GraphQL.BREAK
local invariant = require(scriptParentParent.jsutils.invariant).invariant

local _cache = require(script.Parent.Parent.cache)

local utilities = require(script.Parent.Parent.utilities)

local argumentsObjectFromField = utilities.argumentsObjectFromField
local buildQueryFromSelectionSet = utilities.buildQueryFromSelectionSet
local createFragmentMap = utilities.createFragmentMap
local getFragmentDefinitions = utilities.getFragmentDefinitions
local getMainDefinition = utilities.getMainDefinition
local hasDirectives = utilities.hasDirectives
local isField = utilities.isField
local isInlineFragment = utilities.isInlineFragment
local mergeDeep = utilities.mergeDeep
local mergeDeepArray = utilities.mergeDeepArray
local removeClientSetsFromDocument = utilities.removeClientSetsFromDocument
local resultKeyNameFromField = utilities.resultKeyNameFromField
local shouldInclude = utilities.shouldInclude
local _ApolloClient_types = require(script.Parent.ApolloClient_types)

local _types = require(script.Parent.types)

local _core = require(script.Parent.Parent.link.core)

local cacheSlot = require(script.Parent.Parent.cache).cacheSlot

local LocalState = {}
LocalState.__index = LocalState

function LocalState.new(tbl3)
    local self = setmetatable({}, LocalState)
    local cache = tbl3.cache
    local client = tbl3.client
    local resolvers = tbl3.resolvers
    local fragmentMatcher = tbl3.fragmentMatcher

    self.cache = cache

    if client ~= nil then
        self.client = client
    end

    if resolvers ~= nil then
        self:addResolvers(resolvers)
    end

    if fragmentMatcher ~= nil then
        self:setFragmentMatcher(fragmentMatcher)
    end

    return self
end

function LocalState:addResolvers(arg1)
    self.resolvers = not Boolean.toJSBoolean(self.resolvers) and {} or self.resolvers or {}
    if Array.isArray(arg1) then
        Array.forEach(arg1, function(arg2)
            self.resolvers = mergeDeep(self.resolvers, arg2)
        end)

        return
    end

    self.resolvers = mergeDeep(self.resolvers, arg1)
end

function LocalState.setResolvers(arg1, arg2)
    arg1.resolvers = {}
    arg1:addResolvers(arg2)
end

function LocalState.getResolvers(arg1)
    return Boolean.toJSBoolean(arg1.resolvers) and arg1.resolvers or {}
end

function LocalState.runResolvers(tbl3, tbl4)
    local document = tbl4.document
    local remoteResult = tbl4.remoteResult
    local context = tbl4.context
    local variables = tbl4.variables
    local onlyRunForcedResolvers = tbl4.onlyRunForcedResolvers
    if tbl4.onlyRunForcedResolvers == nil then
        onlyRunForcedResolvers = false
    end

    if not Boolean.toJSBoolean(document) then
        return Promise.resolve(remoteResult)
    end

    return tbl3:resolveDocument(document, remoteResult.data, context, variables, tbl3.fragmentMatcher, onlyRunForcedResolvers):andThen(
        function(arg1)
            return Object.assign({}, remoteResult, { data = arg1.result })
        end
    )
end

function LocalState:setFragmentMatcher(fragmentMatcher: (...any) -> (...any))
    self.fragmentMatcher = fragmentMatcher
end

function LocalState.getFragmentMatcher(arg1)
    return arg1.fragmentMatcher
end

function LocalState.clientQuery(arg1, arg2)
    return if hasDirectives({ "client" }, arg2) and Boolean.toJSBoolean(arg1.resolvers) then arg2 else NULL
end

function LocalState.serverQuery(_, arg1)
    return removeClientSetsFromDocument(arg1)
end

function LocalState:prepareContext(tbl3)
    local cache = self.cache
    return Object.assign({}, tbl3, {
        cache = cache,
        getCacheKey = function(_, arg1)
            return cache:identify(arg1)
        end
    })
end

function LocalState.addExportedVariables(arg1, arg2, arg3, arg4)
    arg3 = arg3 == nil and {} or arg3

    arg4 = arg4 == nil and {} or arg4

    if not Boolean.toJSBoolean(arg2) then
        return Promise.resolve(Object.assign({}, arg3))
    end

    local var1 = arg1:buildRootValueFromCache(arg2, arg3)
    return arg1:resolveDocument(arg2, Boolean.toJSBoolean(var1) and var1 or {}, arg1:prepareContext(arg4), arg3):andThen(function(arg5)
        return Object.assign({}, arg3, arg5.exportedVariables)
    end)
end

function LocalState:shouldForceResolvers(arg1): boolean
    local bool1 = false
    visit(arg1, {
        Directive = {
            enter = function(_, arg2)
                bool1 = arg2.name.value == "client" and Boolean.toJSBoolean(arg2.arguments) and Array.some(arg2.arguments, function(arg3): boolean
                    return arg3.name.value == "always" and arg3.value.kind == "BooleanValue" and arg3.value.value == true
                end)

                return if bool1 then BREAK else nil
            end
        }
    })
    return bool1
end

function LocalState:buildRootValueFromCache(arg1, variables)
    return self.cache:diff(
        {
            query = buildQueryFromSelectionSet(arg1),
            variables = variables,
            returnPartialData = true,
            optimistic = false
        }
    ).result
end

function LocalState:resolveDocument(arg1, arg2, arg3, variables, fragmentMatcher: ((...any) -> (...any))?, onlyRunForcedResolvers: boolean?)
    arg3 = arg3 == nil and {} or arg3

    variables = variables == nil and {} or variables

    fragmentMatcher = fragmentMatcher == nil and function(): boolean
        return true
    end or fragmentMatcher

    if onlyRunForcedResolvers == nil then
        onlyRunForcedResolvers = false
    end

    local mainDefinition = getMainDefinition(arg1)
    local fragmentDefinitions = getFragmentDefinitions(arg1)
    local fragmentMap = createFragmentMap(fragmentDefinitions)

    local operation = mainDefinition.operation

    local defaultOperationType = if Boolean.toJSBoolean(operation) then string.upper(string.sub(operation, 1, 1)) .. String.slice(operation, 2) else "Query"

    local cache = self.cache
    local client = self.client
    local tbl4 = {
        fragmentMap = fragmentMap,
        context = Object.assign({}, arg3, { cache = cache, client = client }),
        variables = variables,
        fragmentMatcher = fragmentMatcher,
        defaultOperationType = defaultOperationType,
        exportedVariables = {},
        onlyRunForcedResolvers = onlyRunForcedResolvers
    }

    return self:resolveSelectionSet(mainDefinition.selectionSet, arg2, tbl4):andThen(function(arg4)
        return {
            result = arg4,
            exportedVariables = tbl4.exportedVariables
        }
    end)
end

function LocalState:resolveSelectionSet(arg1, arg2, tbl3)
    local fragmentMap = tbl3.fragmentMap
    local context = tbl3.context
    local variables = tbl3.variables
    local tbl4 = { arg2 }

    return Promise.all(Array.map(arg1.selections, function(arg3) -- name: execute
        if not Boolean.toJSBoolean(shouldInclude(arg3, variables)) then
            return Promise.resolve(nil)
        end

        if isField(arg3) then
            return self:resolveField(arg3, arg2, tbl3):andThen(function(arg4)
                if typeof(arg4) ~= "nil" then
                    table.insert(tbl4, { [resultKeyNameFromField(arg3)] = arg4 })
                end
            end)
        end

        local var1

        if isInlineFragment(arg3) then
            var1 = arg3
        else
            var1 = fragmentMap[arg3.name.value]
            invariant(var1, ("No fragment named %s"):format(arg3.name.value))
        end

        if var1 and var1.typeCondition ~= nil then
            local value = var1.typeCondition.name.value
            if Boolean.toJSBoolean(tbl3:fragmentMatcher(arg2, value, context)) then
                return self:resolveSelectionSet(var1.selectionSet, arg2, tbl3):andThen(function(arg4)
                    table.insert(tbl4, arg4)
                end)
            end
        end
        return Promise.resolve(nil)
    end)):andThen(function()
        return mergeDeepArray(tbl4)
    end)
end

function LocalState:resolveField(field, arg1, tbl3)
    local variables = tbl3.variables
    local value = field.name.value
    local var1 = resultKeyNameFromField(field)
    local bool1 = value ~= var1
    local var2 = Boolean.toJSBoolean(arg1[var1]) and arg1[var1] or arg1[value]
    local var3 = Promise.resolve(var2)

    if not tbl3.onlyRunForcedResolvers or self:shouldForceResolvers(field) then
        local var4 = Boolean.toJSBoolean(arg1.__typename) and arg1.__typename or tbl3.defaultOperationType
        local var5 = if Boolean.toJSBoolean(self.resolvers) then self.resolvers[tostring(var4)] else self.resolvers

        if Boolean.toJSBoolean(var5) then
            if bool1 then
                var1 = value
            end

            local var6 = var5[var1]

            if Boolean.toJSBoolean(var6) then
                var3 = Promise.resolve(
                    cacheSlot:withValue(
                        self.cache,
                        var6,
                        {
                            arg1,
                            argumentsObjectFromField(field, variables),
                            tbl3.context,
                            {
                                field = field,
                                fragmentMap = tbl3.fragmentMap
                            }
                        }
                    )
                )
            end
        end
    end

    return var3:andThen(function(arg2)
        if arg2 == nil then
            arg2 = var2
        end

        if field.directives ~= nil then
            Array.forEach(field.directives, function(arg3)
                if arg3.name.value ~= "export" or not Boolean.toJSBoolean(arg3.arguments) then
                    return
                end

                Array.forEach(arg3.arguments, function(arg4)
                    if arg4.name.value == "as" and arg4.value.kind == "StringValue" then
                        tbl3.exportedVariables[arg4.value.value] = arg2
                    end
                end)
            end)
        end

        if not Boolean.toJSBoolean(field.selectionSet) or arg2 == nil or arg2 == NULL then
            return arg2
        elseif Array.isArray(arg2) then
            return self:resolveSubSelectedArray(field, arg2, tbl3)
        elseif Boolean.toJSBoolean(field.selectionSet) then
            return self:resolveSelectionSet(field.selectionSet, arg2, tbl3)
        end
        return nil
    end)
end

function LocalState:resolveSubSelectedArray(arg1, arg2, tbl3)
    return Promise.all(Array.map(arg2, function(arg3)
        if arg3 == NULL then
            return NULL
        elseif Array.isArray(arg3) then
            return self:resolveSubSelectedArray(arg1, arg3, tbl3)
        elseif Boolean.toJSBoolean(arg1.selectionSet) then
            return self:resolveSelectionSet(arg1.selectionSet, arg3, tbl3)
        end
        return nil
    end))
end

tbl1.LocalState = LocalState

return tbl1
