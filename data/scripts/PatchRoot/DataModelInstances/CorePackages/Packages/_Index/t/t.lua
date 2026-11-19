-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:10:38Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

function module.type(arg1)
    return function(arg2)
        local str1 = type(arg2)
        if str1 == arg1 then
            return true
        end
        return false, string.format("%s expected, got %s", arg1, str1)
    end
end

function module.typeof(arg1)
    return function(arg2)
        local str1 = typeof(arg2)
        if str1 == arg1 then
            return true
        end
        return false, string.format("%s expected, got %s", arg1, str1)
    end
end

function module.any(arg1)
    if arg1 ~= nil then
        return true
    end
    return false, "any expected, got nil"
end

module.boolean = module.typeof("boolean")

module.thread = module.typeof("thread")

module.callback = module.typeof("function")
module["function"] = module.callback

module.none = module.typeof("nil")
module["nil"] = module.none

module.string = module.typeof("string")

module.table = module.typeof("table")

module.userdata = module.type("userdata")

function module.number(arg1)
    local str1 = typeof(arg1)
    if str1 == "number" then
        if arg1 == arg1 then
            return true
        end
        return false, "unexpected NaN value"
    end

    return false, string.format("number expected, got %s", str1)
end

function module.nan(arg1)
    local str1 = typeof(arg1)
    if str1 == "number" then
        if arg1 ~= arg1 then
            return true
        end
        return false, "unexpected non-NaN value"
    end

    return false, string.format("number expected, got %s", str1)
end

module.Axes = module.typeof("Axes")

module.BrickColor = module.typeof("BrickColor")

module.CatalogSearchParams = module.typeof("CatalogSearchParams")

module.CFrame = module.typeof("CFrame")

module.Color3 = module.typeof("Color3")

module.ColorSequence = module.typeof("ColorSequence")

module.ColorSequenceKeypoint = module.typeof("ColorSequenceKeypoint")

module.DateTime = module.typeof("DateTime")

module.DockWidgetPluginGuiInfo = module.typeof("DockWidgetPluginGuiInfo")

module.Enum = module.typeof("Enum")

module.EnumItem = module.typeof("EnumItem")

module.Enums = module.typeof("Enums")

module.Faces = module.typeof("Faces")

module.Instance = module.typeof("Instance")

module.NumberRange = module.typeof("NumberRange")

module.NumberSequence = module.typeof("NumberSequence")

module.NumberSequenceKeypoint = module.typeof("NumberSequenceKeypoint")

module.PathWaypoint = module.typeof("PathWaypoint")

module.PhysicalProperties = module.typeof("PhysicalProperties")

module.Random = module.typeof("Random")

module.Ray = module.typeof("Ray")

module.RaycastParams = module.typeof("RaycastParams")

module.RaycastResult = module.typeof("RaycastResult")

module.RBXScriptConnection = module.typeof("RBXScriptConnection")

module.RBXScriptSignal = module.typeof("RBXScriptSignal")

module.Rect = module.typeof("Rect")

module.Region3 = module.typeof("Region3")

module.Region3int16 = module.typeof("Region3int16")

module.TweenInfo = module.typeof("TweenInfo")

module.UDim = module.typeof("UDim")

module.UDim2 = module.typeof("UDim2")

module.Vector2 = module.typeof("Vector2")

module.Vector2int16 = module.typeof("Vector2int16")

module.Vector3 = module.typeof("Vector3")

module.Vector3int16 = module.typeof("Vector3int16")

function module.literal(...)
    local select2 = select
    local var1 = select2("#", ...)
    if var1 == 1 then
        local var2 = ...
        return function(arg1)
            if arg1 ~= var2 then
                return false, string.format("expected %s, got %s", tostring(var2), tostring(arg1))
            end

            return true
        end
    end
    local tbl1 = ({})
    for i = 1, var1 do
        local select = select
        local var2 = select(i, ...)
        tbl1[i] = module.literal(var2)
    end

    return module.union(table.unpack(tbl1, 1, var1))
end

module.exactly = module.literal

function module.keyOf(arg1)
    local tbl1 = ({})
    local num1 = 0
    for k in pairs(arg1) do
        num1 += 1
        tbl1[num1] = k
    end

    return module.literal(table.unpack(tbl1, 1, num1))
end

function module.valueOf(arg1)
    local tbl1 = ({})
    local num1 = 0
    for _, value in pairs(arg1) do
        num1 += 1
        tbl1[num1] = value
    end

    return module.literal(table.unpack(tbl1, 1, num1))
end

function module.integer(arg1)
    local var1, var2 = module.number(arg1)
    if not var1 then
        return false, var2 or ""
    elseif arg1 % 1 == 0 then
        return true
    end
    return false, string.format("integer expected, got %s", arg1)
