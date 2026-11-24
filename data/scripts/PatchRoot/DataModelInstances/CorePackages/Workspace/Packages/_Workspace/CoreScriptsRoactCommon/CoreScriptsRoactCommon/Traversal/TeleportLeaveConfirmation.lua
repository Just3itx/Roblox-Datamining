-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local Foundation = require(CoreScriptsRoactCommonParent.Foundation)
local Localization = require(CoreScriptsRoactCommonParent.Localization)
local React = require(CoreScriptsRoactCommonParent.React)

local TeleportBack = require(script.Parent.TeleportBack)
local TraversalTelemetry = require(script.Parent.TraversalTelemetry)

local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local EnumsOrientation = Foundation.Enums.Orientation
local useLocalization = Localization.Hooks.useLocalization

return React.memo(React.forwardRef(function(tbl1, ref) -- name: TeleportLeaveConfirmation
    local var1 = useLocalization({
        leaveHeader = "CoreScripts.InGameMenu.Traversal.LeaveHeader",
        leaveBody = {
            "CoreScripts.InGameMenu.Traversal.LeaveBody",
            PREVIOUS_EXPERIENCE = tbl1.teleportName
        },
        leaveContinueAction = "CoreScripts.InGameMenu.Actions.Continue",
        leaveCancelAction = "CoreScripts.InGameMenu.Cancel"
    })

    local onActivated = React.useCallback(function()
        TraversalTelemetry.sendTeleportConfirmationActions({ source = tbl1.source, event_type = "confirm" })

        TeleportBack(tbl1.placeId)
    end, { TeleportBack, tbl1.placeId })

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small,
        onClose = function(arg1)
            TraversalTelemetry.sendTeleportConfirmationActions({ source = tbl1.source, event_type = "cancel" })

            if tbl1.onClose then
                tbl1.onClose(arg1)
            end
        end,
        hasBackdrop = tbl1.hasBackdrop == nil or tbl1.hasBackdrop,
        ref = ref
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.leaveHeader, testId = "--foundation-dialog--title" }),
        DialogContent = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                DialogText = React.createElement(Dialog.Text, { Text = var1.leaveBody })
            }
        ),
        DialogActions = React.createElement(Dialog.Actions, {
            orientation = EnumsOrientation.Vertical,
            LayoutOrder = 3,
            actions = {
                {
                    text = var1.leaveContinueAction,
                    variant = ButtonVariant.Emphasis,
                    onActivated = onActivated,
                    testId = "--teleport-leave-continue"
                },
                {
                    text = var1.leaveCancelAction,
                    variant = ButtonVariant.Standard,
                    onActivated = function()
                        TraversalTelemetry.sendTeleportConfirmationActions({ source = tbl1.source, event_type = "cancel" })

                        tbl1.onCancel()
                    end,
                    testId = "--teleport-leave-cancel"
                }
            }
        })
    })
end))
