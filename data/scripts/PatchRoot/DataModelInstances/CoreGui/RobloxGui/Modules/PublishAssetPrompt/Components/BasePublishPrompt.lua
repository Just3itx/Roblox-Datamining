-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local ExperienceAuthService = game:GetService("ExperienceAuthService")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local withStyle = UIBlox.Style.withStyle
local FullPageModal = UIBlox.App.Dialog.Modal.FullPageModal
local Overlay = UIBlox.App.Dialog.Overlay
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local GamepadUtils = require(CorePackages.Workspace.Packages.InputUi).Gamepad.GamepadUtils
local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService
local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection
local InputType = require(CorePackages.Workspace.Packages.InputType)
local getInputGroup = require(CorePackages.Workspace.Packages.InputType).getInputGroup

local scriptParent = script.Parent
local LabeledTextBox = require(scriptParent.Common.LabeledTextBox)
local CloseOpenPrompt = require(script.Parent.Parent.Actions.CloseOpenPrompt)
local SetPromptVisibility = require(script.Parent.Parent.Actions.SetPromptVisibility)
local LeaveCreationAlert = require(script.Parent.LeaveCreationAlert)
local Constants = require(script.Parent.Parent.Constants)
local Constants2 = require(RobloxGui.Modules.TopBar.Constants)
local PreviewViewport = require(scriptParent.Common.PreviewViewport)
local ValidationErrorModal = require(scriptParent.ValidationErrorModal)
local PublishAssetAnalytics = require(CorePackages.Workspace.Packages.PurchasePrompt).PublishAssetAnalytics

local var1 = Roact.PureComponent:extend("BasePublishPrompt")

local uDim = UDim.new(1.5, 0)

