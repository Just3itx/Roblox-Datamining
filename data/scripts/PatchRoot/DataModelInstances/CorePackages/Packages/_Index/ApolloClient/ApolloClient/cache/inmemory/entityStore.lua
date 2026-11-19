-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:20:28Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local instanceof = LuauPolyfill.instanceof
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set
local isCallable = require(scriptParentParentParent.luaUtils.isCallable)
local objectKeysForEach = require(scriptParentParentParent.luaUtils.objectKeysForEach)

local dep = require(scriptParentParentParent.optimism).dep

local invariant = require(scriptParentParentParent.jsutils.invariant).invariant

local equal = require(scriptParentParentParent.jsutils.equal)

local Trie = require(scriptParentParentParent.wry.trie).Trie

local utilities = require(script.Parent.Parent.Parent.utilities)
local isReference = utilities.isReference

local makeReference = utilities.makeReference
local DeepMerger = utilities.DeepMerger
local maybeDeepFreeze = utilities.maybeDeepFreeze
local canUseWeakMap = utilities.canUseWeakMap
local isNonNullObject = utilities.isNonNullObject

local _types = require(script.Parent.types)

local helpers = require(script.Parent.helpers)
local hasOwn = helpers.hasOwn
local fieldNameFromStoreName = helpers.fieldNameFromStoreName

local _policies = require(script.Parent.policies)

local _Cache = require(script.Parent.Parent.core.types.Cache)

local _common = require(script.Parent.Parent.core.types.common)

local DELETE = {}

local function delModifier()
    return DELETE
end

local INVALIDATE = {}

local var1 = nil
local var2 = nil
local makeDepKey = nil
local storeObjectReconciler = nil
local supportsResultCaching = nil

local EntityStore = {}
EntityStore.__index = EntityStore

function EntityStore.new(policies, group)
    local self = (setmetatable({}, EntityStore))
    self.policies = policies
    self.group = group
    self.data = {}

    self.rootIds = {}

    self.refs = {}

    function self.getFieldValue(_, arg1, str1: string)
        return (maybeDeepFreeze(if isReference(arg1) then self:get(arg1.__ref, str1) else arg1 and arg1[str1]))
    end

    function self.canRead(_, arg1)
        if isReference(arg1) then
            return self:has(arg1.__ref)
        end
        return typeof(arg1) == "table"
    end

    function self.toReference(_, arg1, arg2)
        if type(arg1) == "string" then
            return makeReference(arg1)
        end

        if isReference(arg1) then
            return arg1
        end

        local var3 = table.unpack(self.policies:identify(arg1), 1, 1)

        if not var3 then
            return
        end
        local reference = makeReference(var3)

        if arg2 then
            self:merge(var3, arg1)
        end
        return reference
    end

    return self
end

function EntityStore.addLayer(_, _: string, _: (...any) -> (...any))
    error("not implemented abstract method")
end

function EntityStore.removeLayer(_, _: string)
    error("not implemented abstract method")
end

function EntityStore:toObject()
    return table.clone(self.data)
end

function EntityStore:has(str1: string): boolean
    return self:lookup(str1, true) ~= nil
end

function EntityStore:get(str1: string, str2: string)
    self.group:depend(str1, str2)
    if hasOwn(self.data, str1) then
        local var3 = self.data[str1]
        if Boolean.toJSBoolean(var3) and hasOwn(var3, str2) then
            return var3[str2]
        end
    end

    if str2 == "__typename" and hasOwn(self.policies.rootTypenamesById, str1) then
        return self.policies.rootTypenamesById[str1]
    elseif instanceof(self, var1) then
        return self.parent:get(str1, str2)
    end
    return nil
end

function EntityStore:lookup(str1: string, bool1: boolean?)
    if bool1 then
        self.group:depend(str1, "__exists")
    end

    if hasOwn(self.data, str1) then
        return self.data[str1]
    elseif instanceof(self, var1) then
        return self.parent:lookup(str1, bool1)
    end

    return if self.policies.rootTypenamesById[str1] then {} else nil
end

