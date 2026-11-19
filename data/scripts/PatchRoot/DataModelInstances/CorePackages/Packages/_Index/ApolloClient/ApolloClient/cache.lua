-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:11:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Object = require(scriptParentParent.LuauPolyfill).Object

local invariant = require(scriptParent.jsutils.invariant).invariant
local DEV = require(script.Parent.utilities).DEV
invariant(typeof(DEV) == "boolean", DEV)
tbl1.ApolloCache = require(script.core.cache).ApolloCache

local _Cache = require(script.core.types.Cache)

local _DataProxy = require(script.core.types.DataProxy)

tbl1.MissingFieldError = require(script.core.types.common).MissingFieldError

local storeUtils = require(script.Parent.utilities.graphql.storeUtils)

tbl1.isReference = storeUtils.isReference
tbl1.makeReference = storeUtils.makeReference

tbl1.EntityStore = require(script.inmemory.entityStore).EntityStore
tbl1.fieldNameFromStoreName = require(script.inmemory.helpers).fieldNameFromStoreName

tbl1.InMemoryCache = require(script.inmemory.inMemoryCache).InMemoryCache

local reactiveVars = require(script.inmemory.reactiveVars)

tbl1.makeVar = reactiveVars.makeVar
tbl1.cacheSlot = reactiveVars.cacheSlot

local policies = require(script.inmemory.policies)
tbl1.defaultDataIdFromObject = policies.defaultDataIdFromObject

tbl1.Policies = policies.Policies

tbl1.None = policies.None

tbl1.canonicalStringify = require(script.inmemory["object-canon"]).canonicalStringify

local types = require(script.inmemory.types)
Object.assign(tbl1, types)

return tbl1
