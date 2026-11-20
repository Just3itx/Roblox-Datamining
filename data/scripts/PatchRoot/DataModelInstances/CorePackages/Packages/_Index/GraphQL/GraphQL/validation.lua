-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local script = script
local ValidationContext = require(script.ValidationContext)

return {
    validate = require(script.validate).validate,
    ValidationContext = ValidationContext.ValidationContext,
    specifiedRules = require(script.specifiedRules).specifiedRules,
    ExecutableDefinitionsRule = require(script.rules.ExecutableDefinitionsRule).ExecutableDefinitionsRule,
    FieldsOnCorrectTypeRule = require(script.rules.FieldsOnCorrectTypeRule).FieldsOnCorrectTypeRule,
    FragmentsOnCompositeTypesRule = require(script.rules.FragmentsOnCompositeTypesRule).FragmentsOnCompositeTypesRule,
    KnownArgumentNamesRule = require(script.rules.KnownArgumentNamesRule).KnownArgumentNamesRule,
    KnownDirectivesRule = require(script.rules.KnownDirectivesRule).KnownDirectivesRule,
    KnownFragmentNamesRule = require(script.rules.KnownFragmentNamesRule).KnownFragmentNamesRule,
    KnownTypeNamesRule = require(script.rules.KnownTypeNamesRule).KnownTypeNamesRule,
    LoneAnonymousOperationRule = require(script.rules.LoneAnonymousOperationRule).LoneAnonymousOperationRule,
    NoFragmentCyclesRule = require(script.rules.NoFragmentCyclesRule).NoFragmentCyclesRule,
    NoUndefinedVariablesRule = require(script.rules.NoUndefinedVariablesRule).NoUndefinedVariablesRule,
    NoUnusedFragmentsRule = require(script.rules.NoUnusedFragmentsRule).NoUnusedFragmentsRule,
    NoUnusedVariablesRule = require(script.rules.NoUnusedVariablesRule).NoUnusedVariablesRule,
    OverlappingFieldsCanBeMergedRule = require(script.rules.OverlappingFieldsCanBeMergedRule).OverlappingFieldsCanBeMergedRule,
    PossibleFragmentSpreadsRule = require(script.rules.PossibleFragmentSpreadsRule).PossibleFragmentSpreadsRule,
    ProvidedRequiredArgumentsRule = require(script.rules.ProvidedRequiredArgumentsRule).ProvidedRequiredArgumentsRule,
    ScalarLeafsRule = require(script.rules.ScalarLeafsRule).ScalarLeafsRule,
    SingleFieldSubscriptionsRule = require(script.rules.SingleFieldSubscriptionsRule).SingleFieldSubscriptionsRule,
    UniqueArgumentNamesRule = require(script.rules.UniqueArgumentNamesRule).UniqueArgumentNamesRule,
    UniqueDirectivesPerLocationRule = require(script.rules.UniqueDirectivesPerLocationRule).UniqueDirectivesPerLocationRule,
    UniqueFragmentNamesRule = require(script.rules.UniqueFragmentNamesRule).UniqueFragmentNamesRule,
    UniqueInputFieldNamesRule = require(script.rules.UniqueInputFieldNamesRule).UniqueInputFieldNamesRule,
    UniqueOperationNamesRule = require(script.rules.UniqueOperationNamesRule).UniqueOperationNamesRule,
    UniqueVariableNamesRule = require(script.rules.UniqueVariableNamesRule).UniqueVariableNamesRule,
    ValuesOfCorrectTypeRule = require(script.rules.ValuesOfCorrectTypeRule).ValuesOfCorrectTypeRule,
    VariablesAreInputTypesRule = require(script.rules.VariablesAreInputTypesRule).VariablesAreInputTypesRule,
    VariablesInAllowedPositionRule = require(script.rules.VariablesInAllowedPositionRule).VariablesInAllowedPositionRule,
    LoneSchemaDefinitionRule = require(script.rules.LoneSchemaDefinitionRule).LoneSchemaDefinitionRule,
    UniqueOperationTypesRule = require(script.rules.UniqueOperationTypesRule).UniqueOperationTypesRule,
    UniqueTypeNamesRule = require(script.rules.UniqueTypeNamesRule).UniqueTypeNamesRule,
    UniqueEnumValueNamesRule = require(script.rules.UniqueEnumValueNamesRule).UniqueEnumValueNamesRule,
    UniqueFieldDefinitionNamesRule = require(script.rules.UniqueFieldDefinitionNamesRule).UniqueFieldDefinitionNamesRule,
    UniqueDirectiveNamesRule = require(script.rules.UniqueDirectiveNamesRule).UniqueDirectiveNamesRule,
    PossibleTypeExtensionsRule = require(script.rules.PossibleTypeExtensionsRule).PossibleTypeExtensionsRule,
    NoDeprecatedCustomRule = require(script.rules.custom.NoDeprecatedCustomRule).NoDeprecatedCustomRule,
    NoSchemaIntrospectionCustomRule = require(script.rules.custom.NoSchemaIntrospectionCustomRule).NoSchemaIntrospectionCustomRule
}
