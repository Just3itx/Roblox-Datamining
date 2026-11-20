-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local jsutils = scriptParentParent.jsutils
local language = scriptParentParent.language
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object

local isNotNillish = require(scriptParentParent.luaUtils.isNillish).isNotNillish

local inspect = require(jsutils.inspect).inspect
local invariant = require(jsutils.invariant).invariant

local print = require(language.printer).print
local DirectiveLocation = require(language.directiveLocation).DirectiveLocation
local astFromValue = require(scriptParentParent.utilities.astFromValue).astFromValue
local _ast = require(scriptParentParent.language.ast)

local scalars = require(script.Parent.scalars)
local GraphQLString = scalars.GraphQLString
local GraphQLBoolean = scalars.GraphQLBoolean
local definition = require(script.Parent.definition)

local GraphQLList = definition.GraphQLList
local GraphQLNonNull = definition.GraphQLNonNull
local GraphQLObjectType = definition.GraphQLObjectType
local GraphQLEnumType = definition.GraphQLEnumType
local isScalarType = definition.isScalarType
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isUnionType = definition.isUnionType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType
local isAbstractType = definition.isAbstractType

local var1 = nil

local var2 = nil
local var3 = nil
local var4 = nil
local var5 = nil
local var6 = nil
local var7 = nil
local var8 = nil

local graphQlObjectType = GraphQLObjectType.new({
    name = "__Schema",
    description = "A GraphQL Schema defines the capabilities of a GraphQL server. It exposes all available types and directives on the server, as well as the entry points for query, mutation, and subscription operations.",
    fields = function()
        return Map.new({
            {
                "description",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return arg1.description
                    end
                }
            },
            {
                "types",
                {
                    description = "A list of all types supported by this server.",
                    type = GraphQLNonNull.new(GraphQLList.new(GraphQLNonNull.new(var5))),
                    resolve = function(arg1)
                        return arg1:getTypeMap():values()
                    end
                }
            },
            {
                "queryType",
                {
                    description = "The type that query operations will be rooted at.",
                    type = GraphQLNonNull.new(var5),
                    resolve = function(arg1)
                        return arg1:getQueryType()
                    end
                }
            },
            {
                "mutationType",
                {
                    description = "If this server supports mutation, the type that mutation operations will be rooted at.",
                    type = var5,
                    resolve = function(arg1)
                        return arg1:getMutationType()
                    end
                }
            },
            {
                "subscriptionType",
                {
                    description = "If this server support subscription, the type that subscription operations will be rooted at.",
                    type = var5,
                    resolve = function(arg1)
                        return arg1:getSubscriptionType()
                    end
                }
            },
            {
                "directives",
                {
                    description = "A list of all directives supported by this server.",
                    type = GraphQLNonNull.new(GraphQLList.new(GraphQLNonNull.new(var3))),
                    resolve = function(arg1)
                        return arg1:getDirectives()
                    end
                }
            }
        })
    end
})

var3 = GraphQLObjectType.new({
    name = "__Directive",
    description = "A Directive provides a way to describe alternate runtime execution and type validation behavior in a GraphQL document.\n\nIn some cases, you need to provide options to alter GraphQL's execution behavior in ways field arguments will not suffice, such as conditionally including or skipping a field. Directives provide this by describing additional information to the executor.",
    fields = function()
        return Map.new({
            {
                "name",
                {
                    type = GraphQLNonNull.new(GraphQLString),
                    resolve = function(arg1)
                        return arg1.name
                    end
                }
            },
            {
                "description",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return arg1.description
                    end
                }
            },
            {
                "isRepeatable",
                {
                    type = GraphQLNonNull.new(GraphQLBoolean),
                    resolve = function(arg1)
                        return arg1.isRepeatable
                    end
                }
            },
            {
                "locations",
                {
                    type = GraphQLNonNull.new(GraphQLList.new(GraphQLNonNull.new(var4))),
                    resolve = function(arg1)
                        return arg1.locations
                    end
                }
            },
            {
                "args",
                {
                    type = GraphQLNonNull.new(GraphQLList.new(GraphQLNonNull.new(var7))),
                    resolve = function(arg1)
                        return arg1.args
                    end
                }
            }
        })
    end
})

