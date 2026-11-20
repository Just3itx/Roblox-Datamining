-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Boolean = LuauPolyfill.Boolean

local inspect = require(script.Parent.Parent.jsutils.inspect).inspect
local invariant = require(script.Parent.Parent.jsutils.invariant).invariant

local print = require(script.Parent.Parent.language.printer).print
local printBlockString = require(script.Parent.Parent.language.blockString).printBlockString

local isIntrospectionType = require(script.Parent.Parent.type.introspection).isIntrospectionType
local GraphQLString = require(script.Parent.Parent.type.scalars).GraphQLString
local isSpecifiedScalarType = require(script.Parent.Parent.type.scalars).isSpecifiedScalarType
local directives = require(script.Parent.Parent.type.directives)

local DEFAULT_DEPRECATION_REASON = directives.DEFAULT_DEPRECATION_REASON
local isSpecifiedDirective = directives.isSpecifiedDirective
local definition = require(script.Parent.Parent.type.definition)
local isScalarType = definition.isScalarType
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isUnionType = definition.isUnionType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType

local _schema = require(script.Parent.Parent.type.schema)

local _ast = require(script.Parent.Parent.language.ast)

local astFromValue = require(script.Parent.astFromValue).astFromValue
local NULL = require(script.Parent.astFromValue).NULL
local isNillish = require(script.Parent.Parent.luaUtils.isNillish)
local isNillish2 = isNillish.isNillish
local isNotNillish = isNillish.isNotNillish

local printScalar = nil
local printDescription = nil
local printFilteredSchema = nil
local isDefinedType = nil
local printSchemaDefinition = nil
local printDirective = nil
local printType = nil
local isSchemaOfCommonNames = nil
local printObject = nil
local printArgs = nil
local printInputValue = nil
local printDeprecated = nil
local printBlock = nil
local printInterface = nil
local printUnion = nil
local printEnum = nil
local printInputObject = nil
local printSpecifiedByUrl = nil
local printFields = nil
local function printSchema(arg1)
    return printFilteredSchema(arg1, function(arg2): boolean
        return not isSpecifiedDirective(arg2)
    end, isDefinedType)
end

local function printIntrospectionSchema(arg1)
    return printFilteredSchema(arg1, isSpecifiedDirective, isIntrospectionType)
end

isDefinedType = function(arg1): boolean
    return not (isSpecifiedScalarType(arg1) or isIntrospectionType(arg1))
end

printFilteredSchema = function(arg1, func1: (...any) -> (...any), func2: (...any) -> (...any))
    local var1 = Array.filter(arg1:getDirectives(), func1)

    local var2 = Array.filter(arg1:getTypeMap():values(), func2)

    local var3 = Array.concat({ printSchemaDefinition(arg1) }, Array.map(var1, function(arg2)
        return printDirective(arg2)
    end), Array.map(var2, function(arg2)
        return printType(arg2)
    end))

    local var4 = Array.filter(var3, function(arg2)
        return Boolean.toJSBoolean(arg2)
    end)

    return Array.join(var4, "\n\n") .. "\n"
end

printSchemaDefinition = function(arg1)
    if isNillish2(arg1.description) and isSchemaOfCommonNames(arg1) then
        return
    end

    local tbl1 = {}
    local queryType = arg1:getQueryType()

    if isNotNillish(queryType) then
        local name = queryType.name
        table.insert(tbl1, ("  query: %s"):format(name))
    end

    local mutationType = arg1:getMutationType()

    if isNotNillish(mutationType) then
        local name = mutationType.name
        table.insert(tbl1, ("  mutation: %s"):format(name))
    end

    local subscriptionType = arg1:getSubscriptionType()

    if isNotNillish(subscriptionType) then
        local name = subscriptionType.name
        table.insert(tbl1, ("  subscription: %s"):format(name))
    end

    return printDescription(arg1) .. ("schema {\n%s\n}"):format(Array.join(tbl1, "\n"))
end

isSchemaOfCommonNames = function(arg1): boolean
    local queryType = arg1:getQueryType()

    if isNotNillish(queryType) and queryType.name ~= "Query" then
        return false
    end

    local mutationType = arg1:getMutationType()

    if isNotNillish(mutationType) and mutationType.name ~= "Mutation" then
        return false
    end

    local subscriptionType = arg1:getSubscriptionType()

    return not isNotNillish(subscriptionType) or subscriptionType.name == "Subscription" or false
end

printType = function(arg1)
    if isScalarType(arg1) then
        return printScalar(arg1)
    end
    if isObjectType(arg1) then
        return printObject(arg1)
    end
    if isInterfaceType(arg1) then
        return printInterface(arg1)
    end
    if isUnionType(arg1) then
        return printUnion(arg1)
    end
    if isEnumType(arg1) then
        return printEnum(arg1)
    end

    if isInputObjectType(arg1) then
        return printInputObject(arg1)
    end

    invariant(false, "Unexpected type: " .. inspect(arg1))

    return ""
