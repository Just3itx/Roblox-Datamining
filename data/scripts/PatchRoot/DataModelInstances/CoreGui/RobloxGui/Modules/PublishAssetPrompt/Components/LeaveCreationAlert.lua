-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local React = require(CorePackages.Packages.React)

local function LeaveCreationAlert(tbl1)
    return React.createElement(InteractiveAlert, {
        title = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.LeaveCreationTitle"),
        bodyText = RobloxTranslator:FormatByKey("CoreScripts.PublishCommon.UnsavedWarning"),
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = tbl1.closePrompt,
                        text = RobloxTranslator:FormatByKey("CoreScripts.PublishCommon.Leave")
                    },
                    isDefaultChild = false
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = tbl1.cancelClosePrompt,
                        text = RobloxTranslator:FormatByKey("CoreScripts.PublishCommon.Stay")
                    },
                    isDefaultChild = true
                }
            }
        },
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = tbl1.screenSize
    })
end

return LeaveCreationAlert