var4 = GraphQLEnumType.new({
    name = "__DirectiveLocation",
    description = "A Directive can be adjacent to many parts of the GraphQL language, a __DirectiveLocation describes one such possible adjacencies.",
    values = Map.new({
        {
            "QUERY",
            {
                value = DirectiveLocation.QUERY,
                description = "Location adjacent to a query operation."
            }
        },
        {
            "MUTATION",
            {
                value = DirectiveLocation.MUTATION,
                description = "Location adjacent to a mutation operation."
            }
        },
        {
            "SUBSCRIPTION",
            {
                value = DirectiveLocation.SUBSCRIPTION,
                description = "Location adjacent to a subscription operation."
            }
        },
        {
            "FIELD",
            {
                value = DirectiveLocation.FIELD,
                description = "Location adjacent to a field."
            }
        },
        {
            "FRAGMENT_DEFINITION",
            {
                value = DirectiveLocation.FRAGMENT_DEFINITION,
                description = "Location adjacent to a fragment definition."
            }
        },
        {
            "FRAGMENT_SPREAD",
            {
                value = DirectiveLocation.FRAGMENT_SPREAD,
                description = "Location adjacent to a fragment spread."
            }
        },
        {
            "INLINE_FRAGMENT",
            {
                value = DirectiveLocation.INLINE_FRAGMENT,
                description = "Location adjacent to an inline fragment."
            }
        },
        {
            "VARIABLE_DEFINITION",
            {
                value = DirectiveLocation.VARIABLE_DEFINITION,
                description = "Location adjacent to a variable definition."
            }
        },
        {
            "SCHEMA",
            {
                value = DirectiveLocation.SCHEMA,
                description = "Location adjacent to a schema definition."
            }
        },
        {
            "SCALAR",
            {
                value = DirectiveLocation.SCALAR,
                description = "Location adjacent to a scalar definition."
            }
        },
        {
            "OBJECT",
            {
                value = DirectiveLocation.OBJECT,
                description = "Location adjacent to an object type definition."
            }
        },
        {
            "FIELD_DEFINITION",
            {
                value = DirectiveLocation.FIELD_DEFINITION,
                description = "Location adjacent to a field definition."
            }
        },
        {
            "ARGUMENT_DEFINITION",
            {
                value = DirectiveLocation.ARGUMENT_DEFINITION,
                description = "Location adjacent to an argument definition."
            }
        },
        {
            "INTERFACE",
            {
                value = DirectiveLocation.INTERFACE,
                description = "Location adjacent to an interface definition."
            }
        },
        {
            "UNION",
            {
                value = DirectiveLocation.UNION,
                description = "Location adjacent to a union definition."
            }
        },
        {
            "ENUM",
            {
                value = DirectiveLocation.ENUM,
                description = "Location adjacent to an enum definition."
            }
        },
        {
            "ENUM_VALUE",
            {
                value = DirectiveLocation.ENUM_VALUE,
                description = "Location adjacent to an enum value definition."
            }
        },
        {
            "INPUT_OBJECT",
            {
                value = DirectiveLocation.INPUT_OBJECT,
                description = "Location adjacent to an input object type definition."
            }
        },
        {
            "INPUT_FIELD_DEFINITION",
            {
                value = DirectiveLocation.INPUT_FIELD_DEFINITION,
                description = "Location adjacent to an input object field definition."
            }
        }
    })
})

