-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local TelemetryService = game:GetService("TelemetryService")

local Cryo = require(EditProfileParent.Cryo)
local Constants = require(EditProfile.Common.Constants)

local TelemetryEventType = {
    EditProfileOpened = "EditProfileOpened",
    DisplayNameModalOpened = "DisplayNameModalOpened",
    DisplayNameModalLoaded = "DisplayNameModalLoaded",
    DisplayNameSaved = "DisplayNameSaved",
    DisplayNameTooShort = "DisplayNameTooShort",
    FilteredDisplayName = "FilteredDisplayName",
    EditUsernameOpened = "EditUsernameOpened",
    UsernameSaved = "UsernameSaved",
    DescriptionPINBlocked = "DescriptionPINBlocked",
    OpenAvatarMarketplace = "OpenAvatarMarketplace"
}

local config = {
    eventName = "EditProfileEvent",
    description = "Event to track edit profile",
    lastUpdated = { 2025, 1, 20 },
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("EditProfileThrottleHundredthsPercent", 10000),
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/social/edit_profile/lua_edit_profile_button_events.proto"
}

local function sendAnalyticsEvent(tbl2, tbl3)
    local customFields = Cryo.Dictionary.join(tbl2 or {}, tbl3)

    TelemetryService:LogEvent(config, { customFields = customFields, standardizedFields = { "addSessionInfo" } })
end

return {
    TelemetryEventType = TelemetryEventType,
    sendEditProfileOpened = function()
        sendAnalyticsEvent({ page = "EditProfilePage" }, { sub_event_type = TelemetryEventType.EditProfileOpened })
    end,
    sendDisplayNameModalOpened = function()
        sendAnalyticsEvent({ btn = "openEditDisplayName" }, { sub_event_type = TelemetryEventType.DisplayNameModalOpened })
    end,
    sendDisplayNameModalLoaded = function(statValue: number?)
        sendAnalyticsEvent(
            { page = "EditDisplayNameModal", statValue = statValue },
            {
                sub_event_type = TelemetryEventType.DisplayNameModalLoaded,
                statValue = statValue
            }
        )
    end,
    sendDisplayNameSaved = function(displayName: string?, statValue: number?)
        sendAnalyticsEvent(
            { btn = "saveDisplayName", displayName = displayName, statValue = statValue },
            {
                sub_event_type = TelemetryEventType.DisplayNameSaved,
                displayName = displayName,
                statValue = statValue
            }
        )
    end,
    sendDisplayNameTooShort = function(displayName: string?)
        sendAnalyticsEvent(
            { displayName = displayName },
            {
                sub_event_type = TelemetryEventType.DisplayNameTooShort,
                displayName = displayName
            }
        )
    end,
    sendFilteredDisplayName = function(displayName: string?)
        sendAnalyticsEvent(
            { displayName = displayName },
            {
                sub_event_type = TelemetryEventType.FilteredDisplayName,
                displayName = displayName
            }
        )
    end,
    sendEditUsernameOpened = function()
        sendAnalyticsEvent({ btn = "openEditUsername" }, { sub_event_type = TelemetryEventType.EditUsernameOpened })
    end,
    sendUsernameSaved = function(statValue: number?)
        sendAnalyticsEvent(
            { statValue = statValue },
            {
                sub_event_type = TelemetryEventType.UsernameSaved,
                statValue = statValue
            }
        )
    end,
    sendOpenAvatarMarketplace = function()
        sendAnalyticsEvent({ btn = "openAvatarMarketplace" }, { sub_event_type = TelemetryEventType.OpenAvatarMarketplace })
    end,
    sendError = function(pinLocked: number)
        if pinLocked == Constants.DescriptionErrorCodes.PinLocked then
            sendAnalyticsEvent(nil, { sub_event_type = TelemetryEventType.DescriptionPINBlocked })
        end
    end
}
