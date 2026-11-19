-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1, var2 = ...
arg0 = var1
arg1 = var2

local function x1(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 + arg2
end

local function x2(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 - arg2
end

local function x3(arg1, arg2)
    return arg2 - arg1
end

local function x4(arg1, arg2): number?
    return tonumber(tostring(arg2 % 1000) .. tostring(math.abs(arg1 % 1000)))
end

local function x5(arg1, arg2): number?
    return tonumber(tostring(arg2 % 1337) .. tostring(math.abs(arg1 % 1337)))
end

local function x6(arg1, arg2): number -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 % 1000 * (arg2 % 1000)
end

local function x7(arg1, arg2): number
    return arg1 % 1337 * (arg2 % 1337)
end

local function x8(arg1, arg2)
    return x6(x1(arg1, arg2), (x2(arg1, arg2)))
end

local tbl1 = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8
}
local random = Random.new(5)
for _ = 1, 32 do
    local num1 = random:NextInteger(1, 8)
    local num2 = random:NextInteger(1, 8)
    local var3 = tbl1[num1]
    tbl1[num1] = tbl1[num2]
    tbl1[num2] = var3
end
local tbl2 = {}
tbl2[tbl1[1]] = x1
tbl2[tbl1[2]] = x2
tbl2[tbl1[3]] = x3
tbl2[tbl1[4]] = x4
tbl2[tbl1[5]] = x5
tbl2[tbl1[6]] = x6
tbl2[tbl1[7]] = x7
tbl2[tbl1[8]] = x8

local function x9(arg1, arg2)
    local num1 = 393
    local num2 = 1

    for _ = 1, 16 do
        local num3 = math.abs(arg2 + num1 + num2) % 8 + 1
        num1 = (num1 + tbl2[num3](num1 + arg1, arg2)) % 10000000
        num2 += 1
    end
    return num1
end

return (x9(arg0, arg1))