function EntityStore:merge(arg1, arg2)
    local var3 = nil

    if isReference(arg1) then
        arg1 = arg1.__ref
    end

    if isReference(arg2) then
        arg2 = arg2.__ref
    end

    local var4

    if type(arg1) == "string" then
        var3 = arg1
        var4 = self:lookup(var3)
    else
        var4 = arg1
    end

    if type(arg2) == "string" then
        var3 = arg2
        arg2 = self:lookup(var3)
    end

    if not arg2 then
        return
    end

    invariant(typeof(var3) == "string", "store.merge expects a string ID")

    local var5 = DeepMerger.new(storeObjectReconciler):merge(var4, arg2)

    self.data[var3] = var5
    if var5 == var4 then
        return
    end

    self.refs[var3] = nil

    if not self.group.caching then
        return
    end
    local tbl4 = {}

    if not var4 then
        tbl4.__exists = 1
    end

    objectKeysForEach(arg2, function(arg3)
        if var4 and var4[arg3] == var5[arg3] then
            return
        end

        tbl4[arg3] = 1

        local var6 = fieldNameFromStoreName(arg3)
        if var6 ~= arg3 and not self.policies:hasKeyArgs(var5.__typename, var6) then
            tbl4[var6] = 1
        end

        if var5[arg3] == nil and not instanceof(self, var1) then
            var5[arg3] = nil
        end
    end)

    if tbl4.__typename and not (var4 and var4.__typename) and self.policies.rootTypenamesById[var3] == var5.__typename then
        tbl4.__typename = nil
    end

    objectKeysForEach(tbl4, function(arg3)
        return self.group:dirty(var3, arg3)
    end)
end

function EntityStore:modify(str1: string, arg1)
    local var3 = self:lookup(str1)

    if var3 then
        local tbl4 = ({})
        local bool1 = false
        local bool2 = true

        local tbl5 = {
            DELETE = DELETE,
            INVALIDATE = INVALIDATE,
            isReference = function(_, ...)
                return isReference(...)
            end,
            toReference = self.toReference,
            canRead = self.canRead,
            readField = function(_, fieldName, from)
                local policies = self.policies

                if typeof(fieldName) == "string" then
                    fieldName = {
                        fieldName = fieldName,
                        from = from or makeReference(str1)
                    } or fieldName
                end

                return policies:readField(fieldName, { store = self })
            end
        }

        objectKeysForEach(var3, function(storeFieldName)
            local fieldName = fieldNameFromStoreName(storeFieldName)
            local var5 = var3[storeFieldName]
            if var5 == nil then
                return
            end

            local var6

            if isCallable(arg1) then
                var6 = arg1
            else
                local var7 = arg1

                var6 = var7[storeFieldName] or var7[fieldName]
            end

            if var6 then
                local none = if var6 == delModifier then DELETE else var6(
                    if isCallable(arg1) then nil else arg1 or nil,
                    maybeDeepFreeze(var5),
                    Object.assign(
                        table.clone(tbl5),
                        {
                            fieldName = fieldName,
                            storeFieldName = storeFieldName,
                            storage = self:getStorage(str1, storeFieldName)
                        }
                    )
                )

                if none == INVALIDATE then
                    self.group:dirty(str1, storeFieldName)
                else
                    if none == DELETE then
                        none = DeepMerger.None
                    end
                    if none ~= var5 then
                        tbl4[storeFieldName] = none
                        bool1 = true
                        var5 = none
                    end
                end
            end

            if var5 ~= nil and var5 ~= DeepMerger.None then
                bool2 = false
            end
        end)

        if bool1 then
            self:merge(str1, tbl4)

            if bool2 then
                if instanceof(self, var1) then
                    self.data[str1] = nil
                else
                    self.data[str1] = nil
                end
                self.group:dirty(str1, "__exists")
            end

            return true
        end
    end
    return false
end

function EntityStore:delete(str1: string, fieldName: string?, args)
    local var3 = self:lookup(str1)

    if not var3 then
        return false
    end

    local typename = self:getFieldValue(var3, "__typename")

    if fieldName and args then
        fieldName = self.policies:getStoreFieldName({ typename = typename, fieldName = fieldName, args = args })
    end

    return self:modify(str1, fieldName and { [fieldName] = delModifier } or delModifier)
end

function EntityStore:evict(arg1)
    local bool1 = false

    if arg1.id then
        if hasOwn(self.data, arg1.id) then
            bool1 = self:delete(arg1.id, arg1.fieldName, arg1.args)
        end
        if instanceof(self, var1) then
            bool1 = self.parent:evict(arg1) or bool1
        end

        if arg1.fieldName or bool1 then
            self.group:dirty(arg1.id, arg1.fieldName or "__exists")
        end
    end

    return bool1
