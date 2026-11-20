-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local Boolean = LuauPolyfill.Boolean
local Set = LuauPolyfill.Set
local WeakMap = LuauPolyfill.WeakMap

local HttpService = game:GetService("HttpService")
local NULL = require(scriptParentParentParent.utilities).NULL

local assertSelectionSetForIdValue = nil

local tbl1 = {}

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local wrap = require(scriptParentParentParent.optimism).wrap

local invariant = require(scriptParentParentParent.jsutils.invariant)
local invariant2 = invariant.invariant
local InvariantError = invariant.InvariantError

local utilities = require(script.Parent.Parent.Parent.utilities)
local isField = utilities.isField
local resultKeyNameFromField = utilities.resultKeyNameFromField

local isReference = utilities.isReference
local makeReference = utilities.makeReference

local createFragmentMap = utilities.createFragmentMap

local shouldInclude = utilities.shouldInclude
local addTypenameToDocument = utilities.addTypenameToDocument
local getDefaultValues = utilities.getDefaultValues
local getFragmentDefinitions = utilities.getFragmentDefinitions
local getMainDefinition = utilities.getMainDefinition
local getQueryDefinition = utilities.getQueryDefinition
local mergeDeepArray = utilities.mergeDeepArray
local getFragmentFromSelection = utilities.getFragmentFromSelection
local maybeDeepFreeze = utilities.maybeDeepFreeze
local isNonNullObject = utilities.isNonNullObject
local _canUseWeakMap = utilities.canUseWeakMap
local _Cache = require(script.Parent.Parent.core.types.Cache)

local _types = require(script.Parent.types)

local entityStore = require(script.Parent.entityStore)
local maybeDependOnExistenceOfEntity = entityStore.maybeDependOnExistenceOfEntity
local supportsResultCaching = entityStore.supportsResultCaching

local getTypenameFromStoreObject = require(script.Parent.helpers).getTypenameFromStoreObject
local _policies = require(script.Parent.policies)

local MissingFieldError = require(script.Parent.Parent.core.types.common).MissingFieldError

local objectCanon = require(script.Parent["object-canon"])
local canonicalStringify = objectCanon.canonicalStringify
local ObjectCanon = objectCanon.ObjectCanon

local function missingFromInvariant(arg1, context)
    return MissingFieldError.new(arg1.message, Array.slice(context.path), context.query, context.variables)
end

local function execSelectionSetKeyArgs(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        tbl2.selectionSet,
        tbl2.objectOrReference,
        tbl2.context,
        tbl2.context.canonizeResults
    }
end

local StoreReader = {}
StoreReader.__index = StoreReader

function StoreReader:resetCanon()
    self.canon = ObjectCanon.new()
end

local function makeSelectionSetCacheKey(_, arg1, arg2, arg3, arg4)
    if not supportsResultCaching(arg3.store) then
        return nil
    end

    local store = arg3.store

    if isReference(arg2) then
        arg2 = arg2.__ref or arg2
    end

    return store:makeCacheKey(arg1, arg2, arg3.varString, arg4)
end

local function makeSubSelectedCacheKey(_, arg1)
    local field = arg1.field
    local array = arg1.array
    local context = arg1.context
    if supportsResultCaching(context.store) then
        return context.store:makeCacheKey(field, array, context.varString)
    end
    return nil
end

function StoreReader.new(tbl3)
    local self = (setmetatable({}, StoreReader))

    self.knownResults = WeakMap.new()

    self.config = Object.assign(table.clone(tbl3), { addTypename = tbl3.addTypename ~= false })

    self.canon = tbl3.canon or ObjectCanon.new()

    self.executeSelectionSet = wrap(function(_, arg1)
        local canonizeResults = arg1.context.canonizeResults
        local tbl4 = execSelectionSetKeyArgs(arg1)
        tbl4[4] = not canonizeResults

        local var1 = self.executeSelectionSet:peek(table.unpack(tbl4))

        if var1 == nil then
            maybeDependOnExistenceOfEntity(arg1.context.store, arg1.enclosingRef.__ref)

            return self:execSelectionSetImpl(arg1)
        end

        if canonizeResults then
            return Object.assign(table.clone(var1), { result = self.canon:admit(var1.result) })
        end

        return var1
    end, {
        max = self.config.resultCacheMaxSize,
        keyArgs = function(_, ...): {any}
            return execSelectionSetKeyArgs((...))
        end,
        makeCacheKey = makeSelectionSetCacheKey
    }, self)

    self.executeSubSelectedArray = wrap(function(_, tbl4)
        maybeDependOnExistenceOfEntity(tbl4.context.store, tbl4.enclosingRef.__ref)
        return self:execSubSelectedArrayImpl(tbl4)
    end, {
        max = self.config.resultCacheMaxSize,
        makeCacheKey = makeSubSelectedCacheKey
    }, self)

    return self
