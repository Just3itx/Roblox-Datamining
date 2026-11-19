-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:21Z
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

local PromptWithAvatarViewport = require(scriptParentParent.Prompts.PromptWithAvatarViewport)

local SignalCreateOutfitPermissionDenied = require(scriptParentParentParent.Thunks.SignalCreateOutfitPermissionDenied)
local CreateOutfitConfirmed = require(scriptParentParentParent.Actions.CreateOutfitConfirmed)
local PerformCreateOutfit = require(scriptParentParentParent.Thunks.PerformCreateOutfit)

local AvatarEditorPromptsPolicy = require(scriptParentParentParent.AvatarEditorPromptsPolicy)

local var1 = Roact.PureComponent:extend("CreateOutfitPrompt")

var1.validateProps = t.strictInterface({
    humanoidDescription = t.instanceOf("HumanoidDescription"),
    rigType = t.enum(Enum.HumanoidRigType),
    createOutfitConfirmed = t.callback,
    signalCreateOutfitPermissionDenied = t.callback,
    performCreateOutfit = t.callback,
    showCustomOutfitNames = t.boolean
})

function var1.render(arg1)
    local onActivated = if arg1.props.showCustomOutfitNames then arg1.props.createOutfitConfirmed else arg1.props.performCreateOutfit
    return Roact.createElement(PromptWithAvatarViewport, {
        humanoidDescription = arg1.props.humanoidDescription,
        rigType = arg1.props.rigType,
        title = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.CreateOutfitPromptTitle"),
        bodyText = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.CreateOutfitPromptText"),
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = arg1.props.signalCreateOutfitPermissionDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.CreateOutfitPromptNo")
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onActivated,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.CreateOutfitPromptYes")
                    },
                    isDefaultChild = false
                }
            }
        }
    })
end

local var2 = RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        humanoidDescription = arg1.promptInfo.humanoidDescription,
        rigType = arg1.promptInfo.rigType
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        signalCreateOutfitPermissionDenied = function()
            return arg1(SignalCreateOutfitPermissionDenied)
        end,
        createOutfitConfirmed = function()
            return arg1(CreateOutfitConfirmed())
        end,
        performCreateOutfit = function()
            return arg1(PerformCreateOutfit(""))
        end
    }
end)(var1)

return (AvatarEditorPromptsPolicy.connect(function(arg1, _)
    return {
        showCustomOutfitNames = arg1.getCustomOutfitNames()
    }
end)(var2))
