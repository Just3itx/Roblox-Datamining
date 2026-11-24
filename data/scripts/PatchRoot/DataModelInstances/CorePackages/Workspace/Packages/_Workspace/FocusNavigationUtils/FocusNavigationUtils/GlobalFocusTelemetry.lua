-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local config = {
    eventName = "GlobalAutoFocusFailureCounter",
    backends = { "RobloxTelemetryCounter" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 6, 17 },
    description = "Records the number of times we detect global autofocus failing. If focus is re-gained, this re-enables the app to increment the counter again."
}

local tbl1 = {
    eventName = "GlobalAutoFocusRecoveryCounter",
    backends = { "RobloxTelemetryCounter" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 6, 17 },
    description = "Records the number of times we detect global autofocus recovery. If focus is regained then and lost again, this re-enables the app to increment the counter again."
}

local config2 = {
    eventName = "GlobalAutoFocusFailureEvent",
    backends = { "Points" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 6, 17 },
    description = "Records data associated with global autofocus failing. If focus is re-gained, this re-enables the app to send another event."
}

return {
    sendAutoFocusFailureCounter = function(tbl2)
        local failureReason = if #tbl2 == 0 then "NoFocusTargets" else "FocusingTargetFailed"
        TelemetryService:LogCounter(config, { customFields = { FailureReason = failureReason } })
    end,
    sendAutoFocusRecoveryCounter = function()
        TelemetryService:LogCounter(tbl1)
        if RunService:IsStudio() then
            warn("[GlobalFocusTelemetry] Global autofocus recovered")
        end
    end,
    sendAutoFocusFailureEvent = function(arg1, tbl2, tbl3, tbl4, prevRoute: string?, currentRoute: string?, overlayType: string?)
        local customFields = {
            SelectedCoreObject = if GuiService.SelectedCoreObject then GuiService.SelectedCoreObject:GetFullName() else "nil",
            SelectedObject = if GuiService.SelectedObject then GuiService.SelectedObject:GetFullName() else "nil",
            FocusedGuiObject = if arg1 then arg1:GetFullName() else "nil",
            OverlayType = overlayType,
            PrevRoute = prevRoute,
            CurrentRoute = currentRoute
        }

        if tbl2 then
            for value, value2 in tbl2 do
                customFields["PrevFocusTarget" .. value] = if value2 then value2:GetFullName() else "nil"
            end
        end

        for value, value2 in tbl3 do
            customFields["FocusTarget" .. value] = if value2 then value2:GetFullName() else "nil"
        end

        if tbl4.moderationOverlay then
            customFields.FocusPriority = "ModerationOverlay"
        elseif tbl4.centralOverlay then
            customFields.FocusPriority = "CentralOverlay"
        elseif tbl4.contextualMenu then
            customFields.FocusPriority = "ContextualMenu"
        elseif tbl4.popUp then
            customFields.FocusPriority = "PopUp"
        elseif tbl4.peekView then
            customFields.FocusPriority = "PeekView"
        elseif tbl4.routerView then
            customFields.FocusPriority = "RouterView"
        elseif tbl4.subRouterView then
            customFields.FocusPriority = "SubRouterView"
        elseif tbl4.globalNavBar then
            customFields.FocusPriority = "GlobalNavBar"
        elseif tbl4.searchBar then
            customFields.FocusPriority = "SearchBar"
        elseif tbl4.auxiliaryView then
            customFields.FocusPriority = "AuxiliaryView"
        elseif tbl4.headerView then
            customFields.FocusPriority = "HeaderView"
        end

        for k, value in pairs(tbl4) do
            customFields["FocusSurface_" .. k:gsub("^%l", string.upper)] = if value then value:GetFullName() else "nil"
        end

        TelemetryService:LogEvent(
            config2,
            {
                customFields = customFields,
                standardizedFields = { "addSessionId", "addSessionInfo", "addOSInfo" }
            }
        )

        if RunService:IsStudio() then
            warn("[GlobalFocusTelemetry] Global Auto Focus Failed:", customFields)
        end
    end
}
