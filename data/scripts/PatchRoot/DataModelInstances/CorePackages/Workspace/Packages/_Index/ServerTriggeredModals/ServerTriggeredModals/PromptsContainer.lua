-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local SduiFeatureEntryPoint = require(ServerTriggeredModalsParent.SduiSharedUtilities).SduiFeatureEntryPoint

local Logger = require(ServerTriggeredModals.Logger)
local reportPromptImpression = require(ServerTriggeredModals.reportPromptImpression)
local sendModalImpressionEvent = require(ServerTriggeredModalsParent.ServerTriggeredModalImpressions).sendModalImpressionEvent

local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)
local FFlagEnableHomepagePromptsForModalsAndBanners = SharedFlags.FFlagEnableHomepagePromptsForModalsAndBanners
local FFlagPromptsHandlerEnabled = SharedFlags.FFlagPromptsHandlerEnabled
local FFlagPromptsActionEventLogging = require(ServerTriggeredModals.Flags.FFlagPromptsActionEventLogging)

return React.memo(function(tbl1) -- name: PromptsContainer
    local modalId = tbl1.modalId
    local modalType = tbl1.modalType

    React.useEffect(function()
        if modalId and modalType then
            reportPromptImpression(modalType, modalId):catch(function()
                Logger:warning("Failed to report prompt impression")
            end)
            sendModalImpressionEvent(modalId, modalType)
        end
    end, { modalId, modalType })

    return React.createElement(SduiFeatureEntryPoint, {
        configKey = tbl1.configKey,
        identifier = if FFlagEnableHomepagePromptsForModalsAndBanners or FFlagPromptsHandlerEnabled then tbl1.modalId else nil,
        appPage = tbl1.appPage,
        additionalAnalyticsData = FFlagPromptsActionEventLogging and {
            promptInstanceId = modalId or nil
        } or nil,
        shouldDisplayLoading = false,
        shouldDisplayError = false
    })
end)
