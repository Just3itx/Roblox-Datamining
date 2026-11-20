-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createUnimplemented(str1: string)
    return function()
        error(`Calling unimplemented function {str1}`)
    end
end

return createUnimplemented
