-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local Object = require(scriptParentParent.LuauPolyfill).Object
local tbl1 = {}

local arguments = require(script.arguments)
Object.assign(tbl1, arguments)
local directives = require(script.directives)
Object.assign(tbl1, directives)
local enumValues = require(script["enum-values"])
Object.assign(tbl1, enumValues)
local enum = require(script.enum)
Object.assign(tbl1, enum)
local fields = require(script.fields)
Object.assign(tbl1, fields)
local inputType = require(script["input-type"])
Object.assign(tbl1, inputType)
local interface = require(script.interface)
Object.assign(tbl1, interface)
local mergeNamedTypeArray = require(script["merge-named-type-array"])
Object.assign(tbl1, mergeNamedTypeArray)
local mergeNodes = require(script["merge-nodes"])
Object.assign(tbl1, mergeNodes)
local mergeTypedefs = require(script["merge-typedefs"])
Object.assign(tbl1, mergeTypedefs)
local scalar = require(script.scalar)
Object.assign(tbl1, scalar)
local type = require(script.type)
Object.assign(tbl1, type)
local union = require(script.union)
Object.assign(tbl1, union)
local utils = require(script.utils)
Object.assign(tbl1, utils)

return tbl1
