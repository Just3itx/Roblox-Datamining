-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")

local UIBlox = require(CorePackages.Packages.UIBlox)
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local iconsControlsKeysXboxA = UIBlox.App.ImageSet.Images["icons/controls/keys/xboxA"]

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local InputType = require(CorePackages.Workspace.Packages.InputType)
local getInputGroup = require(CorePackages.Workspace.Packages.InputType).getInputGroup

local scriptParentParent = script.Parent.Parent
local CloseResultModal = require(scriptParentParent.Thunks.CloseResultModal)
local var1 = if game:GetEngineFeature("EnableImagePublish") then Enum.PromptCreatePlatformContentResult else Enum.PromptPublishAssetResult
local var2 = Roact.PureComponent:extend("ResultModal")

var2.validateProps = t.strictInterface({ screenSize = t.Vector2, resultModalType = t.enum(var1), closeResultModal = t.callback })

local function isGamepadInput(lastInputType): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return getInputGroup(lastInputType) == InputType.InputTypeConstants.Gamepad
end

function var2.init(arg1)
    arg1:setState({ isGamepad = not not isGamepadInput((UserInputService:GetLastInputType())) })
end

function var2.getLocalizedStringForResultPrompt(_, arg1)
    if arg1 == var1.Success then
        return RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.PublishSuccessMessage")
    elseif arg1 == var1.UploadFailed then
        return RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.PublishFailed")
    elseif arg1 == var1.NoUserInput then
        return RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.NoUserInput")
    end

    return RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.UndefinedError", { RESULT_TYPE = tostring(arg1) })
end

function var2.getLocalizedTitleForResultPrompt(_, success)
    if success == var1.Success then
        return RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.PublishSuccessTitle")
    end
    return RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.PublishFailedTitle")
end

function var2.render(arg1)
    return Roact.createElement(InteractiveAlert, {
        title = arg1:getLocalizedTitleForResultPrompt(arg1.props.resultModalType),
        bodyText = arg1:getLocalizedStringForResultPrompt(arg1.props.resultModalType),
        screenSize = arg1.props.screenSize,
        buttonStackInfo = {
            buttons = {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = arg1.props.closeResultModal,
                    text = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.ResultModalOk"),
                    inputIcon = arg1.state.isGamepad and iconsControlsKeysXboxA or nil
                }
            }}
        }
    })
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        resultModalType = arg1.promptRequest.resultModalType
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        closeResultModal = function()
            return arg1(CloseResultModal)
        end
    }
end)(var2)
