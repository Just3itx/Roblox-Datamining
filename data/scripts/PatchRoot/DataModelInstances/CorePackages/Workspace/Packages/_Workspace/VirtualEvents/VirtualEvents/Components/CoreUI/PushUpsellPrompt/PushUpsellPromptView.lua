-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent
local React = require(VirtualEventsParent.React)
local UIBlox = require(VirtualEventsParent.UIBlox)

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local function PushUpsellPromptView(tbl1)
    return React.createElement(InteractiveAlert, {
        title = tbl1.title,
        bodyText = tbl1.bodyText,
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = tbl1.screenSize,
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = tbl1.onCancel,
                        text = tbl1.cancelText
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = tbl1.onConfirm,
                        text = tbl1.confirmText
                    },
                    isDefaultChild = false
                }
            }
        }
    })
end

return PushUpsellPromptView
