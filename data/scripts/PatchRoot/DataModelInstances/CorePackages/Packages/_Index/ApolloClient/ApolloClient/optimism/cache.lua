-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:31:07Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Map = require(scriptParentParentParent.LuauPolyfill).Map

local tbl1 = {}

local function defaultDispose() end

local Cache = {}
Cache.__index = Cache

function Cache.new(num1: number?, dispose: ((...any) -> (...any))?)
    local max = num1 == nil and math.huge or num1

    if dispose == nil then
        dispose = defaultDispose
    end

    local self = setmetatable({}, Cache)

    self.map = Map.new(nil)
    self.newest = nil
    self.oldest = nil

    self.max = max
    self.dispose = dispose

    return self
end

function Cache:has(arg1)
    return self.map:has(arg1)
end

function Cache.get(arg1, arg2)
    local node = arg1:getNode(arg2)

    return node and node.value
end

function Cache:getNode(arg1)
    local var1 = self.map:get(arg1)

    if var1 and var1 ~= self.newest then
        local older = var1.older
        local newer = var1.newer

        if newer then
            newer.older = older
        end

        if older then
            older.newer = newer
        end

        var1.older = self.newest
        var1.older.newer = var1

        var1.newer = nil
        self.newest = var1

        if var1 == self.oldest then
            self.oldest = newer
        end
    end

    return var1
end

function Cache:set(key, value)
    local node = self:getNode(key)

    if node then
        node.value = value
        return node.value
    end

    local tbl3 = {
        key = key,
        value = value,
        newer = nil,
        older = self.newest
    }

    if self.newest then
        self.newest.newer = tbl3
    end

    self.newest = tbl3

    self.oldest = self.oldest or tbl3

    self.map:set(key, tbl3)
    return tbl3.value
end

function Cache:clean()
    while self.oldest and self.map.size > self.max do
        self:delete(self.oldest.key)
    end
end

function Cache:delete(arg1): boolean
    local var1 = self.map:get(arg1)

    if not var1 then
        return false
    end

    if var1 == self.newest then
        self.newest = var1.older
    end

    if var1 == self.oldest then
        self.oldest = var1.newer
    end

    if var1.newer then
        var1.newer.older = var1.older
    end

    if var1.older then
        var1.older.newer = var1.newer
    end

    self.map:delete(arg1)
    self.dispose(var1.value, arg1)

    return true
end

tbl1.Cache = Cache

return tbl1
