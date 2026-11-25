-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)

local SduiActionType = require(SduiCoreSystem.SduiActionType)
local SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local SduiDataBindingContentType = require(SduiCoreSystem.ClientBinding.SduiDataBindingContentType)
local snakeToCamel = require(SduiCoreSystem.ClientBinding.SduiDataBinderTransformUtils).snakeToCamel

local tbl1 = {
    AUTOMATIC_SIZE_XY = "XY",
    SIZE_CONSTRAINT_RELATIVE_XY = "RelativeXY",
    SIZE_CONSTRAINT_RELATIVE_XX = "RelativeXX",
    SIZE_CONSTRAINT_RELATIVE_YY = "RelativeYY"
}

local tbl2 = ({})

local function convertToLuaEnum(arg1, str1: string, bool1: boolean?)
    local var1 = string.match(arg1, "^" .. str1 .. "(.*)")
    if not var1 then
        return arg1
    end

    local var2 = var1:lower():gsub("_(%l)", function(arg2)
        return arg2:upper()
    end)

    if bool1 then
        return var2:gsub("^%l", string.upper)
    end
    return var2
end

local function mapProtoEnumFormatToLua(arg1, str1: string, bool1: boolean?) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = tbl1[arg1]
    if not var1 then
        var1 = convertToLuaEnum(arg1, str1, bool1)
        tbl1[arg1] = var1
    end
    return var1
end

local function mapPropName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return nil
    end
    if typeof(arg1) == "number" then
        return arg1
    end
    local var1 = tbl1[arg1]
    if not var1 then
        var1 = snakeToCamel(arg1)
        tbl1[arg1] = var1
    end
    return var1
end

return {
    mapProtoEnumFormatToLua = mapProtoEnumFormatToLua,
    mapLuaEnumFormatToProto = function(str1: string, str2: string, arg1)
        local str3 = str2 .. str1
        local var1 = tbl2[str3]
        if var1 == false then
            return nil
        end
        if var1 ~= nil then
            return var1
        end

        local str4 = str2 .. string.upper((str1:gsub("(%l)(%u)", "%1_%2")))
        local name = arg1.fromName(str4)
        tbl2[str3] = name or false
        return name
    end,
    mapUiComponentTypeToLua = function(arg1)
        if arg1 == nil then
            return nil
        end

        local var1 = mapProtoEnumFormatToLua(arg1, "UI_COMPONENT_TYPE_", true)
        return if SduiComponentType[var1] then SduiComponentType[var1] else nil
    end,
    mapHydrationContentTypeToLua = function(arg1)
        if arg1 == nil then
            return nil
        end

        local var1 = tbl1[arg1]
        if not var1 then
            local var2 = string.match(arg1, "^HYDRATION_CONTENT_TYPE_(.*)")
            if var2 then
                var1 = var2:lower():gsub("_(%l)", function(arg2)
                    return arg2:upper()
                end)
            else
                var1 = arg1
            end

            tbl1[arg1] = var1
        end

        return if SduiDataBindingContentType[var1] then SduiDataBindingContentType[var1] else nil
    end,
    mapActionTypeToLua = function(arg1)
        if arg1 == nil then
            return nil
        end

        local var1 = mapProtoEnumFormatToLua(arg1, "ACTION_TYPE_", true)
        return if SduiActionType[var1] then SduiActionType[var1] else nil
    end,
    mapPropName = mapPropName,
    camelCaseKeys = function(arg1)
        if type(arg1) ~= "table" then
            return arg1
        end
        local result = ({})
        for value, value2 in arg1 do
            if type(value) == "string" then
                value = mapPropName(value)
            end

            result[value] = value2
        end
        return result
    end,
    mapProtoEngineEnumToLua = function(str1: string, str2: string, func1: (...any) -> (...any))
        if str1 == nil then
            return nil
        end

        local var1 = mapProtoEnumFormatToLua(str1, str2, true)

        if var1 then
            return func1(var1)
        end
        return nil
    end
}
