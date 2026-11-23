-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")

local _NavigationTypes = require(AvatarWorkshop.Navigation.NavigationTypes)

local function getActiveRoute(arg1)
    return arg1.state.routes[arg1.state.index]
end

return getActiveRoute
