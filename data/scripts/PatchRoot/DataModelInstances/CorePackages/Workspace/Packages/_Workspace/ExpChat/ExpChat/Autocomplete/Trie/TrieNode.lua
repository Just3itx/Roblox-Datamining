-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(str1: string)
    local result = {}
    setmetatable(result, module)
    result.children = {}
    result.isEndOfWord = false
    result.data = str1
    return result
end

return module
