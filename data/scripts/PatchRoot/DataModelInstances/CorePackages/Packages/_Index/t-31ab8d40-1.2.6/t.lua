-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1 = typeof or type

local function primitive(str1: string) -- Luacid: Inlined by compiler; 36 call sites recovered
    return function(arg1)
        local var2 = var1(arg1)
        if var2 == str1 then
            return true
        end
        return false, string.format("%s expected, got %s", str1, var2)
    end
end

local module = {}

function module.any(arg1)
    if arg1 ~= nil then
        return true
    end
    return false, "any expected, got nil"
end

module.boolean = primitive("boolean")
module.thread = primitive("thread")
module.callback = primitive("function")
module.none = primitive("nil")
module.string = primitive("string")
module.table = primitive("table")
module.userdata = primitive("userdata")

function module.number(arg1)
    local var2 = var1(arg1)
    if var2 == "number" then
        if arg1 == arg1 then
            return true
        end
        return false, "unexpected NaN value"
    end

    return false, string.format("number expected, got %s", var2)
end

function module.nan(arg1)
    if arg1 ~= arg1 then
        return true
    end
    return false, "unexpected non-NaN value"
end

module.Axes = primitive("Axes")
module.BrickColor = primitive("BrickColor")
module.CFrame = primitive("CFrame")
module.Color3 = primitive("Color3")
module.ColorSequence = primitive("ColorSequence")
module.ColorSequenceKeypoint = primitive("ColorSequenceKeypoint")
module.DockWidgetPluginGuiInfo = primitive("DockWidgetPluginGuiInfo")
module.Faces = primitive("Faces")
module.Instance = primitive("Instance")
module.NumberRange = primitive("NumberRange")
module.NumberSequence = primitive("NumberSequence")
module.NumberSequenceKeypoint = primitive("NumberSequenceKeypoint")
module.PathWaypoint = primitive("PathWaypoint")
module.PhysicalProperties = primitive("PhysicalProperties")
module.Random = primitive("Random")
module.Ray = primitive("Ray")
module.Rect = primitive("Rect")
module.Region3 = primitive("Region3")
module.Region3int16 = primitive("Region3int16")
module.TweenInfo = primitive("TweenInfo")
module.UDim = primitive("UDim")
module.UDim2 = primitive("UDim2")
module.Vector2 = primitive("Vector2")
module.Vector3 = primitive("Vector3")
module.Vector3int16 = primitive("Vector3int16")
module.Enum = primitive("Enum")
module.EnumItem = primitive("EnumItem")
module.RBXScriptSignal = primitive("RBXScriptSignal")
module.RBXScriptConnection = primitive("RBXScriptConnection")

function module.literal(...)
    local select2 = select
    local var2 = select2("#", ...)
    if var2 == 1 then
        local var3 = ...
        return function(arg1)
            if arg1 ~= var3 then
                return false, string.format("expected %s, got %s", tostring(var3), tostring(arg1))
            end
            return true
        end
    end
    local tbl1 = ({})
    for i = 1, var2 do
        local select = select
        local var3 = select(i, ...)
        tbl1[i] = module.literal(var3)
    end
    return module.union(unpack(tbl1))
end

module.exactly = module.literal

