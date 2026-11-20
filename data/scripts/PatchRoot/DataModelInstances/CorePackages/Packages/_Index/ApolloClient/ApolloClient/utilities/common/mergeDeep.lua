-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Set = require(scriptParentParentParentParent.LuauPolyfill).Set

local None = newproxy(true)
getmetatable(None).__tostring = function(): string
    return "Value.None"
end

local isNonNullObject = require(script.Parent.objects).isNonNullObject
local hasOwnProperty = require(scriptParentParentParent.luaUtils.hasOwnProperty)
local objectKeysForEach = require(scriptParentParentParent.luaUtils.objectKeysForEach)

local mergeDeepArray = nil

function module.mergeDeep(...)
    return mergeDeepArray({ ... })
end

local DeepMerger = {}

mergeDeepArray = function(arg1)
    local var2 = arg1[1] or {}

    local num1 = #arg1
    if num1 > 1 then
        local var3 = DeepMerger.new()
        for i = 2, num1 do
            var2 = var3:merge(var2, arg1[i])
        end
    end
    return var2
end
module.mergeDeepArray = mergeDeepArray

DeepMerger.__index = DeepMerger

function DeepMerger.new(func1: ((...any) -> (...any))?)
    local self = setmetatable({}, DeepMerger)

    self.reconciler = func1 == nil and function(arg1, arg2, arg3, arg4)
        return arg1:merge(arg2[arg4], arg3[arg4])
    end or func1

    self.isObject = isNonNullObject
    self.pastCopies = Set.new()

    return self
end

function DeepMerger.merge(tbl2, arg1, arg2, ...)
    local tbl3 = table.pack(...)

    if not (isNonNullObject(arg2) and isNonNullObject(arg1)) then
        return arg2
    end

    objectKeysForEach(arg2, function(arg3)
        if hasOwnProperty(arg1, arg3) then
            local var2 = arg1[arg3]
            if arg2[arg3] ~= var2 then
                local var3 = tbl2:reconciler(arg1, arg2, arg3, table.unpack(tbl3))

                if var3 ~= var2 then
                    arg1 = tbl2:shallowCopyForMerge(arg1)
                    arg1[arg3] = var3
                end
            end
        else
            arg1 = tbl2:shallowCopyForMerge(arg1)
            arg1[arg3] = arg2[arg3]
        end

        if arg1[arg3] == None then
            arg1[arg3] = nil
        end
    end)

    return arg1
end

function DeepMerger:shallowCopyForMerge(arg1)
    if isNonNullObject(arg1) and not self.pastCopies:has(arg1) then
        arg1 = table.clone(arg1)

        self.pastCopies:add(arg1)
    end
    return arg1
end

DeepMerger.None = None

module.DeepMerger = DeepMerger

return module
