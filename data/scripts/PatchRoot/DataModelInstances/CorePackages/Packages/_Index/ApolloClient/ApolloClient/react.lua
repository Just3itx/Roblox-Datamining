-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:31:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Object = require(scriptParentParent.LuauPolyfill).Object

local invariant = require(scriptParent.jsutils.invariant).invariant
local DEV = require(scriptParent.utilities).DEV
invariant(typeof(DEV) == "boolean", tostring(DEV))

local context = require(script.context)
tbl1.ApolloProvider = context.ApolloProvider
tbl1.ApolloConsumer = context.ApolloConsumer
tbl1.getApolloContext = context.getApolloContext
tbl1.resetApolloContext = context.resetApolloContext

local hooks = require(script.hooks)
Object.assign(tbl1, hooks)

local parser = require(script.parser)

tbl1.DocumentType = parser.DocumentType
tbl1.operationName = parser.operationName
tbl1.parser = parser.parser

local types = require(script.types.types)
Object.assign(tbl1, types)

return tbl1
