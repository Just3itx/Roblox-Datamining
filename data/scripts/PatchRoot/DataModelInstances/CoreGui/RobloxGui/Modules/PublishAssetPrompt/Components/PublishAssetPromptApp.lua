-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)
local t = require(CorePackages.Packages.t)
local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection
local InputType = require(CorePackages.Workspace.Packages.InputType)
local getInputGroup = require(CorePackages.Workspace.Packages.InputType).getInputGroup

local scriptParent = script.Parent
local PromptType = require(scriptParent.Parent.PromptType)
local PublishAssetPromptSingleStep = require(scriptParent.PublishAssetPromptSingleStep)
local PublishAvatarPrompt = require(scriptParent.PublishAvatarPrompt.PublishAvatarPrompt)
local PublishAvatarAssetPrompt = require(scriptParent.PublishAvatarAssetPrompt.PublishAvatarAssetPrompt)
local PublishMakeupLookPrompt = require(scriptParent.PublishMakeupLookPrompt.PublishMakeupLookPrompt)
local ResultModal = require(scriptParent.ResultModal)

local SelectionCursorProvider = require(CorePackages.Packages.UIBlox).App.SelectionImage.SelectionCursorProvider
local ReactFocusNavigation = require(CorePackages.Packages.ReactFocusNavigation)

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local GetFFlagUploadMakeupSupport = require(scriptParent.Parent.Flags.GetFFlagUploadMakeupSupport)

local var1 = Roact.PureComponent:extend("PublishAssetPromptApp")

var1.validateProps = t.strictInterface({ assetType = t.optional(t.enum(Enum.AssetType)), assetInstance = t.optional(t.Instance) })

local function isGamepadInput(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return getInputGroup(arg1) == InputType.InputTypeConstants.Gamepad
end

function var1.init(arg1)
    arg1:setState({ screenSize = Vector2.new(0, 0) })

    function arg1.absoluteSizeChanged(arg2)
        if arg1.state.screenSize ~= arg2.AbsoluteSize then
            arg1:setState({ screenSize = arg2.AbsoluteSize })
        end
    end

    arg1.selectedCoreGuiObject = nil
    arg1.selectedGuiObject = nil
end

function var1.render(arg1)
    local element = nil

    if arg1.props.resultModalType then
        element = Roact.createElement(ResultModal, { screenSize = arg1.state.screenSize })
    elseif arg1.props.assetInstance then
        if arg1.props.promptType == PromptType.PublishAssetSingleStep then
            element = Roact.createElement(PublishAssetPromptSingleStep, { screenSize = arg1.state.screenSize })
        end
    elseif arg1.props.promptType == PromptType.PublishAvatar then
        element = Roact.createElement(PublishAvatarPrompt, { screenSize = arg1.state.screenSize })
    elseif arg1.props.promptType == PromptType.PublishAvatarAsset then
        element = Roact.createElement(PublishAvatarAssetPrompt, { screenSize = arg1.state.screenSize })
    elseif GetFFlagUploadMakeupSupport() and arg1.props.promptType == PromptType.PublishMakeupLook then
        element = Roact.createElement(PublishMakeupLookPrompt, { screenSize = arg1.state.screenSize })
    end

    if element == nil then
        return nil
    end

    local createElement = Roact.createElement
    local tbl1 = {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        AutoLocalize = false,
        DisplayOrder = -1,
        [Roact.Change.AbsoluteSize] = arg1.absoluteSizeChanged
    }

    return (createElement("ScreenGui", tbl1, {
        LastInputTypeConnection = Roact.createElement(ExternalEventConnection, {
            event = UserInputService.LastInputTypeChanged,
            callback = function(arg2)
                arg1:setState({ isGamepad = not not isGamepadInput(arg2) })
            end
        }),
        PromptFrame = Roact.createElement(
            RoactGamepad.Focusable.Frame,
            {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            },
            {
                CursorProvider = Roact.createElement(SelectionCursorProvider, {}, {
                    FocusNavigationProvider = Roact.createElement(
                        ReactFocusNavigation.FocusNavigationContext.Provider,
                        { value = focusNavigationService },
                        {
                            FocusNavigationRegistryProvider = Roact.createElement(Provider, nil, {
                                FocusNavigationCoreScriptsWrapper = Roact.createElement(
                                    FocusRoot,
                                    {
                                        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.RouterView,
                                        isIsolated = true,
                                        isAutoFocusRoot = true
                                    },
                                    { Prompt = element }
                                )
                            })
                        }
                    )
                })
            }
        )
    }))
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        resultModalType = arg1.promptRequest.resultModalType,
        promptType = arg1.promptRequest.promptInfo.promptType,
        assetInstance = arg1.promptRequest.promptInfo.assetInstance,
        assetType = arg1.promptRequest.promptInfo.assetType
    }
end)(var1)
