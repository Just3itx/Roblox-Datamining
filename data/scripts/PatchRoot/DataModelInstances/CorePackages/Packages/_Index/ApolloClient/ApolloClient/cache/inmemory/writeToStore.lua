-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__

local tbl1 = {}

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local Map = LuauPolyfill.Map
local Set = LuauPolyfill.Set
local Array = LuauPolyfill.Array

local NULL = require(scriptParentParentParent.utilities).NULL

local HttpService = game:GetService("HttpService")

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local invariant = require(scriptParentParentParent.jsutils.invariant)
local invariant2 = invariant.invariant
local InvariantError = invariant.InvariantError

local equal = require(scriptParentParentParent.jsutils.equal)

local objectKeysForEach = require(scriptParentParentParent.luaUtils.objectKeysForEach)

local utilities = require(scriptParentParentParent.utilities)
local createFragmentMap = utilities.createFragmentMap

local getFragmentFromSelection = utilities.getFragmentFromSelection
local getDefaultValues = utilities.getDefaultValues
local getFragmentDefinitions = utilities.getFragmentDefinitions
local getOperationDefinition = utilities.getOperationDefinition
local getTypenameFromResult = utilities.getTypenameFromResult
local makeReference = utilities.makeReference
local isField = utilities.isField
local resultKeyNameFromField = utilities.resultKeyNameFromField
local isReference = utilities.isReference
local shouldInclude = utilities.shouldInclude
local cloneDeep = utilities.cloneDeep
local addTypenameToDocument = utilities.addTypenameToDocument

local _types = require(script.Parent.types)

local helpers = require(script.Parent.helpers)
local makeProcessedFieldsMerger = helpers.makeProcessedFieldsMerger
local fieldNameFromStoreName = helpers.fieldNameFromStoreName
local storeValueIsStoreObject = helpers.storeValueIsStoreObject

local _entityStore = require(script.Parent.entityStore)

local _Cache = require(script.Parent.Parent.core.types.Cache)

local canonicalStringify = require(script.Parent["object-canon"]).canonicalStringify

local _writeToStore_types = require(script.Parent.writeToStore_types)

local warnAboutDataLoss = nil
local getChildMergeTree = nil
local maybeRecycleChildMergeTree = nil
local mergeMergeTrees = nil
local mergeTreeIsEmpty = nil

local StoreWriter = {}
StoreWriter.__index = StoreWriter

function StoreWriter.new(cache, reader)
    local self = setmetatable({}, StoreWriter)
    self.cache = cache
    self.reader = reader
    return self
end

