-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local NetworkingUserSettings = dependencies.NetworkingUserSettings
local UpdateContactImporterModalLogic = dependencies.SocialModalsCommon.Actions.UpdateContactImporterModalLogic

local AppPage = require(scriptParentParentParentParentParent.RobloxAppEnums).AppPage
local NavigateDown = require(scriptParentParentParentParentParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(scriptParentParentParentParentParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(scriptParentParentParentParentParent.RobloxAppNavigation).NavigationCommands else nil
local ToastRodux = require(scriptParentParentParentParentParent.ToastRodux)

return function(arg1)
    return {
        hideContactImporterModal = function()
            return arg1(UpdateContactImporterModalLogic({ hasOSPermissions = true, shouldShowContactImporterUpsellModal = false }))
        end,
        getUserSettingsMetadata = function()
            return arg1(NetworkingUserSettings.GetUserSettingsMetadata.API())
        end,
        openLearnMoreLink = function()
            local tbl1 = {
                name = AppPage.GenericWebPage,
                detail = "https://en.help.roblox.com/hc/articles/7416652004884",
                extraProps = { title = "" }
            }

            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                return
            end
            arg1(NavigateDown(tbl1, nil))
        end,
        showToast = function(toastMessage)
            arg1(ToastRodux.Actions.SetCurrentToastMessage({ toastMessage = toastMessage }))
        end
    }
end
