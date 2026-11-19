-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:25Z
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

local PromptWithTextField = require(scriptParentParent.Prompts.PromptWithTextField)

local SignalCreateOutfitPermissionDenied = require(scriptParentParentParent.Thunks.SignalCreateOutfitPermissionDenied)
local PerformCreateOutfit = require(scriptParentParentParent.Thunks.PerformCreateOutfit)

local var1 = Roact.PureComponent:extend("EnterOutfitNamePrompt")

var1.validateProps = t.strictInterface(
    {
        screenSize = t.Vector2,
        signalCreateOutfitPermissionDenied = t.callback,
        performCreateOutfit = t.callback
    }
)
function var1.init(arg1)
    arg1:setState({ outfitName = "", alertPosition = UDim2.fromScale(0.5, 0.5) })

    arg1.textBoxRef = Roact.createRef()

    function arg1.confirmCreateOutfit()
        arg1.props.performCreateOutfit(arg1.state.outfitName)
    end

    function arg1.textUpdated(outfitName)
        arg1:setState({ outfitName = outfitName })
    end
end

function var1.render(arg1)
    return Roact.createElement(PromptWithTextField, {
        fieldText = arg1.state.outfitName,
        onFieldTextUpdated = arg1.textUpdated,
        title = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.EnterOutfitNamePromptTitle"),
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = arg1.props.signalCreateOutfitPermissionDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.EnterOutfitNamePromptNo")
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isDisabled = arg1.state.outfitName == "",
                        onActivated = arg1.confirmCreateOutfit,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.EnterOutfitNamePromptYes")
                    },
                    isDefaultChild = false
                }
            }
        }
    })
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        screenSize = arg1.screenSize
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        signalCreateOutfitPermissionDenied = function()
            return arg1(SignalCreateOutfitPermissionDenied)
        end,
        performCreateOutfit = function(arg2)
            return arg1(PerformCreateOutfit(arg2))
        end
    }
end)(var1)