end

printScalar = function(arg1)
    return printDescription(arg1) .. ("scalar %s"):format(arg1.name) .. printSpecifiedByUrl(arg1)
end

local function printImplementedInterfaces(arg1)
    local interfaces = arg1.getInterfaces(arg1)

    if #interfaces > 0 then
        return " implements " .. Array.join(Array.map(interfaces, function(arg2)
            return arg2.name
        end), " & ")
    end

    return ""
end

printObject = function(arg1)
    return printDescription(arg1) .. ("type %s"):format(arg1.name) .. printImplementedInterfaces(arg1) .. printFields(arg1)
end

printInterface = function(arg1)
    return printDescription(arg1) .. ("interface %s"):format(arg1.name) .. printImplementedInterfaces(arg1) .. printFields(arg1)
end

printUnion = function(arg1)
    local types = arg1:getTypes()
    local var1 = if #types > 0 then " = " .. Array.join(types, " | ") else ""

    return printDescription(arg1) .. "union " .. arg1.name .. var1
end

printEnum = function(arg1)
    local var1 = Array.map(arg1:getValues(), function(arg2, arg3)
        return printDescription(arg2, "  ", arg3 == 1) .. "  " .. arg2.name .. printDeprecated(arg2.deprecationReason)
    end)

    return printDescription(arg1) .. ("enum %s"):format(arg1.name) .. printBlock(var1)
end

printInputObject = function(arg1)
    local var1 = Array.map(arg1:getFields():values(), function(arg2, arg3)
        return printDescription(arg2, "  ", arg3 == 1) .. "  " .. printInputValue(arg2)
    end)

    return printDescription(arg1) .. ("input %s"):format(arg1.name) .. printBlock(var1)
end

printFields = function(arg1)
    local var1 = Array.map(arg1.getFields(arg1):values(), function(arg2, arg3)
        return printDescription(arg2, "  ", arg3 == 1) .. "  " .. arg2.name .. printArgs(arg2.args, "  ") .. ": " .. tostring(arg2.type) .. printDeprecated(arg2.deprecationReason)
    end)

    return printBlock(var1)
end

printBlock = function(arg1)
    if #arg1 == 0 then
        return ""
    end

    return " {\n" .. Array.join(arg1, "\n") .. "\n}"
end

printArgs = function(arg1, str1: string?)
    local var1 = if str1 == nil then "" else str1

    if #arg1 == 0 then
        return ""
    end

    if Array.every(arg1, function(arg2)
        return isNillish2(arg2.description)
    end) then
        return "(" .. Array.join(Array.map(arg1, printInputValue), ", ") .. ")"
    end

    return "(\n" .. Array.join(Array.map(arg1, function(arg2, arg3)
        return printDescription(arg2, "  " .. var1, arg3 == 1) .. "  " .. var1 .. printInputValue(arg2)
    end), "\n") .. "\n" .. var1 .. ")"
end

printInputValue = function(arg1)
    local var1 = astFromValue(arg1.defaultValue, arg1.type)
    local var2 = arg1.name .. ": " .. tostring(arg1.type)

    if isNotNillish(var1) then
        var2 ..= (" = %s"):format(print(var1))
    end

    return var2 .. printDeprecated(arg1.deprecationReason)
end

printDirective = function(arg1)
    return printDescription(arg1) .. "directive @" .. arg1.name .. printArgs(arg1.args) .. (if arg1.isRepeatable then " repeatable" else "") .. " on " .. Array.join(arg1.locations, " | ")
end

printDeprecated = function(str1: string?)
    if isNillish2(str1) then
        return ""
    end

    local var1 = astFromValue(str1, GraphQLString)

    if var1 and str1 ~= DEFAULT_DEPRECATION_REASON then
        return " @deprecated(reason: " .. print(var1) .. ")"
    end

    return " @deprecated"
end

printSpecifiedByUrl = function(arg1)
    if isNillish2(arg1.specifiedByUrl) then
        return ""
    end

    local specifiedByUrl = arg1.specifiedByUrl
    local var1 = astFromValue(specifiedByUrl, GraphQLString)

    invariant(var1, "Unexpected null value returned from `astFromValue` for specifiedByUrl")

    return " @specifiedBy(url: " .. print(var1) .. ")"
end

printDescription = function(tbl1, str1: string?, bool1: boolean?)
    local var1 = if str1 == nil then "" else str1

    if bool1 == nil then
        bool1 = true
    end
    local description = tbl1.description

    if isNillish2(description) then
        return ""
    end

    local bool2 = string.len(description) > 70
    local var2 = printBlockString(description, "", bool2)
    local var3 = if Boolean.toJSBoolean(var1) and not bool1 then "\n" .. var1 else var1
    local var4, _ = string.gsub(var2, "\n", "\n" .. var1)
    return var3 .. var4 .. "\n"
end

return {
    printSchema = printSchema,
    printIntrospectionSchema = printIntrospectionSchema,
    printType = printType,
    NULL = NULL
}
