-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local naturalCompare = require(script.Parent.naturalCompare).naturalCompare

local tbl1 = ({})

local stringToArray = nil

tbl1.__index = tbl1

function tbl1.new(_input: string)
    local self = (setmetatable({}, tbl1))
    self._input = _input
    self._inputLowerCase = _input:lower()
    self._inputArray = stringToArray(self._inputLowerCase)

    local num1 = _input:len()
    self._rows = { table.create(num1 + 1, 0), table.create(num1 + 1, 0), table.create(num1 + 1, 0) }

    return self
end

function tbl1:measure(_input: string, num1: number)
    if self._input == _input then
        return 0
    end

    local str1 = _input:lower()

    if self._inputLowerCase == str1 then
        return 1
    end

    local var1 = stringToArray(str1)
    local _inputArray = self._inputArray

    if not (#var1 < #_inputArray) then
        local var2 = var1
        var1 = _inputArray
        _inputArray = var2
    end

    local _inputArrayLen = #_inputArray
    local num2 = #var1

    if num1 < _inputArrayLen - num2 then
        return nil
    end

    local _rows = self._rows
    for i = 0, num2 do
        _rows[1][i + 1] = i
    end

    for i = 1, _inputArrayLen do
        local _row = _rows[(i - 1) % 3 + 1]
        local _row2 = _rows[i % 3 + 1]

        _row2[1] = i
        local num3 = i

        for j = 1, num2 do
            local num4 = if _inputArray[i] == var1[j] then 0 else 1

            local num5 = math.min(_row[j + 1] + 1, _row2[j] + 1, _row[j] + num4)

            if i > 1 and j > 1 and _inputArray[i] == var1[j - 1] and _inputArray[i - 1] == var1[j] then
                num5 = math.min(num5, _rows[(i - 2) % 3 + 1][j - 1] + 1)
            end

            if num5 < num3 then
                num3 = num5
            end

            _row2[j + 1] = num5
        end

        if num1 < num3 then
            return nil
        end
    end

    local var2 = _rows[_inputArrayLen % 3 + 1][num2 + 1]
    return if var2 <= num1 then var2 else nil
end

stringToArray = function(str1: string)
    local result = ({})

    for i = 1, str1:len() do
        result[i] = str1:byte(i)
    end
    return result
end

return {
    suggestionList = function(str1: string, arg1)
        local tbl2 = ({})
        local var1 = tbl1.new(str1)

        local num1 = math.floor(str1:len() * 0.4) + 1
        for i = 1, #arg1 do
            local var2 = arg1[i]
            local var3 = var1:measure(var2, num1)
            if var3 ~= nil then
                tbl2[var2] = var3
            end
        end

        local var2 = Object.keys(tbl2)

        table.sort(var2, function(arg2, arg3): boolean
            local var3 = tbl2[arg2] - tbl2[arg3]
            return if var3 == 0 then naturalCompare(arg2, arg3) < 0 else var3 < 0
        end)

        return var2
    end
}
