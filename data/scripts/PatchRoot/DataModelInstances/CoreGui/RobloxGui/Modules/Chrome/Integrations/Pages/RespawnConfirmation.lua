-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local InGameMenuIntegrationUtils = require(script.Parent.InGameMenuIntegrationUtils)

local Enums = require(CorePackages.Workspace.Packages.InExperienceSideSheet).Enums

local isActivated = InGameMenuIntegrationUtils.createPageOpenSignal("ResetCharacterPage")

return Service:register({
    initialAvailability = Service.AvailabilitySignal.Available,
    id = Enums.ActionBinding.Respawn,
    label = "CoreScripts.InGameMenu.QuickActions.Respawn",
    sideSheetPlacement = SideSheetPlacement.SessionAction,
    activated = function(_)
        InGameMenuIntegrationUtils.toggleIGMPage("ResetCharacterPage", isActivated:get())
    end,
    isActivated = isActivated,
    components = {
        Icon = function(_)
            return CommonIcon("icons/actions/respawn", nil, isActivated)
        end
    }
})
