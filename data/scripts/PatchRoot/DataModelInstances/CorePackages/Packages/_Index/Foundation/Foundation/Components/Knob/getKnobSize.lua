-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local function getKnobSize(arg1, arg2): UDim2
    local var1 = ({
        [InputSize.XSmall] = arg1.Size.Size_300,
        [InputSize.Small] = arg1.Size.Size_400,
        [InputSize.Medium] = arg1.Size.Size_500,
        [InputSize.Large] = arg1.Size.Size_600
    })[arg2]
    return UDim2.fromOffset(var1, var1)
end

return getKnobSize
