-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local rules = script.Parent.rules

local ExecutableDefinitionsRule = require(rules.ExecutableDefinitionsRule).ExecutableDefinitionsRule
local UniqueOperationNamesRule = require(rules.UniqueOperationNamesRule).UniqueOperationNamesRule

local LoneAnonymousOperationRule = require(rules.LoneAnonymousOperationRule).LoneAnonymousOperationRule

local SingleFieldSubscriptionsRule = require(rules.SingleFieldSubscriptionsRule).SingleFieldSubscriptionsRule
local KnownTypeNamesRule = require(rules.KnownTypeNamesRule).KnownTypeNamesRule

local FragmentsOnCompositeTypesRule = require(rules.FragmentsOnCompositeTypesRule).FragmentsOnCompositeTypesRule

local VariablesAreInputTypesRule = require(rules.VariablesAreInputTypesRule).VariablesAreInputTypesRule
local ScalarLeafsRule = require(rules.ScalarLeafsRule).ScalarLeafsRule
local FieldsOnCorrectTypeRule = require(rules.FieldsOnCorrectTypeRule).FieldsOnCorrectTypeRule
local UniqueFragmentNamesRule = require(rules.UniqueFragmentNamesRule).UniqueFragmentNamesRule
local KnownFragmentNamesRule = require(rules.KnownFragmentNamesRule).KnownFragmentNamesRule
local NoUnusedFragmentsRule = require(rules.NoUnusedFragmentsRule).NoUnusedFragmentsRule

local PossibleFragmentSpreadsRule = require(rules.PossibleFragmentSpreadsRule).PossibleFragmentSpreadsRule
local NoFragmentCyclesRule = require(rules.NoFragmentCyclesRule).NoFragmentCyclesRule
local UniqueVariableNamesRule = require(rules.UniqueVariableNamesRule).UniqueVariableNamesRule
local NoUndefinedVariablesRule = require(rules.NoUndefinedVariablesRule).NoUndefinedVariablesRule
local NoUnusedVariablesRule = require(rules.NoUnusedVariablesRule).NoUnusedVariablesRule
local KnownDirectivesRule = require(rules.KnownDirectivesRule).KnownDirectivesRule

local UniqueDirectivesPerLocationRule = require(rules.UniqueDirectivesPerLocationRule).UniqueDirectivesPerLocationRule
local KnownArgumentNamesRule = require(rules.KnownArgumentNamesRule)
local KnownArgumentNamesRule2 = KnownArgumentNamesRule.KnownArgumentNamesRule

local KnownArgumentNamesOnDirectivesRule = KnownArgumentNamesRule.KnownArgumentNamesOnDirectivesRule
local UniqueArgumentNamesRule = require(rules.UniqueArgumentNamesRule).UniqueArgumentNamesRule
local ValuesOfCorrectTypeRule = require(rules.ValuesOfCorrectTypeRule).ValuesOfCorrectTypeRule
local ProvidedRequiredArgumentsRule = require(rules.ProvidedRequiredArgumentsRule)

local ProvidedRequiredArgumentsRule2 = ProvidedRequiredArgumentsRule.ProvidedRequiredArgumentsRule

local ProvidedRequiredArgumentsOnDirectivesRule = ProvidedRequiredArgumentsRule.ProvidedRequiredArgumentsOnDirectivesRule

local VariablesInAllowedPositionRule = require(rules.VariablesInAllowedPositionRule).VariablesInAllowedPositionRule

local OverlappingFieldsCanBeMergedRule = require(rules.OverlappingFieldsCanBeMergedRule).OverlappingFieldsCanBeMergedRule
local UniqueInputFieldNamesRule = require(rules.UniqueInputFieldNamesRule).UniqueInputFieldNamesRule
return {
    specifiedRules = {
        ExecutableDefinitionsRule,
        UniqueOperationNamesRule,
        LoneAnonymousOperationRule,
        SingleFieldSubscriptionsRule,
        KnownTypeNamesRule,
        FragmentsOnCompositeTypesRule,
        VariablesAreInputTypesRule,
        ScalarLeafsRule,
        FieldsOnCorrectTypeRule,
        UniqueFragmentNamesRule,
        KnownFragmentNamesRule,
        NoUnusedFragmentsRule,
        PossibleFragmentSpreadsRule,
        NoFragmentCyclesRule,
        UniqueVariableNamesRule,
        NoUndefinedVariablesRule,
        NoUnusedVariablesRule,
        KnownDirectivesRule,
        UniqueDirectivesPerLocationRule,
        KnownArgumentNamesRule2,
        UniqueArgumentNamesRule,
        ValuesOfCorrectTypeRule,
        ProvidedRequiredArgumentsRule2,
        VariablesInAllowedPositionRule,
        OverlappingFieldsCanBeMergedRule,
        UniqueInputFieldNamesRule
    },
    specifiedSDLRules = {
        require(rules.LoneSchemaDefinitionRule).LoneSchemaDefinitionRule,
        require(rules.UniqueOperationTypesRule).UniqueOperationTypesRule,
        require(rules.UniqueTypeNamesRule).UniqueTypeNamesRule,
        require(rules.UniqueEnumValueNamesRule).UniqueEnumValueNamesRule,
        require(rules.UniqueFieldDefinitionNamesRule).UniqueFieldDefinitionNamesRule,
        require(rules.UniqueDirectiveNamesRule).UniqueDirectiveNamesRule,
        KnownTypeNamesRule,
        KnownDirectivesRule,
        UniqueDirectivesPerLocationRule,
        require(rules.PossibleTypeExtensionsRule).PossibleTypeExtensionsRule,
        KnownArgumentNamesOnDirectivesRule,
        UniqueArgumentNamesRule,
        UniqueInputFieldNamesRule,
        ProvidedRequiredArgumentsOnDirectivesRule
    }
}