end

function StoreReader:diffQueryAgainstStore(arg1)
    local store = arg1.store
    local query = arg1.query
    local rootId = arg1.rootId
    local variables = arg1.variables
    local returnPartialData = arg1.returnPartialData
    local canonizeResults = arg1.canonizeResults
    local var1 = if rootId == nil then "ROOT_QUERY" else rootId

    if returnPartialData == nil then
        returnPartialData = true
    end

    if canonizeResults == nil then
        canonizeResults = true
    end

    local policies = self.config.cache.policies

    local var2 = Object.assign({}, getDefaultValues(getQueryDefinition(query)), variables)

    local reference = makeReference(var1)
    local var3 = self:executeSelectionSet({
        selectionSet = getMainDefinition(query).selectionSet,
        objectOrReference = reference,
        enclosingRef = reference,
        context = {
            store = store,
            query = query,
            policies = policies,
            variables = var2,
            varString = canonicalStringify(var2),
            canonizeResults = canonizeResults,
            fragmentMap = createFragmentMap(getFragmentDefinitions(query)),
            path = {}
        }
    })

    local var4 = var3.missing and #var3.missing > 0

    if var4 and not returnPartialData then
        error(var3.missing[1])
    end

    return {
        result = var3.result,
        missing = var3.missing,
        complete = not var4
    }
end

function StoreReader:isFresh(result, arg1, arg2, arg3)
    if supportsResultCaching(arg3.store) and self.knownResults:get(result) == arg2 then
        local var1 = self.executeSelectionSet:peek(arg2, arg1, arg3, self.canon:isKnown(result))

        if var1 and result == var1.result then
            return true
        end
    end
    return false
end

function StoreReader:execSelectionSetImpl(tbl3)
    local selectionSet = tbl3.selectionSet
    local objectOrReference = tbl3.objectOrReference
    local enclosingRef = tbl3.enclosingRef
    local context = tbl3.context

    if objectOrReference.__ref
        and not (context.policies.rootTypenamesById[objectOrReference.__ref] or context.store:has(objectOrReference.__ref))
    then
        return {
            result = self.canon.empty,
            missing = { missingFromInvariant(
                    InvariantError.new(("Dangling reference to missing %s object"):format(objectOrReference.__ref)),
                    context
                ) }
        }
    end

    local variables = context.variables
    local policies = context.policies
    local store = context.store
    local tbl4 = {}
    local tbl5 = { result = NULL }
    local fieldValue = store:getFieldValue(objectOrReference, "__typename")

    if self.config.addTypename and type(fieldValue) == "string" and not policies.rootIdsByTypename[fieldValue] then
        table.insert(tbl4, { __typename = fieldValue })
    end

    local function getMissing() -- Luacid: Inlined by compiler; 4 call sites recovered
        if not tbl5.missing then
            tbl5.missing = {}
        end
        return tbl5.missing
    end

    local function handleMissing(tbl6) -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl6.missing then
            local missing = getMissing()

            for _, value in tbl6.missing do
                table.insert(missing, value)
            end
        end

        return tbl6.result
    end

    local set = Set.new(selectionSet.selections)

    for _, field in set do
        if not shouldInclude(field, variables) then
            continue
        end

        if isField(field) then
            local tbl6 = {
                fieldName = field.name.value,
                field = field,
                variables = context.variables,
                from = objectOrReference
            }
            local var1 = policies:readField(tbl6, context)

            local var2 = resultKeyNameFromField(field)
            table.insert(context.path, var2)

            if var1 == nil then
                if not addTypenameToDocument:added(field) then
                    table.insert(
                        getMissing(),
                        missingFromInvariant(
                            InvariantError.new(
                                ("Can't find field '%s' on %s"):format(
                                    field.name.value,
                                    isReference(objectOrReference) and objectOrReference.__ref .. " object"
                                        or "object " .. HttpService:JSONEncode(objectOrReference)
                                )
                            ),
                            context
                        )
                    )
                end
            elseif Array.isArray(var1) then
                var1 = handleMissing(
                    (self:executeSubSelectedArray({ field = field, array = var1, enclosingRef = enclosingRef, context = context }))
                )
            elseif not field.selectionSet then
                if context.canonizeResults then
                    var1 = self.canon:pass(var1)
                end
            elseif var1 ~= NULL then
                local tbl7 = {
                    selectionSet = field.selectionSet,
                    objectOrReference = var1,
                    enclosingRef = if isReference(var1) then var1 or enclosingRef else enclosingRef,
                    context = context
                }
                var1 = handleMissing((self:executeSelectionSet(tbl7)))
            end

            if var1 ~= nil then
                table.insert(tbl4, { [var2] = var1 })
            end

            local bool1 = table.remove(context.path) == var2
            if not bool1 then
                invariant2(bool1)
            end
        else
            local fragmentFromSelection = getFragmentFromSelection(field, context.fragmentMap)

            if fragmentFromSelection and policies:fragmentMatches(fragmentFromSelection, fieldValue) then
                Array.forEach(fragmentFromSelection.selectionSet.selections, set.add, set)
            end
        end
    end

    local var1 = mergeDeepArray(tbl4)
    if context.canonizeResults then
        tbl5.result = self.canon:admit(var1)
    else
        tbl5.result = maybeDeepFreeze(var1)
    end

    self.knownResults:set(tbl5.result, selectionSet)

    return tbl5
