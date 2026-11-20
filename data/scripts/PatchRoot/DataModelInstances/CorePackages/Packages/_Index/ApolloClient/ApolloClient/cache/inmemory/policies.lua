-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local HttpService = game:GetService("HttpService")

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set
local Map = LuauPolyfill.Map

local isCallable = require(scriptParentParentParent.luaUtils.isCallable)
local objectKeysForEach = require(scriptParentParentParent.luaUtils.objectKeysForEach)

local LuauRegExp = require(scriptParentParentParentParent.LuauRegExp)

local tbl1 = {}

local makeFieldFunctionOptions = nil
local makeMergeObjectsFunction = nil
local keyArgsFnFromSpecifier = nil
local keyFieldsFnFromSpecifier = nil
local makeAliasMap = nil
local computeKeyObject = nil

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local Trie = require(scriptParentParentParent.wry.trie).Trie
local invariant = require(scriptParentParentParent.jsutils.invariant)
local invariant2 = invariant.invariant
local InvariantError = invariant.InvariantError

local utilities = require(script.Parent.Parent.Parent.utilities)

local getFragmentFromSelection = utilities.getFragmentFromSelection
local isField = utilities.isField
local getTypenameFromResult = utilities.getTypenameFromResult
local storeKeyNameFromField = utilities.storeKeyNameFromField

local argumentsObjectFromField = utilities.argumentsObjectFromField

local isReference = utilities.isReference
local getStoreKeyName = utilities.getStoreKeyName
local canUseWeakMap = utilities.canUseWeakMap
local isNonNullObject = utilities.isNonNullObject
local stringifyForDisplay = utilities.stringifyForDisplay

local helpers = require(script.Parent.helpers)

local hasOwnProperty = require(scriptParentParentParent.luaUtils.hasOwnProperty)
local fieldNameFromStoreName = helpers.fieldNameFromStoreName
local storeValueIsStoreObject = helpers.storeValueIsStoreObject
local selectionSetMatchesResult = helpers.selectionSetMatchesResult
local TypeOrFieldNameRegExp = helpers.TypeOrFieldNameRegExp
local cacheSlot = require(script.Parent.reactiveVars).cacheSlot

local _common = require(script.Parent.Parent.core.types.common)

local _writeToStore_types = require(script.Parent.writeToStore_types)

getStoreKeyName:setStringify(require(script.Parent["object-canon"]).canonicalStringify)

local _policies_types = require(script.Parent.policies_types)

