-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local print = GraphQL.print

local Kind = GraphQL.Kind
local isSpecifiedScalarType = GraphQL.isSpecifiedScalarType
local isIntrospectionType = GraphQL.isIntrospectionType

local isSpecifiedDirective = GraphQL.isSpecifiedDirective

local astFromValue = GraphQL.astFromValue

local GraphQLDeprecatedDirective = GraphQL.GraphQLDeprecatedDirective
local isObjectType = GraphQL.isObjectType

local isInterfaceType = GraphQL.isInterfaceType
local isUnionType = GraphQL.isUnionType

local isInputObjectType = GraphQL.isInputObjectType

local isEnumType = GraphQL.isEnumType
local isScalarType = GraphQL.isScalarType

local _types = require(script.Parent.types)

local astFromType = require(script.Parent.astFromType).astFromType
local getDirectivesInExtensions = require(script.Parent["get-directives"]).getDirectivesInExtensions
local astFromValueUntyped = require(script.Parent.astFromValueUntyped).astFromValueUntyped
local isSome = require(script.Parent.helpers).isSome
local getRootTypeMap = require(script.Parent.rootTypes).getRootTypeMap

local astFromSchema = nil
local astFromDirective = nil
local makeDirectiveNode = nil
local getDirectiveNodes = nil
local astFromObjectType = nil
local makeDirectiveNodes = nil
local astFromEnumValue = nil
local makeDeprecatedDirective = nil
local astFromInterfaceType = nil
local astFromUnionType = nil
local astFromInputObjectType = nil
local astFromEnumType = nil
local astFromScalarType = nil
local astFromArg = nil
local astFromField = nil
local astFromInputField = nil

local NULL = GraphQL.NULL

local function getDocumentNodeFromSchema(arg1, arg2)
    local pathToDirectivesInExtensions = (arg2 == nil and {} or arg2).pathToDirectivesInExtensions
    local typeMap = arg1:getTypeMap()
    local var1 = astFromSchema(arg1, pathToDirectivesInExtensions)
    local definitions = var1 == nil and {} or { var1 }

    for _, value in (arg1:getDirectives()) do
        if not Boolean.toJSBoolean(isSpecifiedDirective(value)) then
            table.insert(definitions, astFromDirective(value, arg1, pathToDirectivesInExtensions))
        end
    end

    for _, value in typeMap do
        local var3 = typeMap:get(value[1])

        local var4 = isSpecifiedScalarType(var3)
        local var5 = isIntrospectionType(var3)

        if var4 or var5 then
            continue
        end

        if Boolean.toJSBoolean(isObjectType(var3)) then
            table.insert(definitions, astFromObjectType(var3, arg1, pathToDirectivesInExtensions))
        elseif Boolean.toJSBoolean(isInterfaceType(var3)) then
            table.insert(definitions, astFromInterfaceType(var3, arg1, pathToDirectivesInExtensions))
        elseif Boolean.toJSBoolean(isUnionType(var3)) then
            table.insert(definitions, astFromUnionType(var3, arg1, pathToDirectivesInExtensions))
        elseif Boolean.toJSBoolean(isInputObjectType(var3)) then
            table.insert(definitions, astFromInputObjectType(var3, arg1, pathToDirectivesInExtensions))
        elseif Boolean.toJSBoolean(isEnumType(var3)) then
            table.insert(definitions, astFromEnumType(var3, arg1, pathToDirectivesInExtensions))
        elseif Boolean.toJSBoolean(isScalarType(var3)) then
            table.insert(definitions, astFromScalarType(var3, arg1, pathToDirectivesInExtensions))
        else
            error(Error.new(("Unknown type %s."):format(tostring(var3))))
        end
    end
    return {
        kind = Kind.DOCUMENT,
        definitions = definitions
    }
end

module.getDocumentNodeFromSchema = getDocumentNodeFromSchema

function module.printSchemaWithDirectives(arg1, arg2)
    local documentNodeFromSchema = getDocumentNodeFromSchema(arg1, arg2 == nil and {} or arg2)
    return print(documentNodeFromSchema)
end

