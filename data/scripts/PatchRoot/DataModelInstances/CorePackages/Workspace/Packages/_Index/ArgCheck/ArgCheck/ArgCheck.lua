-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("DebugLuaArgCheck", false)
local isStudio = game:GetService("RunService"):IsStudio()

local module = {}

function module.isEnabled()
    return bool1 or _G.__TESTEZ_RUNNING_TEST__ or isStudio
end

local function assert_(arg1, str1: string?) -- Luacid: Inlined by compiler; 10 call sites recovered
    if module.isEnabled() then
        assert(arg1, str1)
    end
end

local function stubArgCheckFunction(): boolean
    return true
end

function module.wrap(arg1)
    return if module.isEnabled() then arg1 else stubArgCheckFunction
end

function module.isNonNegativeNumber<T>(arg1: T, arg2): T
    local bool2 = typeof(arg1) == "number" and arg1 >= 0
    assert_(bool2, string.format("expects %s to be a non-negative number!", arg2))

    return arg1
end

function module.isType<T>(arg1: T, arg2, arg3): T
    assert_(typeof(arg1) == arg2, string.format("expects %s to be a %s! it was: %s", arg3, arg2, typeof(arg1)))

    return arg1
end

function module.isInTypes(arg1, arg2, arg3)
    for _, value in ipairs(arg2) do
        if typeof(arg1) == value then
            return arg1
        end
    end

    assert_(false, string.format("expects %s to be one of expectedTypes! it was: %s", arg3, typeof(arg1)))

    return arg1
end

function module.isTypeOrNil<T>(arg1: T, arg2, arg3): T
    assert_(
        arg1 == nil or typeof(arg1) == arg2,
        string.format("expects %s to be a %s! it was: %s", arg3, arg2, typeof(arg1))
    )

    return arg1
end

function module.isNotNil<T>(arg1: T, arg2): T
    assert_(arg1 ~= nil, string.format("expects %s to be not nil!", arg2))

    return arg1
end

function module.isNonEmptyString<T>(arg1: T, arg2): T
    local bool2 = typeof(arg1) == "string" and arg1 ~= ""
    assert_(bool2, string.format("expects %s to be a non-empty string!", arg2))

    return arg1
end

function module.isEqual<T>(arg1: T, arg2, arg3): T
    assert_(arg1 == arg2, string.format("expects %s to equal %s! it was: %s", arg3, tostring(arg2), tostring(arg1)))

    return arg1
end

function module.representsInteger<T>(arg1: T, arg2): T
    local var1 = tonumber(arg1)
    assert_(var1 ~= nil, string.format("expects %s to represent a number!", arg2))
    assert_(var1 % 1 == 0, string.format("expects %s to represent an integer!", arg2))

    return arg1
end

function module.matchesInterface(arg1, arg2, arg3, arg4)
    if module.isEnabled() then
        local tbl1 = {
            integer = module.representsInteger,
            nonEmptyString = module.isNonEmptyString
        }
        if type(arg2) == "string" then
            if arg4 and arg4[arg2] then
                module.matchesInterface(arg1, arg4[arg2], arg3, arg4)
                return arg1
            end
            local var1 = tbl1[arg2]
            if type(var1) == "function" then
                var1(arg1, arg3)
                return arg1
            end
            module.isType(arg1, arg2, arg3)
            return arg1
        end

        module.isType(arg1, "table", arg3)
        if arg2[1] ~= nil then
            for i, value in ipairs(arg1) do
                module.matchesInterface(value, arg2[1], arg3 .. "[" .. i .. "]", arg4)
            end

            return arg1
        end

        for k, value in pairs(arg2) do
            if string.sub(k, 1, 1) == "_" then
                continue
            end

            local var1 = arg3 .. "." .. k
            local var2 = arg1[k]
            if arg2._required and arg2._required[k] or var2 ~= nil then
                module.matchesInterface(var2, value, var1, arg4)
            end
        end
    end

    return arg1
end

function module.assert(...)
    assert_(...)
end

return module
