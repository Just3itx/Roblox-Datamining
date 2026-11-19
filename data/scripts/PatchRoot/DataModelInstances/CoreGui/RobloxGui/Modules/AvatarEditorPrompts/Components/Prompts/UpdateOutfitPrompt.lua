-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local ButtonType = require(CorePackages.Packages.UIBlox).App.Button.Enum.ButtonType

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local SignalUpdateOutfitPermissionDenied = require(scriptParentParentParent.Thunks.SignalUpdateOutfitPermissionDenied)
local PerformUpdateOutfit = require(scriptParentParentParent.Thunks.PerformUpdateOutfit)

local PromptWithAvatarViewport = require(scriptParentParent.Prompts.PromptWithAvatarViewport)

local AvatarEditorPromptsPolicy = require(scriptParentParentParent.AvatarEditorPromptsPolicy)

local var1 = Roact.PureComponent:extend("UpdateOutfitPrompt")

var1.validateProps = t.strictInterface({
    screenSize = t.Vector2,
    humanoidDescription = t.instanceOf("HumanoidDescription"),
    rigType = t.enum(Enum.HumanoidRigType),
    outfitName = t.string,
    signalUpdateOutfitPermissionDenied = t.callback,
    performUpdateOutfit = t.callback,
    showCustomOutfitNames = t.boolean
})

function var1.render(arg1)
    local bodyText = if arg1.props.showCustomOutfitNames then RobloxTranslator:FormatByKey(
        "CoreScripts.AvatarEditorPrompts.UpdateOutfitPromptText",
        {
            RBX_NAME = arg1.props.outfitName
        }
    ) else RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.UpdateOutfitPromptTextNoOutfitName")
    return Roact.createElement(PromptWithAvatarViewport, {
        humanoidDescription = arg1.props.humanoidDescription,
        rigType = arg1.props.rigType,
        title = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.UpdateOutfitPromptTitle"),
        bodyText = bodyText,
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = arg1.props.signalUpdateOutfitPermissionDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.UpdateOutfitPromptNo")
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = arg1.props.performUpdateOutfit,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.UpdateOutfitPromptYes")
                    },
                    isDefaultChild = false
                }
            }
        }
    })
end

local var2 = RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        screenSize = arg1.screenSize,
        humanoidDescription = arg1.promptInfo.humanoidDescription,
        rigType = arg1.promptInfo.rigType,
        outfitName = arg1.promptInfo.outfitName
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        signalUpdateOutfitPermissionDenied = function()
            return arg1(SignalUpdateOutfitPermissionDenied)
        end,
        performUpdateOutfit = function()
            return arg1(PerformUpdateOutfit)
        end or nil
    }
end)(var1)

return (AvatarEditorPromptsPolicy.connect(function(arg1, _)
    return {
        showCustomOutfitNames = arg1.getCustomOutfitNames()
    }
end)(var2))
