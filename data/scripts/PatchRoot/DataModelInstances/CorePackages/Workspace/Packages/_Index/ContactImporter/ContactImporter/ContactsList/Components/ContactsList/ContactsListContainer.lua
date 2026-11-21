-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)

local Roact = dependencies.Roact
local RoactRodux = dependencies.RoactRodux
local _LocalTypes = require(scriptParentParentParentParent.Common.LocalTypes)
local Constants = require(scriptParentParentParentParent.Common.Constants)
local Promise = dependencies.Promise
local Analytics = require(scriptParentParentParentParent.Analytics)
local FieldNames = Analytics.FieldNames
local EventNames = Analytics.EventNames
local setupFireAnalyticsEvents = require(scriptParentParentParentParent.Analytics.setupFireAnalyticsEvents)

local formatContacts = require(scriptParentParentParentParent.Utils.formatContacts)
local ContactsProtocol = dependencies.ContactsProtocol
local Dash = dependencies.Dash

local EnumScreens = dependencies.SocialModalsCommon.EnumScreens
local AmpApiProvider = dependencies.AmpUpsell.AmpApiProvider
local AccessResponseEnum = dependencies.AmpUpsell.AmpEnums.AccessResponseEnum
local getFFlagFindFriendsClickedEventEnabled = require(scriptParentParentParentParent.Flags.getFFlagFindFriendsClickedEventEnabled)
local ContactsList = require(script.Parent.ContactsList)
local ContactsListMapDispatchToProps = require(script.Parent.ContactsListMapDispatchToProps)
local ContactsListMapStateToProps = require(script.Parent.ContactsListMapStateToProps)
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue
local UploadContactsSources = require(scriptParentParentParentParent.Analytics.Enums.UploadContactsSources)
local getFIntContactImporterUploadContactsMin = require(scriptParentParentParentParent.Flags.getFIntContactImporterUploadContactsMin)

local DiscoverabilityAnalytics = dependencies.DiscoverabilityAnalytics

local var1 = Roact.PureComponent:extend("ContactsListContainer")

var1.defaultProps = {
    contactsProtocol = ContactsProtocol.default
}