astFromSchema = function(arg1, arg2): {directives: number, kind: number, operationTypes: number}?
    local map = Map.new({ { "query", Object.None }, { "mutation", Object.None }, { "subscription", Object.None } })

    local tbl1 = {}

    if arg1.astNode ~= nil then
        table.insert(tbl1, arg1.astNode)
    end

    if arg1.extensionASTNodes ~= nil then
        for _, value in arg1.extensionASTNodes do
            table.insert(tbl1, value)
        end
    end
    for _, value in tbl1 do
        if not Boolean.toJSBoolean(value.operationTypes) then
            continue
        end

        for _, value2 in value.operationTypes do
            map:set(value2.operation, value2)
        end
    end

    local rootTypeMap = getRootTypeMap(arg1)
    for _, value in map do
        local operation, var2 = table.unpack(value, 1, 2)
        local var3 = rootTypeMap:get(operation)
        if var3 == nil then
            continue
        end

        local type = astFromType(var3)
        if var2 ~= nil and var2 ~= Object.None then
            var2.type = type
        else
            local tbl2 = {
                kind = Kind.OPERATION_TYPE_DEFINITION,
                operation = operation,
                type = type
            }
            map:set(operation, tbl2)
        end
    end

    local operationTypes = Array.filter(Array.concat({}, map:values()), isSome)

    local directives = getDirectiveNodes(arg1, arg1, arg2)

    if not (Boolean.toJSBoolean(#operationTypes) or Boolean.toJSBoolean(#directives)) then
        return nil
    end
    local tbl2 = {
        kind = if operationTypes ~= nil then Kind.SCHEMA_DEFINITION else Kind.SCHEMA_EXTENSION,
        operationTypes = operationTypes,
        directives = directives
    }

    local toJsBoolean = Boolean.toJSBoolean
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil

    if description == nil then
        description = arg1.description ~= nil
    end

    tbl2.description = toJsBoolean(description) and {
        kind = Kind.STRING,
        value = arg1.description,
        block = true
    } or nil

    return tbl2
end
module.astFromSchema = astFromSchema

astFromDirective = function(arg1, arg2, arg3)
    local directiveDefinition = Kind.DIRECTIVE_DEFINITION

    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description
        } or nil
    end
    local name = {
        kind = Kind.NAME,
        value = arg1.name
    }

    local var1 = if typeof(arg1.args) == "table" then Array.map(arg1.args, function(arg4)
        return astFromArg(arg4, arg2, arg3)
    end) else nil

    local isRepeatable = arg1.isRepeatable

    local var2 = if typeof(arg1.locations) == "table" then Array.map(arg1.locations, function(value)
        return {
            kind = Kind.NAME,
            value = value
        }
    end) else nil

    return {
        kind = directiveDefinition,
        description = description,
        name = name,
        arguments = var1,
        repeatable = isRepeatable,
        locations = Boolean.toJSBoolean(var2) and var2 or {}
    }
end

module.astFromDirective = astFromDirective

getDirectiveNodes = function(arg1, arg2, arg3)
    local directivesInExtensions = getDirectivesInExtensions(arg1, arg3)

    local tbl1 = {}

    if arg1.astNode ~= nil then
        table.insert(tbl1, arg1.astNode)
    end

    if Array.indexOf(Object.keys(arg1), "extensionASTNodes") ~= -1 and arg1.extensionASTNodes ~= nil then
        tbl1 = Array.concat(tbl1, arg1.extensionASTNodes)
    end

    if directivesInExtensions ~= nil then
        return (makeDirectiveNodes(arg2, directivesInExtensions))
    end

    local directiveNodes = {}
    for _, value in tbl1 do
        if Boolean.toJSBoolean(value.directives) then
            directiveNodes = Array.concat(directiveNodes, value.directives)
        end
    end

    return directiveNodes
end
module.getDirectiveNodes = getDirectiveNodes
local function getDeprecatableDirectiveNodes(arg1, arg2, arg3)
    local tbl1 = {}
    local deprecatedDirective = nil
    local directivesInExtensions = getDirectivesInExtensions(arg1, arg3)
    local var1 = if directivesInExtensions ~= nil then makeDirectiveNodes(arg2, directivesInExtensions) elseif typeof(arg1.astNode) == "table" then arg1.astNode.directives else nil

    if var1 ~= nil then
        tbl1 = Array.filter(var1, function(arg4): boolean
            return arg4.name.value ~= "deprecated"
        end)

        if arg1.deprecationReason ~= nil then
            local filter = Array.filter

            if typeof(filter(var1, function(arg4): boolean
                return arg4.name.value == "deprecated"
            end)) == "table" then
                deprecatedDirective = Array.filter(var1, function(arg4): boolean
                    return arg4.name.value == "deprecated"
                end)[1]
            else
                deprecatedDirective = nil
            end
        end
    end

    if arg1.deprecationReason ~= nil and deprecatedDirective == nil then
        deprecatedDirective = makeDeprecatedDirective(arg1.deprecationReason)
    end
    if deprecatedDirective == nil then
        return tbl1
    end

    return (Array.concat({ deprecatedDirective }, tbl1))
end
module.getDeprecatableDirectiveNodes = getDeprecatableDirectiveNodes

astFromArg = function(arg1, arg2, arg3)
    local inputValueDefinition = Kind.INPUT_VALUE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    return {
        kind = inputValueDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        type = astFromType(arg1.type),
        defaultValue = if arg1.defaultValue == nil then nil else astFromValue(arg1.defaultValue, arg1.type),
        directives = getDeprecatableDirectiveNodes(arg1, arg2, arg3)
    }
end
module.astFromArg = astFromArg

astFromObjectType = function(arg1, arg2, arg3)
    local objectTypeDefinition = Kind.OBJECT_TYPE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    return {
        kind = objectTypeDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        fields = Array.map(arg1:getFields():values(), function(arg4)
            return astFromField(arg4, arg2, arg3)
        end),
        interfaces = Array.map(Object.values(arg1:getInterfaces()), function(arg4)
            return (astFromType(arg4))
        end),
        directives = getDirectiveNodes(arg1, arg2, arg3)
    }
end
module.astFromObjectType = astFromObjectType

astFromInterfaceType = function(arg1, arg2, arg3)
    local interfaceTypeDefinition = Kind.INTERFACE_TYPE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    local tbl1 = {
        kind = interfaceTypeDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        fields = Array.map(arg1:getFields():values(), function(arg4)
            return astFromField(arg4, arg2, arg3)
        end),
        directives = getDirectiveNodes(arg1, arg2, arg3)
    }

    if arg1.getInterfaces ~= nil then
        tbl1.interfaces = Array.map(Object.values(arg1:getInterfaces()), function(arg4)
            return (astFromType(arg4))
        end)
    end

    return tbl1
end
module.astFromInterfaceType = astFromInterfaceType

astFromUnionType = function(arg1, arg2, arg3)
    local unionTypeDefinition = Kind.UNION_TYPE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    return {
        kind = unionTypeDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        directives = getDirectiveNodes(arg1, arg2, arg3),
        types = Array.map(arg1:getTypes(), function(arg4)
            return (astFromType(arg4))
        end)
    }
end
module.astFromUnionType = astFromUnionType

astFromInputObjectType = function(arg1, arg2, arg3)
    local inputObjectTypeDefinition = Kind.INPUT_OBJECT_TYPE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    return {
        kind = inputObjectTypeDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        fields = Array.map(arg1:getFields():values(), function(arg4)
            return astFromInputField(arg4, arg2, arg3)
        end),
        directives = getDirectiveNodes(arg1, arg2, arg3)
    }
end
module.astFromInputObjectType = astFromInputObjectType

astFromEnumType = function(arg1, arg2, arg3)
    local enumTypeDefinition = Kind.ENUM_TYPE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    return {
        kind = enumTypeDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        values = Array.map(Object.values(arg1:getValues()), function(arg4)
            return astFromEnumValue(arg4, arg2, arg3)
        end),
        directives = getDirectiveNodes(arg1, arg2, arg3)
    }
end
module.astFromEnumType = astFromEnumType

astFromScalarType = function(arg1, arg2, arg3)
    local directivesInExtensions = getDirectivesInExtensions(arg1, arg3)
    local var1 = if Boolean.toJSBoolean(directivesInExtensions) then makeDirectiveNodes(arg2, directivesInExtensions) else (if typeof(arg1.astNode) == "table" then arg1.astNode.directives else nil) or {}
    local url = Boolean.toJSBoolean(arg1.specifiedByUrl) and arg1.specifiedByUrl or arg1.specifiedByURL

    local toJsBoolean = Boolean.toJSBoolean

    if toJsBoolean(if Boolean.toJSBoolean(url) then not Boolean.toJSBoolean(Array.some(var1, function(arg4): boolean
        return arg4.name.value == "specifiedBy"
    end)) else url) then
        table.insert(var1, makeDirectiveNode("specifiedBy", { url = url }))
    end
    local scalarTypeDefinition = Kind.SCALAR_TYPE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    return {
        kind = scalarTypeDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        directives = var1
    }
end
module.astFromScalarType = astFromScalarType

astFromField = function(arg1, arg2, arg3)
    local fieldDefinition = Kind.FIELD_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    return {
        kind = fieldDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        arguments = Array.map(arg1.args, function(arg4)
            return astFromArg(arg4, arg2, arg3)
        end),
        type = astFromType(arg1.type),
        directives = getDeprecatableDirectiveNodes(arg1, arg2, arg3)
    }
end
module.astFromField = astFromField

astFromInputField = function(arg1, arg2, arg3)
    local inputValueDefinition = Kind.INPUT_VALUE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    local name = {
        kind = Kind.NAME,
        value = arg1.name
    }
    local type = astFromType(arg1.type)
    local directives = getDeprecatableDirectiveNodes(arg1, arg2, arg3)

    local var2 = astFromValue(arg1.defaultValue, arg1.type)
    if var2 == nil or var2 == NULL then
        var2 = nil
    end
    return {
        kind = inputValueDefinition,
        description = description,
        name = name,
        type = type,
        directives = directives,
        defaultValue = var2
    }
end
module.astFromInputField = astFromInputField

astFromEnumValue = function(arg1, arg2, arg3)
    local enumValueDefinition = Kind.ENUM_VALUE_DEFINITION
    local description = if typeof(arg1.astNode) == "table" then arg1.astNode.description else nil
    if description == nil then
        description = Boolean.toJSBoolean(arg1.description) and {
            kind = Kind.STRING,
            value = arg1.description,
            block = true
        } or nil
    end
    return {
        kind = enumValueDefinition,
        description = description,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        },
        directives = getDeprecatableDirectiveNodes(arg1, arg2, arg3)
    }
