-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Navigation = require(scriptParentParentParent.Navigation)
local NavigationRodux = require(scriptParentParentParent.NavigationRodux)

local FFlagAppIaHomeSubTab = require(scriptParentParentParent.SharedFlags).FFlagAppIaHomeSubTab

local tbl1 = {
    [NavigationRodux.Constants.TempRnSwitchNavigatorName] = true
}
if FFlagAppIaHomeSubTab then
    tbl1[NavigationRodux.Constants.HomeContainerName] = true
end

return function(arg1)
    if not arg1 then
        return nil
    end

    while tbl1[arg1.routeName] and arg1.routes and arg1.index do
        arg1 = arg1.routes[arg1.index]
    end

    return arg1.routeName
end