end

function module.numberMin(arg1)
    return function(arg2)
        local var1, var2 = module.number(arg2)
        if not var1 then
            return false, var2 or ""
        elseif arg1 <= arg2 then
            return true
        end
        return false, string.format("number >= %s expected, got %s", arg1, arg2)
    end
end

function module.numberMax(arg1)
    return function(arg2)
        local var1, var2 = module.number(arg2)
        if not var1 then
            return false, var2
        elseif arg2 <= arg1 then
            return true
        end
        return false, string.format("number <= %s expected, got %s", arg1, arg2)
    end
end

function module.numberMinExclusive(arg1)
    return function(arg2)
        local var1, var2 = module.number(arg2)
        if not var1 then
            return false, var2 or ""
        elseif arg1 < arg2 then
            return true
        end
        return false, string.format("number > %s expected, got %s", arg1, arg2)
    end
end

function module.numberMaxExclusive(arg1)
    return function(arg2)
        local var1, var2 = module.number(arg2)
        if not var1 then
            return false, var2 or ""
        elseif arg2 < arg1 then
            return true
        end
        return false, string.format("number < %s expected, got %s", arg1, arg2)
    end
end

module.numberPositive = module.numberMinExclusive(0)

module.numberNegative = module.numberMaxExclusive(0)

function module.numberConstrained(arg1, arg2)
    assert(module.number(arg1))
    assert(module.number(arg2))
    local var1 = module.numberMin(arg1)
    local var2 = module.numberMax(arg2)

    return function(arg3)
        local var3, var4 = var1(arg3)
        if not var3 then
            return false, var4 or ""
        end

        local var5, var6 = var2(arg3)
        if not var5 then
            return false, var6 or ""
        end

        return true
    end
end

function module.numberConstrainedExclusive(arg1, arg2)
    assert(module.number(arg1))
    assert(module.number(arg2))
    local var1 = module.numberMinExclusive(arg1)
    local var2 = module.numberMaxExclusive(arg2)

    return function(arg3)
        local var3, var4 = var1(arg3)
        if not var3 then
            return false, var4 or ""
        end

        local var5, var6 = var2(arg3)
        if not var5 then
            return false, var6 or ""
        end

        return true
    end
end

function module.match(arg1)
    assert(module.string(arg1))
    return function(arg2)
        local var1, var2 = module.string(arg2)
        if not var1 then
            return false, var2
        elseif string.match(arg2, arg1) == nil then
            return false, string.format("%q failed to match pattern %q", arg2, arg1)
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

        local var1, var2 = arg1(arg2)
        if var1 then
            return true
        end
        return false, string.format("(optional) %s", var2 or "")
    end
end

function module.tuple(...)
    local tbl1 = { ... }
    return function(...)
        local tbl2 = { ... }
        for i, value in ipairs(tbl1) do
            local var1, var2 = value(tbl2[i])
            if var1 == false then
                return false, string.format("Bad tuple index #%s:\n\t%s", i, var2 or "")
            end
        end

        return true
    end
end

function module.keys(arg1)
    assert(module.callback(arg1))
    return function(arg2)
        local var1, var2 = module.table(arg2)
        if var1 == false then
            return false, var2 or ""
        end

        for k in pairs(arg2) do
            local var3, var4 = arg1(k)
            if var3 == false then
                return false, string.format("bad key %s:\n\t%s", tostring(k), var4 or "")
            end
        end

        return true
    end
end

function module.values(arg1)
    assert(module.callback(arg1))
    return function(arg2)
        local var1, var2 = module.table(arg2)
        if var1 == false then
            return false, var2 or ""
        end

        for k, value in pairs(arg2) do
            local var3, var4 = arg1(value)
            if var3 == false then
                return false, string.format("bad value for key %s:\n\t%s", tostring(k), var4 or "")
            end
        end

        return true
    end
end

function module.map(arg1, arg2)
    assert(module.callback(arg1))
    assert(module.callback(arg2))
    local var1 = module.keys(arg1)
    local var2 = module.values(arg2)

    return function(arg3)
        local var3, var4 = var1(arg3)
        if not var3 then
            return false, var4 or ""
        end

        local var5, var6 = var2(arg3)
        if not var5 then
            return false, var6 or ""
        end

        return true
    end
end

function module.set(arg1)
    return module.map(arg1, module.literal(true))
end

local var1 = module.keys(module.integer)

