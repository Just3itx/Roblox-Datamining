-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local useScreenSize = require(Foundation.Components.Sheet.useScreenSize)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function useSurfaceWidth(num1: number, num2: number, num3: number?): (number, number)
    local var1 = useTokens()
    local num4 = math.min(num1, math.max(useScreenSize().X - var1.Size.Size_1200 - num2, 0))
    return num4, num4 + num2 + (num3 or 0)
end

return useSurfaceWidth
