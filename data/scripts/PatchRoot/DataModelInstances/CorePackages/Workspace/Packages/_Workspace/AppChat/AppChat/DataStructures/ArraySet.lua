-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.__index(arg1, arg2)
    if type(arg2) == "number" then
        return arg1:at(arg2)
    end
    return module[arg2]
end

function module.__len(arg1)
    return arg1:size()
end

function module.__newindex(arg1, arg2, arg3)
    arg1._indexToValue[arg2] = arg3
end

function module.__iter(arg1)
    local num1 = 0
    return function()
        num1 += 1
        return if num1 <= arg1._size then arg1._indexToValue[num1] else nil
    end
end

function module.add(arg1, arg2): boolean
    if arg1._valueToIndex[arg2] then
        return false
    end

    local _size = arg1._size + 1
    arg1._valueToIndex[arg2] = _size
    arg1._indexToValue[_size] = arg2
    arg1._size = _size

    return true
end

function module.prependAll(tbl1, tbl2): boolean
    local tbl3 = {}
    local tbl4 = ({})
    for _, value in tbl2 do
        if not (tbl1._valueToIndex[value] or tbl4[value]) then
            tbl4[value] = true
            table.insert(tbl3, value)
        end
    end

    if #tbl3 == 0 then
        return false
    end

    local num1 = #tbl3

    for i = tbl1._size, 1, -1 do
        local var1 = tbl1._indexToValue[i]
        tbl1._indexToValue[i + num1] = var1
        tbl1._valueToIndex[var1] = i + num1
    end

    for value, value2 in tbl3 do
        tbl1._indexToValue[value] = value2
        tbl1._valueToIndex[value2] = value
    end

    tbl1._size += num1
    return true
end

function module.remove(arg1, arg2): boolean
    if not arg1._valueToIndex[arg2] then
        return false
    end

    local var1 = arg1._valueToIndex[arg2]

    arg1._valueToIndex[arg2] = nil

    for i = var1 + 1, arg1._size do
        local var2 = arg1._indexToValue[i]
        arg1._indexToValue[i - 1] = var2
        arg1._valueToIndex[var2] = i - 1
    end

    arg1._indexToValue[arg1._size] = nil
    arg1._size -= 1

    return true
end

function module.has(arg1, arg2): boolean
    return arg1._valueToIndex[arg2] ~= nil
end

function module.clear(arg1)
    arg1._valueToIndex = {}
    arg1._indexToValue = {}
    arg1._size = 0
end

function module.size(arg1)
    return arg1._size
end

function module.at(tbl1, _size: number)
    return if _size < 1 or tbl1._size < _size then nil else tbl1._indexToValue[_size]
end

function module.indexOf(arg1, arg2)
    return arg1._valueToIndex[arg2]
end

function module.toArray(arg1)
    return table.clone(arg1._indexToValue)
end

function module.values(arg1)
    return arg1._indexToValue
end

function module.clone(arg1)
    return module.new(arg1._indexToValue)
end

function module.new(tbl1)
    local var1 = setmetatable({ _valueToIndex = {}, _indexToValue = {}, _size = 0 }, module)

    if tbl1 then
        for _, value in tbl1 do
            var1:add(value)
        end
    end

    return var1
end

return module
