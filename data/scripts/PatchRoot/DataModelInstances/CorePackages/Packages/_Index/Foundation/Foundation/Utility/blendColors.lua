-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local function blendColors(arg1, tbl1)
    local var1 = 1 - (tbl1.Transparency or 0)
    local var2 = 1 - (arg1.Transparency or 0)

    if var1 == 1 or var2 == 0 or arg1.Color3 == nil then
        return tbl1
    end

    if var1 == 0 then
        return arg1
    end

    local var3 = 1 - var1

    local var4 = var1 + var2 * var3

    local var5 = var4 > 0 and 1 / var4 or 0

    local red = (tbl1.Color3.R * var1 + arg1.Color3.R * (var2 * var3)) * var5

    local green = (tbl1.Color3.G * var1 + arg1.Color3.G * (var2 * var3)) * var5

    local blue = (tbl1.Color3.B * var1 + arg1.Color3.B * (var2 * var3)) * var5

    return {
        Color3 = Color3.new(red, green, blue),
        Transparency = 1 - var4
    }
end

return blendColors
