-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error

local isNotNillish = require(scriptParentParent.luaUtils.isNillish).isNotNillish

local inspect = require(script.Parent.Parent.jsutils.inspect).inspect
local GraphQLError = require(script.Parent.Parent.error.GraphQLError).GraphQLError

local locatedError = require(script.Parent.Parent.error).locatedError

local _ast = require(scriptParentParent.language.ast)

local isValidNameError = require(scriptParentParent.utilities.assertValidName).isValidNameError
local typeComparators = require(script.Parent.Parent.utilities.typeComparators)
local isEqualType = typeComparators.isEqualType
local isTypeSubTypeOf = typeComparators.isTypeSubTypeOf
local assertSchema = require(script.Parent.schema).assertSchema

local definition = require(script.Parent.definition)

local isIntrospectionType = require(script.Parent.introspection).isIntrospectionType
local directives = require(script.Parent.directives)
local isDirective = directives.isDirective
local GraphQLDeprecatedDirective = directives.GraphQLDeprecatedDirective
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isUnionType = definition.isUnionType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType
local isNamedType = definition.isNamedType
local isNonNullType = definition.isNonNullType
local isInputType = definition.isInputType
local isOutputType = definition.isOutputType
local isRequiredArgument = definition.isRequiredArgument
local isRequiredInputField = definition.isRequiredInputField

local var1 = nil
local validateRootTypes = nil
local validateDirectives = nil
local getOperationTypeNode = nil
local getAllSubNodes = nil
local getAllNodes = nil
local getAllImplementsInterfaceNodes = nil
local getDeprecatedDirectiveNode = nil
local getUnionMemberTypeNodes = nil
local validateEnumValues = nil
local validateName = nil
local validateFields = nil
local validateTypeImplementsAncestors = nil
local validateTypes = nil
local validateTypeImplementsInterface = nil
local validateInterfaces = nil

local function validateSchema(arg1)
    assertSchema(arg1)

    if arg1.__validationErrors ~= nil then
        return arg1.__validationErrors
    end

    local var2 = var1.new(arg1)
    validateRootTypes(var2)
    validateDirectives(var2)
    validateTypes(var2)

    local errors = var2:getErrors()

    arg1.__validationErrors = errors

    return errors
end

var1 = {}
var1.__index = var1

function var1.new(schema)
    local self = (setmetatable({}, var1))

    self._errors = {}
    self.schema = schema

    return self
end

function var1.reportError(tbl1, str1: string, arg1)
    if Array.isArray(arg1) then
        arg1 = Array.filter(arg1, Boolean.toJSBoolean)
    end

    tbl1:addError(GraphQLError.new(str1, arg1))
end

function var1:addError(arg1)
    table.insert(self._errors, arg1)
end

function var1:getErrors()
    return self._errors
end

validateRootTypes = function(tbl1)
    local schema = tbl1.schema
    local queryType = schema:getQueryType()

    if not isNotNillish(queryType) then
        tbl1:reportError("Query root type must be provided.", schema.astNode)
    elseif not isObjectType(queryType) then
        local operationTypeNode = getOperationTypeNode(schema, "query")
        tbl1:reportError(
            ("Query root type must be Object type, it cannot be %s."):format(inspect(queryType)),
            operationTypeNode or queryType.astNode
        )
    end

    local mutationType = schema:getMutationType()

    if isNotNillish(mutationType) and not isObjectType(mutationType) then
        local operationTypeNode = getOperationTypeNode(schema, "mutation")
        tbl1:reportError(
            "Mutation root type must be Object type if provided, it cannot be " .. ("%s."):format(inspect(mutationType)),
            operationTypeNode or mutationType.astNode
        )
    end

    local subscriptionType = schema:getSubscriptionType()

    if isNotNillish(subscriptionType) and not isObjectType(subscriptionType) then
        local operationTypeNode = getOperationTypeNode(schema, "subscription")
        tbl1:reportError(
            "Subscription root type must be Object type if provided, it cannot be " .. ("%s."):format(inspect(subscriptionType)),
            operationTypeNode or subscriptionType.astNode
        )
    end
end

getOperationTypeNode = function(arg1, operation)
    local allSubNodes = getAllSubNodes(arg1, function(arg2)
        return arg2.operationTypes
    end)

    for _, value in ipairs(allSubNodes) do
        if value.operation == operation then
            return value.type
        end
    end

    return nil
end

