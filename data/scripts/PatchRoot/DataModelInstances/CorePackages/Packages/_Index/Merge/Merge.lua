-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local Object = require(scriptParent.LuauPolyfill).Object
local tbl1 = {}

local mergeResolvers = require(script["merge-resolvers"])
Object.assign(tbl1, mergeResolvers)
local typedefsMergers = require(script["typedefs-mergers"])
Object.assign(tbl1, typedefsMergers)
local extensions = require(script.extensions)
Object.assign(tbl1, extensions)

return tbl1