function StoreWriter.writeToStore(arg1, store, arg2)
    local query = arg2.query
    local result = arg2.result
    local dataId = arg2.dataId
    local variables = arg2.variables
    local overwrite = arg2.overwrite
    local operationDefinition = getOperationDefinition(query)
    local processedFieldsMerger = makeProcessedFieldsMerger()

    local var1 = Object.assign(getDefaultValues(operationDefinition), variables)

    local context = {
        store = store,
        written = {},
        merge = function(arg3, arg4)
            return processedFieldsMerger:merge(arg3, arg4)
        end,
        variables = var1,
        varString = canonicalStringify(var1),
        fragmentMap = createFragmentMap(getFragmentDefinitions(query)),
        overwrite = overwrite or false,
        incomingById = Map.new(nil),
        clientOnly = false
    }

    local var2 = arg1:processSelectionSet({
        result = result or {},
        dataId = dataId,
        selectionSet = operationDefinition.selectionSet,
        mergeTree = {
            map = Map.new(nil)
        },
        context = context
    })

    if not isReference(var2) then
        error(InvariantError.new(("Could not identify object %s"):format(HttpService:JSONEncode(result))))
    end

    context.incomingById:forEach(function(arg3, arg4)
        local fields = arg3.fields
        local mergeTree = arg3.mergeTree
        local selections = arg3.selections

        local reference = makeReference(arg4)

        if mergeTree.map.size > 0 then
            local var3 = arg1:applyMerges(mergeTree, reference, fields, context)
            if isReference(var3) then
                return
            end

            fields = var3
        end

        if __DEV__ and not context.overwrite then
            local set = nil
            local function hasSelectionSet(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
                return set:has(fieldNameFromStoreName(str1))
            end
            set = Set.new()
            selections:forEach(function(arg5)
                if isField(arg5) and arg5.selectionSet then
                    set:add(arg5.name.value)
                end
            end)

            local function hasMergeFunction(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
                local var3 = mergeTree.map:get(str1)
                return not (var3 == nil or var3.info == nil) and var3.info.merge ~= nil
            end

            objectKeysForEach(fields, function(arg5)
                if hasSelectionSet(arg5) and not hasMergeFunction(arg5) then
                    warnAboutDataLoss(reference, fields, arg5, context.store)
                end
            end)
        end

        store:merge(arg4, fields)
    end)

    store:retain(var2.__ref)

    return var2
end

function StoreWriter:processSelectionSet(tbl3)
    local dataId = tbl3.dataId
    local result = tbl3.result
    local selectionSet = tbl3.selectionSet
    local context = tbl3.context

    local mergeTree = tbl3.mergeTree

    local policies = self.cache.policies

    local var1, var2 = table.unpack(policies:identify(result, selectionSet, context.fragmentMap), 1, 2)

    local var3 = dataId or var1

    if type(var3) == "string" then
        local tbl4

        if context.written[var3] ~= nil then
            tbl4 = context.written[var3]
        else
            tbl4 = {}
            context.written[var3] = tbl4
        end
        local reference = makeReference(var3)

        if Array.indexOf(tbl4, selectionSet) >= 1 then
            return reference
        end
        table.insert(tbl4, selectionSet)

        if self.reader ~= nil and self.reader:isFresh(result, reference, selectionSet, context) then
            return reference
        end
    end

    local tbl4 = ({})

    if var2 ~= nil then
        tbl4 = context.merge(tbl4, var2)
    end

    local typename = var3 and policies.rootTypenamesById[var3]
        or getTypenameFromResult(result, selectionSet, context.fragmentMap)
        or var3 and context.store:get(var3, "__typename")

    if type(typename) == "string" then
        tbl4.__typename = typename
    end

    local set = Set.new(selectionSet.selections)

    for _, field in set do
        if not shouldInclude(field, context.variables) then
            continue
        end

        if isField(field) then
            local var5 = result[resultKeyNameFromField(field)]

            local clientOnly = context.clientOnly

            context.clientOnly = clientOnly or field.directives and Array.some(field.directives, function(arg1): boolean
                return arg1.name.value == "client"
            end)

            if var5 ~= nil then
                local tbl5 = {
                    typename = typename,
                    fieldName = field.name.value,
                    field = field,
                    variables = context.variables
                }
                local storeFieldName = policies:getStoreFieldName(tbl5)

                local childMergeTree = getChildMergeTree(mergeTree, storeFieldName)

                local var6 = self:processFieldValue(var5, field, context, childMergeTree)
                local var7

                if field.selectionSet == nil then
                    var7 = nil
                else
                    var7 = context.store:getFieldValue(var6, "__typename")

                    if not var7 and isReference(var6) then
                        local var8 = context.incomingById:get(var6.__ref)
                        if var8 == nil then
                            var7 = nil
                        else
                            var7 = var8.fields.__typename
                        end
                    end
                end

                local merge = policies:getMergeFunction(typename, field.name.value, var7)

                if merge ~= nil then
                    childMergeTree.info = { field = field, typename = typename, merge = merge }
                else
                    maybeRecycleChildMergeTree(mergeTree, storeFieldName)
                end

                tbl4 = context.merge(tbl4, { [storeFieldName] = var6 })
            elseif not (context.clientOnly or addTypenameToDocument:added(field)) then
                invariant2.error(
                    string.sub(
                        ("Missing field '%s' while writing result %s"):format(resultKeyNameFromField(field), HttpService:JSONEncode(result)),
                        1,
                        1000
                    )
                )
            end

            context.clientOnly = clientOnly
        else
            local fragmentFromSelection = getFragmentFromSelection(field, context.fragmentMap)

            if fragmentFromSelection and policies:fragmentMatches(fragmentFromSelection, typename, result, context.variables) then
                Array.forEach(fragmentFromSelection.selectionSet.selections, set.add, set)
            end
        end
    end

    if type(var3) ~= "string" then
        return tbl4
    end

    local var5 = context.incomingById:get(var3)
    if var5 then
        var5.fields = context.merge(var5.fields, tbl4)
        var5.mergeTree = mergeMergeTrees(var5.mergeTree, mergeTree)

        var5.selections:forEach(set.add, set)
        var5.selections = set
    else
        context.incomingById:set(var3, { fields = tbl4, mergeTree = mergeTree, selections = set })
    end

    return makeReference(var3)
end

function StoreWriter:processFieldValue(arg1, arg2, context, mergeTree)
    if not arg2.selectionSet or arg1 == NULL then
        if __DEV__ then
            return cloneDeep(arg1)
        end
        return arg1
    elseif Array.isArray(arg1) then
        return Array.map(arg1, function(arg3, arg4)
            local var1 = self:processFieldValue(arg3, arg2, context, getChildMergeTree(mergeTree, arg4))
            maybeRecycleChildMergeTree(mergeTree, arg4)
            return var1
        end)
    else
        return self:processSelectionSet({ result = arg1, selectionSet = arg2.selectionSet, context = context, mergeTree = mergeTree })
    end
end

function StoreWriter:applyMerges(arg1, arg2, arg3, arg4, arg5)
    if arg1.map.size > 0 and not isReference(arg3) then
        local var1 = if not Array.isArray(arg3) and (isReference(arg2) or storeValueIsStoreObject(arg2)) then arg2 else nil
        local var2 = arg3

        if var1 ~= nil and not arg5 then
            arg5 = isReference(var1) and { var1.__ref } or { var1 }
        end

        local var3 = nil

        local function getValue(arg6, arg7) -- Luacid: Inlined by compiler; 2 call sites recovered
            if Array.isArray(arg6) then
                return if typeof(arg7) == "number" then arg6[arg7] else nil
            end

            return arg4.store:getFieldValue(arg6, tostring(arg7))
        end

        arg1.map:forEach(function(arg6, arg7)
            local value = getValue(var1, arg7)
            local value2 = getValue(var2, arg7)

            if value2 == nil then
                return
            end
            if arg5 ~= nil then
                table.insert(arg5, arg7)
            end
            local var4 = self:applyMerges(arg6, value, value2, arg4, arg5)
            if var4 ~= value2 then
                var3 = var3 or Map.new(nil)

                var3:set(arg7, var4)
            end
            if arg5 ~= nil then
                invariant2(table.remove(arg5, #arg5) == arg7)
            end
        end)

        if var3 ~= nil then
            arg3 = table.clone(var2)

            var3:forEach(function(arg6, arg7)
                arg3[arg7] = arg6
            end)
        end
    end

    if not arg1.info then
        return arg3
    end

    return self.cache.policies:runMergeFunction(
        arg2,
        arg3,
        arg1.info,
        arg4,
        if Boolean.toJSBoolean(arg5) then arg4.store:getStorage(table.unpack(arg5)) or nil else nil
    )
end

tbl1.StoreWriter = StoreWriter

local tbl3 = {}

getChildMergeTree = function(arg1, arg2)
    local map = arg1.map
    if not map:has(arg2) then
        map:set(arg2, table.remove(tbl3, #tbl3) or { map = Map.new(nil) })
    end

    return (map:get(arg2))
end

mergeMergeTrees = function(arg1, arg2)
    if arg1 == arg2 or arg2 == nil or mergeTreeIsEmpty(arg2) then
        return arg1
    end

    if arg1 == nil or mergeTreeIsEmpty(arg1) then
        return arg2
    end

    local info = if arg1.info and arg2.info then Object.assign(table.clone(arg1.info), arg2.info) else arg1.info or arg2.info
    local size = if arg1.map.size > 0 then arg2.map.size else arg1.map.size
    local tbl4 = {
        info = info,
        map = if size > 0 then Map.new() elseif arg1.map.size > 0 then arg1.map else arg2.map
    }
    if size > 0 then
        local set = Set.new(arg2.map:keys())

        arg1.map:forEach(function(arg3, arg4)
            tbl4.map:set(arg4, mergeMergeTrees(arg3, arg2.map:get(arg4)))
            set:delete(arg4)
        end)

        set:forEach(function(arg3)
            tbl4.map:set(arg3, mergeMergeTrees(arg2.map:get(arg3), arg1.map:get(arg3)))
        end)
    end

    return tbl4
end

mergeTreeIsEmpty = function(arg1): boolean
    return not arg1 or not (arg1.info or arg1.map.size > 0)
end

maybeRecycleChildMergeTree = function(arg1, arg2)
    local map = arg1.map

    local var1 = map:get(arg2)

    if var1 ~= nil and mergeTreeIsEmpty(var1) then
        table.insert(tbl3, var1)
        map:delete(arg2)
    end
end

local set = Set.new()

warnAboutDataLoss = function(arg1, arg2, str1: string, arg3)
    local function getChild(arg4): boolean | {[any]: any} -- Luacid: Inlined by compiler; 2 call sites recovered
        local fieldValue = arg3:getFieldValue(arg4, str1)
        if typeof(fieldValue) ~= "table" then
            fieldValue = false
        end

        return fieldValue
    end

    local child = getChild(arg1)

    if not child then
        return
    end

    local child2 = getChild(arg2)

    if not child2 or isReference(child) or equal(child, child2) or Array.every(Object.keys(child), function(arg4): boolean
        return arg3:getFieldValue(child2, arg4) ~= nil
    end) then
        return
    end

    local fieldValue = arg3:getFieldValue(arg1, "__typename")
    local var1 = Boolean.toJSBoolean(fieldValue) and fieldValue or arg3:getFieldValue(arg2, "__typename")

    local var2 = fieldNameFromStoreName(str1)
    local str2 = ("%s.%s"):format(var1, var2)

    if set:has(str2) then
        return
    end
    set:add(str2)

    local tbl4 = {}

    if not (Array.isArray(child) or Array.isArray(child2)) then
        Array.forEach({ child, child2 }, function(arg4)
            local fieldValue2 = arg3:getFieldValue(arg4, "__typename")
            if typeof(fieldValue2) == "string" and not Array.includes(tbl4, fieldValue2) then
                table.insert(tbl4, fieldValue2)
            end
        end)
    end
    local warn = invariant2.warn

    local var3 = if Boolean.toJSBoolean(#tbl4) then "either ensure all objects of type " .. Array.join(tbl4, " and ") .. " have an ID or a custom merge function, or " else ""

    local str3 = string.sub(HttpService:JSONEncode(child), 1, 1000)
    local str4 = HttpService:JSONEncode(child2)
    warn(
        ("Cache data may be lost when replacing the %s field of a %s object.\n\n\tTo address this problem (which is not a bug in Apollo Client), %sdefine a custom merge function for the %s field, so InMemoryCache can safely merge these objects:\n\n\t  existing: %s\n\t  incoming: %s\n\n\tFor more information about these options, please refer to the documentation:\n\n\t  * Ensuring entity objects have IDs: https://go.apollo.dev/c/generating-unique-identifiers\n\t  * Defining custom merge functions: https://go.apollo.dev/c/merging-non-normalized-objects\n\t"):format(
            var2,
            var1,
            var3,
            str2,
            str3,
            string.sub(str4, 1, 1000)
        )
    )
end
return tbl1
