-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage
local _NavigationRodux = require(GameDetailParent.NavigationRodux)
local SessionType = require(GameDetailParent.RobloxAppSessionization).SessionType
local hasPageInCurrentRoute = require(GameDetailParent.DiscoveryRouting).hasPageInCurrentRoute

local function removeGameDetailSessionIfDeparted(arg1, arg2)
    if not (arg1 and arg2) then
        return
    end
    if not (hasPageInCurrentRoute(arg2, AppPage.GameDetail, true) or hasPageInCurrentRoute(arg2, AppPage.ExperienceDetail, true)) then
        arg1:RemoveSession(SessionType.StructuralIdentifier.GameDetailSource)
    end
end

return removeGameDetailSessionIfDeparted
