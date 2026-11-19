-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = ({})

module.__index = module

function module.new(getId, sortPredicate, ...)
    local tbl1 = {
        keys = {},
        values = {},
        getId = getId,
        sortPredicate = sortPredicate
    }

    setmetatable(tbl1, module)

    module._InsertInPlace(tbl1, ...)

    return tbl1
end

function module:Get(arg1)
    return self.values[arg1]
end

function module:GetByIndex(arg1)
    local key = self.keys[arg1]

    return if key == nil then nil else self.values[key]
end

function module:GetIds()
    return self.keys
end

function module:Length(): number
    return #self.keys
end

function module:Delete(...)
    local module2 = module.new(self.getId, self.sortPredicate)

    local select2 = select
    local var1 = select2("#", ...)

    for k, value in pairs(self.values) do
        module2.values[k] = value
    end

    for i = 1, var1 do
        local select = select
        local var2 = select(i, ...)

        module2.values[var2] = nil
    end

    for _, key in ipairs(self.keys) do
        if module2.values[key] ~= nil then
            module2.keys[#module2.keys + 1] = key
        end
    end

    return module2
end

function module.Insert(arg1, ...)
    local var1 = arg1:_Copy()

    module._InsertInPlace(var1, ...)

    return var1
end

function module:First()
    if self.keys[1] then
        return self:Get(self.keys[1])
    end
    return nil
end

function module:Last()
    local keysLen = #self.keys
    if self.keys[keysLen] then
        return self:Get(self.keys[keysLen])
    end
    return nil
end

function module:CreateIterator()
    local num1 = 0
    local keysLen = #self.keys

    return function()
        num1 += 1
        if not (num1 <= keysLen) then
            return nil, nil, nil
        end

        local key = self.keys[num1]
        return key, self.values[key], num1
    end
end

function module:CreateReverseIterator()
    local num1 = #self.keys + 1

    return function()
        num1 -= 1
        if not (num1 > 0) then
            return nil, nil, nil
        end

        local key = self.keys[num1]
        return key, self.values[key], num1
    end
end

function module:Map(arg1)
    local module2 = module.new(self.getId, self.sortPredicate)

    for value, value2 in self:CreateIterator() do
        module2:_InsertInPlaceUnsorted(arg1(value2, value))
    end

    module2:_Sort()

    return module2
end

function module.Merge(arg1, ...)
    local var1 = nil

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var2 = select(i, ...)

        if not (var2:Length() > 0) then
            continue
        end

        var1 = var1 or arg1:_Copy()

        for _, value in var2:CreateIterator() do
            var1:_InsertInPlaceUnsorted(value)
        end
    end

    if not var1 then
        return arg1
    end

    var1:_Sort()

    return var1
end

function module:_Copy()
    local module2 = module.new(self.getId, self.sortPredicate)

    for i, key in ipairs(self.keys) do
        module2.keys[i] = key
    end

    for k, value in pairs(self.values) do
        module2.values[k] = value
    end

    return module2
end

function module:_InsertInPlaceUnsorted(...)
    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)
        local id = self.getId(var1)

        if not self.values[id] then
            table.insert(self.keys, id)
        end

        self.values[id] = var1
    end
end

function module:_Sort()
    table.sort(self.keys, function(arg1, arg2)
        local var1 = self.values[arg1]
        local var2 = self.values[arg2]

        return self.sortPredicate(var1, var2)
    end)
end

function module._InsertInPlace(arg1, ...)
    arg1:_InsertInPlaceUnsorted(...)
    arg1:_Sort()
end

return module