validateDirectives = function(tbl1)
    for _, value in ipairs(tbl1.schema:getDirectives()) do
        if not isDirective(value) then
            local str1 = ("Expected directive but got: %s."):format(inspect(value))
            local astNode = if value then value.astNode else nil
            tbl1:reportError(str1, astNode)
        else
            validateName(tbl1, value)

            for _, arg in ipairs(value.args) do
                validateName(tbl1, arg)

                if not isInputType(arg.type) then
                    tbl1:reportError(
                        ("The type of @%s(%s:) must be Input Type "):format(value.name, arg.name) .. ("but got: %s."):format(inspect(arg.type)),
                        arg.astNode
                    )
                end

                if not (isRequiredArgument(arg) and isNotNillish(arg.deprecationReason)) then
                    continue
                end
                local str1 = ("Required argument @%s(%s:) cannot be deprecated."):format(value.name, arg.name)

                local tbl2 = { getDeprecatedDirectiveNode(arg.astNode), if arg.astNode == nil then nil else arg.astNode.type }
                tbl1:reportError(str1, tbl2)
            end
        end
    end
end

validateName = function(tbl1, tbl2)
    local astNode = nil
    local name

    if typeof(tbl2) == "table" then
        name = tbl2.name
        astNode = tbl2.astNode
    else
        name = tostring(tbl2)
    end
    local var2 = isValidNameError(name)

    if var2 then
        tbl1:addError(locatedError(var2, astNode))
    end
end

validateTypes = function(tbl1)
    local inputObjectCircularRefsValidator = createInputObjectCircularRefsValidator(tbl1)
    local typeMap = tbl1.schema:getTypeMap()

    for _, value in ipairs(typeMap:values()) do
        local astNode = if typeof(value) == "table" then value.astNode else nil

        if not isNamedType(value) then
            tbl1:reportError(("Expected GraphQL named type but got: %s."):format(inspect(value)), astNode)
        else
            if not isIntrospectionType(value) then
                validateName(tbl1, value)
            end

            if isObjectType(value) or isInterfaceType(value) then
                validateFields(tbl1, value)

                validateInterfaces(tbl1, value)
            elseif isUnionType(value) then
                validateUnionMembers(tbl1, value)
            elseif isEnumType(value) then
                validateEnumValues(tbl1, value)
            elseif isInputObjectType(value) then
                validateInputFields(tbl1, value)

                inputObjectCircularRefsValidator(value)
            end
        end
    end
end

validateFields = function(tbl1, arg1)
    local var2 = arg1:getFields():values()

    if #var2 == 0 then
        tbl1:reportError(("Type %s must define one or more fields."):format(arg1.name), getAllNodes(arg1))
    end

    for _, value in ipairs(var2) do
        validateName(tbl1, value)

        if not isOutputType(value.type) then
            local str1 = ("The type of %s.%s must be Output Type "):format(arg1.name, value.name) .. ("but got: %s."):format(inspect(value.type))
            local type = if value.astNode == nil then nil else value.astNode.type
            tbl1:reportError(str1, type)
        end

        for _, arg in ipairs(value.args) do
            local name = arg.name

            validateName(tbl1, arg)

            if not isInputType(arg.type) then
                local str1 = ("The type of %s.%s(%s:) must be Input "):format(arg1.name, value.name, name) .. ("Type but got: %s."):format(inspect(arg.type))
                local type = if arg.astNode == nil then nil else arg.astNode.type
                tbl1:reportError(str1, type)
            end

            if not (isRequiredArgument(arg) and isNotNillish(arg.deprecationReason)) then
                continue
            end
            local str1 = ("Required argument %s.%s(%s:) cannot be deprecated."):format(arg1.name, value.name, name)

            local tbl2 = { getDeprecatedDirectiveNode(arg.astNode), if arg.astNode == nil then nil else arg.astNode.type }
            tbl1:reportError(str1, tbl2)
        end
    end
end

validateInterfaces = function(tbl1, arg1)
    local tbl2 = ({})

    for _, value in ipairs(arg1:getInterfaces()) do
        if not isInterfaceType(value) then
            tbl1:reportError(
                ("Type %s must only implement Interface types, "):format(inspect(arg1)) .. ("it cannot implement %s."):format(inspect(value)),
                getAllImplementsInterfaceNodes(arg1, value)
            )
        elseif arg1 == value then
            tbl1:reportError(
                ("Type %s cannot implement itself because it would create a circular reference."):format(arg1.name),
                getAllImplementsInterfaceNodes(arg1, value)
            )
        else
            local var2 = if typeof(nil) == "table" then tostring(value.name) else tostring(value)

            if tbl2[var2] then
                tbl1:reportError(
                    ("Type %s can only implement %s once."):format(arg1.name, value.name),
                    getAllImplementsInterfaceNodes(arg1, value)
                )
            else
                tbl2[var2] = true

                validateTypeImplementsAncestors(tbl1, arg1, value)
                validateTypeImplementsInterface(tbl1, arg1, value)
            end
        end
    end
