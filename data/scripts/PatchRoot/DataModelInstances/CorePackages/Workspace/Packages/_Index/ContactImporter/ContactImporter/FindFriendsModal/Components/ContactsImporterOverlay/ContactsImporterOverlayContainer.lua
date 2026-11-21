-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)
local _scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local TextKeys = require(scriptParentParentParentParent.Common.TextKeys)
local contactImporterModalInfoUpdater = require(scriptParentParentParentParent.Utils.contactImporterModalInfoUpdater)
local updateOptedInUsers = dependencies.SocialModalsCommon.Utils.updateOptedInUsers

local EnumScreens = dependencies.SocialModalsCommon.EnumScreens
local Constants = require(scriptParentParentParentParent.Common.Constants)
local Analytics = require(scriptParentParentParentParent.Analytics)

local Roact = dependencies.Roact
local RoactRodux = dependencies.RoactRodux
local PermissionsProtocol = dependencies.PermissionsProtocol
local Promise = dependencies.Promise

local ContactsImporterOverlay = require(script.Parent.ContactsImporterOverlay)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)
local Selectors = dependencies.RoduxContacts.Selectors
local AppStorageService = dependencies.AppStorageService
local DiscoverabilityAnalytics = dependencies.DiscoverabilityAnalytics

local var1 = Roact.PureComponent:extend("ContactsImporterOverlayContainer")

var1.defaultProps = {
    checkOrRequestPermissions = function(arg1)
        return PermissionsProtocol.default:checkOrRequestPermissions(arg1)
    end,
    localUserId = "",
    handleShowToastForTests = nil
}

function var1.init(arg1)
    arg1.isFromAddFriendsPage = arg1.props.navigation.getParam(Constants.IS_FROM_ADD_FRIENDS_PAGE, false)

    arg1.entryPoint = if arg1.isFromAddFriendsPage then DiscoverabilityAnalytics.EntryPoints.AddFriends else DiscoverabilityAnalytics.EntryPoints.HomePage

    arg1.fireAnalyticsEvent = Analytics.setupFireAnalyticsEvents(
        {
            analytics = Analytics.AnalyticsService,
            defaultAnalyticsInfo = {
                entry = arg1.entryPoint
            }
        }
    )
    local openAmpUpsell = arg1.props.navigation.getParam(Constants.OPEN_AMP_UPSELL)
    function arg1.checkOrRequestContactsPermissions()
        return arg1.props.checkOrRequestPermissions({ PermissionsProtocol.Permissions.CONTACTS_ACCESS })
    end

    function arg1.failedToUpload(_)
        arg1.props.showToast(TextKeys.CI_FAILED)
    end

    function arg1.closeModal()
        arg1.props.navigation.pop()
    end

    function arg1.permissionsFlowToContactImporter()
        local props = arg1.props
        local navigation = props.navigation
        local param2 = navigation.getParam(Constants.IS_FROM_SIGNUP)

        arg1.checkOrRequestContactsPermissions():andThen(function(arg2)
            if arg2 ~= PermissionsProtocol.Status.AUTHORIZED then
                if arg2 ~= PermissionsProtocol.Status.DENIED then
                    return Promise.reject()
                end

                navigation.replace(
                    EnumScreens.ContactsRevokedAccessDialog,
                    {
                        screenSize = props.screenSize,
                        closeModal = arg1.closeModal
                    }
                )
                return Promise.resolve()
            end

            updateOptedInUsers:addUserToLocalStorage(AppStorageService, props.localUserId)

            if param2 then
                props.updateUserSettings()
                props.navigation.pop()
            else
                props.hideContactImporterModal()
                navigation.replace(EnumScreens.ContactsList, {
                    [Constants.SHOULD_UPDATE_USER_SETTINGS] = true,
                    [Constants.IS_PHONE_VERIFIED] = navigation.getParam(Constants.IS_PHONE_VERIFIED),
                    [Constants.OPEN_LEARN_MORE_LINK] = navigation.getParam(Constants.OPEN_LEARN_MORE_LINK),
                    openAmpUpsell = openAmpUpsell,
                    entryPoint = arg1.entryPoint
                })
            end
            return Promise.resolve()
        end):catch(arg1.failedToUpload)
    end

    function arg1.checkDiscoverability(arg2)
        local param2 = arg1.props.navigation.getParam(Constants.IS_PHONE_VERIFIED)
        return arg2 and param2
    end

    function arg1.onConnectContacts()
        local param2 = arg1.props.navigation.getParam("isDiscoverabilityUnset")
        arg1.fireAnalyticsEvent(Analytics.EventNames.ContactImportModalContinue)

        if arg1.checkDiscoverability(param2) then
            arg1.navigateToDiscoverabilityModal()
            return
        end
        arg1.permissionsFlowToContactImporter()
    end

    function arg1.navigateToDiscoverabilityModal()
        local props = arg1.props
        local navigation = props.navigation

        props.getUserSettingsMetadata():andThen(function()
            navigation.replace(EnumScreens.DiscoverabilityOverlay, { entryPoint = arg1.entryPoint })
        end)
    end

    function arg1.onAddFriendsActivated()
        local props = arg1.props
        arg1.fireAnalyticsEvent(Analytics.EventNames.ContactImportModalAddFriends)

        props.navigation.replace(EnumScreens.AddFriendsPage)
    end

    function arg1.onCloseClicked()
        local props = arg1.props
        arg1.fireAnalyticsEvent(Analytics.EventNames.ContactImportModalClose)
        props.navigation.pop()
    end

    function arg1.onLearnMoreClick()
        arg1.props.openLearnMoreLink()
    end
end

function var1.didMount(arg1)
    arg1.fireAnalyticsEvent(Analytics.EventNames.ContactImportModalPageLoad)

    contactImporterModalInfoUpdater:addSeenCount(AppStorageService, arg1.props.localUserId)
    contactImporterModalInfoUpdater:updateTimestamp(
        AppStorageService,
        arg1.props.localUserId,
        DateTime.now().UnixTimestampMillis
    )
end

function var1.render(arg1)
    local props = arg1.props
    local navigation = props.navigation
    local isFromAddFriendsPage = navigation.getParam(Constants.IS_FROM_ADD_FRIENDS_PAGE, false)
    local param2 = arg1.props.navigation.getParam(Constants.IS_FROM_SIGNUP)
    local param3 = navigation.getParam(Constants.IS_FROM_SOCIAL_ONBOARDING_BUTTONS)

    return Roact.createElement(ContactsImporterOverlay, {
        screenSize = props.screenSize,
        onCloseClicked = arg1.onCloseClicked,
        onAddFriendsActivated = arg1.onAddFriendsActivated,
        onConnectContacts = arg1.onConnectContacts,
        onLearnMoreClick = arg1.onLearnMoreClick,
        isFromAddFriendsPage = isFromAddFriendsPage,
        isFromSignup = if param3 then true else param2
    })
end

return RoactRodux.connect(function(arg1)
    return {
        contacts = Selectors.sortContacts(arg1),
        localUserId = arg1.LocalUserId,
        screenSize = arg1.ScreenSize
    }
end, mapDispatchToProps)(var1)
