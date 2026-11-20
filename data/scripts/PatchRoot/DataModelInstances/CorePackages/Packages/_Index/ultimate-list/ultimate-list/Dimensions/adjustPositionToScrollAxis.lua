-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local exhaustiveMatch = require(ultimateList.Util.exhaustiveMatch)

local function adjustPositionToScrollAxis(uDim2: UDim2, num1: number, str1: string)
    if str1 == "x" then
        return UDim2.new(0, uDim2.X.Offset - num1, uDim2.Y.Scale, uDim2.Y.Offset)
    elseif str1 == "y" then
        return UDim2.new(uDim2.X.Scale, uDim2.X.Offset, 0, uDim2.Y.Offset - num1)
    end
    return exhaustiveMatch(str1)
end

return adjustPositionToScrollAxis
