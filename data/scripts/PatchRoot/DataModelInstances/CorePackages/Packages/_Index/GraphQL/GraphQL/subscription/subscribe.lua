-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local _ast = require(scriptParentParent.language.ast)

local _execute = require(scriptParentParent.execution.execute)

local _schema = require(scriptParentParent.type.schema)

local _definition = require(scriptParentParent.type.definition)

return {
    subscribe = function(_)
        error("graphql-lua does not currently implement subscriptions")
    end,
    createSourceEventStream = function(_, _, _, _, _, _: string?, _)
        error("graphql-lua does not currently implement subscriptions")
    end
}
