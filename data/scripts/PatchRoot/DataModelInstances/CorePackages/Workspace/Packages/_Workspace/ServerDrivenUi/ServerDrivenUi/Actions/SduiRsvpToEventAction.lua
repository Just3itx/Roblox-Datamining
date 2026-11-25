-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local DataHydration = require(ServerDrivenUiParent.DataHydration)
local Foundation = require(ServerDrivenUiParent.Foundation)
local SduiSharedUtilities = require(ServerDrivenUiParent.SduiSharedUtilities)
local VirtualEvents = require(ServerDrivenUiParent.VirtualEvents)

local CentralOverlayType = require(ServerDrivenUiParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Actions.SetCentralOverlay
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue
local getExperienceEventInfoStore = DataHydration.ExperienceEvents.getExperienceEventInfoStore
local getSduiPageEntrySnackbarStore = SduiSharedUtilities.getSduiPageEntrySnackbarStore

local function showRsvpSuccessToast(arg1, str1: string, eventName: string, eventTime: string)
    local title = arg1.dependencies.localization:Format("Feature.VirtualEvents.Label.ReminderSetForEventTime"):gsub(
        "{(.-)}",
        { eventName = eventName, eventTime = eventTime }
    )

    getSduiPageEntrySnackbarStore().show(str1, { title = title, icon = Foundation.Enums.IconName.CircleCheck })
end

return function(arg1, arg2, arg3, _)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "RsvpToEvent", message = "Missing actionParams" },
            arg3.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")

    local eventId = actionParams.eventId
    if eventId == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "RsvpToEvent", message = "Missing eventId", propName = "eventId" },
            arg3.appPage
        )
        return
    end

    local userRsvp = actionParams.userRsvp

    VirtualEvents.fireVirtualEventRSVP({
        virtualEventId = tostring(eventId),
        universeId = tostring(getActionTelemetryFieldValue(arg1, arg2, "universeId", "")),
        channel = tostring(getActionTelemetryFieldValue(arg1, arg2, "channel", "")),
        status = if userRsvp then "going" else "notGoing"
    })

    local experienceEventInfoStore = getExperienceEventInfoStore(false)
    local var1 = experienceEventInfoStore.patchRsvpStatus(eventId, userRsvp)

    if not var1 then
        return
    end

    local var2 = actionParams.entryPointKey or arg3.configKey

    var1:andThen(function(arg4)
        if userRsvp ~= true or not var2 then
            return
        end

        local var3 = arg4 and arg4.shouldSeeNotificationsUpsellModal == true

        local notificationsModalIdentifier = actionParams.notificationsModalIdentifier
        if var3 and notificationsModalIdentifier then
            arg3.dependencies.dispatch(
                SetCentralOverlay(
                    CentralOverlayType.SduiOverlay,
                    {
                        configKey = arg3.configKey,
                        identifier = notificationsModalIdentifier,
                        appPage = arg3.appPage
                    }
                )
            )
            return
        end

        local experienceEventInfo = experienceEventInfoStore.getExperienceEventInfo(eventId)
        local var4 = experienceEventInfo and experienceEventInfo.data and experienceEventInfo.data(false)
        if not var4 then
            return
        end
        local title = var4.title
        local derivedField = experienceEventInfoStore.calculateDerivedField("formattedStartDate", var4, false, arg3.dependencies.localization)

        if title and derivedField and var4.userRsvp then
            showRsvpSuccessToast(arg3, var2, title, derivedField)
        end
    end):catch(function()
        return nil
    end)
end