end

validateTypeImplementsInterface = function(tbl1, arg1, arg2)
    local fields = arg1:getFields()

    for _, value in ipairs(arg2:getFields():values()) do
        local name = value.name

        local var2 = fields:get(name)

        if not var2 then
            tbl1:reportError(
                ("Interface field %s.%s expected but %s does not provide it."):format(arg2.name, name, arg1.name),
                Array.concat({ value.astNode }, getAllNodes(arg1))
            )
        else
            if not isTypeSubTypeOf(tbl1.schema, var2.type, value.type) then
                local str1 = ("Interface field %s.%s expects type "):format(arg2.name, name) .. ("%s but %s.%s "):format(inspect(value.type), arg1.name, name) .. ("is type %s."):format(inspect(var2.type))
                local tbl2 = { if value.astNode == nil then nil else value.astNode.type, if var2.astNode == nil then nil else var2.astNode.type }
                tbl1:reportError(str1, tbl2)
            end

            for _, arg in ipairs(value.args) do
                local name2 = arg.name
                local var3 = Array.find(var2.args, function(arg3): boolean
                    return arg3.name == name2
                end)

                if not var3 then
                    tbl1:reportError(
                        ("Interface field argument %s.%s(%s:) expected but %s.%s does not provide it."):format(
                            arg2.name,
                            name,
                            name2,
                            arg1.name,
                            name
                        ),
                        { arg.astNode, var2.astNode }
                    )
                elseif not isEqualType(arg.type, var3.type) then
                    local str1 = ("Interface field argument %s.%s(%s:) "):format(arg2.name, name, name2) .. ("expects type %s but "):format(inspect(arg.type)) .. ("%s.%s(%s:) is type "):format(arg1.name, name, name2) .. ("%s."):format(inspect(var3.type))
                    local tbl2 = { if arg.astNode == nil then nil else arg.astNode.type, if var3.astNode == nil then nil else var3.astNode.type }
                    tbl1:reportError(str1, tbl2)
                end
            end

            for _, arg in ipairs(var2.args) do
                local name2 = arg.name
                if not Array.find(value.args, function(arg3): boolean
                    return arg3.name == name2
                end) and isRequiredArgument(arg) then
                    tbl1:reportError(
                        ("Object field %s.%s includes required argument %s that is missing from the Interface field %s.%s."):format(
                            arg1.name,
                            name,
                            name2,
                            arg2.name,
                            name
                        ),
                        { arg.astNode, value.astNode }
                    )
                end
            end
        end
    end
end

validateTypeImplementsAncestors = function(tbl1, arg1, arg2)
    local interfaces = arg1:getInterfaces()

    for _, value in ipairs(arg2:getInterfaces()) do
        if Array.indexOf(interfaces, value) == -1 then
            local str1 = if value == arg1 then ("Type %s cannot implement %s because it would create a circular reference."):format(arg1.name, arg2.name) else ("Type %s must implement %s because it is implemented by %s."):format(arg1.name, value.name, arg2.name)
            tbl1:reportError(
                str1,
                Array.concat(getAllImplementsInterfaceNodes(arg2, value), getAllImplementsInterfaceNodes(arg1, arg2))
            )
        end
    end
end

function validateUnionMembers(tbl1, arg1)
    local types = arg1:getTypes()

    if #types == 0 then
        tbl1:reportError(("Union type %s must define one or more member types."):format(arg1.name), getAllNodes(arg1))
    end

    local tbl2 = {}

    for _, value in ipairs(types) do
        if tbl2[tostring(value.name)] then
            tbl1:reportError(
                ("Union type %s can only include type %s once."):format(arg1.name, value.name),
                getUnionMemberTypeNodes(arg1, value.name)
            )
        else
            local name = value.name
            tbl2[tostring(name)] = true

            if not isObjectType(value) then
                tbl1:reportError(
                    ("Union type %s can only include Object types, "):format(arg1.name) .. ("it cannot include %s."):format(inspect(value)),
                    getUnionMemberTypeNodes(arg1, tostring(value))
                )
            end
        end
    end
end