function module.array(callback)
    assert(module.callback(callback))
    local var2 = module.values(callback)

    return function(arg1)
        local var3, var4 = var1(arg1)
        if var3 == false then
            return false, string.format("[array] %s", var4 or "")
        end

        local num1 = 0

        for _ in ipairs(arg1) do
            num1 += 1
        end

        for k in pairs(arg1) do
            if k < 1 or num1 < k then
                return false, string.format("[array] key %s must be sequential", tostring(k))
            end
        end

        local var5, var6 = var2(arg1)
        if not var5 then
            return false, string.format("[array] %s", var6 or "")
        end

        return true
    end
end

function module.strictArray(...)
    local tbl1 = { ... }
    assert(module.array(module.callback)(tbl1))

    return function(arg1)
        local var2, var3 = var1(arg1)
        if var2 == false then
            return false, string.format("[strictArray] %s", var3 or "")
        end

        if #tbl1 < #arg1 then
            return false, string.format("[strictArray] Array size exceeds limit of %d", #tbl1)
        end

        for k, value in pairs(tbl1) do
            local var4, var5 = value(arg1[k])
            if not var4 then
                return false, string.format("[strictArray] Array index #%d - %s", k, var5)
            end
        end

        return true
    end
end

local var2 = module.array(module.callback)

function module.union(...)
    local tbl1 = { ... }
    assert(var2(tbl1))

    return function(arg1)
        for _, value in ipairs(tbl1) do
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
    assert(var2(tbl1))

    return function(arg1)
        for _, value in ipairs(tbl1) do
            local var3, var4 = value(arg1)
            if not var3 then
                return false, var4 or ""
            end
        end

        return true
    end
end

module.every = module.intersection

local var3 = module.map(module.any, module.callback)

function module.interface(arg1)
    assert(var3(arg1))
    return function(arg2)
        local var4, var5 = module.table(arg2)
        if var4 == false then
            return false, var5 or ""
        end

        for k, value in pairs(arg1) do
            local var6, var7 = value(arg2[k])
            if var6 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(k), var7 or "")
            end
        end

        return true
    end
end

function module.strictInterface(arg1)
    assert(var3(arg1))
    return function(arg2)
        local var4, var5 = module.table(arg2)
        if var4 == false then
            return false, var5 or ""
        end

        for k, value in pairs(arg1) do
            local var6, var7 = value(arg2[k])
            if var6 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(k), var7 or "")
            end
        end

        for k in pairs(arg2) do
            if not arg1[k] then
                return false, string.format("[interface] unexpected field %q", tostring(k))
            end
        end

        return true
    end
end

function module.instanceOf(className, arg1)
    assert(module.string(className))

    local var4 = if arg1 ~= nil then module.children(arg1) else nil

    return function(arg2)
        local var5, var6 = module.Instance(arg2)
        if not var5 then
            return false, var6 or ""
        end

        if arg2.ClassName ~= className then
            return false, string.format("%s expected, got %s", className, arg2.ClassName)
        end

        if var4 then
            local var7, var8 = var4(arg2)
            if not var7 then
                return false, var8
            end
        end

        return true
    end
end

module.instance = module.instanceOf

function module.instanceIsA(arg1, arg2)
    assert(module.string(arg1))

    local var4 = if arg2 ~= nil then module.children(arg2) else nil

    return function(arg3)
        local var5, var6 = module.Instance(arg3)
        if not var5 then
            return false, var6 or ""
        end

        if not arg3:IsA(arg1) then
            return false, string.format("%s expected, got %s", arg1, arg3.ClassName)
        end

        if var4 then
            local var7, var8 = var4(arg3)
            if not var7 then
                return false, var8
            end
        end

        return true
    end
end

function module.enum(enumType)
    assert(module.Enum(enumType))
    return function(enumItem)
        local var4, var5 = module.EnumItem(enumItem)
        if not var4 then
            return false, var5
        end

        if enumItem.EnumType == enumType then
            return true
        end
        return false, string.format("enum of %s expected, got enum of %s", tostring(enumType), tostring(enumItem.EnumType))
    end
end

local var4 = module.tuple(module.callback, module.callback)

function module.wrap(arg1, arg2)
    assert(var4(arg1, arg2))
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

local var5 = module.map(module.string, module.callback)

function module.children(arg1)
    assert(var5(arg1))

    return function(arg2)
        local var6, var7 = module.Instance(arg2)
        if not var6 then
            return false, var7 or ""
        end

        local tbl1 = ({})
        for _, child in ipairs(arg2:GetChildren()) do
            local childName = child.Name
            if not arg1[childName] then
                continue
            end

            if tbl1[childName] then
                return false, string.format("Cannot process multiple children with the same name %q", childName)
            end

            tbl1[childName] = child
        end

        for k, value in pairs(arg1) do
            local var8, var9 = value(tbl1[k])
            if not var8 then
                return false, string.format("[%s.%s] %s", arg2:GetFullName(), k, var9 or "")
            end
        end

        return true
    end
end

return module