function module.keyOf(arg1)
    local tbl1 = {}
    for k in pairs(arg1) do
        tbl1[#tbl1 + 1] = k
    end
    return module.literal(unpack(tbl1))
end

function module.valueOf(arg1)
    local tbl1 = {}
    for _, value in pairs(arg1) do
        tbl1[#tbl1 + 1] = value
    end
    return module.literal(unpack(tbl1))
end

function module.integer(arg1)
    local var2, var3 = module.number(arg1)
    if not var2 then
        return false, var3 or ""
    elseif arg1 % 1 == 0 then
        return true
    end
    return false, string.format("integer expected, got %s", arg1)
end

function module.numberMin(arg1)
    return function(arg2)
        local var2, var3 = module.number(arg2)
        if not var2 then
            return false, var3 or ""
        elseif arg1 <= arg2 then
            return true
        end
        return false, string.format("number >= %s expected, got %s", arg1, arg2)
    end
end

function module.numberMax(arg1)
    return function(arg2)
        local var2, var3 = module.number(arg2)
        if not var2 then
            return false, var3
        elseif arg2 <= arg1 then
            return true
        end
        return false, string.format("number <= %s expected, got %s", arg1, arg2)
    end
end

function module.numberMinExclusive(arg1)
    return function(arg2)
        local var2, var3 = module.number(arg2)
        if not var2 then
            return false, var3 or ""
        elseif arg1 < arg2 then
            return true
        end
        return false, string.format("number > %s expected, got %s", arg1, arg2)
    end
end

function module.numberMaxExclusive(arg1)
    return function(arg2)
        local var2, var3 = module.number(arg2)
        if not var2 then
            return false, var3 or ""
        elseif arg2 < arg1 then
            return true
        end
        return false, string.format("number < %s expected, got %s", arg1, arg2)
    end
end

module.numberPositive = module.numberMinExclusive(0)

module.numberNegative = module.numberMaxExclusive(0)

function module.numberConstrained(arg1, arg2)
    assert(module.number(arg1) and module.number(arg2))
    local var2 = module.numberMin(arg1)
    local var3 = module.numberMax(arg2)
    return function(arg3)
        local var4, var5 = var2(arg3)
        if not var4 then
            return false, var5 or ""
        end

        local var6, var7 = var3(arg3)
        if not var6 then
            return false, var7 or ""
        end

        return true
    end
end

function module.numberConstrainedExclusive(arg1, arg2)
    assert(module.number(arg1) and module.number(arg2))
    local var2 = module.numberMinExclusive(arg1)
    local var3 = module.numberMaxExclusive(arg2)
    return function(arg3)
        local var4, var5 = var2(arg3)
        if not var4 then
            return false, var5 or ""
        end

        local var6, var7 = var3(arg3)
        if not var6 then
            return false, var7 or ""
        end

        return true
    end
end

function module.match(arg1)
    assert(module.string(arg1))
    return function(arg2)
        local var2, var3 = module.string(arg2)
        if not var2 then
            return false, var3
        elseif string.match(arg2, arg1) == nil then
            return false, string.format("\"%s\" failed to match pattern \"%s\"", arg2, arg1)
        end

        return true
    end
end

function module.optional(arg1)
    assert(module.callback(arg1))
    return function(arg2)
        if arg2 == nil then
            return true
        end
        local var2, var3 = arg1(arg2)
        if var2 then
            return true
        end
        return false, string.format("(optional) %s", var3 or "")
    end
end

function module.tuple(...)
    local tbl1 = { ... }
    return function(...)
        local tbl2 = { ... }
        for i = 1, #tbl1 do
            local var2, var3 = tbl1[i](tbl2[i])
            if var2 == false then
                return false, string.format("Bad tuple index #%s:\n\t%s", i, var3 or "")
            end
        end
        return true
    end
end

function module.keys(arg1)
    assert(module.callback(arg1))
    return function(arg2)
        local var2, var3 = module.table(arg2)
        if var2 == false then
            return false, var3 or ""
        end

        for k in pairs(arg2) do
            local var4, var5 = arg1(k)
            if var4 == false then
                return false, string.format("bad key %s:\n\t%s", tostring(k), var5 or "")
            end
        end

        return true
    end
end

function module.values(callback)
    assert(module.callback(callback))
    return function(arg1)
        local var2, var3 = module.table(arg1)
        if var2 == false then
            return false, var3 or ""
        end

        for k, value in pairs(arg1) do
            local var4, var5 = callback(value)
            if var4 == false then
                return false, string.format("bad value for key %s:\n\t%s", tostring(k), var5 or "")
            end
        end

        return true
    end
end

function module.map(arg1, callback)
    assert(module.callback(arg1), module.callback(callback))
    local var2 = module.keys(arg1)
    local var3 = module.values(callback)
    return function(arg2)
        local var4, var5 = var2(arg2)
        if not var4 then
            return false, var5 or ""
        end

        local var6, var7 = var3(arg2)
        if not var6 then
            return false, var7 or ""
        end

        return true
    end
end

local var2 = module.keys(module.integer)

function module.array(callback)
    assert(module.callback(callback))
    local var3 = module.values(callback)
    return function(arg1)
        local var4, var5 = var2(arg1)
        if var4 == false then
            return false, string.format("[array] %s", var5 or "")
        end

        local num1 = 0

        for _, _ in ipairs(arg1) do
            num1 += 1
        end

        for k in pairs(arg1) do
            if k < 1 or num1 < k then
                return false, string.format("[array] key %s must be sequential", tostring(k))
            end
        end

        local var6, var7 = var3(arg1)
        if not var6 then
            return false, string.format("[array] %s", var7 or "")
        end

        return true
    end
end

local var3 = module.array(module.callback)

function module.union(...)
    local tbl1 = { ... }
    assert(var3(tbl1))
    return function(arg1)
        for _, value in pairs(tbl1) do
            if value(arg1) then
                return true
            end
        end
        return false, "bad type for union"
    end
end

module.some = module.union

function module.intersection(...)
    local tbl1 = { ... }
    assert(var3(tbl1))
    return function(arg1)
        for _, value in pairs(tbl1) do
            local var4, var5 = value(arg1)
            if not var4 then
                return false, var5 or ""
            end
        end
        return true
    end
end

module.every = module.intersection

local var4 = module.map(module.any, module.callback)

function module.interface(arg1)
    assert(var4(arg1))
    return function(arg2)
        local var5, var6 = module.table(arg2)
        if var5 == false then
            return false, var6 or ""
        end

        for k, value in pairs(arg1) do
            local var7, var8 = value(arg2[k])
            if var7 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(k), var8 or "")
            end
        end
        return true
    end
end

function module.strictInterface(arg1)
    assert(var4(arg1))
    return function(arg2)
        local var5, var6 = module.table(arg2)
        if var5 == false then
            return false, var6 or ""
        end

        for k, value in pairs(arg1) do
            local var7, var8 = value(arg2[k])
            if var7 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(k), var8 or "")
            end
        end

        for k in pairs(arg2) do
            if not arg1[k] then
                return false, string.format("[interface] unexpected field '%s'", tostring(k))
            end
        end

        return true
    end