var5 = GraphQLObjectType.new({
    name = "__Type",
    description = "The fundamental unit of any GraphQL Schema is the type. There are many kinds of types in GraphQL as represented by the `__TypeKind` enum.\n\nDepending on the kind of a type, certain fields describe information about that type. Scalar types provide no information beyond a name, description and optional `specifiedByUrl`, while Enum types provide their values. Object and Interface types provide the fields they describe. Abstract types, Union and Interface, provide the Object types possible at runtime. List and NonNull types compose other types.",
    fields = function()
        return Map.new({
            {
                "kind",
                {
                    type = GraphQLNonNull.new(var2),
                    resolve = function(arg1)
                        if isScalarType(arg1) then
                            return var1.SCALAR
                        end
                        if isObjectType(arg1) then
                            return var1.OBJECT
                        end
                        if isInterfaceType(arg1) then
                            return var1.INTERFACE
                        end
                        if isUnionType(arg1) then
                            return var1.UNION
                        end
                        if isEnumType(arg1) then
                            return var1.ENUM
                        end
                        if isInputObjectType(arg1) then
                            return var1.INPUT_OBJECT
                        end
                        if isListType(arg1) then
                            return var1.LIST
                        end

                        if isNonNullType(arg1) then
                            return var1.NON_NULL
                        end

                        invariant(false, ("Unexpected type: \"%s\"."):format(inspect(arg1)))
                        assert(false)
                    end
                }
            },
            {
                "name",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return if arg1.name == nil then nil else arg1.name
                    end
                }
            },
            {
                "description",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return if arg1.description == nil then nil else arg1.description
                    end
                }
            },
            {
                "specifiedByUrl",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return if arg1.specifiedByUrl == nil then nil else arg1.specifiedByUrl
                    end
                }
            },
            {
                "fields",
                {
                    type = GraphQLList.new(GraphQLNonNull.new(var6)),
                    args = {
                        includeDeprecated = { type = GraphQLBoolean, defaultValue = false }
                    },
                    resolve = function(arg1, arg2)
                        local includeDeprecated = arg2.includeDeprecated
                        if isObjectType(arg1) or isInterfaceType(arg1) then
                            local var9 = arg1:getFields():values()
                            return includeDeprecated and var9 or Array.filter(var9, function(arg3): boolean
                                return arg3.deprecationReason == nil
                            end)
                        end
                    end
                }
            },
            {
                "interfaces",
                {
                    type = GraphQLList.new(GraphQLNonNull.new(var5)),
                    resolve = function(arg1)
                        if isObjectType(arg1) or isInterfaceType(arg1) then
                            return arg1:getInterfaces()
                        end
                    end
                }
            },
            {
                "possibleTypes",
                {
                    type = GraphQLList.new(GraphQLNonNull.new(var5)),
                    resolve = function(arg1, _, _, arg2)
                        local schema = arg2.schema

                        if isAbstractType(arg1) then
                            return schema:getPossibleTypes(arg1)
                        end
                        return nil
                    end
                }
            },
            {
                "enumValues",
                {
                    type = GraphQLList.new(GraphQLNonNull.new(var8)),
                    args = {
                        includeDeprecated = { type = GraphQLBoolean, defaultValue = false }
                    },
                    resolve = function(arg1, arg2)
                        local includeDeprecated = arg2.includeDeprecated

                        if isEnumType(arg1) then
                            local values = arg1:getValues()

                            return includeDeprecated and values or Array.filter(values, function(arg3): boolean
                                return arg3.deprecationReason == nil
                            end)
                        end
                    end
                }
            },
            {
                "inputFields",
                {
                    type = GraphQLList.new(GraphQLNonNull.new(var7)),
                    args = {
                        includeDeprecated = { type = GraphQLBoolean, defaultValue = false }
                    },
                    resolve = function(arg1, arg2)
                        local includeDeprecated = arg2.includeDeprecated

                        if isInputObjectType(arg1) then
                            local var9 = arg1:getFields():values()

                            return includeDeprecated and var9 or Array.filter(var9, function(arg3): boolean
                                return arg3.deprecationReason == nil
                            end)
                        end
                    end
                }
            },
            {
                "ofType",
                {
                    type = var5,
                    resolve = function(arg1)
                        return if arg1.ofType == nil then nil else arg1.ofType
                    end
                }
            }
        })
    end
})

