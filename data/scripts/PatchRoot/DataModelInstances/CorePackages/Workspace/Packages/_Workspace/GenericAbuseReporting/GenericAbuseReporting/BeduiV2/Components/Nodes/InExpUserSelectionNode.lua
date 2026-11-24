-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local SignalsReact = require(GenericAbuseReportingParent.SignalsReact)

local View = Foundation.View

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local ListNodeV2 = require(GenericAbuseReporting.BeduiV2.Components.Nodes.ListNodeV2)
local RecentlyLeftBadge = require(GenericAbuseReporting.BeduiV2.Components.Shared.RecentlyLeftBadge)
local recentlyLeftSignals = require(GenericAbuseReporting.BeduiV2.Utils.Signals.recentlyLeftSignals)
local VoiceSpeakingIcon = require(GenericAbuseReporting.BeduiV2.Components.Shared.VoiceSpeakingIcon)
local voiceSpeakingSignals = require(GenericAbuseReporting.BeduiV2.Utils.Signals.voiceSpeakingSignals)

return React.memo(function(arg1) -- name: InExpUserSelectionNode
    local trailingAccessories = arg1.trailingAccessories
    local var1 = Dash.join(arg1, { trailingAccessories = Dash.None })

    local var2 = voiceSpeakingSignals.useVoiceSpeakingStore()

    local var3 = SignalsReact.useSignalState(recentlyLeftSignals.getRecentlyLeftIds())

    local renderTrailingAccessory = React.useCallback(function(arg2)
        if not trailingAccessories or #trailingAccessories == 0 then
            return nil
        end
        local tbl1 = {}

        for layoutOrder, value2 in trailingAccessories do
            if value2.type == "voiceSpeakingIndicator" then
                table.insert(
                    tbl1,
                    React.createElement(VoiceSpeakingIcon, { isSpeakingSignal = var2.getIsSpeaking(arg2.id), layoutOrder = layoutOrder })
                )
            elseif value2.type == "recentlyLeftIndicator" and var3[arg2.id] then
                table.insert(tbl1, React.createElement(RecentlyLeftBadge, { text = value2.text, layoutOrder = layoutOrder }))
            end
        end

        if next(tbl1) == nil then
            return nil
        end
        return React.createElement(View, { tag = "row align-y-center gap-small auto-xy" }, tbl1)
    end, { trailingAccessories, var2, var3 })

    return React.createElement(ListNodeV2, Dash.join(var1, { renderTrailingAccessory = renderTrailingAccessory }))
end)
