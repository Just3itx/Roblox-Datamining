-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local module = {}
local buildASTSchema = require(scriptParentParent.GraphQL).buildASTSchema

local _types = require(script.Parent.types)

local getDocumentNodeFromSchema = require(script.Parent["print-schema-with-directives"]).getDocumentNodeFromSchema

local function buildFixedSchema(arg1, arg2)
    local documentNodeFromSchema = getDocumentNodeFromSchema(arg1)
    return buildASTSchema(documentNodeFromSchema, Object.assign({}, Boolean.toJSBoolean(arg2) and arg2 or {}))
end

function module.fixSchemaAst(arg1, arg2)
    local fixedSchema = if Boolean.toJSBoolean(arg1.astNode) and Boolean.toJSBoolean(arg1.extensionASTNodes) then nil else buildFixedSchema(arg1, arg2)

    if not Boolean.toJSBoolean(arg1.astNode) and fixedSchema and Boolean.toJSBoolean(fixedSchema.astNode) then
        arg1.astNode = fixedSchema.astNode
    end

    if not Boolean.toJSBoolean(arg1.extensionASTNodes) and fixedSchema and Boolean.toJSBoolean(fixedSchema.astNode) then
        arg1.extensionASTNodes = fixedSchema.extensionASTNodes
    end
    return arg1
end

return module
