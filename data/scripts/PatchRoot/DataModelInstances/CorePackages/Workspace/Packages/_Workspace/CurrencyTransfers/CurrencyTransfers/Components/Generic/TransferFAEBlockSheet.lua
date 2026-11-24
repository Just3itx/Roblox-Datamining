-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)

local Foundation = require(CurrencyTransfersParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Sheet = Foundation.Sheet
local Button = Foundation.Button
local View = Foundation.View
local FoundationText = Foundation.Text
local FillBehavior = Foundation.Enums.FillBehavior
local useScaledValue = Foundation.Hooks.useScaledValue
local Enums = Foundation.Enums
local getIconRichText = Foundation.Utility.getIconRichText

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local processTransfer = require(CurrencyTransfers.Actions.Send.processTransfer)
local acceptTransfer = require(CurrencyTransfers.Actions.Receive.acceptTransfer)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)

local AmpUpsell = require(CurrencyTransfersParent.AmpUpsell)
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum
local InExpAmpWizardController = AmpUpsell.InExpAmpWizardController
local OpenAmpWizardContainer = AmpUpsell.OpenAmpWizardContainer

local useDispatch = require(CurrencyTransfersParent.RoactUtils).Hooks.RoactRodux.useDispatch
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)

local GetFFlagCurrencyTransferUseAmpWizardContainerForInApp = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferUseAmpWizardContainerForInApp)

local AmpWizardTransferConstants = require(CurrencyTransfers.Constants.AmpWizardTransferConstants)
local getCounterUserId = require(CurrencyTransfers.Utils.getCounterUserId)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local GetFFlagCurrencyTransferFocusNavigation = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFocusNavigation)
local useTransferSheetFocus = require(CurrencyTransfers.Hooks.useTransferSheetFocus)

