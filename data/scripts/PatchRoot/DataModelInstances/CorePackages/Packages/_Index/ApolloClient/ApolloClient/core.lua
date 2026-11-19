-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:20:46Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Object = require(scriptParentParent.LuauPolyfill).Object

local DEV = require(scriptParent.utilities).DEV

local ApolloClient = require(script.ApolloClient)

tbl1.ApolloClient = ApolloClient.ApolloClient

tbl1.mergeOptions = ApolloClient.mergeOptions

local ObservableQuery = require(script.ObservableQuery)
tbl1.applyNextFetchPolicy = ObservableQuery.applyNextFetchPolicy
tbl1.ObservableQuery = ObservableQuery.ObservableQuery

local _watchQueryOptions = require(script.watchQueryOptions)

tbl1.NetworkStatus = require(script.networkStatus).NetworkStatus

local types = require(script.types)
Object.assign(tbl1, types)

local _LocalState = require(script.LocalState)

local errors = require(script.Parent.errors)
tbl1.isApolloError = errors.isApolloError
tbl1.ApolloError = errors.ApolloError

local cache = require(script.Parent.cache)
tbl1.ApolloCache = cache.ApolloCache
tbl1.defaultDataIdFromObject = cache.defaultDataIdFromObject
tbl1.InMemoryCache = cache.InMemoryCache
tbl1.MissingFieldError = cache.MissingFieldError
tbl1.makeVar = cache.makeVar

tbl1.None = cache.None

local types2 = require(script.Parent.cache.inmemory.types)
Object.assign(tbl1, types2)

local core = require(script.Parent.link.core)
Object.assign(tbl1, core)

local http = require(script.Parent.link.http)
Object.assign(tbl1, http)

local utils = require(script.Parent.link.utils)
tbl1.fromError = utils.fromError
tbl1.toPromise = utils.toPromise
tbl1.fromPromise = utils.fromPromise
tbl1.throwServerError = utils.throwServerError

local utilities = require(script.Parent.utilities)
tbl1.Observable = utilities.Observable

tbl1.isReference = utilities.isReference
tbl1.makeReference = utilities.makeReference
tbl1.NULL = utilities.NULL

local setVerbosity = require(scriptParent.jsutils.invariant).setVerbosity
tbl1.setLogVerbosity = setVerbosity

setVerbosity(if DEV then "log" else "silent")

local GraphQLTag = require(scriptParentParent.GraphQLTag)
tbl1.gql = GraphQLTag.default
tbl1.resetCaches = GraphQLTag.resetCaches
tbl1.disableFragmentWarnings = GraphQLTag.disableFragmentWarnings
tbl1.enableExperimentalFragmentVariables = GraphQLTag.enableExperimentalFragmentVariables
tbl1.disableExperimentalFragmentVariables = GraphQLTag.disableExperimentalFragmentVariables

return tbl1
