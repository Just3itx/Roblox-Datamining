-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:31:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Set = LuauPolyfill.Set
local Map = LuauPolyfill.Map
local Error = LuauPolyfill.Error

local tbl1 = {}

local var1 = newproxy(true)
getmetatable(var1).__tostring = function(): string
    return "Value.None"
end

local rememberParent = nil
local reallyRecompute = nil
local recomputeNewValue = nil
local mightBeDirty = nil
local setClean = nil
local reportDirty = nil
local reportClean = nil
local eachParent = nil
local reportDirtyChild = nil
local reportCleanChild = nil
local removeDirtyChild = nil
local forgetChildren = nil
local forgetChild = nil
local maybeSubscribe = nil

local parentEntrySlot = require(script.Parent.context).parentEntrySlot
local _initTypes = require(script.Parent.initTypes)

local _depTypes = require(script.Parent.depTypes)

local helpers = require(script.Parent.helpers)
local maybeUnsubscribe = helpers.maybeUnsubscribe
local toArray = helpers.toArray

local tbl2 = {}

local function assert(arg1, str1: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    if not arg1 then
        error(Error.new(str1 or "assertion failure"))
    end
end

local _entryTypes = require(script.Parent.entryTypes)
local _anyEntryTypes = require(script.Parent.anyEntryTypes)

local function valueIs(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = #arg1

    return num1 > 0 and num1 == #arg2 and arg1[num1] == arg2[num1]
end

local function valueGet(arg1)
    if arg1[2] ~= nil then
        error(arg1[2])
        return
    end

    if arg1[1] ~= nil then
        return if arg1[1] == var1 then nil else arg1[1]
    end
    error(Error.new("unknown value"))
end

local function valueCopy(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (table.clone(arg1))
end

local Entry = {}
Entry.__index = Entry
Entry.count = 0

function Entry.new(fn: (...any) -> (...any))
    local self = setmetatable({}, Entry)

    self.parents = Set.new()

    self.childValues = Map.new(nil)

    self.dirtyChildren = nil
    self.dirty = true
    self.recomputing = false
    self.value = {}

    self.deps = nil

    self.fn = fn

    local tbl4 = Entry
    tbl4.count += 1

    return self
end

function Entry:peek()
    if #self.value ~= 1 or mightBeDirty(self) then
        return nil
    end

    rememberParent(self)
    return self.value[1]
end

function Entry:recompute(arg1)
    if self.recomputing then
        error(Error.new("already recomputing"))
    end

    rememberParent(self)
    if mightBeDirty(self) then
        return reallyRecompute(self, arg1)
    end
    return valueGet(self.value)
end

function Entry:setDirty()
    if self.dirty then
        return
    end
    self.dirty = true

    self.value = {}

    reportDirty(self)

    maybeUnsubscribe(self)
end

function Entry.dispose(arg1)
    arg1:setDirty()

    forgetChildren(arg1)

    eachParent(arg1, function(arg2, _)
        arg2:setDirty()
        forgetChild(arg2, arg1)
        return nil
    end)
end

function Entry.forget(arg1)
    arg1:dispose()
end

function Entry:dependOn(arg1)
    arg1:add(self)
    if not self.deps then
        self.deps = table.remove(tbl2) or Set.new()
    end

    self.deps:add(arg1)
end

function Entry:forgetDeps()
    if not self.deps then
        return
    end
    Array.forEach(toArray(self.deps), function(arg1)
        arg1:delete(self)
    end)
    self.deps:clear()
    table.insert(tbl2, self.deps)
    self.deps = nil
end

tbl1.Entry = Entry

rememberParent = function(arg1)
    local value = parentEntrySlot:getValue()

    if not value then
        return nil
    end

    arg1.parents:add(value)

    if not value.childValues:has(arg1) then
        value.childValues:set(arg1, {})
    end

    if mightBeDirty(arg1) then
        reportDirtyChild(value, arg1)
    else
        reportCleanChild(value, arg1)
    end

    return value
end

reallyRecompute = function(arg1, arg2)
    forgetChildren(arg1)

    parentEntrySlot:withValue(arg1, recomputeNewValue, { arg1, arg2 })

    if maybeSubscribe(arg1, arg2) then
        setClean(arg1)
    end

    return valueGet(arg1.value)
end

recomputeNewValue = function(_, arg1, tbl4: {any})
    arg1.recomputing = true

    table.clear(arg1.value)

    local success, result = pcall(arg1.fn, table.unpack(tbl4))
    if success then
        arg1.value[1] = result

        if arg1.value[1] == nil then
            arg1.value[1] = var1
        end
    end
    if not success then
        arg1.value[2] = result
    end

    arg1.recomputing = false
end

mightBeDirty = function(arg1)
    local dirty = arg1.dirty
    return dirty or arg1.dirtyChildren ~= nil and arg1.dirtyChildren.size > 0
end

setClean = function(arg1)
    arg1.dirty = false

    if mightBeDirty(arg1) then
        return
    end

    reportClean(arg1)
end

reportDirty = function(arg1)
    eachParent(arg1, reportDirtyChild)
end

reportClean = function(arg1)
    eachParent(arg1, reportCleanChild)
end

eachParent = function(arg1, callback: (...any) -> (...any))
    local size = arg1.parents.size

    if not size then
        return
    end
    local var2 = toArray(arg1.parents)
    for i = 1, size do
        callback(var2[i], arg1)
    end
end

reportDirtyChild = function(arg1, arg2)
    if _G.__DEV__ then
        local var2, var3 = arg1.childValues:has(arg2)
        assert(var2, var3)
        local var4, var5 = mightBeDirty(arg2)
        assert(var4, var5)
    end

    local bool1 = not mightBeDirty(arg1)

    if not arg1.dirtyChildren then
        arg1.dirtyChildren = table.remove(tbl2) or Set.new()
    elseif arg1.dirtyChildren:has(arg2) then
        return
    end

    arg1.dirtyChildren:add(arg2)

    if bool1 then
        reportDirty(arg1)
    end
end

reportCleanChild = function(arg1, arg2)
    if _G.__DEV__ then
        local var2, var3 = arg1.childValues:has(arg2)
        assert(var2, var3)

        if mightBeDirty(arg2) then
            error(Error.new("assertion failure"))
        end
    end

    local var2 = arg1.childValues:get(arg2)
    if #var2 == 0 then
        arg1.childValues:set(arg2, (valueCopy(arg2.value)))
    elseif not valueIs(var2, arg2.value) then
        arg1:setDirty()
    end

    removeDirtyChild(arg1, arg2)

    if mightBeDirty(arg1) then
        return
    end

    reportClean(arg1)
end

removeDirtyChild = function(arg1, arg2)
    local dirtyChildren = arg1.dirtyChildren
    if dirtyChildren == nil then
        return
    end

    dirtyChildren:delete(arg2)
    if dirtyChildren.size ~= 0 then
        return
    end

    if #tbl2 < 100 then
        table.insert(tbl2, dirtyChildren)
    end
    arg1.dirtyChildren = nil
end

forgetChildren = function(arg1)
    if arg1.childValues.size > 0 then
        local var2 = table.clone(arg1.childValues:keys())
        Array.forEach(var2, function(arg2)
            forgetChild(arg1, arg2)
        end)
    end

    arg1:forgetDeps()

    if arg1.dirtyChildren ~= nil then
        error(Error.new("assertion failure"))
    end
end

forgetChild = function(arg1, arg2)
    arg2.parents:delete(arg1)
    arg1.childValues:delete(arg2)
    removeDirtyChild(arg1, arg2)
end

maybeSubscribe = function(arg1, tbl4: {any}): boolean
    if typeof(arg1.subscribe) ~= "function" or pcall(function()
        maybeUnsubscribe(arg1)
        arg1.unsubscribe = arg1.subscribe(table.unpack(tbl4))
        return nil, false
    end) then
        return true
    end

    arg1:setDirty()
    return false
end

return tbl1