local function isGamepadInput(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return getInputGroup(arg1) == InputType.InputTypeConstants.Gamepad
end

var1.validateProps = t.strictInterface({
    screenSize = t.Vector2,
    nameLabel = t.string,
    defaultName = t.string,
    promptBody = t.any,
    titleText = t.string,
    showingPreviewView = t.boolean,
    closePreviewView = t.callback,
    isMakeupPreview = t.optional(t.boolean),
    asset = t.optional(t.union(t.instanceOf("Model"), t.instanceIsA("AnimationClip"))),
    onNameUpdated = t.callback,
    canSubmit = t.callback,
    onSubmit = t.callback,
    enableInputDelayed = t.optional(t.boolean),
    isDelayedInput = t.optional(t.boolean),
    delayInputSeconds = t.optional(t.number),
    priceInRobux = t.optional(t.number),
    showTopScrim = t.optional(t.boolean),
    guid = t.any,
    scopes = t.any,
    errorMessage = t.optional(t.string),
    promptVisible = t.optional(t.boolean),
    closePrompt = t.callback,
    SetPromptVisibility = t.callback
})

function var1.init(arg1)
    arg1.swipeScrollingFrameRef = Roact.createRef()
    arg1.inputState = nil
    arg1.inputObject = nil
    arg1.connection = nil
    arg1.disposeUiScaleEffect = Signals.createEffect(function(arg2)
        local displayStore = Display.GetDisplayStore(arg2)
        arg1:setState({ UiScale = displayStore.getUIScale(arg2) })
    end)

    function arg1.storeInput(_, inputState, inputObject): Enum.ContextActionResult
        arg1.inputState = inputState
        arg1.inputObject = inputObject

        return Enum.ContextActionResult.Sink
    end

    arg1:setState(
        {
            showUnsavedDataWarning = false,
            isGamepad = not not isGamepadInput((UserInputService:GetLastInputType()))
        }
    )
    function arg1.closePrompt()
        arg1.props.closePrompt()
        arg1.props.SetPromptVisibility(false)
    end

    function arg1.showUnsavedDataWarning()
        arg1:setState({ showUnsavedDataWarning = true })

        PublishAssetAnalytics.sendButtonClicked(PublishAssetAnalytics.Section.BuyCreationPage, PublishAssetAnalytics.Element.X)
    end

    function arg1.cancelClosePrompt()
        arg1:setState({ showUnsavedDataWarning = false })
    end

    function arg1.denyAndClose()
        ExperienceAuthService:ScopeCheckUIComplete(arg1.props.guid, arg1.props.scopes, Enum.ScopeCheckResult.ConsentDenied, {})

        arg1.closePrompt()
    end

    function arg1.confirmAndUpload()
        if arg1.props.canSubmit() then
            arg1.props.onSubmit()
        end
    end
end

function var1.setUpGamepad(arg1)
    if not UserInputService.GamepadEnabled then
        return
    end

    ContextActionService:UnbindCoreAction("ScrollPrompt")
    ContextActionService:BindCoreAction("ScrollPrompt", arg1.storeInput, false, Enum.KeyCode.Thumbstick2)
    arg1.connection = RunService.RenderStepped:Connect(function(deltaTime: number)
        if arg1.inputState ~= Enum.UserInputState.Change or not arg1.inputObject then
            return
        end

        local inputObjectPosition = arg1.inputObject.Position
        local current = arg1.swipeScrollingFrameRef.current
        local y = current.CanvasPosition.Y + deltaTime * -GamepadUtils.normalizeStickByDeadzone(inputObjectPosition).Y * 1000
        if y <= current.AbsoluteSize.Y * uDim.Scale + uDim.Offset then
            current.CanvasPosition = Vector2.new(0, y)
        end
    end)

    ContextActionService:UnbindCoreAction("ClosePrompt")
    ContextActionService:BindCoreAction("ClosePrompt", arg1.storeInput, false, Enum.KeyCode.ButtonB)
end

function var1.cleanupGamepad(arg1)
    ContextActionService:UnbindCoreAction("ClosePrompt")
    ContextActionService:UnbindCoreAction("ScrollPrompt")
    if arg1.connection then
        arg1.connection:Disconnect()
    end
end

function var1.overrideMouseIconBehavior(arg1)
    local overrideMouseIconBehavior2 = if arg1.state.isGamepad then Enum.OverrideMouseIconBehavior.ForceHide else Enum.OverrideMouseIconBehavior.ForceShow
    MouseIconOverrideService.push("BasePublishPromptOverrideKey", overrideMouseIconBehavior2)
end

function var1.removeMouseIconBehaviorOverride(_)
    MouseIconOverrideService.pop("BasePublishPromptOverrideKey")
end

function var1.didMount(arg1)
    arg1:setUpGamepad()

    arg1.props.SetPromptVisibility(true)

    arg1:overrideMouseIconBehavior()
end

function var1.didUpdate(arg1, arg2, arg3)
    if arg2.promptVisible ~= arg1.props.promptVisible and arg1.props.promptVisible == false then
        arg1.closePrompt()
    end

    if arg1.state.isGamepad ~= arg3.isGamepad then
        arg1:overrideMouseIconBehavior()
    end
end

function var1.renderMiddle(arg1, arg2)
    return withStyle(function(arg3)
        local font = arg3.Font
        local baseSize = font.BaseSize
        local theme = arg3.Theme

        local footer = font.Footer
        local textDefaultColor = theme.TextDefault.Color

        local createFragment = Roact.createFragment
        local tbl1 = {
            ScrollingFrame = Roact.createElement("ScrollingFrame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, -50),
                CanvasSize = UDim2.new(1, 0, 0, 0),
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Selectable = false,
                [Roact.Ref] = arg1.swipeScrollingFrameRef
            }, {
                layout = Roact.createElement("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical
                }),
                padding = Roact.createElement(
                    "UIPadding",
                    {
                        PaddingLeft = UDim.new(0, Constants.PromptSidePadding),
                        PaddingRight = UDim.new(0, Constants.PromptSidePadding)
                    }
                ),
                NameInput = Roact.createElement(LabeledTextBox, {
                    LayoutOrder = 1,
                    labelText = arg1.props.nameLabel,
                    topPadding = 24,
                    defaultText = arg1.props.defaultName,
                    onTextUpdated = arg1.props.onNameUpdated,
                    textBoxHeight = 30
                }),
                PromptBody = Roact.createElement(
                    "Frame",
                    {
                        Size = UDim2.fromScale(1, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundTransparency = 1,
                        LayoutOrder = 2
                    },
                    arg1.props.promptBody
                )
            }),
            BottomGradient = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 5),
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(0, 0, 1, -50),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                ZIndex = 2
            }, {
                gradient = Roact.createElement("UIGradient", {
                    Rotation = 270,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, theme.BackgroundUIDefault.Color), ColorSequenceKeypoint.new(1, theme.BackgroundUIDefault.Color) }),
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, theme.BackgroundUIDefault.Transparency), NumberSequenceKeypoint.new(0.5, theme.BackgroundUIDefault.Transparency), NumberSequenceKeypoint.new(1, 1) })
                })
            }),
            DisclaimerContainer = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 50),
                    Position = UDim2.new(0, 0, 1, -50)
                },
                {
                    padding = Roact.createElement(
                        "UIPadding",
                        {
                            PaddingLeft = UDim.new(0, Constants.PromptSidePadding),
                            PaddingRight = UDim.new(0, Constants.PromptSidePadding)
                        }
                    ),
                    Disclaimer = Roact.createElement("TextLabel", {
                        Size = UDim2.fromScale(1, 1),
                        Text = arg2.disclaimer,
                        FontFace = normalizeFontFace(arg3.Tokens.Typography.CaptionSmall.Font),
                        TextSize = baseSize * footer.RelativeSize,
                        TextColor3 = textDefaultColor,
                        BackgroundTransparency = 1,
                        TextWrapped = true
                    })
                }
            )
        }
        return createFragment(tbl1)
    end)
end

