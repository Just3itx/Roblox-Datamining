-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local SduiSharedUtilities = require(ServerTriggeredModalsParent.SduiSharedUtilities)
local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)

local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint

local Logger = require(ServerTriggeredModals.Logger)
local reportPromptImpression = require(ServerTriggeredModals.reportPromptImpression)
local sendModalImpressionEvent = require(ServerTriggeredModalsParent.ServerTriggeredModalImpressions).sendModalImpressionEvent
local PromptStyle = require(ServerTriggeredModals.SduiV2.PromptStyle)
local usePromptEntries = require(ServerTriggeredModals.SduiV2.usePromptEntries)
local useModalSignalStore = require(ServerTriggeredModals.SignalStores.useModalSignalStore)
local FFlagPromptsActionEventLogging = require(ServerTriggeredModals.Flags.FFlagPromptsActionEventLogging)
local FFlagPromptsCoachmarkImpressionOnShow = SharedFlags.FFlagPromptsCoachmarkImpressionOnShow

return React.memo(function(tbl1) -- name: CoachmarkRenderer
    local surfaceConfig = tbl1.surfaceConfig
    local hasShownKey = tbl1.hasShownKey
    local var1 = useModalSignalStore()
    local var2, var3 = React.useState(false)

    React.useEffect(function()
        if not var2 and var1.tryClaimPrimaryHandler(hasShownKey) then
            var3(true)
        end
        return function()
            if var2 then
                var1.releasePrimaryHandler(hasShownKey)
            end
        end
    end, { var2, hasShownKey, var1 })

    local var4 = usePromptEntries(surfaceConfig.configKey, PromptStyle.Coachmark)

    if not FFlagPromptsCoachmarkImpressionOnShow then
        local var5 = React.useMemo(function(): string
            if not var2 then
                return ""
            end
            local tbl2 = {}
            for _, value in var4 do
                if value.identifier and value.title and value.config then
                    table.insert(tbl2, `{value.identifier}:{value.title}`)
                end
            end
            return table.concat(tbl2, "|")
        end, { var2, var4 })

        React.useEffect(function()
            if var5 == "" then
                return
            end
            for _, value in var4 do
                if value.identifier and value.title and value.config then
                    reportPromptImpression(value.title, value.identifier):catch(function()
                        Logger:warning("Failed to report coachmark prompt impression")
                    end)
                    sendModalImpressionEvent(value.identifier, value.title)
                end
            end
        end, { var5 })
    end

    if not var2 then
        return nil
    end

    local tbl2 = ({})
    for _, value in var4 do
        if value.config == nil or value.identifier == nil or value.title == nil then
            continue
        end

        local identifier = value.identifier
        local createElement = React.createElement
        local var5 = SduiFeatureEntryPoint

        local tbl3 = {
            configKey = surfaceConfig.configKey,
            identifier = value.identifier,
            appPage = surfaceConfig.appPage,
            additionalAnalyticsData = if FFlagPromptsActionEventLogging then {
                promptInstanceId = if value.identifier then value.identifier else nil
            } else nil,
            shouldDisplayLoading = false,
            shouldDisplayError = false,
            extraLocalProps = FFlagPromptsCoachmarkImpressionOnShow and {
                onShown = function()
                    reportPromptImpression(value.title, value.identifier):catch(function()
                        Logger:warning("Failed to report coachmark prompt impression")
                    end)
                    sendModalImpressionEvent(value.identifier, value.title)
                end
            } or nil
        }

        tbl2[identifier] = createElement(var5, tbl3)
    end

    return React.createElement(React.Fragment, nil, tbl2)
end)
