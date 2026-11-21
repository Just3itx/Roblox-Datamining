-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local scriptParentParentParentParent = scriptParentParentParent.Parent

local EnumScreens = dependencies.SocialModalsCommon.EnumScreens
local TextKeys = require(scriptParentParentParent.Common.TextKeys)
local Constants = require(scriptParentParentParent.Common.Constants)
local Analytics = scriptParentParentParent.Analytics
local useAnalytics = require(Analytics.useAnalytics)
local EventNames = require(Analytics.Enums.EventNames)

local updateOptedInUsers = dependencies.SocialModalsCommon.Utils.updateOptedInUsers
local UpdateContactImporterModalLogic = dependencies.SocialModalsCommon.Actions.UpdateContactImporterModalLogic
local UpdateIsDiscoverabilityUnset = dependencies.SocialModalsCommon.Actions.UpdateIsDiscoverabilityUnset

local NetworkingUserSettings = dependencies.NetworkingUserSettings
local PermissionsProtocol = dependencies.PermissionsProtocol
local Promise = dependencies.Promise
local Dash = dependencies.Dash
local AppStorageService = dependencies.AppStorageService
local SocialLibraries = dependencies.SocialLibraries
local React = dependencies.React
local useSelector = dependencies.Hooks.useSelector
local useDispatch = dependencies.Hooks.useDispatch

local getDeepValue = SocialLibraries.Dictionary.getDeepValue

local DiscoverabilityOverlay = require(script.Parent.DiscoverabilityOverlay)

local AppPage = require(scriptParentParentParentParent.RobloxAppEnums).AppPage
local NavigateDown = require(scriptParentParentParentParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(scriptParentParentParentParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(scriptParentParentParentParent.RobloxAppNavigation).NavigationCommands else nil
local ToastRodux = require(scriptParentParentParentParent.ToastRodux)

local tbl1 = {
    checkOrRequestPermissions = function(arg1)
        return PermissionsProtocol.default:checkOrRequestPermissions(arg1)
    end
}

return function(tbl2)
    local var1 = Dash.join(tbl1, tbl2 or {})
    local function func1(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        if var1.navigation then
            return var1.navigation.getParam(arg1)
        end
        return getDeepValue(var1, arg1)
    end

    local var2 = func1(Constants.IS_STANDALONE_DISCOVERABILITY_MODAL)
    local var3 = useDispatch()
    local analytics = useAnalytics()
    local screenSize = useSelector(function(tbl3)
        return tbl3.ScreenSize
    end)
    local var6 = useSelector(function(tbl3)
        return tbl3.LocalUserId
    end)

    local var7 = React.useCallback(function()
        if var1.navigation then
            var1.navigation.pop()
        elseif var1.onClose then
            var1.onClose()
        end
    end, { var1 })

    local var8 = useSelector(function(tbl3)
        return getDeepValue(tbl3, "DiscoverabilityModal.UserPermissions.userSettingsMetadata")
    end)

    React.useEffect(function()
        local version = if var8.prefillDiscoverabilitySetting then Constants.NON_GDPR_VERSION_CHECKBOX else Constants.GDPR_VERSION
        analytics.fireAnalyticsEvent(
            EventNames.DiscoverabilityModalLoad,
            {
                version = version,
                wordingVersion = Constants.WORDING_VERSION_1
            }
        )
    end, {})

    local var9 = React.useCallback(function(toastMessage)
        var3(ToastRodux.Actions.SetCurrentToastMessage({ toastMessage = toastMessage }))
    end, { var3 })

    local function func2(_)
        var9(TextKeys.CI_FAILED)
    end

    local function func3() -- Luacid: Inlined by compiler; 1 call site recovered
        return var3(UpdateContactImporterModalLogic({ hasOSPermissions = true, shouldShowContactImporterUpsellModal = false }))
    end

    local function func4() -- Luacid: Inlined by compiler; 2 call sites recovered
        return var3(UpdateIsDiscoverabilityUnset({ isDiscoverabilityUnset = false }))
    end

    local function func5(phoneNumberDiscoverability: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        return var3(NetworkingUserSettings.UpdateUserSettings.API({ phoneNumberDiscoverability = phoneNumberDiscoverability }))
    end

    return React.createElement(DiscoverabilityOverlay, {
        screenSize = screenSize,
        onCloseClicked = function(selected: string)
            analytics.fireAnalyticsEvent(EventNames.DiscoverabilityModalClose, { selected = selected })

            var7()
        end,
        onLearnMoreClick = function()
            local tbl3 = {
                name = AppPage.GenericWebPage,
                detail = "https://en.help.roblox.com/hc/articles/7416652004884",
                extraProps = { title = "" }
            }

            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
                return
            end
            var3(NavigateDown(tbl3, nil))
        end,
        onActivated = function(selected: string)
            analytics.fireAnalyticsEvent(EventNames.DiscoverabilityModalContinue, { selected = selected })

            if var2 then
                func5(selected):andThen(function()
                    func4()
                    local var10 = func1(Constants.NAVIGATE_ON_ACTIVATED)
                    var7()
                    var10()
                    var9(TextKeys.SETTING_SAVED)
                end)

                return
            end

            var1.checkOrRequestPermissions({ PermissionsProtocol.Permissions.CONTACTS_ACCESS }):andThen(function(arg1)
                if arg1 == PermissionsProtocol.Status.AUTHORIZED then
                    updateOptedInUsers:addUserToLocalStorage(AppStorageService, var6)
                    func3()

                    func5(selected):andThen(function()
                        func4()
                        var1.navigation.replace(
                            EnumScreens.ContactsList,
                            {
                                [Constants.IS_PHONE_VERIFIED] = true,
                                entryPoint = var1.navigation.getParam("entryPoint")
                            }
                        )
                    end)

                    return
                end

                if arg1 ~= PermissionsProtocol.Status.DENIED then
                    return Promise.reject()
                end

                func5(selected):andThen(function()
                    var1.navigation.replace(EnumScreens.ContactsRevokedAccessDialog, {
                        screenSize = screenSize,
                        closeModal = function()
                            var1.navigation.pop()
                        end
                    })
                end)
            end):catch(func2)
        end,
        prefillDiscoverabilitySetting = var8.prefillDiscoverabilitySetting,
        analytics = analytics
    })
end