function var1.renderAlertLocalized(arg1, arg2)
    local vector2, _vector2 = GuiService:GetGuiInset()
    local uDim2 = UDim2.new(0, 0, 0, -vector2.Y)
    local uDim2_2 = UDim2.new(1, 0, 1, vector2.Y)
    local yOffset = Constants2.TopBarHeight * arg1.state.UiScale

    return withStyle(function(arg3)
        local theme = arg3.Theme
        local text = if arg1.props.priceInRobux and arg1.props.priceInRobux > 0 then string.format("%s %i", "", arg1.props.priceInRobux) else arg2.submit
        local createFragment = Roact.createFragment

        local tbl1 = {
            LastInputTypeConnection = Roact.createElement(ExternalEventConnection, {
                event = UserInputService.LastInputTypeChanged,
                callback = function(arg4)
                    arg1:setState({ isGamepad = not not isGamepadInput(arg4) })
                end
            }),
            BottomScrim = Roact.createElement(
                "Frame",
                { Position = uDim2, Size = uDim2_2, ZIndex = -1, BackgroundTransparency = 1 },
                {
                    Overlay = Roact.createElement(Overlay, { showGradient = false }),
                    InputSink = Roact.createElement("TextButton", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", Modal = true })
                }
            ),
            PublishPrompt = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, -yOffset),
                Position = UDim2.fromOffset(0, yOffset),
                Visible = not (arg1.state.showUnsavedDataWarning or arg1.props.showingPreviewView or arg1.props.showTopScrim)
            }, {
                FullPageModal = Roact.createElement(FullPageModal, {
                    title = arg1.props.titleText,
                    onCloseClicked = arg1.showUnsavedDataWarning,
                    distanceFromTop = 4,
                    marginSize = 0,
                    screenSize = arg1.props.screenSize,
                    buttonStackProps = {
                        buttons = {{
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                isDisabled = not arg1.props.canSubmit(),
                                isDelayedInput = arg1.props.isDelayedInput,
                                enableInputDelayed = arg1.props.enableInputDelayed,
                                delayInputSeconds = arg1.props.delayInputSeconds,
                                onActivated = arg1.confirmAndUpload,
                                text = text,
                                isLoading = not arg1.props.priceInRobux
                            }
                        }},
                        disableRoactGamepadButtonSelection = true
                    }
                }, {
                    middleContent = arg1:renderMiddle(arg2)
                })
            }),
            LeaveCreationAlert = if arg1.state.showUnsavedDataWarning then Roact.createElement(
                LeaveCreationAlert,
                {
                    screenSize = arg1.props.screenSize,
                    closePrompt = arg1.denyAndClose,
                    cancelClosePrompt = arg1.cancelClosePrompt
                }
            ) else nil,
            ValidationErrorAlert = if arg1.props.errorMessage then Roact.createElement(ValidationErrorModal, { screenSize = arg1.props.screenSize, closePrompt = arg1.closePrompt }) else nil,
            PreviewFrame = 0,
            TopScrim = 0
        }

        local element

        if arg1.props.showingPreviewView then
            element = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = theme.BackgroundUIDefault.Color,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                BackgroundTransparency = theme.BackgroundUIDefault.Transparency
            }, {
                PreviewViewport = Roact.createElement(PreviewViewport, {
                    asset = arg1.props.asset,
                    closePreviewView = arg1.props.closePreviewView,
                    isMakeupPreview = arg1.props.isMakeupPreview
                })
            })
                or nil
        else
            element = nil
        end

        tbl1.PreviewFrame = element

        tbl1.TopScrim = Roact.createElement(
            "Frame",
            {
                Position = uDim2,
                Size = uDim2_2,
                ZIndex = 2,
                BackgroundTransparency = 1,
                Visible = arg1.props.showTopScrim
            },
            {
                InputSink = Roact.createElement("TextButton", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "" })
            }
        )
        return createFragment(tbl1)
    end)
end

local function GetLocalizedStrings() -- Luacid: Inlined by compiler; 1 call site recovered
    local localizedStrings = ({})
    localizedStrings.submit = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Submit")
    localizedStrings.disclaimer = RobloxTranslator:FormatByKey("CoreScripts.PublishCommon.Disclaimer")

    return localizedStrings
end

function var1.render(arg1)
    return arg1:renderAlertLocalized((GetLocalizedStrings()))
end

function var1.willUnmount(arg1)
    arg1:removeMouseIconBehaviorOverride()

    arg1:cleanupGamepad()

    if arg1.disposeUiScaleEffect then
        arg1.disposeUiScaleEffect()
    end

    arg1.props.SetPromptVisibility(false)
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        guid = arg1.promptRequest.promptInfo.guid,
        scopes = arg1.promptRequest.promptInfo.scopes,
        errorMessage = arg1.promptRequest.promptInfo.errorMessage,
        promptVisible = arg1.promptRequest.promptInfo.promptVisible
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        closePrompt = function()
            return arg1(CloseOpenPrompt())
        end,
        SetPromptVisibility = function(arg2)
            return arg1(SetPromptVisibility(arg2))
        end
    }
end)(var1)