var6 = GraphQLObjectType.new({
    name = "__Field",
    description = "Object and Interface types are described by a list of Fields, each of which has a name, potentially a list of arguments, and a return type.",
    fields = function()
        return Map.new({
            {
                "name",
                {
                    type = GraphQLNonNull.new(GraphQLString),
                    resolve = function(arg1)
                        return arg1.name
                    end
                }
            },
            {
                "description",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return arg1.description
                    end
                }
            },
            {
                "args",
                {
                    type = GraphQLNonNull.new(GraphQLList.new(GraphQLNonNull.new(var7))),
                    args = {
                        includeDeprecated = { type = GraphQLBoolean, defaultValue = false }
                    },
                    resolve = function(arg1, arg2)
                        if arg2.includeDeprecated then
                            return arg1.args
                        end

                        return (Array.filter(arg1.args, function(arg3): boolean
                            return arg3.deprecationReason == nil
                        end))
                    end
                }
            },
            {
                "type",
                {
                    type = GraphQLNonNull.new(var5),
                    resolve = function(arg1)
                        return arg1.type
                    end
                }
            },
            {
                "isDeprecated",
                {
                    type = GraphQLNonNull.new(GraphQLBoolean),
                    resolve = function(arg1)
                        return isNotNillish(arg1.deprecationReason)
                    end
                }
            },
            {
                "deprecationReason",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return arg1.deprecationReason
                    end
                }
            }
        })
    end
})

var7 = GraphQLObjectType.new({
    name = "__InputValue",
    description = "Arguments provided to Fields or Directives and the input fields of an InputObject are represented as Input Values which describe their type and optionally a default value.",
    fields = function()
        return Map.new({
            {
                "name",
                {
                    type = GraphQLNonNull.new(GraphQLString),
                    resolve = function(arg1)
                        return arg1.name
                    end
                }
            },
            {
                "description",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return arg1.description
                    end
                }
            },
            {
                "type",
                {
                    type = GraphQLNonNull.new(var5),
                    resolve = function(arg1)
                        return arg1.type
                    end
                }
            },
            {
                "defaultValue",
                {
                    type = GraphQLString,
                    description = "A GraphQL-formatted string representing the default value for this input value.",
                    resolve = function(arg1)
                        local type = arg1.type
                        local defaultValue = arg1.defaultValue
                        local var9 = astFromValue(defaultValue, type)

                        if var9 then
                            return (print(var9))
                        end

                        return nil
                    end
                }
            },
            {
                "isDeprecated",
                {
                    type = GraphQLNonNull.new(GraphQLBoolean),
                    resolve = function(arg1)
                        return isNotNillish(arg1.deprecationReason)
                    end
                }
            },
            {
                "deprecationReason",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return arg1.deprecationReason
                    end
                }
            }
        })
    end
})

var8 = GraphQLObjectType.new({
    name = "__EnumValue",
    description = "One possible value for a given Enum. Enum values are unique values, not a placeholder for a string or numeric value. However an Enum value is returned in a JSON response as a string.",
    fields = function()
        return Map.new({
            {
                "name",
                {
                    type = GraphQLNonNull.new(GraphQLString),
                    resolve = function(arg1)
                        return arg1.name
                    end
                }
            },
            {
                "description",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return arg1.description
                    end
                }
            },
            {
                "isDeprecated",
                {
                    type = GraphQLNonNull.new(GraphQLBoolean),
                    resolve = function(arg1)
                        return isNotNillish(arg1.deprecationReason)
                    end
                }
            },
            {
                "deprecationReason",
                {
                    type = GraphQLString,
                    resolve = function(arg1)
                        return arg1.deprecationReason
                    end
                }
            }
        })
    end
})

