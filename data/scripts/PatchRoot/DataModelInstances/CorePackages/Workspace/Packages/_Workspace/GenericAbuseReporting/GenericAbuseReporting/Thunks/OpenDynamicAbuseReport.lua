-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local CentralOverlayType = require(GenericAbuseReportingParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(GenericAbuseReportingParent.CentralOverlay).Actions.SetCentralOverlay

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)

return function(arg1)
    return function(arg2)
        arg2:dispatch(SetCentralOverlay(CentralOverlayType.DynamicAbuseReport, arg1))
    end
end
