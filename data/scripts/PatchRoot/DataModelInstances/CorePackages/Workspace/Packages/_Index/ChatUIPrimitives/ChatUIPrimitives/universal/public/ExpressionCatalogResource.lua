-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Signals = require(ChatUIPrimitivesParent.Signals)
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)
local createExpressionCatalogResource = require(ChatUIPrimitives.createExpressionCatalogResource)

local function noop() end

return {
    create = function(func1: (...any) -> (...any))
        return createExpressionCatalogResource(func1)
    end,
    createStatic = function(arg1)
        return {
            getCatalog = Signals.createComputed(function(_)
                return arg1
            end),
            acquire = noop,
            release = noop
        }
    end
}
