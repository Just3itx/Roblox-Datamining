-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}

local version = require(script.version)
tbl1.version = version.version
tbl1.versionInfo = version.versionInfo

local graphql = require(script.graphql)
tbl1.graphql = graphql.graphql
tbl1.graphqlSync = graphql.graphqlSync

local type = require(script.type)

tbl1.GraphQLSchema = type.GraphQLSchema
tbl1.GraphQLDirective = type.GraphQLDirective
tbl1.GraphQLScalarType = type.GraphQLScalarType
tbl1.GraphQLObjectType = type.GraphQLObjectType
tbl1.GraphQLInterfaceType = type.GraphQLInterfaceType
tbl1.GraphQLUnionType = type.GraphQLUnionType
tbl1.GraphQLEnumType = type.GraphQLEnumType
tbl1.GraphQLInputObjectType = type.GraphQLInputObjectType
tbl1.GraphQLList = type.GraphQLList
tbl1.GraphQLNonNull = type.GraphQLNonNull

tbl1.specifiedScalarTypes = type.specifiedScalarTypes
tbl1.GraphQLInt = type.GraphQLInt
tbl1.GraphQLFloat = type.GraphQLFloat
tbl1.GraphQLString = type.GraphQLString
tbl1.GraphQLBoolean = type.GraphQLBoolean
tbl1.GraphQLID = type.GraphQLID

tbl1.specifiedDirectives = type.specifiedDirectives
tbl1.GraphQLIncludeDirective = type.GraphQLIncludeDirective
tbl1.GraphQLSkipDirective = type.GraphQLSkipDirective
tbl1.GraphQLDeprecatedDirective = type.GraphQLDeprecatedDirective
tbl1.GraphQLSpecifiedByDirective = type.GraphQLSpecifiedByDirective

tbl1.TypeKind = type.TypeKind

tbl1.DEFAULT_DEPRECATION_REASON = type.DEFAULT_DEPRECATION_REASON

tbl1.introspectionTypes = type.introspectionTypes
tbl1.__Schema = type.__Schema
tbl1.__Directive = type.__Directive
tbl1.__DirectiveLocation = type.__DirectiveLocation
tbl1.__Type = type.__Type
tbl1.__Field = type.__Field
tbl1.__InputValue = type.__InputValue
tbl1.__EnumValue = type.__EnumValue
tbl1.__TypeKind = type.__TypeKind

tbl1.SchemaMetaFieldDef = type.SchemaMetaFieldDef
tbl1.TypeMetaFieldDef = type.TypeMetaFieldDef
tbl1.TypeNameMetaFieldDef = type.TypeNameMetaFieldDef

tbl1.isSchema = type.isSchema
tbl1.isDirective = type.isDirective
tbl1.isType = type.isType
tbl1.isScalarType = type.isScalarType
tbl1.isObjectType = type.isObjectType
tbl1.isInterfaceType = type.isInterfaceType
tbl1.isUnionType = type.isUnionType
tbl1.isEnumType = type.isEnumType
tbl1.isInputObjectType = type.isInputObjectType
tbl1.isListType = type.isListType
tbl1.isNonNullType = type.isNonNullType
tbl1.isInputType = type.isInputType
tbl1.isOutputType = type.isOutputType
tbl1.isLeafType = type.isLeafType
tbl1.isCompositeType = type.isCompositeType
tbl1.isAbstractType = type.isAbstractType
tbl1.isWrappingType = type.isWrappingType
tbl1.isNullableType = type.isNullableType
tbl1.isNamedType = type.isNamedType
tbl1.isRequiredArgument = type.isRequiredArgument
tbl1.isRequiredInputField = type.isRequiredInputField
tbl1.isSpecifiedScalarType = type.isSpecifiedScalarType
tbl1.isIntrospectionType = type.isIntrospectionType
tbl1.isSpecifiedDirective = type.isSpecifiedDirective

