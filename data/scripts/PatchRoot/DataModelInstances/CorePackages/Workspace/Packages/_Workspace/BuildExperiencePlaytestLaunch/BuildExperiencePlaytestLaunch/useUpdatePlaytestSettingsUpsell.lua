-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunchParent = script:FindFirstAncestor("BuildExperiencePlaytestLaunch").Parent
local CentralOverlay = require(BuildExperiencePlaytestLaunchParent.CentralOverlay)
local Foundation = require(BuildExperiencePlaytestLaunchParent.Foundation)
local Localization = require(BuildExperiencePlaytestLaunchParent.Localization)
local Navigation = require(BuildExperiencePlaytestLaunchParent.Navigation)
local React = require(BuildExperiencePlaytestLaunchParent.React)
local RoactUtils = require(BuildExperiencePlaytestLaunchParent.RoactUtils)
local RobloxAppEnums = require(BuildExperiencePlaytestLaunchParent.RobloxAppEnums)
local UniversalAppPolicy = require(BuildExperiencePlaytestLaunchParent.UniversalAppPolicy)
local UrlBuilder = require(BuildExperiencePlaytestLaunchParent.UrlBuilder).UrlBuilder

local useAppPolicy = UniversalAppPolicy.useAppPolicy
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useNavigation = Navigation.useNavigation
local useLocalization = Localization.Hooks.useLocalization

local AppPage = RobloxAppEnums.AppPage
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay

local DialogSize = Foundation.Enums.DialogSize

local function useUpdatePlaytestSettingsUpsell()
    local var1 = useDispatch()
    local var2 = useNavigation()

    local var3 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local var4 = useLocalization({
        title = "Feature.Build.Action.Settings",
        body = "Feature.Build.Message.UpdateSettingsToPlaytest",
        updateSettings = "Feature.Build.Action.OpenSettings",
        cancel = "Feature.Build.Action.Cancel",
        ok = "CommonUI.Controls.Action.OK"
    })

    return (React.useCallback(function()
        local var5 = var1
        local var6 = SetCentralOverlay
        local confirmationDialog = CentralOverlayType.ConfirmationDialog
        local tbl1 = {
            title = var4.title,
            body = var4.body,
            confirmButtonText = var4.updateSettings,
            cancelButtonText = if var3 then var4.cancel else var4.ok,
            hideConfirmButton = not var3,
            size = DialogSize.Small,
            orientButtonsVertically = true,
            showCloseButton = false,
            onConfirm = 0,
            onCancel = 0
        }

        function tbl1.onConfirm()
            var1(CloseCentralOverlay())
            if var2 == nil then
                return
            end

            var2.push(
                AppPage.GenericWebPage,
                {
                    detail = UrlBuilder.static.settings.account(),
                    extraProps = {
                        title = var4.updateSettings
                    }
                }
            )
        end
        function tbl1.onCancel()
            var1(CloseCentralOverlay())
        end

        var5(var6(confirmationDialog, tbl1))
    end, {
        var1,
        var2,
        var3,
        var4.title,
        var4.body,
        var4.updateSettings,
        var4.cancel,
        var4.ok
    }))
end
return useUpdatePlaytestSettingsUpsell
