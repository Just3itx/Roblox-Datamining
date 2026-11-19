-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:50:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local uuid = require(scriptParentParentParent.utilities.common.makeUniqueId).uuid

local tbl1 = {}

local var1 = nil

local tbl2 = {}

local num1 = 1

local function makeSlotClass()
    local module = {}
    module.__index = module

    function module.new()
        local self = setmetatable({}, module)

        self.id = Array.join({ "slot", num1, DateTime.now().UnixTimestampMillis, uuid() }, ":")
        num1 += 1

        return self
    end

    function module:hasValue()
        local var2 = var1

        while var2 do
            if var2.slots[self.id] then
                local slot = var2.slots[self.id]
                if slot ~= tbl2 then
                    if var2 ~= var1 then
                        var1.slots[self.id] = slot
                    end
                    return true
                end

                break
            end

            var2 = var2.parent
        end

        if var1 then
            var1.slots[self.id] = tbl2
        end
        return false
    end

    function module:getValue()
        if self:hasValue() then
            return var1.slots[self.id]
        end

        return nil
    end

    function module:withValue(arg1, func1: (...any) -> (...any), arg2, arg3)
        local slots = {
            [self.id] = arg1
        }
        local parent = var1
        var1 = { parent = parent, slots = slots }

        local success, result, result2 = pcall(function()
            return func1(arg3, table.unpack(arg2 or {})), true
        end)
        var1 = parent

        if result2 then
            return result
        end
        if not success then
            error(result)
        end
        return nil
    end

    function module.bind(callback: (...any) -> (...any))
        local var2 = var1
        return function(arg1, ...)
            local var3 = var1
            var1 = var2
            local success, result = pcall(callback, arg1, table.unpack({ ... }))
            var1 = var3
            if not success then
                error(result)
            end
            return result
        end
    end

    function module.noContext(func1: (...any) -> (...any), arg1, arg2)
        if not var1 then
            return func1(arg2, table.unpack(arg1 or {}))
        end

        local var2 = var1
        local success, result, result2 = pcall(function()
            var1 = nil

            return func1(arg2, table.unpack(arg1 or {})), true
        end)

        var1 = var2

        if result2 then
            return result
        end
        if not success then
            error(result)
        end

        return nil
    end

    return module
end

local wryContextSlot = Boolean.toJSBoolean(Array["@wry/context:Slot"]) and Array["@wry/context:Slot"]

if not wryContextSlot then
    local slotClass = makeSlotClass()
    pcall(function()
        Array["@wry/context:Slot"] = slotClass
    end)

    wryContextSlot = slotClass
end

tbl1.Slot = wryContextSlot

return tbl1
