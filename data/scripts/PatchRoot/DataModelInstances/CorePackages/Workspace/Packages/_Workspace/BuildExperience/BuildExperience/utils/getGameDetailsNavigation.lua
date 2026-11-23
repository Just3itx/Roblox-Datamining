-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local _Navigation = require(BuildExperienceParent.Navigation)

local function getGameDetailsNavigation(arg1)
    if typeof(arg1.clearAppScreens) == "function" then
        return arg1
    end

    local var1 = table.clone(arg1)
    function var1.clearAppScreens(routeNames)
        arg1.dispatch({ type = "ClearAppScreensAction", routeNames = routeNames })
    end

    return var1
end

return getGameDetailsNavigation
