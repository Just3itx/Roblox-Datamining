-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local HttpService = game:GetService("HttpService")

local getCartId = HttpService:GenerateGUID(false)

return {
    getCartId = function()
        return getCartId
    end,
    refreshCartId = function()
        getCartId = HttpService:GenerateGUID(false)
    end
}
