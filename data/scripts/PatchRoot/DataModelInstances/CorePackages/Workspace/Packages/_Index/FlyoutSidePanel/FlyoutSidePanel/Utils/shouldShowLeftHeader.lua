-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent

local AppPage = require(FlyoutSidePanelParent.RobloxAppEnums).AppPage
local NavigationRodux = require(FlyoutSidePanelParent.NavigationRodux)

local FFlagAppIaHomeSubTab = require(FlyoutSidePanelParent.SharedFlags).FFlagAppIaHomeSubTab

return function(arg1, arg2, arg3)
    local var1 = arg1 == AppPage.Home
        or arg1 == AppPage.Games
        or FFlagAppIaHomeSubTab and arg1 == NavigationRodux.Constants.HomeContainerName
    local bool1 = arg2 == AppPage.Home or arg2 == AppPage.Games

    if not (var1 or bool1) then
        return false
    end

    if not var1 or arg2 ~= arg1 then
        return true
    end

    local var2 = var1 and arg2 == AppPage.GameDetail
    return (bool1 or var2) and not arg3
end
