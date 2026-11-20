-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local InputLabelSize = require(Foundation.Enums.InputLabelSize)

local tbl1 = {
    [InputSize.Large] = InputLabelSize.Large,
    [InputSize.Medium] = InputLabelSize.Medium,
    [InputSize.Small] = InputLabelSize.Small,
    [InputSize.XSmall] = InputLabelSize.XSmall
}

local function getInputTextSize(arg1)
    return tbl1[arg1]
end

return getInputTextSize
