-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local invariant = require(scriptParent.jsutils.invariant).invariant
local DEV = require(script.globals).DEV
invariant(typeof(DEV) == "boolean", tostring(DEV))
tbl1.DEV = DEV

local Object = require(scriptParentParent.LuauPolyfill).Object

tbl1.NULL = require(script.globals).NULL

local directives = require(script.graphql.directives)
tbl1.shouldInclude = directives.shouldInclude
tbl1.hasDirectives = directives.hasDirectives
tbl1.hasClientExports = directives.hasClientExports
tbl1.getDirectiveNames = directives.getDirectiveNames
tbl1.getInclusionDirectives = directives.getInclusionDirectives

local fragments = require(script.graphql.fragments)

tbl1.createFragmentMap = fragments.createFragmentMap
tbl1.getFragmentQueryDocument = fragments.getFragmentQueryDocument
tbl1.getFragmentFromSelection = fragments.getFragmentFromSelection

local getFromAST = require(script.graphql.getFromAST)
tbl1.checkDocument = getFromAST.checkDocument
tbl1.getOperationDefinition = getFromAST.getOperationDefinition
tbl1.getOperationName = getFromAST.getOperationName
tbl1.getFragmentDefinitions = getFromAST.getFragmentDefinitions
tbl1.getQueryDefinition = getFromAST.getQueryDefinition
tbl1.getFragmentDefinition = getFromAST.getFragmentDefinition
tbl1.getMainDefinition = getFromAST.getMainDefinition
tbl1.getDefaultValues = getFromAST.getDefaultValues

local storeUtils = require(script.graphql.storeUtils)

tbl1.makeReference = storeUtils.makeReference
tbl1.isDocumentNode = storeUtils.isDocumentNode
tbl1.isReference = storeUtils.isReference
tbl1.isField = storeUtils.isField
tbl1.isInlineFragment = storeUtils.isInlineFragment
tbl1.valueToObjectRepresentation = storeUtils.valueToObjectRepresentation
tbl1.storeKeyNameFromField = storeUtils.storeKeyNameFromField
tbl1.argumentsObjectFromField = storeUtils.argumentsObjectFromField
tbl1.resultKeyNameFromField = storeUtils.resultKeyNameFromField
tbl1.getStoreKeyName = storeUtils.getStoreKeyName
tbl1.getTypenameFromResult = storeUtils.getTypenameFromResult

local transform = require(script.graphql.transform)

tbl1.addTypenameToDocument = transform.addTypenameToDocument
tbl1.buildQueryFromSelectionSet = transform.buildQueryFromSelectionSet
tbl1.removeDirectivesFromDocument = transform.removeDirectivesFromDocument
tbl1.removeConnectionDirectiveFromDocument = transform.removeConnectionDirectiveFromDocument
tbl1.removeArgumentsFromDocument = transform.removeArgumentsFromDocument
tbl1.removeFragmentSpreadFromDocument = transform.removeFragmentSpreadFromDocument
tbl1.removeClientSetsFromDocument = transform.removeClientSetsFromDocument

local pagination = require(script.policies.pagination)
tbl1.concatPagination = pagination.concatPagination
tbl1.offsetLimitPagination = pagination.offsetLimitPagination
tbl1.relayStylePagination = pagination.relayStylePagination

tbl1.Observable = require(script.observables.Observable).Observable

Object.assign(tbl1, require(script.common.mergeDeep))
Object.assign(tbl1, require(script.common.cloneDeep))
Object.assign(tbl1, require(script.common.maybeDeepFreeze))
Object.assign(tbl1, require(script.common.stringifyForDisplay))
Object.assign(tbl1, require(script.observables.iteration))
Object.assign(tbl1, require(script.observables.asyncMap))
local Concast = require(script.observables.Concast)
Object.assign(tbl1, Concast)

Object.assign(tbl1, require(script.observables.subclassing))
Object.assign(tbl1, require(script.common.arrays))
Object.assign(tbl1, require(script.common.objects))
Object.assign(tbl1, require(script.common.errorHandling))
Object.assign(tbl1, require(script.common.canUse))
Object.assign(tbl1, require(script.common.compact))
Object.assign(tbl1, require(script.common.makeUniqueId))

return tbl1
