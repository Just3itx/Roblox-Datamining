-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Set = LuauPolyfill.Set
local WeakMap = LuauPolyfill.WeakMap
local Map = LuauPolyfill.Map

local Object = require(scriptParentParentParent.luaUtils.Object)

local HttpService = game:GetService("HttpService")

local tbl1 = {}
local Trie = require(scriptParentParentParent.wry.trie).Trie

local utilities = require(script.Parent.Parent.Parent.utilities)
local canUseWeakMap = utilities.canUseWeakMap

local isNonNullObject = utilities.isNonNullObject

local sortedEncode = require(scriptParentParentParent.luaUtils.sortedEncode).sortedEncode

local resetCanonicalStringify = nil

local var1 = nil
local var2 = nil

local function shallowCopy(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (table.clone(arg1))
end

local function isArrayLike(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return #arg1 == 0 and not next(arg1) or #arg1 > 1
end

local ObjectCanon = {}

ObjectCanon.__index = ObjectCanon

function ObjectCanon.new()
    local self = setmetatable({}, ObjectCanon)

    self.known = Set.new()
    self.pool = Trie.new(canUseWeakMap)
    self.passes = WeakMap.new()

    self.keysByJSON = Map.new(nil)

    self.empty = self:admit({})

    return self
end

function ObjectCanon:isKnown(arg1)
    return isNonNullObject(arg1) and self.known:has(arg1)
end

function ObjectCanon:pass(arg1)
    if not isNonNullObject(arg1) then
        return arg1
    end

    local var3 = shallowCopy(arg1)

    self.passes:set(var3, arg1)
    return var3
end

function ObjectCanon:admit(arg1)
    if isNonNullObject(arg1) then
        local var3 = self.passes:get(arg1)

        if var3 then
            return var3
        end

        if Object.getPrototypeOf(arg1) == nil then
            if isArrayLike(arg1) then
                if self.known:has(arg1) then
                    return arg1
                end

                local array = Array.map(arg1, self.admit, self)

                local var5 = self.pool:lookupArray(array)

                if not var5.array then
                    var5.array = array
                    self.known:add(var5.array)

                    if _G.__DEV__ then
                        Object.freeze(array)
                    end
                end

                return var5.array
            end
            if self.known:has(arg1) then
                return arg1
            end
            local prototypeOf = Object.getPrototypeOf(arg1)
            local tbl3 = { prototypeOf }
            local var4 = self:sortedKeys(arg1)
            table.insert(tbl3, var4.json)
            local num1 = #tbl3
            Array.forEach(var4.sorted, function(arg2)
                local tbl4 = tbl3
                local var5 = self
                local var6 = arg1[arg2]
                table.insert(tbl4, var5:admit(var6))
            end)

            local var5 = self.pool:lookupArray(tbl3)

            if not var5.object then
                var5.object = Object.create(prototypeOf)
                local object = var5.object
                self.known:add(object)
                Array.forEach(var4.sorted, function(arg2, arg3)
                    object[arg2] = tbl3[num1 + arg3]
                end)

                if _G.__DEV__ then
                    Object.freeze(object)
                end
            end

            return var5.object
        end
    end

    return arg1
end

function ObjectCanon:sortedKeys(tbl3)
    local input = Object.keys(tbl3)
    local var3 = self.pool:lookupArray(input)

    if not var3.keys then
        Array.sort(input)
        local json = HttpService:JSONEncode(input)

        var3.keys = self.keysByJSON:get(json)

        if not var3.keys then
            var3.keys = { sorted = input, json = json }

            self.keysByJSON:set(json, var3.keys)
        end
    end

    return var3.keys
end

tbl1.ObjectCanon = ObjectCanon

tbl1.canonicalStringify = Object.assign(setmetatable({}, {
    __call = function(_, input)
        if not isNonNullObject(input) then
            return HttpService:JSONEncode(input)
        end

        if var1 == nil then
            resetCanonicalStringify()
        end
        local var3 = var1:admit(input)
        local var4 = var2:get(var3)
        if var4 == nil then
            local var5 = var2

            var4 = sortedEncode(var3)
            var5:set(var3, var4)
        end

        return var4
    end
}), {
    reset = function(_)
        return resetCanonicalStringify()
    end
})

resetCanonicalStringify = function()
    var1 = ObjectCanon.new()
    var2 = WeakMap.new()
end

return tbl1