end

function module.instanceOf(className, arg1)
    assert(module.string(className))

    local var5 = if arg1 ~= nil then module.children(arg1) else nil

    return function(arg2)
        local var6, var7 = module.Instance(arg2)
        if not var6 then
            return false, var7 or ""
        end

        if arg2.ClassName ~= className then
            return false, string.format("%s expected, got %s", className, arg2.ClassName)
        end

        if var5 then
            local var8, var9 = var5(arg2)
            if not var8 then
                return false, var9
            end
        end

        return true
    end
end
module.instance = module.instanceOf

function module.instanceIsA(arg1, arg2)
    assert(module.string(arg1))

    local var5 = if arg2 ~= nil then module.children(arg2) else nil

    return function(arg3)
        local var6, var7 = module.Instance(arg3)
        if not var6 then
            return false, var7 or ""
        end

        if not arg3:IsA(arg1) then
            return false, string.format("%s expected, got %s", arg1, arg3.ClassName)
        end

        if var5 then
            local var8, var9 = var5(arg3)
            if not var8 then
                return false, var9
            end
        end

        return true
    end
end

function module.enum(enumType)
    assert(module.Enum(enumType))
    return function(enumItem)
        local var5, var6 = module.EnumItem(enumItem)
        if not var5 then
            return false, var6
        end

        if enumItem.EnumType == enumType then
            return true
        end
        return false, string.format("enum of %s expected, got enum of %s", tostring(enumType), tostring(enumItem.EnumType))
    end
end

local var5 = module.tuple(module.callback, module.callback)

function module.wrap(arg1, arg2)
    assert(var5(arg1, arg2))
    return function(...)
        assert(arg2(...))
        return arg1(...)
    end
end

function module.strict(arg1)
    return function(...)
        assert(arg1(...))
    end
end

local var6 = module.map(module.string, module.callback)

function module.children(arg1)
    assert(var6(arg1))

    return function(arg2)
        local var7, var8 = module.Instance(arg2)
        if not var7 then
            return false, var8 or ""
        end

        local tbl1 = ({})
        for _, child in pairs(arg2:GetChildren()) do
            local childName = child.Name
            if not arg1[childName] then
                continue
            end

            if tbl1[childName] then
                return false, string.format("Cannot process multiple children with the same name \"%s\"", childName)
            end
            tbl1[childName] = child
        end

        for k, value in pairs(arg1) do
            local var9, var10 = value(tbl1[k])
            if not var9 then
                return false, string.format("[%s.%s] %s", arg2:GetFullName(), k, var10 or "")
            end
        end

        return true
    end
end

return module
