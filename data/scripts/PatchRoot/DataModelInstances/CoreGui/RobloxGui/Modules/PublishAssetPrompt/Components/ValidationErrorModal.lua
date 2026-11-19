-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local Overlay = UIBlox.App.Dialog.Overlay
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local iconsControlsKeysXboxA = UIBlox.App.ImageSet.Images["icons/controls/keys/xboxA"]
local RoactUtils = require(CorePackages.Workspace.Packages.RoactUtils)
local useIsGamepad = RoactUtils.Hooks.useIsGamepad
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local React = require(CorePackages.Packages.React)

local scriptParentParent = script.Parent.Parent
local CloseOpenPrompt = require(scriptParentParent.Actions.CloseOpenPrompt)

return function(tbl1)
    local var1 = useIsGamepad()

    local var2 = useDispatch()
    local function onActivated()
        var2(CloseOpenPrompt())
    end
    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 3
    }, {
        Overlay = React.createElement(Overlay, { showGradient = false, ZIndex = 3 }),
        InteractiveAlertWrapper = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 4
            },
            {
                InteractiveAlert = React.createElement(InteractiveAlert, {
                    title = "Something Went Wrong",
                    bodyText = "Your creation could not be created due to an error. A report has been sent to the developer of this experience.",
                    screenSize = tbl1.screenSize,
                    buttonStackInfo = {
                        buttons = {{
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                onActivated = onActivated,
                                text = RobloxTranslator:FormatByKey("InGame.CommonUI.Button.Ok"),
                                inputIcon = var1 and iconsControlsKeysXboxA or nil
                            }
                        }}
                    }
                })
            }
        )
    })
end