validateEnumValues = function(tbl1, arg1)
    local values = arg1:getValues()

    if #values == 0 then
        tbl1:reportError(("Enum type %s must define one or more values."):format(arg1.name), getAllNodes(arg1))
    end

    for _, value in ipairs(values) do
        local name = value.name

        validateName(tbl1, value)

        if name == "true" or name == "false" or name == "null" then
            tbl1:reportError(("Enum type %s cannot include value: %s."):format(arg1.name, name), value.astNode)
        end
    end
end

function validateInputFields(tbl1, arg1)
    local var2 = arg1:getFields():values()

    if #var2 == 0 then
        tbl1:reportError(("Input Object type %s must define one or more fields."):format(arg1.name), getAllNodes(arg1))
    end

    for _, value in ipairs(var2) do
        validateName(tbl1, value)

        if not isInputType(value.type) then
            local str1 = ("The type of %s.%s must be Input Type "):format(arg1.name, value.name) .. ("but got: %s."):format(inspect(value.type))
            local type = if value.astNode == nil then nil else value.astNode.type
            tbl1:reportError(str1, type)
        end

        if not (isRequiredInputField(value) and isNotNillish(value.deprecationReason)) then
            continue
        end
        local str1 = ("Required input field %s.%s cannot be deprecated."):format(arg1.name, value.name)

        local tbl2 = { getDeprecatedDirectiveNode(value.astNode), if value.astNode == nil then nil else value.astNode.type }
        tbl1:reportError(str1, tbl2)
    end
end

function createInputObjectCircularRefsValidator(tbl1)
    local tbl2 = {}

    local tbl3 = {}

    local tbl4 = {}

    local function detectCycleRecursive(arg1)
        local tbl5 = tbl2

        if tbl5[tostring(arg1.name)] then
            return
        end

        local tbl6 = tbl2
        local name = arg1.name
        tbl6[tostring(name)] = true

        local tbl7 = tbl4
        local name2 = arg1.name
        tbl7[tostring(name2)] = #tbl3 + 1

        local var2 = arg1:getFields():values()

        for _, value in ipairs(var2) do
            if not (isNonNullType(value.type) and isInputObjectType(value.type.ofType)) then
                continue
            end

            local ofType = value.type.ofType

            local var3 = tbl4[tostring(ofType.name)]

            table.insert(tbl3, value)

            if var3 == nil then
                detectCycleRecursive(ofType)
            else
                local var4 = Array.slice(tbl3, var3)
                local var5 = Array.join(Array.map(var4, function(arg2)
                    return arg2.name
                end), ".")

                tbl1:reportError(
                    ("Cannot reference Input Object \"%s\" within itself through a series of non-null fields: \"%s\"."):format(
                        ofType.name,
                        var5
                    ),
                    Array.map(var4, function(arg2)
                        return arg2.astNode
                    end)
                )
            end

            table.remove(tbl3)
        end

        local tbl8 = tbl4
        local name3 = arg1.name
        tbl8[tostring(name3)] = nil
    end

    return detectCycleRecursive
end

getAllNodes = function(tbl1)
    local astNode = tbl1.astNode
    local extensionAstNodes = tbl1.extensionASTNodes

    if not astNode then
        return extensionAstNodes or {}
    end

    if extensionAstNodes then
        return (Array.concat({ astNode }, extensionAstNodes))
    end

    return { astNode }
end

getAllSubNodes = function(tbl1, func2: (...any) -> (...any))
    local allSubNodes = {}

    for _, value in ipairs(getAllNodes(tbl1)) do
        local var2 = func2(value)
        allSubNodes = Array.concat(allSubNodes, var2 or {})
    end

    return allSubNodes
end

getAllImplementsInterfaceNodes = function(arg1, arg2)
    return Array.filter(getAllSubNodes(arg1, function(arg3)
        return arg3.interfaces
    end), function(arg3): boolean
        return arg3.name.value == arg2.name
    end)
end

getUnionMemberTypeNodes = function(arg1, str1: string)
    return Array.filter(getAllSubNodes(arg1, function(arg2)
        return arg2.types
    end), function(arg2): boolean
        return arg2.name.value == str1
    end)
end

getDeprecatedDirectiveNode = function(tbl1)
    if tbl1 ~= nil and tbl1.directives ~= nil then
        return Array.find(tbl1.directives, function(arg1): boolean
            return arg1.name.value == GraphQLDeprecatedDirective.name
        end)
    end
end

return {
    validateSchema = validateSchema,
    assertValidSchema = function(arg1)
        local var2 = validateSchema(arg1)

        if #var2 ~= 0 then
            error(Error.new(Array.join(Array.map(var2, function(arg2)
                return arg2.message
            end), "\n\n")))
        end
    end
}