end

function EntityStore.clear(arg1)
    arg1:replace(nil)
end

function EntityStore.extract(arg1)
    local var3 = arg1:toObject()
    local tbl4 = {}
    arg1:getRootIdSet():forEach(function(arg2)
        if not hasOwn(arg1.policies.rootTypenamesById, arg2) then
            table.insert(tbl4, arg2)
        end
    end)

    if #tbl4 > 0 then
        var3.__META = {
            extraRootIds = Array.sort(tbl4)
        }
    end

    return var3
end

function EntityStore:replace(arg1)
    objectKeysForEach(self.data, function(arg2)
        if not (arg1 and hasOwn(arg1, arg2)) then
            self:delete(arg2)
        end
    end)

    if arg1 == nil then
        return
    end

    local __meta = arg1.__META
    local var3 = Object.assign(table.clone(arg1), { __META = Object.None })

    objectKeysForEach(var3, function(arg2)
        self:merge(arg2, var3[arg2])
    end)

    if __meta ~= nil then
        Array.forEach(__meta.extraRootIds, self.retain, self)
    end
end

function EntityStore:getStorage(_, ...)
    error("not implemented abstract method")
end

function EntityStore:retain(str1: string)
    self.rootIds[str1] = (if Boolean.toJSBoolean(self.rootIds[str1]) then self.rootIds[str1] else 0) + 1

    return self.rootIds[str1]
end

function EntityStore:release(str1: string): number
    if not (self.rootIds[str1] > 0) then
        return 0
    end

    local rootIds = self.rootIds
    rootIds[str1] -= 1

    local rootId = self.rootIds[str1]

    if not Boolean.toJSBoolean(rootId) then
        self.rootIds[str1] = nil
    end
    return rootId
end

function EntityStore:getRootIdSet(arg1)
    if arg1 == nil then
        arg1 = Set.new()
    end
    Array.forEach(Object.keys(self.rootIds), arg1.add, arg1)
    if instanceof(self, var1) then
        self.parent:getRootIdSet(arg1)
    else
        Array.forEach(Object.keys(self.policies.rootTypenamesById), arg1.add, arg1)
    end
    return arg1
end

