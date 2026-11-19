-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local AccountUpgrade = require(CorePackages.Workspace.Packages.AccountUpgrade)
local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local Service = require(Chrome.Service)
local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch
local React = require(CorePackages.Packages.React)

local Pioneer = AccountUpgrade.AccountUpgradeFlow.Pioneer
local var1 = nil

local function openAccountUpsell()
    if AccountUpgrade.InExperienceController.mount({
        flow = Pioneer,
        onComplete = function(arg1)
            if arg1.reason == "success" and var1 then
                var1.availability:unavailable()
            end
        end
    }) == "already_mounted" then
        AccountUpgrade.InExperienceController.unmount()
    end
end

local var2 = isPioneerLaunch()
    and {
        id = "AccountUpsell",
        label = "CoreScripts.InGameMenu.UnlockMore.Title",
        activated = function() end,
        sideSheetPlacement = Chrome2.Enums.SideSheetPlacement.ScrollableContentBottom,
        components = {
            Widget = function(arg1) -- name: AccountUpsellIntegration
                return React.createElement(
                    InExperienceSideSheet.AccountUpsell,
                    {
                        layoutOrder = arg1.layoutOrder,
                        placement = arg1.placement,
                        onActivated = openAccountUpsell
                    }
                )
            end
        }
    }
    or nil

if var2 then
    var2.initialAvailability = Service.AvailabilitySignal.Unavailable
    local var3 = Service:register(var2)
    var1 = var3

    task.spawn(function()
        if AccountUpgrade.Eligibility.getAvailability(Pioneer).granted then
            var3.availability:available()
        end
    end)
end

return var1 or {}
