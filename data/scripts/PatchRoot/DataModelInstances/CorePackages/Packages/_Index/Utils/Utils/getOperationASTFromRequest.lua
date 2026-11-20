-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local tbl1 = {}
local getOperationAST = require(scriptParentParent.GraphQL).getOperationAST

local _Interfaces = require(script.Parent.Interfaces)

local memoize1 = require(script.Parent.memoize).memoize1

local function getOperationASTFromDocument(arg1, str1: string?)
    local operationAst = getOperationAST(arg1, str1)
    if not Boolean.toJSBoolean(operationAst) then
        local error = error
        local new = Error.new

        local str2 = Boolean.toJSBoolean(str1) and str1 or ""
        error(new(("Cannot infer operation %s"):format(tostring(str2))))
    end

    return operationAst
end

tbl1.getOperationASTFromDocument = getOperationASTFromDocument
tbl1.getOperationASTFromRequest = memoize1(function(arg1)
    return (getOperationASTFromDocument(arg1.document, arg1.operationName))
end)

return tbl1
