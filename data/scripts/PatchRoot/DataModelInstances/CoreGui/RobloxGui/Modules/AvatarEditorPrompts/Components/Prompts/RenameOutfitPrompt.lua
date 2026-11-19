-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local PromptWithTextField = require(scriptParentParent.Prompts.PromptWithTextField)

local SignalRenameOutfitPermissionDenied = require(scriptParentParentParent.Thunks.SignalRenameOutfitPermissionDenied)
local PerformRenameOutfit = require(scriptParentParentParent.Thunks.PerformRenameOutfit)

local AvatarEditorPromptsPolicy = require(scriptParentParentParent.AvatarEditorPromptsPolicy)

local var1 = Roact.PureComponent:extend("RenameOutfitNamePrompt")

var1.validateProps = t.strictInterface({
    outfitId = t.integer,
    outfitName = t.string,
    screenSize = t.Vector2,
    signalRenameOutfitPermissionDenied = t.callback,
    performRenameOutfit = t.callback,
    showCustomOutfitNames = t.boolean
})

function var1.init(arg1)
    arg1:setState({ outfitName = "", alertPosition = UDim2.fromScale(0.5, 0.5) })

    function arg1.textUpdated(outfitName)
        arg1:setState({ outfitName = outfitName })
    end

    function arg1.confirmRenameOutfit()
        arg1.props.performRenameOutfit(arg1.state.outfitName)
    end
end

function var1.render(arg1)
    if not arg1.props.showCustomOutfitNames then
        return Roact.createElement(InteractiveAlert, {
            title = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.DisabledRenameOutfitPromptTitle"),
            bodyText = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.DisabledRenameOutfitPromptText"),
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = arg1.props.signalRenameOutfitPermissionDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.DisabledRenameOutfitPromptOkay")
                    },
                    isDefaultChild = true
                }}
            },
            position = UDim2.fromScale(0.5, 0.5),
            screenSize = arg1.props.screenSize,
            isMiddleContentFocusable = false
        })
    end

    return Roact.createElement(PromptWithTextField, {
        fieldText = arg1.state.outfitName,
        onFieldTextUpdated = arg1.textUpdated,
        title = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.RenameOutfitNamePromptTitle"),
        bodyText = RobloxTranslator:FormatByKey(
            "CoreScripts.AvatarEditorPrompts.RenameOutfitPromptText",
            {
                RBX_NAME = arg1.props.outfitName
            }
        ),
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = arg1.props.signalRenameOutfitPermissionDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.EnterOutfitNamePromptNo")
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isDisabled = arg1.state.outfitName == "",
                        onActivated = arg1.confirmRenameOutfit,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.EnterOutfitNamePromptYes")
                    },
                    isDefaultChild = false
                }
            }
        }
    })
end

local var2 = RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        outfitId = arg1.promptInfo.outfitId,
        outfitName = arg1.promptInfo.outfitName,
        screenSize = arg1.screenSize
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        signalRenameOutfitPermissionDenied = function()
            return arg1(SignalRenameOutfitPermissionDenied)
        end,
        performRenameOutfit = function(arg2)
            return arg1(PerformRenameOutfit(arg2))
        end
    }
end)(var1)

return (AvatarEditorPromptsPolicy.connect(function(arg1, _)
    return {
        showCustomOutfitNames = arg1.getCustomOutfitNames()
    }
end)(var2))
