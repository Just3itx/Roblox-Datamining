-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:31Z
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
local SharedFlags = require(BuildExperiencePlaytestLaunchParent.SharedFlags)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useNavigation = Navigation.useNavigation
local useLocalization = Localization.Hooks.useLocalization

local AppPage = RobloxAppEnums.AppPage
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay

local DialogSize = Foundation.Enums.DialogSize

local FFlagLuaAppPlaytestTrustedFriendsRefetchPlayability = SharedFlags.FFlagLuaAppPlaytestTrustedFriendsRefetchPlayability

local function useTrustedFriendsPlaytestUpsell(userId: string?, onRequestAccepted: (...any) -> (...any))
    local var1 = useDispatch()
    local var2 = useNavigation()

    local var3 = useLocalization({
        title = "Feature.Friends.TrustedFriend.Label.AddTrustedFriend",
        body = "Feature.Build.Message.TrustedFriendsRequiredForPlaytest",
        add = "Feature.Friends.Action.Add",
        cancel = "Feature.Build.Action.Cancel",
        ok = "CommonUI.Controls.Action.OK"
    })
    local bool1 = not (var2 == nil) and userId ~= nil
    local useCallback = React.useCallback
    local function func1()
        local var4 = var1
        local var5 = SetCentralOverlay
        local confirmationDialog = CentralOverlayType.ConfirmationDialog
        local tbl1 = {
            title = var3.title,
            body = var3.body,
            confirmButtonText = var3.add,
            cancelButtonText = if bool1 then var3.cancel else var3.ok,
            hideConfirmButton = not bool1,
            showCloseButton = false,
            size = DialogSize.Small,
            orientButtonsVertically = true,
            onConfirm = 0,
            onCancel = 0
        }
        function tbl1.onConfirm()
            var1(CloseCentralOverlay())
            if not bool1 then
                return
            end

            var2.push(AppPage.TrustedContactsModal, {
                props = {
                    userId = userId,
                    onRequestAccepted = if FFlagLuaAppPlaytestTrustedFriendsRefetchPlayability then onRequestAccepted else nil
                }
            })
        end

        function tbl1.onCancel()
            var1(CloseCentralOverlay())
        end

        var4(var5(confirmationDialog, tbl1))
    end

    local var4 = if FFlagLuaAppPlaytestTrustedFriendsRefetchPlayability then onRequestAccepted else nil
    return (useCallback(func1, { var1, var2, userId, var4, bool1, var3.title, var3.body, var3.add, var3.cancel, var3.ok }))
end

return useTrustedFriendsPlaytestUpsell
