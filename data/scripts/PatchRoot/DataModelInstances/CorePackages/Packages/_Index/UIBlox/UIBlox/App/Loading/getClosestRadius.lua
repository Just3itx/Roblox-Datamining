-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Radius = require(scriptParentParentParentParent.Foundation).Enums.Radius

local function getClosestRadius(arg1, uDim: UDim?)
    if not uDim or uDim == UDim.new(0, 0) then
        return Radius.None
    end

    if uDim.Scale >= 0.5 then
        return Radius.Circle
    end

    local var1 = nil
    local huge = math.huge

    for value, value2 in {
        [Radius.None] = 0,
        [Radius.XSmall] = 2,
        [Radius.Small] = arg1.Small,
        [Radius.Medium] = arg1.Medium,
        [Radius.Large] = arg1.XLarge,
        [Radius.Circle] = arg1.Circle
    } do
        local num1 = math.abs(uDim.Offset - value2)
        if num1 < huge then
            var1 = value
            huge = num1
        end
    end

    return var1
end

return getClosestRadius
