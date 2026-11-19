-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local scriptParentParentParent = script.Parent.Parent.Parent

local SetAllowInventoryReadAccess = require(scriptParentParentParent.Thunks.SetAllowInventoryReadAccess)

local var1 = Roact.PureComponent:extend("AllowInventoryReadAccessPrompt")

var1.validateProps = t.strictInterface({
    gameName = t.string,
    screenSize = t.Vector2,
    setAvatarReadAccessAllowed = t.callback,
    setAvatarReadAccessDenied = t.callback
})

function var1.render(arg1)
    return Roact.createElement(InteractiveAlert, {
        title = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.InventoryReadAccessPromptTitle"),
        bodyText = RobloxTranslator:FormatByKey(
            "CoreScripts.AvatarEditorPrompts.InventoryReadAccessPromptText",
            {
                RBX_NAME = arg1.props.gameName
            }
        ),
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = arg1.props.setAvatarReadAccessDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.InventoryReadAccessPromptNo")
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = arg1.props.setAvatarReadAccessAllowed,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.InventoryReadAccessPromptYes")
                    },
                    isDefaultChild = false
                }
            }
        },
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = arg1.props.screenSize
    })
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        gameName = arg1.gameName,
        screenSize = arg1.screenSize
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        setAvatarReadAccessDenied = function()
            return arg1(SetAllowInventoryReadAccess(false))
        end,
        setAvatarReadAccessAllowed = function()
            return arg1(SetAllowInventoryReadAccess(true))
        end
    }
end)(var1)
