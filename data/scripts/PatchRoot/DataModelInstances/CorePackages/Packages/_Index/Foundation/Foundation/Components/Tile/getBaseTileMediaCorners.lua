-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Tokens = require(Foundation.Providers.Style.Tokens)

local uDim = UDim.new(0, 0)

local function getBaseTileMediaCorners(arg1, bool1: boolean?)
    local uDim2 = UDim.new(0, arg1.Radius.Medium)
    local uDim3 = if bool1 then uDim else uDim2
    return {
        TopLeftRadius = uDim2,
        TopRightRadius = uDim2,
        BottomLeftRadius = uDim3,
        BottomRightRadius = uDim3
    }
end

return getBaseTileMediaCorners
