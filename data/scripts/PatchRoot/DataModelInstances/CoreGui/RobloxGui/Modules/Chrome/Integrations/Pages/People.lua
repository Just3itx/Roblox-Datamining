-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local InGameMenuIntegrationUtils = require(script.Parent.InGameMenuIntegrationUtils)

local isActivated = InGameMenuIntegrationUtils.createPageOpenSignal("PlayersPage")

return Service:register({
    initialAvailability = Service.AvailabilitySignal.Available,
    id = "people",
    label = "CoreScripts.InGameMenu.PageTitle.Players",
    sideSheetPlacement = SideSheetPlacement.AboveFold,
    activated = function(_)
        InGameMenuIntegrationUtils.toggleIGMPage("PlayersPage", isActivated:get())
    end,
    isActivated = isActivated,
    components = {
        Icon = function(_)
            return CommonIcon("icons/menu/friends", "icons/menu/friendsOn", isActivated)
        end
    }
})