function var1.init(arg1)
    arg1.entryPoint = arg1.props.navigation.getParam("entryPoint")

    arg1.fireAnalyticsEvent = setupFireAnalyticsEvents({ analytics = Analytics.AnalyticsService, defaultAnalyticsInfo = { entry = arg1.entryPoint } })

    arg1.state = { hasUploadError = false, isFetching = true, showMatchedContacts = false }

    function arg1.getPropOrParam(arg2)
        if arg1.props.navigation and arg1.props.navigation.getParam(arg2) or arg1.props.navigation then
            return arg1.props.navigation.getParam(arg2)
        end
        return getDeepValue(arg1.props, arg2)
    end

    arg1.contactsCount = nil

    arg1.numTotalNumbersOnDevice = nil
    arg1.numTotalContactsOnDevice = nil
    arg1.numContactsWithMultipleNumbers = nil
    arg1.startTime = os.clock()
    arg1.ampApiProvider = if arg1.props.ampApiProvider ~= nil then arg1.props.ampApiProvider else AmpApiProvider

    local function makeErrorFunction(failedStep: string) -- Luacid: Inlined by compiler; 5 call sites recovered
        return function(arg2)
            if type(arg2) ~= "table" or not arg2.hasAlreadyErrored then
                arg1:setState({ hasUploadError = true, isFetching = false })

                arg1.fireAnalyticsEvent(failedStep, { failedStep = failedStep })

                arg1.fireContactImportingTimeEvent({ isSuccessfulUpload = false, failedStep = failedStep })
            end

            return Promise.reject({ hasAlreadyErrored = true })
        end
    end

    local function func1(arg2): number -- Luacid: Inlined by compiler; 1 call site recovered
        local deepValue = getDeepValue(arg2 or {}, "responseBody.userContactsEntities")

        return if deepValue then #deepValue else 0
    end

    local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
        if arg1.props.navigation then
            arg1.props.navigation.pop()
        elseif arg1.props.onClose then
            arg1.props.onClose()
        end
    end

    function arg1.requestFriendship(arg2)
        local props = arg1.props

        arg1.fireAnalyticsEvent(EventNames.RequestFriendship, { requestedId = arg2 })

        props.requestFriendship({ currentUserId = props.localUserId, contactId = arg2 }):andThen(function()
            props.requestSent(arg2)
        end)
    end

    function arg1.fireContactImportingTimeEvent(tbl1)
        arg1.fireAnalyticsEvent(EventNames.ContactImportingTime, {
            [FieldNames.NumTotalContactsImported] = arg1.contactsCount,
            [FieldNames.NumMatchedContacts] = tbl1.numMatchedContacts,
            [FieldNames.NumTotalContactsOnDevice] = arg1.numTotalContactsOnDevice,
            [FieldNames.NumMaxContacts] = true,
            [FieldNames.NumMinContacts] = true,
            [FieldNames.NumTotalNumbersOnDevice] = arg1.numTotalNumbersOnDevice,
            [FieldNames.NumContactsWithMultipleNumbers] = arg1.numContactsWithMultipleNumbers,
            loadingTime = os.clock() - arg1.startTime,
            isSuccessfulUpload = tbl1.isSuccessfulUpload
        })
    end

    function arg1.getContactsFromDevice()
        local props = arg1.props

        return props.contactsProtocol:supportsContacts():andThen(function(arg2)
            if not arg2 then
                return Promise.reject()
            end

            return props.contactsProtocol:getContacts()
        end):catch(function()
            return Promise.reject()
        end)
    end

    function arg1.formatContactsFromDevice(arg2)
        local props = arg1.props
        if #(arg2.contacts or {}) == 0 then
            return {
                contacts = {},
                contactsCount = 0,
                countryCode = nil
            }
        end

        props.deviceContactsReceived(arg2.contacts)

        local var2 = formatContacts(arg2)

        arg1.contactsCount = #var2.contacts
        arg1.numTotalContactsOnDevice = var2.contactsCount
        local num1 = 0
        local num2 = 0
        for _, contact in ipairs(arg2.contacts) do
            local phonenumberLen = #contact.phonenumber
            if phonenumberLen > 1 then
                num2 += 1
            end
            num1 += phonenumberLen
        end

        arg1.numTotalNumbersOnDevice = num1
        arg1.numContactsWithMultipleNumbers = num2

        return var2
    end

    function arg1.uploadDeviceContacts(arg2)
        arg2.source = UploadContactsSources.CI
        local props = arg1.props
        if #arg2.contacts == 0 or #arg2.contacts < getFIntContactImporterUploadContactsMin() then
            return Promise.resolve({ shouldFindContacts = false })
        end

        return props.uploadContacts(arg2):andThen(function()
            return Promise.resolve({ shouldFindContacts = true })
        end, function()
            arg1.fireAnalyticsEvent(
                EventNames.FailedUploadContactsFromDevice,
                {
                    failedStep = EventNames.FailedUploadContactsFromDevice
                }
            )
            arg1.fireContactImportingTimeEvent(
                {
                    isSuccessfulUpload = false,
                    failedStep = EventNames.FailedUploadContactsFromDevice
                }
            )
            return Promise.resolve({ shouldFindContacts = true })
        end)
    end

    function arg1.findContacts(arg2)
        local props = arg1.props
        if arg2.shouldFindContacts then
            return props.findContacts()
        end
        return Promise.resolve()
    end

    function arg1.getContactEntities(arg2)
        local props = arg1.props

        if arg2 then
            return props.getContactEntities(arg2)
        end
        return Promise.resolve()
    end

    function arg1.fireHasLoaded(arg2)
        local nummatchedContacts = func1(arg2)
        arg1.fireAnalyticsEvent(EventNames.ContactsListLoaded, {
            [FieldNames.NumTotalContactsImported] = arg1.contactsCount,
            [FieldNames.NumMatchedContacts] = nummatchedContacts,
            [FieldNames.NumMaxContacts] = true,
            [FieldNames.NumMinContacts] = true,
            [FieldNames.NumTotalContactsOnDevice] = arg1.numTotalContactsOnDevice
        })

        arg1:setState({ isFetching = false })

        arg1.fireContactImportingTimeEvent({ isSuccessfulUpload = true, nummatchedContacts = nummatchedContacts })

        return Promise.resolve()
    end

    function arg1.failedToUpload(_)
        arg1:setState({ hasUploadError = true, isFetching = false })

        arg1.fireContactImportingTimeEvent({ isSuccessfulUpload = false })
    end

    function arg1.getContacts()
        arg1:setState({ isFetching = true })

        local featureAccess = arg1.ampApiProvider.getFeatureAccess({ Constants.SHOW_MATCHED_CONTACTS })

        local showMatchedContacts = (if #featureAccess.featureAccessList > 0 then featureAccess.featureAccessList[1].access else AccessResponseEnum.Actionable) == AccessResponseEnum.Granted
        arg1:setState({ showMatchedContacts = showMatchedContacts })

        arg1.getContactsFromDevice():andThen(
            arg1.formatContactsFromDevice,
            (makeErrorFunction(EventNames.FailedGetContactsFromDevice))
        ):andThen(
            arg1.uploadDeviceContacts,
            (makeErrorFunction(EventNames.FailedFormatContactsFromDevice))
        ):andThen(
            arg1.findContacts,
            (makeErrorFunction(EventNames.FailedUploadContactsFromDevice))
        ):andThen(
            arg1.getContactEntities,
            (makeErrorFunction(EventNames.FailedFindContacts))
        ):andThen(
            arg1.fireHasLoaded,
            (makeErrorFunction(EventNames.FailedGetContactEntities))
        ):catch(
            arg1.failedToUpload
        )
    end
    function arg1.closeModal(arg2)
        local state = arg1.state

        arg1.fireAnalyticsEvent(
            arg2,
            {
                isLoading = arg1.state.isFetching,
                loadingTime = if state.isFetching then os.clock() - arg1.startTime else nil
            }
        )
        func2()
    end

    function arg1.onAddFriendsActivated()
        arg1.props.navigation.replace(EnumScreens.AddFriendsPage)
    end

    arg1.isFetching = nil

    function arg1.openDiscoverabilityModal()
        local navigation = arg1.props.navigation

        navigation.replace(EnumScreens.DiscoverabilityOverlay, {
            isStandaloneDiscoverabilityModal = true,
            entryPoint = DiscoverabilityAnalytics.EntryPoints.ContactsList,
            navigateOnActivated = function()
                navigation.replace(EnumScreens.ContactsList, {
                    [Constants.SHOULD_UPDATE_USER_SETTINGS] = true,
                    [Constants.IS_PHONE_VERIFIED] = arg1.getPropOrParam(Constants.IS_PHONE_VERIFIED),
                    openAmpUpsell = arg1.getPropOrParam(Constants.OPEN_AMP_UPSELL),
                    entryPoint = arg1.entryPoint
                })
            end
        })

        local propOrParam = arg1.getPropOrParam(Constants.OPEN_AMP_UPSELL)
        arg1.openAmpUpsell = propOrParam and function()
            local function func3(granted, _)
                if granted == AccessResponseEnum.Granted then
                    arg1.getContacts()
                    arg1.openDiscoverabilityModal()
                end
            end

            if getFFlagFindFriendsClickedEventEnabled() then
                arg1.fireAnalyticsEvent(EventNames.FindFriendsButtonClicked)
            end
            propOrParam(Constants.SHOW_MATCHED_CONTACTS, func3)
        end or Dash.noop
    end
end

function var1.didMount(arg1)
    arg1.getContacts()
end

function var1.render(arg1)
    local props = arg1.props
    local entryPoint = arg1.entryPoint

    return Roact.createElement(ContactsList, {
        deviceContacts = props.deviceContacts,
        matchedContacts = props.matchedContacts,
        isFetching = arg1.state.isFetching,
        requestFriendship = arg1.requestFriendship,
        screenSize = props.screenSize,
        hasUploadError = arg1.state.hasUploadError,
        onAddFriendsActivated = arg1.onAddFriendsActivated,
        closeModal = arg1.closeModal,
        showAddFriendsButton = entryPoint == Analytics.EntryPoints.HomePage,
        openProfilePeekView = arg1.props.openProfilePeekView,
        showMatchedContacts = arg1.state.showMatchedContacts,
        openAmpUpsell = arg1.openAmpUpsell
    })
end

return RoactRodux.connect(ContactsListMapStateToProps, ContactsListMapDispatchToProps)(var1)
