-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Tokens = require(Foundation.Providers.Style.Tokens)

local function migrateFontSize(num1: number, arg1)
    local size100 = arg1.Size.Size_100
    local size600 = arg1.Size.Size_600
    local size900 = arg1.Size.Size_900

    if size600 <= num1 and num1 <= size900 then
        num1 = size600
    end

    return math.round(num1 / size100) * size100
end

return migrateFontSize
