-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local invariant = require(scriptParentParent.jsutils.invariant).invariant
local DEV = require(scriptParentParent.utilities).DEV
invariant(typeof(DEV) == "boolean", tostring(DEV))

tbl1.empty = require(script.empty).empty
tbl1.from = require(script.from).from
tbl1.split = require(script.split).split
tbl1.concat = require(script.concat).concat
tbl1.execute = require(script.execute).execute

tbl1.ApolloLink = require(script.ApolloLink).ApolloLink

local types = require(script.types)
Object.assign(tbl1, types)

return tbl1