end
module.astFromEnumValue = astFromEnumValue

makeDeprecatedDirective = function(reason: string)
    return makeDirectiveNode("deprecated", { reason = reason }, GraphQLDeprecatedDirective)
end
module.makeDeprecatedDirective = makeDeprecatedDirective

makeDirectiveNode = function(value: string, tbl1, arg1)
    local tbl2 = {}
    if arg1 ~= nil then
        for _, arg in arg1.args do
            local name = arg.name
            local var1 = tbl1[tostring(name)]
            if var1 == nil then
                continue
            end

            local var2 = astFromValue(var1, arg.type)
            if not Boolean.toJSBoolean(var2) then
                continue
            end

            table.insert(tbl2, { kind = Kind.ARGUMENT, name = { kind = Kind.NAME, value = name }, value = var2 })
        end
    else
        for value2 in tbl1 do
            local var1 = tbl1[tostring(value2)]
            local var2 = astFromValueUntyped(var1)
            if not Boolean.toJSBoolean(var2) then
                continue
            end

            table.insert(tbl2, { kind = Kind.ARGUMENT, name = { kind = Kind.NAME, value = value2 }, value = var2 })
        end
    end

    return {
        kind = Kind.DIRECTIVE,
        name = {
            kind = Kind.NAME,
            value = value
        },
        arguments = tbl2
    }
end
module.makeDirectiveNode = makeDirectiveNode

makeDirectiveNodes = function(arg1, tbl1)
    local directiveNodes = {}
    for value in tbl1 do
        local var1 = tbl1[tostring(value)]
        local directive = if typeof(arg1) == "table" then arg1:getDirective(value) else nil

        if Array.isArray(var1) and #var1 ~= 0 then
            for _, value2 in var1 do
                table.insert(directiveNodes, makeDirectiveNode(value, value2, directive))
            end
        else
            table.insert(directiveNodes, makeDirectiveNode(value, var1, directive))
        end
    end
    return directiveNodes
end
module.makeDirectiveNodes = makeDirectiveNodes
return module
