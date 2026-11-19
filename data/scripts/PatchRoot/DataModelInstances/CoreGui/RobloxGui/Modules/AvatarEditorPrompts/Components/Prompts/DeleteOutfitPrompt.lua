-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:23Z
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
local LoadableImage = UIBlox.App.Loading.LoadableImage

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local scriptParentParentParent = script.Parent.Parent.Parent

local SignalDeleteOutfitPermissionDenied = require(scriptParentParentParent.Thunks.SignalDeleteOutfitPermissionDenied)
local PerformDeleteOutfit = require(scriptParentParentParent.Thunks.PerformDeleteOutfit)

local AvatarEditorPromptsPolicy = require(scriptParentParentParent.AvatarEditorPromptsPolicy)

local var1 = Roact.PureComponent:extend("DeleteOutfitPrompt")

var1.validateProps = t.strictInterface({
    screenSize = t.Vector2,
    outfitId = t.integer,
    outfitName = t.string,
    performDeleteOutfit = t.callback,
    signalDeleteOutfitPermissionDenied = t.callback,
    showCustomOutfitNames = t.boolean
})

function var1.init(arg1)
    function arg1.renderAlertMiddleContent()
        local image = "rbxthumb://type=Outfit&id=" .. arg1.props.outfitId .. "&w=150&h=150"

        return Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 150)
        }, {
            Thumnail = Roact.createElement(LoadableImage, {
                Position = UDim2.fromScale(0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0),
                Size = UDim2.fromOffset(150, 150),
                BackgroundTransparency = 1,
                Image = image,
                useShimmerAnimationWhileLoading = true,
                showFailedStateWhenLoadingFailed = true
            })
        })
    end
end

function var1.render(arg1)
    local bodyText = if arg1.props.showCustomOutfitNames then RobloxTranslator:FormatByKey(
        "CoreScripts.AvatarEditorPrompts.DeleteOutfitPromptText",
        {
            RBX_NAME = arg1.props.outfitName
        }
    ) else RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.DeleteOutfitPromptTextNoName")
    return Roact.createElement(InteractiveAlert, {
        title = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.DeleteOutfitPromptTitle"),
        bodyText = bodyText,
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = arg1.props.signalDeleteOutfitPermissionDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.DeleteOutfitPromptNo")
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = arg1.props.performDeleteOutfit,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.DeleteOutfitPromptYes")
                    },
                    isDefaultChild = false
                }
            }
        },
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = arg1.props.screenSize,
        middleContent = arg1.renderAlertMiddleContent,
        isMiddleContentFocusable = false
    })
end

local var2 = RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        screenSize = arg1.screenSize,
        outfitId = arg1.promptInfo.outfitId,
        outfitName = arg1.promptInfo.outfitName
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        signalDeleteOutfitPermissionDenied = function()
            return arg1(SignalDeleteOutfitPermissionDenied)
        end,
        performDeleteOutfit = function()
            return arg1(PerformDeleteOutfit)
        end
    }
end)(var1)

return (AvatarEditorPromptsPolicy.connect(function(arg1, _)
    return {
        showCustomOutfitNames = arg1.getCustomOutfitNames()
    }
end)(var2))