function EntityStore.gc(arg1)
    local rootIdSet = arg1:getRootIdSet()
    local var3 = arg1:toObject()

    for _, value in rootIdSet do
        if hasOwn(var3, value) then
            Array.forEach(Object.keys(arg1:findChildRefIds(value)), rootIdSet.add, rootIdSet)

            var3[value] = nil
        end
    end

    local var4 = Object.keys(var3)

    if Boolean.toJSBoolean(#var4) then
        local var5 = arg1

        while instanceof(var5, var1) do
            var5 = var5.parent
        end
        Array.forEach(var4, function(arg2)
            return var5:delete(arg2)
        end)
    end
    return var4
end

function EntityStore:findChildRefIds(str1: string)
    if not hasOwn(self.refs, str1) then
        self.refs[str1] = {}
        local ref = self.refs[str1]
        local var3 = self.data[str1]

        if not var3 then
            return ref
        end

        local set = Set.new({ var3 })

        for _, value in set do
            if isReference(value) then
                ref[value.__ref] = true
            end

            if not isNonNullObject(value) then
                continue
            end
            objectKeysForEach(value, function(arg1)
                local var4 = value[arg1]

                if isNonNullObject(var4) then
                    set:add(var4)
                end
            end)
        end
    end

    return self.refs[str1]
end

function EntityStore:makeCacheKey(...)
    return self.group.keyMaker:lookupArray({ ... })
end
module.EntityStore = EntityStore

local tbl4 = {}
tbl4.__index = tbl4
function tbl4.new(caching: boolean, parent)
    local self = setmetatable({}, tbl4)
    self.caching = caching
    self.parent = parent
    self.d = nil
    self:resetCaching()
    return self
end

function tbl4:resetCaching()
    self.d = if self.caching then dep() else nil

    self.keyMaker = Trie.new(canUseWeakMap)
end

function tbl4:depend(str1: string, str2: string)
    if not self.d then
        return
    end
    self.d(makeDepKey(str1, str2))
    local var3 = fieldNameFromStoreName(str2)
    if var3 ~= str2 then
        self.d(makeDepKey(str1, var3))
    end

    if self.parent then
        self.parent:depend(str1, str2)
    end
end

function tbl4:dirty(str1: string, str2: string)
    if self.d then
        self.d:dirty(makeDepKey(str1, str2), if str2 == "__exists" then "forget" else "setDirty")
    end
end

makeDepKey = function(str1: string, str2: string): string
    return str2 .. "#" .. str1
end

function module.maybeDependOnExistenceOfEntity(arg1, str1: string)
    if supportsResultCaching(arg1) then
        arg1.group:depend(str1, "__exists")
    end
end

local EntityStore_Root = setmetatable({}, { __index = EntityStore })
EntityStore_Root.__index = EntityStore_Root

function EntityStore_Root.new(tbl5)
    local policies = tbl5.policies
    local resultCaching = tbl5.resultCaching
    local seed = tbl5.seed
    if tbl5.resultCaching == nil then
        resultCaching = true
    end

    local self = setmetatable(EntityStore.new(policies, tbl4.new(resultCaching)), EntityStore_Root)

    self.stump = var2.new(self)
    self.storageTrie = Trie.new(canUseWeakMap)

    if seed then
        self:replace(seed)
    end
    return self
end

function EntityStore_Root:addLayer(str1: string, func1: (...any) -> (...any))
    return self.stump:addLayer(str1, func1)
end

function EntityStore_Root.removeLayer<T>(arg1: T): T
    return arg1
end

function EntityStore_Root:getStorage(...)
    return self.storageTrie:lookupArray({ ... })
end
module.EntityStore_Root = EntityStore_Root

var1 = setmetatable({}, { __index = EntityStore })
var1.__index = var1

function var1.new(id: string, parent, replay: (...any) -> (...any), group)
    local self = setmetatable(EntityStore.new(parent.policies, group), var1)
    self.id = id
    self.parent = parent
    self.replay = replay
    self.group = group
    replay(self, self)
    return self
end

function var1:addLayer(str1: string, func1: (...any) -> (...any))
    return var1.new(str1, self, func1, self.group)
end

function var1:removeLayer(id: string)
    local var4 = self.parent:removeLayer(id)

    if id == self.id then
        if self.group.caching then
            objectKeysForEach(self.data, function(arg1)
                local var5 = self.data[arg1]
                local var6 = var4.lookup(var4, arg1)

                if not var6 then
                    self:delete(arg1)
                    return
                end
                if not var5 then
                    self.group:dirty(arg1, "__exists")

                    objectKeysForEach(var6, function(arg2)
                        self.group:dirty(arg1, arg2)
                    end)

                    return
                end
                if var5 == var6 then
                    return
                end

                objectKeysForEach(var5, function(arg2)
                    if not equal(var5[arg2], var6[arg2]) then
                        self.group:dirty(arg1, arg2)
                    end
                end)
            end)
        end

        return var4
    elseif var4 == self.parent then
        return self
    else
        return var4:addLayer(self.id, self.replay)
    end
end

function var1:toObject()
    return Object.assign({}, self.parent:toObject(), self.data)
end

function var1:findChildRefIds(str1: string)
    local var4 = self.parent:findChildRefIds(str1)
    local __index = getmetatable((getmetatable(self))).__index

    if hasOwn(self.data, str1) then
        var4 = Object.assign({}, var4, __index.findChildRefIds(self, str1)) or var4
    end

    return var4
end

function var1:getStorage(...)
    local parent = self.parent
    while parent.parent do
        parent = parent.parent
    end
    return parent:getStorage(...)
end

var2 = setmetatable({}, { __index = var1 })
var2.__index = var2

function var2.new(arg1)
    return (setmetatable(var1.new("EntityStore.Stump", arg1, function() end, tbl4.new(arg1.group.caching, arg1.group)), var2))
end

function var2.removeLayer<T>(arg1: T): T
    return arg1
end

function var2.merge(arg1, ...)
    return arg1.parent:merge(...)
end

storeObjectReconciler = function(_, arg1, arg2, str1: string)
    local var4 = arg1[str1]
    local var5 = arg2[str1]

    return if equal(var4, var5) then var4 else var5
end

supportsResultCaching = function(arg1): boolean
    return type(arg1) == "table" and type(arg1.group) == "table" and arg1.group.caching == true
end

module.supportsResultCaching = supportsResultCaching

return module