tbl1.assertSchema = type.assertSchema
tbl1.assertDirective = type.assertDirective
tbl1.assertType = type.assertType
tbl1.assertScalarType = type.assertScalarType
tbl1.assertObjectType = type.assertObjectType
tbl1.assertInterfaceType = type.assertInterfaceType
tbl1.assertUnionType = type.assertUnionType
tbl1.assertEnumType = type.assertEnumType
tbl1.assertInputObjectType = type.assertInputObjectType
tbl1.assertListType = type.assertListType
tbl1.assertNonNullType = type.assertNonNullType
tbl1.assertInputType = type.assertInputType
tbl1.assertOutputType = type.assertOutputType
tbl1.assertLeafType = type.assertLeafType
tbl1.assertCompositeType = type.assertCompositeType
tbl1.assertAbstractType = type.assertAbstractType
tbl1.assertWrappingType = type.assertWrappingType
tbl1.assertNullableType = type.assertNullableType
tbl1.assertNamedType = type.assertNamedType

tbl1.getNullableType = type.getNullableType
tbl1.getNamedType = type.getNamedType

tbl1.validateSchema = type.validateSchema
tbl1.assertValidSchema = type.assertValidSchema

local language = require(script.language)

tbl1.Token = language.Token
tbl1.Source = language.Source
tbl1.Location = language.Location
tbl1.getLocation = language.getLocation

tbl1.printLocation = language.printLocation
tbl1.printSourceLocation = language.printSourceLocation

tbl1.Lexer = language.Lexer

tbl1.TokenKind = language.TokenKind

tbl1.parse = language.parse
tbl1.parseValue = language.parseValue
tbl1.parseType = language.parseType

tbl1.print = language.print

tbl1.visit = language.visit
tbl1.visitInParallel = language.visitInParallel
tbl1.getVisitFn = language.getVisitFn
tbl1.BREAK = language.BREAK
tbl1.REMOVE = language.REMOVE
tbl1.Kind = language.Kind
tbl1.DirectiveLocation = language.DirectiveLocation

tbl1.isDefinitionNode = language.isDefinitionNode
tbl1.isExecutableDefinitionNode = language.isExecutableDefinitionNode
tbl1.isSelectionNode = language.isSelectionNode
tbl1.isValueNode = language.isValueNode
tbl1.isTypeNode = language.isTypeNode
tbl1.isTypeSystemDefinitionNode = language.isTypeSystemDefinitionNode
tbl1.isTypeDefinitionNode = language.isTypeDefinitionNode
tbl1.isTypeSystemExtensionNode = language.isTypeSystemExtensionNode
tbl1.isTypeExtensionNode = language.isTypeExtensionNode

local execution = require(script.execution)

tbl1.execute = execution.execute
tbl1.executeSync = execution.executeSync
tbl1.defaultFieldResolver = execution.defaultFieldResolver
tbl1.defaultTypeResolver = execution.defaultTypeResolver
tbl1.responsePathAsArray = execution.responsePathAsArray
tbl1.getDirectiveValues = execution.getDirectiveValues

local subscription = require(script.subscription)
tbl1.subscribe = subscription.subscribe
tbl1.createSourceEventStream = subscription.createSourceEventStream

local validation = require(script.validation)

tbl1.validate = validation.validate
tbl1.ValidationContext = validation.ValidationContext

tbl1.specifiedRules = validation.specifiedRules

tbl1.ExecutableDefinitionsRule = validation.ExecutableDefinitionsRule
tbl1.FieldsOnCorrectTypeRule = validation.FieldsOnCorrectTypeRule
tbl1.FragmentsOnCompositeTypesRule = validation.FragmentsOnCompositeTypesRule
tbl1.KnownArgumentNamesRule = validation.KnownArgumentNamesRule
tbl1.KnownDirectivesRule = validation.KnownDirectivesRule
tbl1.KnownFragmentNamesRule = validation.KnownFragmentNamesRule
tbl1.KnownTypeNamesRule = validation.KnownTypeNamesRule
tbl1.LoneAnonymousOperationRule = validation.LoneAnonymousOperationRule
tbl1.NoFragmentCyclesRule = validation.NoFragmentCyclesRule
tbl1.NoUndefinedVariablesRule = validation.NoUndefinedVariablesRule
tbl1.NoUnusedFragmentsRule = validation.NoUnusedFragmentsRule
tbl1.NoUnusedVariablesRule = validation.NoUnusedVariablesRule
tbl1.OverlappingFieldsCanBeMergedRule = validation.OverlappingFieldsCanBeMergedRule
tbl1.PossibleFragmentSpreadsRule = validation.PossibleFragmentSpreadsRule
tbl1.ProvidedRequiredArgumentsRule = validation.ProvidedRequiredArgumentsRule
tbl1.ScalarLeafsRule = validation.ScalarLeafsRule
tbl1.SingleFieldSubscriptionsRule = validation.SingleFieldSubscriptionsRule
tbl1.UniqueArgumentNamesRule = validation.UniqueArgumentNamesRule
tbl1.UniqueDirectivesPerLocationRule = validation.UniqueDirectivesPerLocationRule
tbl1.UniqueFragmentNamesRule = validation.UniqueFragmentNamesRule
tbl1.UniqueInputFieldNamesRule = validation.UniqueInputFieldNamesRule
tbl1.UniqueOperationNamesRule = validation.UniqueOperationNamesRule
tbl1.UniqueVariableNamesRule = validation.UniqueVariableNamesRule
tbl1.ValuesOfCorrectTypeRule = validation.ValuesOfCorrectTypeRule
tbl1.VariablesAreInputTypesRule = validation.VariablesAreInputTypesRule
tbl1.VariablesInAllowedPositionRule = validation.VariablesInAllowedPositionRule