var1 = Object.freeze({
    SCALAR = "SCALAR",
    OBJECT = "OBJECT",
    INTERFACE = "INTERFACE",
    UNION = "UNION",
    ENUM = "ENUM",
    INPUT_OBJECT = "INPUT_OBJECT",
    LIST = "LIST",
    NON_NULL = "NON_NULL"
})

var2 = GraphQLEnumType.new({
    name = "__TypeKind",
    description = "An enum describing what kind of type a given `__Type` is.",
    values = Map.new({
        {
            "SCALAR",
            {
                value = var1.SCALAR,
                description = "Indicates this type is a scalar."
            }
        },
        {
            "OBJECT",
            {
                value = var1.OBJECT,
                description = "Indicates this type is an object. `fields` and `interfaces` are valid fields."
            }
        },
        {
            "INTERFACE",
            {
                value = var1.INTERFACE,
                description = "Indicates this type is an interface. `fields`, `interfaces`, and `possibleTypes` are valid fields."
            }
        },
        {
            "UNION",
            {
                value = var1.UNION,
                description = "Indicates this type is a union. `possibleTypes` is a valid field."
            }
        },
        {
            "ENUM",
            {
                value = var1.ENUM,
                description = "Indicates this type is an enum. `enumValues` is a valid field."
            }
        },
        {
            "INPUT_OBJECT",
            {
                value = var1.INPUT_OBJECT,
                description = "Indicates this type is an input object. `inputFields` is a valid field."
            }
        },
        {
            "LIST",
            {
                value = var1.LIST,
                description = "Indicates this type is a list. `ofType` is a valid field."
            }
        },
        {
            "NON_NULL",
            {
                value = var1.NON_NULL,
                description = "Indicates this type is a non-null. `ofType` is a valid field."
            }
        }
    })
})

local SchemaMetaFieldDef = {
    name = "__schema",
    type = GraphQLNonNull.new(graphQlObjectType),
    description = "Access the current type schema of this server.",
    args = {},
    resolve = function(_, _, _, arg1)
        return arg1.schema
    end,
    deprecationReason = nil,
    extensions = nil,
    astNode = nil
}

local TypeMetaFieldDef = {
    name = "__type",
    type = var5,
    description = "Request the type information of a single type.",
    args = {{
        name = "name",
        description = nil,
        type = GraphQLNonNull.new(GraphQLString),
        defaultValue = nil,
        deprecationReason = nil,
        extensions = nil,
        astNode = nil
    }},
    resolve = function(_, arg1, _, arg2)
        local name = arg1.name
        return arg2.schema:getType(name)
    end,
    deprecationReason = nil,
    extensions = nil,
    astNode = nil
}

local TypeNameMetaFieldDef = {
    name = "__typename",
    type = GraphQLNonNull.new(GraphQLString),
    description = "The name of the current Object type at runtime.",
    args = {},
    resolve = function(_, _, _, arg1)
        return arg1.parentType.name
    end,
    deprecationReason = nil,
    extensions = nil,
    astNode = nil
}

local introspectionTypes = Object.freeze({ graphQlObjectType, var3, var4, var5, var6, var7, var8, var2 })

return {
    introspectionTypes = introspectionTypes,
    isIntrospectionType = function(arg1)
        return Array.some(introspectionTypes, function(arg2): boolean
            local name = arg2.name
            return arg1.name == name
        end)
    end,
    TypeNameMetaFieldDef = TypeNameMetaFieldDef,
    TypeMetaFieldDef = TypeMetaFieldDef,
    SchemaMetaFieldDef = SchemaMetaFieldDef,
    TypeKind = var1,
    __TypeKind = var2,
    __Schema = graphQlObjectType,
    __Directive = var3,
    __DirectiveLocation = var4,
    __Type = var5,
    __Field = var6,
    __InputValue = var7,
    __EnumValue = var8
}
