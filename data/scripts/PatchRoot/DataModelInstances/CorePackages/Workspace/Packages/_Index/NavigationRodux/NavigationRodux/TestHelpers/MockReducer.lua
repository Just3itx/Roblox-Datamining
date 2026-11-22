-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRoduxParent = script:FindFirstAncestor("NavigationRodux").Parent

local Cryo = require(NavigationRoduxParent.Cryo)

return function(arg1, arg2)
    arg1 = arg1 or {
        Navigation = { lockNavigationActions = nil }
    }

    if arg2.type ~= "ApplySetNavigationLocked" then
        return arg1
    end

    if arg1.Navigation.lockNavigationActions == arg2.locked then
        return arg1
    end

    return {
        Navigation = Cryo.Dictionary.join(arg1.Navigation, { lockNavigationActions = arg2.locked or false })
    }
end