end

function StoreReader:execSubSelectedArrayImpl(tbl3)
    local field = tbl3.field
    local array = tbl3.array
    local enclosingRef = tbl3.enclosingRef
    local context = tbl3.context

    local var1 = nil

    local function handleMissing(tbl4, num1: number)
        if tbl4.missing then
            var1 = var1 or {}

            local missing = tbl4.missing
            for i = 1, #missing do
                table.insert(var1, missing[i])
            end
        end

        invariant2(table.remove(context.path) == num1)

        return tbl4.result
    end

    if field.selectionSet then
        array = Array.filter(array, function(arg1)
            return context.store:canRead(arg1)
        end)
    end

    local var2 = Array.map(array, function(arg1, num1: number)
        if arg1 == NULL then
            return NULL
        end

        table.insert(context.path, num1)

        if Array.isArray(arg1) and #arg1 > 0 then
            return (handleMissing(
                self:executeSubSelectedArray({ field = field, array = arg1, enclosingRef = enclosingRef, context = context }),
                num1
            ))
        end

        if Boolean.toJSBoolean(field.selectionSet) then
            return (handleMissing(
                self:executeSelectionSet({
                    selectionSet = field.selectionSet,
                    objectOrReference = arg1,
                    enclosingRef = isReference(arg1) and arg1 or enclosingRef,
                    context = context
                }),
                num1
            ))
        end

        if _G.__DEV__ then
            assertSelectionSetForIdValue(context.store, field, arg1)
        end

        local bool1 = table.remove(context.path) == num1
        if not bool1 then
            invariant2(bool1)
        end

        return arg1
    end)

    local tbl4 = { result = 0, missing = 0 }

    if context.canonizeResults then
        var2 = self.canon:admit(var2)
    end

    tbl4.result = var2

    tbl4.missing = var1
    return tbl4
end

tbl1.StoreReader = StoreReader

assertSelectionSetForIdValue = function(arg1, arg2, arg3)
    if arg2.selectionSet then
        return
    end
    local set = Set.new({ arg3 })

    for _, value in set do
        if isNonNullObject(value) then
            invariant2(
                not isReference(value),
                ("Missing selection set for object of type %s returned for query field %s"):format(
                    getTypenameFromStoreObject(arg1, value) or "nil",
                    arg2.name.value
                )
            )
            Array.forEach(Object.values(value), set.add, set)
        end
    end
end

return tbl1
