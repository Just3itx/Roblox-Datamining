-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UIBlox = require(CorePackages.Packages.UIBlox)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")

local scriptParentParent = script.Parent.Parent
local ThemedTextLabel = require(scriptParentParent.Components.PortedComponents.ThemedTextLabel)
local ModalDialog = require(scriptParentParent.Components.ModalDialog)
local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local ShowOnboardingModalThunk = require(scriptParentParent.Thunks.ShowOnboardingModalThunk)

local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization
local var1 = Roact.PureComponent:extend("OnboardingModal")

local FFlagTopBarSignalizeScreenSize = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeScreenSize

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local GetFFlagEnableSendImageFeedbackToBackend = require(RobloxGui.Modules.Flags.GetFFlagEnableSendImageFeedbackToBackend)

function var1.init(arg1)
    function arg1.onDismiss()
        arg1.props.showOnboardingModal(false)
    end

    function arg1.onCancel()
        ExperienceStateCaptureService:ToggleCaptureMode()
    end

    if not FFlagTopBarSignalizeScreenSize then
        return
    end

    local getViewportSize = Display.GetDisplayStore(false).getViewportSize

    arg1.disposeScreenSize = Signals.createEffect(function(arg2)
        arg1:setState({ screenSize = getViewportSize(arg2) })
    end)
end

function var1.willUnmount(arg1)
    if FFlagTopBarSignalizeScreenSize then
        arg1.disposeScreenSize()
    end
end

function var1.render(arg1)
    return withLocalization({
        mainHeader = "CoreScripts.Feedback.Onboarding.MainHeader",
        instructionLabel = if GetFFlagEnableSendImageFeedbackToBackend() then "CoreScripts.Feedback.Onboarding.InstructionsWithImage" else "CoreScripts.Feedback.Onboarding.Instructions",
        cancel = "CoreScripts.Feedback.Onboarding.Cancel",
        start = "CoreScripts.Feedback.Onboarding.Start"
    })(
        function(arg2)
            return Roact.createElement(ModalDialog, {
                visible = arg1.props.visible,
                screenSize = if FFlagTopBarSignalizeScreenSize then arg1.state.screenSize else arg1.props.screenSize,
                titleText = arg2.mainHeader,
                maxHeight = 200,
                maxWidth = 540,
                showCloseButton = true,
                actionButtons = Roact.createElement(ButtonStack, {
                    buttonHeight = 36,
                    buttons = {
                        {
                            buttonType = ButtonType.Secondary,
                            props = {
                                onActivated = arg1.onCancel,
                                text = arg2.cancel
                            }
                        },
                        {
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                isDisabled = false,
                                onActivated = arg1.onDismiss,
                                text = arg2.start
                            }
                        }
                    }
                }),
                contents = Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1)
                }, {
                    Padding = Roact.createElement(
                        "UIPadding",
                        {
                            PaddingLeft = UDim.new(0, 24),
                            PaddingRight = UDim.new(0, 24),
                            PaddingBottom = UDim.new(0, 24)
                        }
                    ),
                    Layout = Roact.createElement("UIListLayout", {
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Top
                    }),
                    InstructionLabel = Roact.createElement(ThemedTextLabel, {
                        LayoutOrder = 1,
                        fontKey = "Body",
                        themeKey = "TextDefault",
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, 76, 0.5, 0),
                        Size = UDim2.new(1, 0, 0.4, 36),
                        Text = arg2.instructionLabel,
                        TextWrapped = true,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                }),
                onDismiss = arg1.onDismiss
            })
        end
    )
end
return RoactRodux.connect(function(arg1)
    return {
        screenSize = if FFlagTopBarSignalizeScreenSize then nil else arg1.displayOptions.screenSize,
        visible = arg1.common.showOnboardingModal
    }
end, function(callback)
    return {
        showOnboardingModal = function(arg1)
            callback(ShowOnboardingModalThunk(arg1))
        end
    }
end)(var1)
