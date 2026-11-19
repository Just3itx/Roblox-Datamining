-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch
local FFlagRenameHelpToControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagRenameHelpToControls

local InGameMenuIntegrationUtils = require(script.Parent.InGameMenuIntegrationUtils)

local isActivated = InGameMenuIntegrationUtils.createPageOpenSignal("HelpPage")

local tbl1 = {
    initialAvailability = Service.AvailabilitySignal.Available,
    id = "help",
    label = if FFlagRenameHelpToControls then "CoreScripts.InGameMenu.Controls.ControlsPage" else "CoreScripts.Feedback.Help.MainHeader",
    sideSheetPlacement = if isPioneerLaunch() then SideSheetPlacement.AboveFold else SideSheetPlacement.BelowFold,
    activated = 0,
    isActivated = 0,
    components = 0
}

function tbl1.activated(_)
    InGameMenuIntegrationUtils.toggleIGMPage("HelpPage", isActivated:get())
end
tbl1.isActivated = isActivated
tbl1.components = {
    Icon = function(_)
        return CommonIcon(if FFlagRenameHelpToControls then "Controller" else "CircleQuestion", nil, isActivated)
    end
}

return Service:register(tbl1)