tbl1.LoneSchemaDefinitionRule = validation.LoneSchemaDefinitionRule
tbl1.UniqueOperationTypesRule = validation.UniqueOperationTypesRule
tbl1.UniqueTypeNamesRule = validation.UniqueTypeNamesRule
tbl1.UniqueEnumValueNamesRule = validation.UniqueEnumValueNamesRule
tbl1.UniqueFieldDefinitionNamesRule = validation.UniqueFieldDefinitionNamesRule
tbl1.UniqueDirectiveNamesRule = validation.UniqueDirectiveNamesRule
tbl1.PossibleTypeExtensionsRule = validation.PossibleTypeExtensionsRule

tbl1.NoDeprecatedCustomRule = validation.NoDeprecatedCustomRule
tbl1.NoSchemaIntrospectionCustomRule = validation.NoSchemaIntrospectionCustomRule

local error = require(script.error)
tbl1.GraphQLError = error.GraphQLError
tbl1.syntaxError = error.syntaxError
tbl1.locatedError = error.locatedError
tbl1.printError = error.printError
tbl1.formatError = error.formatError

local utilities = require(script.utilities)

tbl1.getIntrospectionQuery = utilities.getIntrospectionQuery

tbl1.getOperationAST = utilities.getOperationAST

tbl1.getOperationRootType = utilities.getOperationRootType

tbl1.introspectionFromSchema = utilities.introspectionFromSchema

tbl1.buildClientSchema = utilities.buildClientSchema

tbl1.buildASTSchema = utilities.buildASTSchema

tbl1.buildSchema = utilities.buildSchema
tbl1.parse = utilities.parse

tbl1.extendSchema = utilities.extendSchema

tbl1.lexicographicSortSchema = utilities.lexicographicSortSchema

tbl1.printSchema = utilities.printSchema

tbl1.printType = utilities.printType

tbl1.printIntrospectionSchema = utilities.printIntrospectionSchema

tbl1.typeFromAST = utilities.typeFromAST

tbl1.valueFromAST = utilities.valueFromAST

tbl1.valueFromASTUntyped = utilities.valueFromASTUntyped

tbl1.astFromValue = utilities.astFromValue

tbl1.TypeInfo = utilities.TypeInfo
tbl1.visitWithTypeInfo = utilities.visitWithTypeInfo

tbl1.coerceInputValue = utilities.coerceInputValue

tbl1.concatAST = utilities.concatAST

tbl1.separateOperations = utilities.separateOperations

tbl1.stripIgnoredCharacters = utilities.stripIgnoredCharacters

tbl1.isEqualType = utilities.isEqualType
tbl1.isTypeSubTypeOf = utilities.isTypeSubTypeOf
tbl1.doTypesOverlap = utilities.doTypesOverlap

tbl1.assertValidName = utilities.assertValidName

tbl1.isValidNameError = utilities.isValidNameError

tbl1.BreakingChangeType = utilities.BreakingChangeType
tbl1.DangerousChangeType = utilities.DangerousChangeType
tbl1.findBreakingChanges = utilities.findBreakingChanges
tbl1.findDangerousChanges = utilities.findDangerousChanges

tbl1.NULL = require(script.luaUtils.null)

tbl1.stringify = require(script.luaUtils.stringify)

return tbl1
