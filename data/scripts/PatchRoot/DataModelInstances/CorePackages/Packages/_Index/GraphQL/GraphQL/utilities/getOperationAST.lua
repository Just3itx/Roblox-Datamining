-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ast = require(script.Parent.Parent.language.ast)

local Kind = require(script.Parent.Parent.language.kinds).Kind

local module = {}

function module.getOperationAST(arg1, str1: string?)
    local var1 = nil
    for _, definition in pairs(arg1.definitions) do
        if definition.kind ~= Kind.OPERATION_DEFINITION then
            continue
        end

        if str1 == nil then
            if var1 then
                return nil
            end

            var1 = definition
        elseif definition.name and definition.name.value == str1 then
            return definition
        end
    end

    return var1
end

return module
