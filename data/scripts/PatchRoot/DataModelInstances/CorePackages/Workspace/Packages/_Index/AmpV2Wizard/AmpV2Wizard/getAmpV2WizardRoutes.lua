-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local AppPage = require(AmpV2WizardParent.RobloxAppEnums).AppPage
local _Navigation = require(AmpV2WizardParent.Navigation)

local function getAmpV2WizardRoutes()
    local tbl1 = {
        [AppPage.AmpV2Wizard] = {
            getScreen = function()
                return require(AmpV2Wizard.AmpV2WizardRoute)
            end,
            navigationOptions = {
                overlayEnabled = true,
                transparent = true,
                absorbInput = true,
                renderUnderlyingPage = true,
                disableBackButton = true,
                bottomTabBarHidden = true,
                sideTabBarHidden = false
            }
        }
    }

    return { tbl1 }
end

return getAmpV2WizardRoutes
