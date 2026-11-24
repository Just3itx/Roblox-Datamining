-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)
local UIBlox = require(GenericAbuseReportingParent.UIBlox)
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization
local useLocalizedStrings = require(GenericAbuseReporting.LocalizationKeys.useLocalizedStrings)
local MODAL_POSITION_OFFSET = require(GenericAbuseReporting.Common.MODAL_POSITION_OFFSET)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector

local function ReportCompleteDialog(tbl1)
    local var1 = tbl1.localizationKeys and useLocalization(tbl1.localizationKeys) or useLocalizedStrings()
    local var2 = useLayerCollector()
    local absoluteSize = var2.absoluteSize

    return React.createElement(InteractiveAlert, {
        screenSize = Vector2.new(absoluteSize.X, absoluteSize.Y - var2.insets.top),
        title = var1.completeTitle,
        bodyText = var1.completeDescription,
        anchorPoint = Vector2.new(0.5, 0),
        position = UDim2.new(0.5, 0, 0, var2.insets.top + MODAL_POSITION_OFFSET),
        buttonStackInfo = tbl1.buttonStackInfo
            or {
                buttons = {{
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = tbl1.onDismiss,
                        text = var1.completeClose
                    }
                }}
            },
        middleContent = tbl1.middleContent
    })
end

return ReportCompleteDialog
