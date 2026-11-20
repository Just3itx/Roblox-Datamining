-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local standardizedFields = { "addOSInfo", "addSessionInfo", "addSessionId" }

local config = {
    eventName = "AdDisclosureMenuToggledCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 1, 13 },
    description = "\t\tCounts the number of times the ad disclosure menu is toggled. \n\t\tCustom field \"isOpened\" indicates whether the menu was opened (true) or closed (false).\n\t"
}

local config2 = {
    eventName = "AdDisclosureWhyThisAdToggledCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 1, 13 },
    description = "\t\tCounts the number of times the \"Why This Ad\" modal is toggled. \n\t\tCustom field \"isOpened\" indicates whether the modal was opened (true) or closed (false).\n\t"
}

local config3 = {
    eventName = "AdPreferencesLinkClickedCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 1, 13 },
    description = "\t\tCounts the number of times the ad preferences link is clicked.\n\t"
}

local module = {}

function module.logAdDisclosureMenuToggled(isOpened: boolean)
    TelemetryService:LogCounter(
        config,
        {
            standardizedFields = standardizedFields,
            customFields = { isOpened = isOpened }
        },
        1
    )
end

function module.logAdDisclosureWhyThisAdToggled(isOpened: boolean)
    TelemetryService:LogCounter(
        config2,
        {
            standardizedFields = standardizedFields,
            customFields = { isOpened = isOpened }
        },
        1
    )
end

function module.logAdPreferencesLinkClicked()
    TelemetryService:LogCounter(config3, { standardizedFields = standardizedFields, customFields = {} }, 1)
end

return module
