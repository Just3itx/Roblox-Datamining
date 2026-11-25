-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _scriptParentParent = script.Parent.Parent

return function(arg1, arg2)
    if arg2 then
        if arg1.PremiumPriceInRobux == nil then
            return arg1.PriceInRobux or 0
        end

        return arg1.PremiumPriceInRobux
    end

    return arg1.PriceInRobux or 0
end
