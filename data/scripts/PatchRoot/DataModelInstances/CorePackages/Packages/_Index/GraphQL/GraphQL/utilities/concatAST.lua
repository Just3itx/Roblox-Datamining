-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local _ast = require(script.Parent.Parent.language.ast)

function concatAST(arg1)
    local tbl1 = {}
    for _, value in ipairs(arg1) do
        tbl1 = Array.concat(tbl1, value.definitions)
    end
    return { kind = "Document", definitions = tbl1 }
end

return {
    concatAST = concatAST
}
