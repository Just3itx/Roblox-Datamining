-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}

local _Path = require(script.Parent.jsutils.Path)

local schema = require(script.schema)

tbl1.isSchema = schema.isSchema

tbl1.assertSchema = schema.assertSchema

tbl1.GraphQLSchema = schema.GraphQLSchema

local definition = require(script.definition)

tbl1.isType = definition.isType
tbl1.isScalarType = definition.isScalarType
tbl1.isObjectType = definition.isObjectType
tbl1.isInterfaceType = definition.isInterfaceType
tbl1.isUnionType = definition.isUnionType
tbl1.isEnumType = definition.isEnumType
tbl1.isInputObjectType = definition.isInputObjectType
tbl1.isListType = definition.isListType
tbl1.isNonNullType = definition.isNonNullType
tbl1.isInputType = definition.isInputType
tbl1.isOutputType = definition.isOutputType
tbl1.isLeafType = definition.isLeafType
tbl1.isCompositeType = definition.isCompositeType
tbl1.isAbstractType = definition.isAbstractType
tbl1.isWrappingType = definition.isWrappingType
tbl1.isNullableType = definition.isNullableType
tbl1.isNamedType = definition.isNamedType
tbl1.isRequiredArgument = definition.isRequiredArgument
tbl1.isRequiredInputField = definition.isRequiredInputField

tbl1.assertType = definition.assertType
tbl1.assertScalarType = definition.assertScalarType
tbl1.assertObjectType = definition.assertObjectType
tbl1.assertInterfaceType = definition.assertInterfaceType
tbl1.assertUnionType = definition.assertUnionType
tbl1.assertEnumType = definition.assertEnumType
tbl1.assertInputObjectType = definition.assertInputObjectType
tbl1.assertListType = definition.assertListType
tbl1.assertNonNullType = definition.assertNonNullType
tbl1.assertInputType = definition.assertInputType
tbl1.assertOutputType = definition.assertOutputType
tbl1.assertLeafType = definition.assertLeafType
tbl1.assertCompositeType = definition.assertCompositeType
tbl1.assertAbstractType = definition.assertAbstractType
tbl1.assertWrappingType = definition.assertWrappingType
tbl1.assertNullableType = definition.assertNullableType
tbl1.assertNamedType = definition.assertNamedType

tbl1.getNullableType = definition.getNullableType
tbl1.getNamedType = definition.getNamedType

tbl1.GraphQLScalarType = definition.GraphQLScalarType
tbl1.GraphQLObjectType = definition.GraphQLObjectType
tbl1.GraphQLInterfaceType = definition.GraphQLInterfaceType
tbl1.GraphQLUnionType = definition.GraphQLUnionType
tbl1.GraphQLEnumType = definition.GraphQLEnumType
tbl1.GraphQLInputObjectType = definition.GraphQLInputObjectType

tbl1.GraphQLList = definition.GraphQLList
tbl1.GraphQLNonNull = definition.GraphQLNonNull

local directives = require(script.directives)

tbl1.isDirective = directives.isDirective

tbl1.assertDirective = directives.assertDirective

tbl1.GraphQLDirective = directives.GraphQLDirective

tbl1.isSpecifiedDirective = directives.isSpecifiedDirective
tbl1.specifiedDirectives = directives.specifiedDirectives
tbl1.GraphQLIncludeDirective = directives.GraphQLIncludeDirective
tbl1.GraphQLSkipDirective = directives.GraphQLSkipDirective
tbl1.GraphQLDeprecatedDirective = directives.GraphQLDeprecatedDirective
tbl1.GraphQLSpecifiedByDirective = directives.GraphQLSpecifiedByDirective

tbl1.DEFAULT_DEPRECATION_REASON = directives.DEFAULT_DEPRECATION_REASON

local scalars = require(script.scalars)

tbl1.isSpecifiedScalarType = scalars.isSpecifiedScalarType

tbl1.specifiedScalarTypes = scalars.specifiedScalarTypes
tbl1.GraphQLInt = scalars.GraphQLInt
tbl1.GraphQLFloat = scalars.GraphQLFloat
tbl1.GraphQLString = scalars.GraphQLString
tbl1.GraphQLBoolean = scalars.GraphQLBoolean
tbl1.GraphQLID = scalars.GraphQLID

local introspection = require(script.introspection)

tbl1.isIntrospectionType = introspection.isIntrospectionType

tbl1.introspectionTypes = introspection.introspectionTypes
tbl1.__Schema = introspection.__Schema
tbl1.__Directive = introspection.__Directive
tbl1.__DirectiveLocation = introspection.__DirectiveLocation
tbl1.__Type = introspection.__Type
tbl1.__Field = introspection.__Field
tbl1.__InputValue = introspection.__InputValue
tbl1.__EnumValue = introspection.__EnumValue
tbl1.__TypeKind = introspection.__TypeKind

tbl1.TypeKind = introspection.TypeKind

tbl1.SchemaMetaFieldDef = introspection.SchemaMetaFieldDef
tbl1.TypeMetaFieldDef = introspection.TypeMetaFieldDef
tbl1.TypeNameMetaFieldDef = introspection.TypeNameMetaFieldDef

local validate = require(script.validate)

tbl1.validateSchema = validate.validateSchema
tbl1.assertValidSchema = validate.assertValidSchema

return tbl1