local function TransferFAEBlockSheet(tbl1)
    local var1 = useLocalization(TransferLocalizationKeys.Presets.TransferFAEBlockSheet)

    local var2 = useTransferStore()
    local var3 = useDispatch()
    local direction = tbl1.direction
    local triggerOnClose = var2.triggerOnClose
    local selectedAmount = var2.getSelectedAmount(false)

    local bool1 = (if GetFFlagCurrencyTransferUseAmpWizardContainerForInApp() then var2.getTransferOrigination(false) else nil) == TransferOrigination.InExperience
    local var4 = useScaledValue(420)

    React.useEffect(function()
        logCurrencyTransferCounter(
            var2,
            CurrencyTransferTelemetry.CurrencyTransferFAEBlockSheetShownCounter,
            { recourseSurface = "fae" }
        )

        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.fae_block_shown)
        end
        return nil
    end, { var2 })

    local var5 = if direction == TransferDirection.Send then var1.RequireSenderFAE else var1.RequireReceiverFAE
    local requireFae = var1.RequireFAE
    local var6, var7

    if GetFFlagCurrencyTransferFocusNavigation() then
        var6, var7 = useTransferSheetFocus(triggerOnClose)
    else
        var6 = nil
        var7 = nil
    end

    return React.createElement(
        Sheet.Root,
        {
            preferCenterSheet = true,
            snapPoints = { var4, 0.5 },
            onClose = triggerOnClose,
            ref = var6
        },
        {
            Content = React.createElement(Sheet.Content, { LayoutOrder = 1 }, {
                SheetContentContainer = React.createElement(
                    View,
                    {
                        tag = "col gap-small auto-y size-full-0 align-x-center padding-top-xlarge padding-x-large"
                    },
                    {
                        IconsContainer = React.createElement(
                            View,
                            {
                                tag = "auto-xy position-relative padding-bottom-large",
                                Size = UDim2.fromOffset(300, 140),
                                LayoutOrder = 1
                            },
                            {
                                ShieldIconContainer = React.createElement(View, {
                                    tag = "radius-medium stroke-default bg-surface-100 align-x-center align-y-center position-absolute",
                                    Size = UDim2.fromOffset(100, 100),
                                    Position = UDim2.new(0.5, -40, 0.5, 10),
                                    AnchorPoint = Vector2.new(0.5, 0.5),
                                    Rotation = -15,
                                    ZIndex = 2
                                }, {
                                    ShieldIcon = React.createElement(FoundationText, {
                                        Text = getIconRichText(Enums.IconName.ShieldCheck),
                                        tag = "content-emphasis text-align-x-center text-display-medium",
                                        RichText = true,
                                        Size = UDim2.fromOffset(72, 72),
                                        Position = UDim2.new(0.5, 0, 0.5, 0),
                                        AnchorPoint = Vector2.new(0.5, 0.5)
                                    })
                                }),
                                RobuxIconContainer = React.createElement(View, {
                                    tag = "radius-medium stroke-default bg-surface-100 align-x-center align-y-center position-absolute",
                                    Size = UDim2.fromOffset(100, 100),
                                    Position = UDim2.new(0.5, 55, 0.5, -10),
                                    AnchorPoint = Vector2.new(0.5, 0.5),
                                    Rotation = 15,
                                    ZIndex = 1
                                }, {
                                    RobuxIcon = React.createElement(FoundationText, {
                                        Text = getIconRichText("robux"),
                                        tag = "content-emphasis text-align-x-center text-display-medium",
                                        RichText = true,
                                        Size = UDim2.fromOffset(72, 72),
                                        Position = UDim2.new(0.5, 0, 0.5, 0),
                                        AnchorPoint = Vector2.new(0.5, 0.5)
                                    })
                                })
                            }
                        ),
                        TitleText = React.createElement(FoundationText, {
                            Text = var5,
                            tag = "text-heading-medium content-emphasis text-align-x-left text-wrap padding-top-xlarge",
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            LayoutOrder = 2
                        }),
                        BodyText = React.createElement(FoundationText, {
                            Text = requireFae,
                            tag = "text-body-medium content-default text-align-x-left text-wrap",
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            LayoutOrder = 3
                        })
                    }
                )
            }),
            Actions = React.createElement(Sheet.Actions, { LayoutOrder = 2 }, {
                React.createElement(
                    View,
                    {
                        tag = "col auto-y align-y-center align-x-center size-full-0 gap-small padding-x-medium padding-bottom-large"
                    },
                    {
                        React.createElement(View, { tag = "row auto-y size-full-0 gap-small" }, {
                            React.createElement(Button, {
                                ref = var7,
                                text = var1.Continue,
                                onActivated = function()
                                    logCurrencyTransferCounter(
                                        var2,
                                        CurrencyTransferTelemetry.CurrencyTransferFAEBlockContinueClickedCounter,
                                        { recourseSurface = "fae" }
                                    )
                                    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                                        logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.fae_continue_clicked)
                                    end

                                    if not tbl1.ampFeatureCheck then
                                        print("No ampFeatureCheck available")
                                        triggerOnClose()

                                        return
                                    end

                                    local promptState = var2.getPromptState(false)
                                    var2.setPreviousPromptState(promptState)
                                    var2.setPromptState(PromptState.Hidden)

                                    local counterUserId = getCounterUserId(var2, direction)

                                    local var8 = counterUserId and {{
                                        name = "targetUser",
                                        value = tostring(counterUserId),
                                        type = "UserId"
                                    }} or nil

                                    local function func1(granted, _)
                                        local previousPromptState = var2.getPreviousPromptState(false)
                                        if previousPromptState then
                                            var2.setPromptState(previousPromptState)
                                        end

                                        if granted ~= AccessResponseEnum.Granted then
                                            triggerOnClose()
                                            return
                                        end

                                        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                                            logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.age_verification_completed)
                                        end

                                        if direction == TransferDirection.Receive then
                                            acceptTransfer(var2)
                                        elseif direction == TransferDirection.Send then
                                            processTransfer(var2, selectedAmount or 0)
                                        end
                                    end

                                    if bool1 or not GetFFlagCurrencyTransferUseAmpWizardContainerForInApp() then
                                        InExpAmpWizardController.OpenAmpWizardContainerInExp(
                                            tbl1.ampFeatureCheck,
                                            func1,
                                            nil,
                                            AmpWizardTransferConstants.ENTRY_POINT_EVENT_CTX,
                                            var8,
                                            AmpWizardTransferConstants.NAMESPACE_NAME
                                        )
                                        return
                                    end

                                    var3(
                                        OpenAmpWizardContainer(
                                            tbl1.ampFeatureCheck,
                                            func1,
                                            nil,
                                            AmpWizardTransferConstants.ENTRY_POINT_EVENT_CTX,
                                            var8,
                                            AmpWizardTransferConstants.NAMESPACE_NAME
                                        )
                                    )
                                end,
                                variant = ButtonVariant.Emphasis,
                                fillBehavior = FillBehavior.Fill
                            })
                        })
                    }
                )
            })
        }
    )
end

return TransferFAEBlockSheet