local function argsFromFieldSpecifier(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1.args ~= nil then
        return arg1.args
    elseif arg1.field then
        return (argumentsObjectFromField(arg1.field, arg1.variables))
    end

    return nil
end

local function defaultDataIdFromObject(_, arg1, arg2)
    local __typename = arg1.__typename
    local id = arg1.id
    local _id = arg1._id

    if type(__typename) == "string" then
        if arg2 then
            if id ~= nil then
                arg2.keyObject = { id = id }
            elseif _id ~= nil then
                arg2.keyObject = { _id = _id }
            else
                arg2.keyObject = nil
            end
        end
        if id ~= nil then
            _id = id
        end

        if _id ~= nil then
            local str1 = type(_id)

            local format = string.format
            local str2 = "%s:%s"

            if str1 ~= "number" and str1 ~= "string" then
                _id = HttpService:JSONEncode(_id)
            end

            return format(str2, __typename, _id)
        end
    end

    return nil
end
tbl1.defaultDataIdFromObject = defaultDataIdFromObject
local function nullKeyFieldsFn(_)
    return nil
end

local function simpleKeyArgsFn(_, arg1)
    return arg1.fieldName
end

local function mergeTrueFn(_, arg1, arg2, arg3)
    return arg3:mergeObjects(arg1, arg2)
end

local function mergeFalseFn<T>(_, _, arg1: T): T
    return arg1
end

local Policies = {}
Policies.__index = Policies

function Policies.new(config)
    local self = (setmetatable({}, Policies))

    self.typePolicies = {}
    self.toBeAdded = {}

    self.supertypeMap = Map.new(nil)

    self.fuzzySubtypes = Map.new(nil)

    self.cache = nil
    self.rootIdsByTypename = {}
    self.rootTypenamesById = {}
    self.usingPossibleTypes = false

    self.config = config
    self.config = Object.assign({ dataIdFromObject = defaultDataIdFromObject }, config)

    self.cache = self.config.cache
    self:setRootTypename("Query")
    self:setRootTypename("Mutation")
    self:setRootTypename("Subscription")

    if config.possibleTypes then
        self:addPossibleTypes(config.possibleTypes)
    end
    if config.typePolicies then
        self:addTypePolicies(config.typePolicies)
    end

    return self
end

function Policies:identify(arg1, selectionSet, fragmentMap): {string}
    local typename = if selectionSet and fragmentMap then getTypenameFromResult(arg1, selectionSet, fragmentMap) else arg1.__typename

    if typename == self.rootTypenamesById.ROOT_QUERY then
        return { "ROOT_QUERY" }
    end

    local tbl3 = { typename = typename, selectionSet = selectionSet, fragmentMap = fragmentMap }

    local var2 = nil

    local typePolicy = typename and self:getTypePolicy(typename)
    local var3 = if typePolicy and typePolicy.keyFn then typePolicy.keyFn else self.config.dataIdFromObject
    local var4

    while true do
        if not var3 then
            var4 = var2
            break
        end

        var4 = var3(typePolicy, arg1, tbl3)

        if type(var4) ~= "table" then
            break
        end
        var3 = keyFieldsFnFromSpecifier(var4)
    end

    local var5 = if var4 then tostring(var4) else nil
    return if tbl3.keyObject then { var5, tbl3.keyObject } else { var5 }
end

function Policies:addTypePolicies(arg1)
    objectKeysForEach(arg1, function(arg2)
        local var1 = arg1[arg2]
        local queryType = var1.queryType
        local mutationType = var1.mutationType
        local subscriptionType = var1.subscriptionType
        local var2 = Object.assign({}, var1, { queryType = Object.None, mutationType = Object.None, subscriptionType = Object.None })

        if queryType then
            self:setRootTypename("Query", arg2)
        end
        if mutationType then
            self:setRootTypename("Mutation", arg2)
        end
        if subscriptionType then
            self:setRootTypename("Subscription", arg2)
        end

        if hasOwnProperty(self.toBeAdded, arg2) then
            table.insert(self.toBeAdded[arg2], var2)
            return
        end
        self.toBeAdded[arg2] = { var2 }
    end)
end

function Policies:updateTypePolicy(str1: string, arg1)
    local typePolicy = self:getTypePolicy(str1)
    local keyFields = arg1.keyFields
    local fields = arg1.fields

    local function setMerge(tbl3, merge) -- Luacid: Inlined by compiler; 2 call sites recovered
        if isCallable(merge) then
            tbl3.merge = merge
        elseif merge == true then
            tbl3.merge = mergeTrueFn
        elseif merge == false then
            tbl3.merge = mergeFalseFn
        else
            tbl3.merge = tbl3.merge
        end
    end

    setMerge(typePolicy, arg1.merge)

    if keyFields == false then
        typePolicy.keyFn = nullKeyFieldsFn
    else
        local str2 = type(keyFields)
        if str2 == "table" then
            typePolicy.keyFn = keyFieldsFnFromSpecifier(keyFields)
        elseif str2 == "function" then
            typePolicy.keyFn = keyFields
        else
            typePolicy.keyFn = typePolicy.keyFn
        end
    end

    if not fields then
        return
    end

    objectKeysForEach(fields, function(arg2)
        local fieldPolicy = self:getFieldPolicy(str1, arg2, true)
        local read = fields[arg2]

        if type(read) == "function" then
            fieldPolicy.read = read
        else
            local keyArgs = read.keyArgs
            local read2 = read.read
            local merge = read.merge

            if keyArgs == false then
                fieldPolicy.keyFn = simpleKeyArgsFn
            else
                local str2 = type(keyArgs)
                if str2 == "table" then
                    fieldPolicy.keyFn = keyArgsFnFromSpecifier(keyArgs)
                elseif str2 == "function" then
                    fieldPolicy.keyFn = keyArgs
                else
                    fieldPolicy.keyFn = fieldPolicy.keyFn
                end
            end

            if type(read2) == "function" then
                fieldPolicy.read = read2
            end

            setMerge(fieldPolicy, merge)
        end

        if fieldPolicy.read and fieldPolicy.merge then
            fieldPolicy.keyFn = fieldPolicy.keyFn or simpleKeyArgsFn
        end
    end)
end

function Policies:setRootTypename(str1: string, str2: string?)
    if str2 == nil then
        str2 = str1
    end

    local str3 = "ROOT_" .. string.upper(str1)
    local var1 = self.rootTypenamesById[str3]
    if str2 == var1 then
        return
    end
    local bool1 = not var1 or var1 == str1
    if not bool1 then
        invariant2(bool1, ("Cannot change root %s __typename more than once"):format(str1))
    end

    if var1 then
        self.rootIdsByTypename[var1] = nil
    end

    self.rootIdsByTypename[str2] = str3

    self.rootTypenamesById[str3] = str2
end

function Policies:addPossibleTypes(tbl3)
    self.usingPossibleTypes = true

    objectKeysForEach(tbl3, function(arg1)
        self:getSupertypeSet(arg1, true)

        Array.forEach(tbl3[arg1], function(arg2)
            self:getSupertypeSet(arg2, true):add(arg1)

            local var1 = TypeOrFieldNameRegExp:exec(arg2)
            if not var1 or var1[1] ~= arg2 then
                self.fuzzySubtypes:set(arg2, LuauRegExp.new(arg2))
            end
        end)
    end)
end

function Policies:getTypePolicy(str1: string)
    if not hasOwnProperty(self.typePolicies, str1) then
        self.typePolicies[str1] = {}

        local var1 = self.typePolicies[str1]
        var1.fields = {}

        local var2 = self.supertypeMap:get(str1)

        if var2 and var2.size > 0 then
            var2:forEach(function(arg1)
                local typePolicy = self:getTypePolicy(arg1)

                local fields = typePolicy.fields
                local var3 = Object.assign(table.clone(typePolicy), { fields = Object.None })

                Object.assign(var1, var3)
                Object.assign(var1.fields, fields)
            end)
        end
    end

    local var1 = self.toBeAdded[str1]

    if var1 and #var1 > 0 then
        Array.forEach(Array.splice(var1, 1), function(arg1)
            self:updateTypePolicy(str1, arg1)
        end)
    end

    return self.typePolicies[str1]
end

function Policies:getFieldPolicy(str1: string?, str2: string, bool1: boolean)
    if not str1 then
        return nil
    end

    local fields = self:getTypePolicy(str1).fields
    if fields[str2] then
        return fields[str2]
    end
    if not bool1 then
        return nil
    end

    fields[str2] = {}
    return fields[str2]
end

function Policies:getSupertypeSet(str1: string, bool1: boolean)
    local var1 = self.supertypeMap:get(str1)

    if not var1 and bool1 then
        var1 = Set.new()
        self.supertypeMap:set(str1, var1)
    end
    return var1
end

function Policies:fragmentMatches(arg1, str1: string?, tbl3, tbl4)
    if not arg1.typeCondition then
        return true
    end

    if not str1 then
        return false
    end

    local value = arg1.typeCondition.name.value

    if str1 == value then
        return true
    end

    if self.usingPossibleTypes and self.supertypeMap:has(value) then
        local supertypeSet = self:getSupertypeSet(str1, true)
        local tbl5 = { supertypeSet }
        local function maybeEnqueue(str2: string) -- Luacid: Inlined by compiler; 1 call site recovered
            local supertypeSet2 = self:getSupertypeSet(str2, false)

            if supertypeSet2 and supertypeSet2.size > 0 and Array.indexOf(tbl5, supertypeSet2) < 1 then
                table.insert(tbl5, supertypeSet2)
            end
        end

        local bool1 = not (tbl3 == nil) and self.fuzzySubtypes.size > 0
        local bool2 = false

        for value2, _ in tbl5 do
            local var1 = tbl5[value2]

            if var1:has(value) then
                if not supertypeSet:has(value) then
                    if bool2 then
                        invariant2.warn(("Inferring subtype %s of supertype %s"):format(str1, value))
                    end

                    supertypeSet:add(value)
                end
                return true
            end

            var1:forEach(maybeEnqueue)

            if not bool1 or value2 ~= #tbl5 or not selectionSetMatchesResult(arg1.selectionSet, tbl3, tbl4) then
                continue
            end

            Array.forEach(self.fuzzySubtypes:entries(), function(arg2): number
                local var2 = arg2[2]
                local var3 = arg2[1]

                local var4 = var2:exec(str1)

                if var4 and var4[1] == str1 then
                    maybeEnqueue(var3)
                end

                return 1
            end)

            bool2 = true
            bool1 = false
        end
    end

    return false
end

function Policies.hasKeyArgs(tbl3, str1: string?, str2: string): boolean
    local fieldPolicy = tbl3:getFieldPolicy(str1, str2, false)

    return not (fieldPolicy == nil) and fieldPolicy.keyFn ~= nil
end

function Policies:getStoreFieldName(arg1)
    local typename = arg1.typename
    local fieldName = arg1.fieldName
    local fieldPolicy = self:getFieldPolicy(typename, fieldName, false)
    local storeKeyName = nil
    local keyFn = if fieldPolicy then fieldPolicy.keyFn else nil

    if keyFn and typename then
        local tbl3 = {
            typename = typename,
            fieldName = fieldName,
            field = arg1.field or nil,
            variables = arg1.variables
        }
        local var1 = argsFromFieldSpecifier(arg1)

        while keyFn do
            local var2 = keyFn(var1, tbl3)

            if type(var2) ~= "table" then
                storeKeyName = var2 or fieldName
                break
            end
            keyFn = keyArgsFnFromSpecifier(var2)
        end
    end

    if storeKeyName == nil then
        if arg1.field then
            storeKeyName = storeKeyNameFromField(arg1.field, arg1.variables)
        else
            storeKeyName = getStoreKeyName(fieldName, (argsFromFieldSpecifier(arg1)))
        end
    end

    if storeKeyName == false then
        return fieldName
    end

    if fieldName == fieldNameFromStoreName(storeKeyName) then
        return storeKeyName
    end

    return fieldName .. ":" .. storeKeyName
end

function Policies:readField(arg1, tbl3)
    local from = arg1.from
    if not from then
        return
    end

    if not (arg1.field or arg1.fieldName) then
        return
    end

    if arg1.typename == nil then
        local typename = tbl3.store:getFieldValue(from, "__typename")

        if typename then
            arg1.typename = typename
        end
    end

    local storeFieldName = self:getStoreFieldName(arg1)
    local var1 = fieldNameFromStoreName(storeFieldName)
    local fieldValue = tbl3.store:getFieldValue(from, storeFieldName)
    local fieldPolicy = self:getFieldPolicy(arg1.typename, var1, false)
    local read = if fieldPolicy then fieldPolicy.read else nil

    if not read then
        return fieldValue
    end

    local var2 = makeFieldFunctionOptions

    local store = tbl3.store
    local var3 = if from.__ref then from.__ref else from
    local var4 = var2(self, from, arg1, tbl3, store:getStorage(var3, storeFieldName))

    return (cacheSlot:withValue(self.cache, read, { fieldValue, var4 }))
end

function Policies.getMergeFunction(tbl3, str1: string?, str2: string, str3: string?)
    local fieldPolicy = tbl3:getFieldPolicy(str1, str2, false)

    local merge = fieldPolicy and fieldPolicy.merge

    if not merge and str3 then
        merge = tbl3:getTypePolicy(str3)

        if merge then
            return merge.merge
        end
    end

    return merge
end

function Policies.runMergeFunction(tbl3, arg1, arg2, tbl4, arg3, arg4)
    local field = tbl4.field
    local typename = tbl4.typename
    local merge = tbl4.merge

    if merge == mergeTrueFn then
        return makeMergeObjectsFunction(arg3.store)(tbl4, arg1, arg2)
    end

    if merge == mergeFalseFn then
        return arg2
    end

    if arg3.overwrite then
        arg1 = nil
    end

    return merge(
        tbl4,
        arg1,
        arg2,
        makeFieldFunctionOptions(
            tbl3,
            nil,
            {
                typename = typename,
                fieldName = field.name.value,
                field = field,
                variables = arg3.variables
            },
            arg3,
            arg4 or {}
        )
    )
end

tbl1.Policies = Policies

makeFieldFunctionOptions = function(tbl3, from, arg1, tbl4, storage)
    local storeFieldName = tbl3:getStoreFieldName(arg1)
    local fieldName = fieldNameFromStoreName(storeFieldName)

    local variables = arg1.variables or tbl4.variables

    local module = {
        args = argsFromFieldSpecifier(arg1),
        field = arg1.field or nil,
        fieldName = fieldName,
        storeFieldName = storeFieldName,
        variables = variables,
        isReference = 0,
        toReference = 0,
        storage = 0,
        cache = 0,
        canRead = 0,
        readField = 0,
        mergeObjects = 0
    }

    function module.isReference(_, ...)
        return isReference(...)
    end
    module.toReference = tbl4.store.toReference
    module.storage = storage
    module.cache = tbl3.cache
    module.canRead = tbl4.store.canRead
    function module.readField(_, fieldName2, ...)
        local str1 = type(fieldName2)
        local var2 = if str1 == "table" then Object.assign(table.clone(fieldName2), fieldName2.from == Object.None and { from = "<Object.None>" } or nil) else fieldName2
        local select2 = select
        local tbl5 = { var2, if select2("#", ...) >= 1 then "<nil>" else nil }
        local tbl6

        if str1 == "string" then
            tbl6 = { fieldName = fieldName2, from = 0 }

            local select = select
            local var1 = if select("#", ...) >= 1 then ... else from
            tbl6.from = var1
        else
            if str1 ~= "table" then
                invariant2.warn(("Unexpected readField arguments: %s"):format(stringifyForDisplay(Array.from(tbl5))))

                return
            end

            tbl6 = Object.assign({}, fieldName2)

            if not hasOwnProperty(fieldName2, "from") then
                tbl6.from = from
            end
        end
        if _G.__DEV__ and tbl6.from == nil then
            invariant2.warn(
                ("Undefined 'from' passed to readField with arguments %s"):format(stringifyForDisplay(Array.from(tbl5)))
            )
        end

        if tbl6.variables == nil then
            tbl6.variables = variables
        end
        return tbl3:readField(tbl6, tbl4)
    end
    module.mergeObjects = makeMergeObjectsFunction(tbl4.store)
    return module
end

makeMergeObjectsFunction = function(tbl3)
    return function(_, arg1, arg2)
        if Array.isArray(arg1) or Array.isArray(arg2) then
            error(InvariantError.new("Cannot automatically merge arrays"))
        end

        if isNonNullObject(arg1) and isNonNullObject(arg2) then
            local fieldValue = tbl3:getFieldValue(arg1, "__typename")
            local fieldValue2 = tbl3:getFieldValue(arg2, "__typename")

            if fieldValue ~= nil and fieldValue2 ~= nil and fieldValue ~= fieldValue2 then
                return arg2
            end

            if isReference(arg1) and storeValueIsStoreObject(arg2) then
                tbl3:merge(arg1.__ref, arg2)
                return arg1
            end

            if storeValueIsStoreObject(arg1) and isReference(arg2) then
                tbl3:merge(arg1, arg2.__ref)
                return arg2
            end

            if storeValueIsStoreObject(arg1) and storeValueIsStoreObject(arg2) then
                return Object.assign({}, arg1, arg2)
            end
        end

        return arg2
    end
end

local function keyObjEncode(tbl3, tbl4)
    assert(typeof(tbl4) == "table", "specifier must be an array")

    if not next(tbl4) then
        return "[]"
    end

    return "{" .. Array.join(Array.filter(Array.map(tbl4, function(input, arg1)
        if Array.isArray(input) then
            return ""
        end

        if not tbl3[input] then
            return ""
        end

        if not (arg1 < #tbl4) then
            return HttpService:JSONEncode(input) .. ":" .. HttpService:JSONEncode(tbl3[input])
        end

        local var1 = if Array.isArray(tbl4[arg1 + 1]) then keyObjEncode(tbl3[input], tbl4[arg1 + 1]) else HttpService:JSONEncode(tbl3[input])
        return HttpService:JSONEncode(input) .. ":" .. var1
    end), function(arg1): boolean
        return arg1 ~= ""
    end), ",") .. "}"
end

keyArgsFnFromSpecifier = function(arg1)
    return function(arg2, arg3)
        if arg2 then
            return ("%s:%s"):format(arg3.fieldName, (keyObjEncode(computeKeyObject(arg2, arg1, false), arg1)))
        end

        return arg3.fieldName
    end
end

keyFieldsFnFromSpecifier = function(arg1)
    local trie = Trie.new(canUseWeakMap)
    return function(_, arg2, arg3): string
        local aliasMap

        if arg3.selectionSet and arg3.fragmentMap then
            local var1 = trie:lookupArray({ arg3.selectionSet, arg3.fragmentMap })

            if var1.aliasMap then
                aliasMap = var1.aliasMap
            else
                var1.aliasMap = makeAliasMap(arg3.selectionSet, arg3.fragmentMap)
                aliasMap = var1.aliasMap
            end
        else
            aliasMap = nil
        end

        arg3.keyObject = computeKeyObject(arg2, arg1, true, aliasMap)
        local keyObject = arg3.keyObject

        return ("%s:%s"):format(arg3.typename or "null", (keyObjEncode(keyObject, arg1)))
    end
end

makeAliasMap = function(arg1, arg2)
    local aliasMap = {}

    local set = Set.new({ arg1 })
    for _, value in set do
        Array.forEach(value.selections, function(arg3)
            if not isField(arg3) then
                local fragmentFromSelection = getFragmentFromSelection(arg3, arg2)

                if fragmentFromSelection then
                    set:add(fragmentFromSelection.selectionSet)
                end

                return
            end

            if arg3.alias then
                local value2 = arg3.alias.value
                local value3 = arg3.name.value
                if value3 ~= value2 then
                    local aliases

                    if aliasMap.aliases then
                        aliases = aliasMap.aliases
                    else
                        aliasMap.aliases = {}
                        aliases = aliasMap.aliases
                    end
                    aliases[value3] = value2
                end
            end

            if not arg3.selectionSet then
                return
            end

            local subsets

            if aliasMap.subsets then
                subsets = aliasMap.subsets
            else
                aliasMap.subsets = {}
                subsets = aliasMap.subsets
            end
            subsets[arg3.name.value] = makeAliasMap(arg3.selectionSet, arg2)
        end)
    end

    return aliasMap
end

computeKeyObject = function(tbl3, arg1, bool1: boolean, tbl4)
    local result = ({})
    local var1 = nil

    for _, value in arg1 do
        if type(value) ~= "table" then
            local aliases = tbl4 and tbl4.aliases
            local var2 = if aliases and aliases[value] then aliases[value] else value

            if hasOwnProperty(tbl3, var2) then
                result[value] = tbl3[var2]
                var1 = value
            else
                invariant2(not bool1, ("Missing field '%s' while computing key fields"):format(var2))
                var1 = nil
            end
        elseif type(var1) == "string" then
            local subsets = tbl4 and tbl4.subsets

            local subset = subsets and subsets[var1]

            result[var1] = computeKeyObject(tbl3[var1], value, bool1, subset)
        end
    end

    return result
end

tbl1.None = Object.None

return tbl1
