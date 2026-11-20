-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local isObjectType = GraphQL.isObjectType
local getNamedType = GraphQL.getNamedType
local isUnionType = GraphQL.isUnionType

local isNonNullType = GraphQL.isNonNullType

local isScalarType = GraphQL.isScalarType

local isListType = GraphQL.isListType

local isInterfaceType = GraphQL.isInterfaceType
local isEnumType = GraphQL.isEnumType
local Kind = GraphQL.Kind

local rootTypes = require(script.Parent.rootTypes)

local getDefinedRootType = rootTypes.getDefinedRootType
local getRootTypeNames = rootTypes.getRootTypeNames

local buildOperationAndCollectVariables = nil
local resolveVariable = nil
local hasCircularRef = nil
local resolveField = nil

local tbl1 = {}

local tbl2 = {}
local map = Map.new()
local function addOperationVariable(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    table.insert(tbl2, arg1)
end

local function resetOperationVariables() -- Luacid: Inlined by compiler; 2 call sites recovered
    tbl2 = {}
end

local function resetFieldMap() -- Luacid: Inlined by compiler; 2 call sites recovered
    map = Map.new()
end

function module.buildOperationNodeForField(tbl3)
    local schema = tbl3.schema
    local kind = tbl3.kind
    local field = tbl3.field
    local models = tbl3.models
    local ignore = tbl3.ignore == nil and {} or tbl3.ignore
    local depthLimit = tbl3.depthLimit
    local circularReferenceDepth = tbl3.circularReferenceDepth
    local argNames = tbl3.argNames
    local selectedFields = tbl3.selectedFields == nil or tbl3.selectedFields
    resetOperationVariables()
    resetFieldMap()
    local rootTypeNames = getRootTypeNames(schema)

    local operationAndCollectVariables = buildOperationAndCollectVariables({
        schema = schema,
        fieldName = field,
        kind = kind,
        models = not Boolean.toJSBoolean(models) and {} or models,
        ignore = ignore,
        depthLimit = not Boolean.toJSBoolean(depthLimit) and math.huge or depthLimit,
        circularReferenceDepth = Boolean.toJSBoolean(circularReferenceDepth) and circularReferenceDepth or 1,
        argNames = argNames,
        selectedFields = selectedFields,
        rootTypeNames = rootTypeNames
    })

    operationAndCollectVariables.variableDefinitions = Array.concat({}, tbl2)
    resetOperationVariables()
    resetFieldMap()
    return operationAndCollectVariables
end

buildOperationAndCollectVariables = function(tbl3)
    local schema = tbl3.schema
    local fieldName = tbl3.fieldName
    local kind = tbl3.kind
    local models = tbl3.models
    local ignore = tbl3.ignore
    local depthLimit = tbl3.depthLimit
    local circularReferenceDepth = tbl3.circularReferenceDepth
    local argNames = tbl3.argNames
    local selectedFields = tbl3.selectedFields
    local rootTypeNames = tbl3.rootTypeNames

    local type = getDefinedRootType(schema, kind)

    local field = type:getFields():get(fieldName)

    local value = ("%s_%s"):format(tostring(fieldName), tostring(kind))

    if field and field.args then
        for _, arg in field.args do
            local name = arg.name

            if not argNames or Array.includes(argNames, name) then
                addOperationVariable((resolveVariable(arg, name)))
            end
        end
    end
    return {
        kind = Kind.OPERATION_DEFINITION,
        operation = kind,
        name = {
            kind = Kind.NAME,
            value = value
        },
        variableDefinitions = {},
        selectionSet = {
            kind = Kind.SELECTION_SET,
            selections = { resolveField({
                    type = type,
                    field = field,
                    models = models,
                    firstCall = true,
                    path = {},
                    ancestors = {},
                    ignore = ignore,
                    depthLimit = depthLimit,
                    circularReferenceDepth = circularReferenceDepth,
                    schema = schema,
                    depth = 0,
                    argNames = argNames,
                    selectedFields = selectedFields,
                    rootTypeNames = rootTypeNames
                }) }
        }
    }
end

local function resolveSelectionSet(tbl3)
    local parent = tbl3.parent
    local type = tbl3.type
    local models = tbl3.models
    local firstCall = tbl3.firstCall
    local path = tbl3.path
    local ancestors = tbl3.ancestors
    local ignore = tbl3.ignore
    local depthLimit = tbl3.depthLimit
    local circularReferenceDepth = tbl3.circularReferenceDepth
    local schema = tbl3.schema
    local depth = tbl3.depth
    local argNames = tbl3.argNames
    local selectedFields = tbl3.selectedFields
    local rootTypeNames = tbl3.rootTypeNames

    if typeof(selectedFields) == "boolean" and depthLimit < depth then
        return
    end

    if Boolean.toJSBoolean(isUnionType(type)) then
        local types = type:getTypes()

        return {
            kind = Kind.SELECTION_SET,
            selections = Array.filter(Array.map(Array.filter(types, function(arg1): boolean
                return not hasCircularRef(Array.concat({}, ancestors, { arg1 }), { depth = circularReferenceDepth })
            end), function(type2)
                return {
                    kind = Kind.INLINE_FRAGMENT,
                    typeCondition = {
                        kind = Kind.NAMED_TYPE,
                        name = {
                            kind = Kind.NAME,
                            value = type2.name
                        }
                    },
                    selectionSet = resolveSelectionSet({
                        parent = type,
                        type = type2,
                        models = models,
                        path = path,
                        ancestors = ancestors,
                        ignore = ignore,
                        depthLimit = depthLimit,
                        circularReferenceDepth = circularReferenceDepth,
                        schema = schema,
                        depth = depth,
                        argNames = argNames,
                        selectedFields = selectedFields,
                        rootTypeNames = rootTypeNames
                    })
                }
            end), function(arg1): boolean
                return typeof(arg1) == "table"
                    and arg1.selectionSet ~= tbl1
                    and typeof(arg1.selectionSet) == "table"
                    and typeof(arg1.selectionSet.selections) == "table"
                    and #arg1.selectionSet.selections > 0
            end)
        }
    end

    if Boolean.toJSBoolean(isInterfaceType(type)) then
        local var1 = Array.filter(schema:getTypeMap():values(), function(arg1)
            local var1 = isObjectType(arg1)
            if Boolean.toJSBoolean(var1) then
                return (Array.includes(arg1:getInterfaces(), type))
            end

            return var1
        end)
        return {
            kind = Kind.SELECTION_SET,
            selections = Array.filter(Array.map(Array.filter(var1, function(arg1): boolean
                return not hasCircularRef(Array.concat({}, ancestors, { arg1 }), { depth = circularReferenceDepth })
            end), function(type2)
                return {
                    kind = Kind.INLINE_FRAGMENT,
                    typeCondition = {
                        kind = Kind.NAMED_TYPE,
                        name = {
                            kind = Kind.NAME,
                            value = type2.name
                        }
                    },
                    selectionSet = resolveSelectionSet({
                        parent = type,
                        type = type2,
                        models = models,
                        path = path,
                        ancestors = ancestors,
                        ignore = ignore,
                        depthLimit = depthLimit,
                        circularReferenceDepth = circularReferenceDepth,
                        schema = schema,
                        depth = depth,
                        argNames = argNames,
                        selectedFields = selectedFields,
                        rootTypeNames = rootTypeNames
                    })
                }
            end), function(arg1): boolean
                return typeof(arg1) == "table"
                    and arg1.selectionSet ~= tbl1
                    and typeof(arg1.selectionSet) == "table"
                    and typeof(arg1.selectionSet.selections) == "table"
                    and #arg1.selectionSet.selections > 0
            end)
        }
    end

    local toJsBoolean = Boolean.toJSBoolean
    local bool1 = isObjectType(type)
    if Boolean.toJSBoolean(bool1) then
        bool1 = not Boolean.toJSBoolean(rootTypeNames:has(type.name))
    end

    if not toJsBoolean(bool1) then
        return nil
    end

    local var1 = Array.includes(ignore, type.name)
    if not (Boolean.toJSBoolean(var1) and var1) then
        local includes = Array.includes

        local name = parent.name
        local var2 = path[#path]
        var1 = includes(ignore, ("%s.%s"):format(name, tostring(var2)))
    end

    local var2 = Array.includes(models, type.name)

    local toJsBoolean2 = Boolean.toJSBoolean
    local bool2 = not Boolean.toJSBoolean(firstCall) and var2
    if Boolean.toJSBoolean(bool2) then
        bool2 = not Boolean.toJSBoolean(var1)
    end

    if toJsBoolean2(bool2) then
        return {
            kind = Kind.SELECTION_SET,
            selections = {{
                kind = Kind.FIELD,
                name = {
                    kind = Kind.NAME,
                    value = "id"
                }
            }}
        }
    end
    local fields = type:getFields()

    return {
        kind = Kind.SELECTION_SET,
        selections = Array.filter(Array.map(Array.filter(fields:keys(), function(arg1): boolean
            return not hasCircularRef(Array.concat({}, ancestors, { getNamedType(fields:get(arg1).type) }), { depth = circularReferenceDepth })
        end), function(arg1)
            local var3 = typeof(selectedFields) ~= "table" or selectedFields[tostring(arg1)]

            if not Boolean.toJSBoolean(var3) then
                return tbl1
            end

            return resolveField({
                type = type,
                field = fields:get(arg1),
                models = models,
                path = Array.concat({}, path, { arg1 }),
                ancestors = ancestors,
                ignore = ignore,
                depthLimit = depthLimit,
                circularReferenceDepth = circularReferenceDepth,
                schema = schema,
                depth = depth,
                argNames = argNames,
                selectedFields = var3,
                rootTypeNames = rootTypeNames
            })
        end), function(arg1)
            if arg1 == nil or arg1 == tbl1 then
                return false
            end

            if Array.indexOf(Object.keys(arg1), "selectionSet") == -1 then
                return true
            end

            return Boolean.toJSBoolean(
                typeof(arg1.selectionSet) == "table"
                    and typeof(arg1.selectionSet.selections) == "table"
                    and #arg1.selectionSet.selections
                    or nil
            )
        end)
    }
end

resolveVariable = function(arg1, str1: string?)
    local function resolveVariableType(arg2)
        if Boolean.toJSBoolean(isListType(arg2)) then
            return {
                kind = Kind.LIST_TYPE,
                type = resolveVariableType(arg2.ofType)
            }
        end

        if Boolean.toJSBoolean(isNonNullType(arg2)) then
            return {
                kind = Kind.NON_NULL_TYPE,
                type = resolveVariableType(arg2.ofType)
            }
        end

        return {
            kind = Kind.NAMED_TYPE,
            name = {
                kind = Kind.NAME,
                value = arg2.name
            }
        }
    end

    return {
        kind = Kind.VARIABLE_DEFINITION,
        variable = {
            kind = Kind.VARIABLE,
            name = {
                kind = Kind.NAME,
                value = Boolean.toJSBoolean(str1) and str1 or arg1.name
            }
        },
        type = resolveVariableType(arg1.type)
    }
end

local function getArgumentName(name: string, path)
    return Array.join(Array.concat({}, path, { name }), "_")
end

resolveField = function(tbl3)
    local type = tbl3.type
    local field = tbl3.field
    local models = tbl3.models
    local firstCall = tbl3.firstCall
    local path = tbl3.path
    local ancestors = tbl3.ancestors
    local ignore = tbl3.ignore
    local depthLimit = tbl3.depthLimit
    local circularReferenceDepth = tbl3.circularReferenceDepth
    local schema = tbl3.schema
    local depth = tbl3.depth
    local argNames = tbl3.argNames
    local selectedFields = tbl3.selectedFields
    local rootTypeNames = tbl3.rootTypeNames
    local namedType = getNamedType(field.type)
    local tbl4 = {}
    local bool1 = false

    if Boolean.toJSBoolean(field.args) and #field.args ~= 0 then
        tbl4 = Array.filter(Array.map(field.args, function(arg1)
            local argumentName = getArgumentName(arg1.name, path)

            if if argNames then not Array.includes(argNames, argumentName) else Boolean.toJSBoolean(argNames) then
                if Boolean.toJSBoolean(isNonNullType(arg1.type)) then
                    bool1 = true
                end
                return nil
            end
            if not Boolean.toJSBoolean(firstCall) then
                addOperationVariable((resolveVariable(arg1, argumentName)))
            end
            return {
                kind = Kind.ARGUMENT,
                name = {
                    kind = Kind.NAME,
                    value = arg1.name
                },
                value = {
                    kind = Kind.VARIABLE,
                    name = {
                        kind = Kind.NAME,
                        value = getArgumentName(arg1.name, path)
                    }
                }
            }
        end), Boolean.toJSBoolean)
    end

    if Boolean.toJSBoolean(bool1) then
        return nil
    end

    local var1 = Array.concat({}, path, { field.name })

    local var2 = Array.join(var1, ".")
    local name = field.name

    local toJsBoolean = Boolean.toJSBoolean
    local bool2 = map:has(var2)
    if Boolean.toJSBoolean(bool2) then
        bool2 = map:get(var2) ~= tostring(field.type)
    end

    if toJsBoolean(bool2) then
        name ..= tostring(field.type):gsub("!", "NonNull")
    end

    map:set(var2, tostring(field.type))
    if Boolean.toJSBoolean(isScalarType(namedType)) or Boolean.toJSBoolean(isEnumType(namedType)) then
        return Object.assign(
            {},
            {
                kind = Kind.FIELD,
                name = {
                    kind = Kind.NAME,
                    value = field.name
                }
            },
            name ~= field.name and {
                alias = {
                    kind = Kind.NAME,
                    value = name
                }
            } or false,
            { arguments = tbl4 }
        )
    end

    local var3 = resolveSelectionSet({
        parent = type,
        type = namedType,
        models = models,
        firstCall = firstCall,
        path = var1,
        ancestors = Array.concat({}, ancestors, { type }),
        ignore = ignore,
        depthLimit = depthLimit,
        circularReferenceDepth = circularReferenceDepth,
        schema = schema,
        depth = depth + 1,
        argNames = argNames,
        selectedFields = selectedFields,
        rootTypeNames = rootTypeNames
    })
    if not Boolean.toJSBoolean(var3) then
        var3 = nil
    end
    return Object.assign(
        {},
        {
            kind = Kind.FIELD,
            name = {
                kind = Kind.NAME,
                value = field.name
            }
        },
        name ~= field.name and {
            alias = {
                kind = Kind.NAME,
                value = name
            }
        } or false,
        {
            selectionSet = Boolean.toJSBoolean(var3) and var3 or tbl1,
            arguments = tbl4
        }
    )
end

hasCircularRef = function(arg1, tbl3): boolean
    local var1 = arg1[#arg1]

    return not Boolean.toJSBoolean(isScalarType(var1)) and #Array.filter(arg1, function(arg2): boolean
        return arg2.name == var1.name
    end) > (tbl3 == nil and { depth = 1 } or tbl3).depth
end
return module
