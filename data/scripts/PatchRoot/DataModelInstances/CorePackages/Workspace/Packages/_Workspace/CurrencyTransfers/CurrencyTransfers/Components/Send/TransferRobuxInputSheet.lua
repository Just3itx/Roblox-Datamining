-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)
local transferLocaleFormat = require(CurrencyTransfers.Localization.transferLocaleFormat)
local React = require(CurrencyTransfersParent.React)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)

local Foundation = require(CurrencyTransfersParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Sheet = Foundation.Sheet
local Button = Foundation.Button
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local FillBehavior = Foundation.Enums.FillBehavior
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local RobuxText = require(CurrencyTransfers.Components.Generic.RobuxText)
local TransferRobuxHeader = require(CurrencyTransfers.Components.Generic.TransferRobuxHeader)
local TransferAmountOptionChips = require(CurrencyTransfers.Components.Generic.TransferAmountOptionChips)
local TransferProfileThumbnail = require(CurrencyTransfers.Components.Generic.TransferProfileThumbnail)

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local useTextBoxOnChangeRef = require(CurrencyTransfers.Hooks.useTextBoxOnChangeRef)
local useAutoFocusTextBoxOnMount = require(CurrencyTransfers.Hooks.useAutoFocusTextBoxOnMount)

local proceedToConfirm = require(CurrencyTransfers.Actions.Send.proceedToConfirm)
local setTransferPromptState = require(CurrencyTransfers.Actions.Send.setTransferPromptState)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local GetFIntCurrencyTransferMinAmount = require(CurrencyTransfers.Flags.GetFIntCurrencyTransferMinAmount)
local GetFIntCurrencyTransferMaxAmount = require(CurrencyTransfers.Flags.GetFIntCurrencyTransferMaxAmount)
local GetFFlagCurrencyTransferFixTextBoxInput = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFixTextBoxInput)

local GetFFlagCurrencyTransferFlowUIImprovementFix = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFlowUIImprovementFix)
local GetFFlagCurrencyTransferFixDesktopInput = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFixDesktopInput)
local GetFFlagCurrencyTransferFocusNavigation = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFocusNavigation)
local useTransferSheetFocus = require(CurrencyTransfers.Hooks.useTransferSheetFocus)

local GetFFlagCurrencyTransferUseBackendTransferLimits = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferUseBackendTransferLimits)
local FFlagShowRemainingTransfersForNonPlus = require(CurrencyTransfers.Flags.FFlagShowRemainingTransfersForNonPlus)

local FFlagCurrencyTransferHideAmountChipsAboveMax = require(CurrencyTransfers.Flags.FFlagCurrencyTransferHideAmountChipsAboveMax)
local TransferBenefitSource = require(CurrencyTransfers.Enums.TransferBenefitSource)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)
local formatNumber = require(CurrencyTransfers.Utils.formatNumber)

local function TransferRobuxInputSheet(_)
    local var1 = useLocalization(TransferLocalizationKeys.Presets.TransferRobuxInputSheet)
    local var2 = useTokens()

    local var3 = GetFFlagCurrencyTransferFixDesktopInput() and not UserInputService.TouchEnabled

    local var4 = useTransferStore()

    React.useEffect(function()
        logCurrencyTransferCounter(var4, CurrencyTransferTelemetry.CurrencyTransferInputSheetShownCounter)
        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(var4, RobuxTransferFlowEventName.input_shown)
        end
        return nil
    end, { var4 })

    local var5 = SignalsReact.useSignalState(var4.getSelectedAmount) or 0
    local setSelectedAmount = var4.setSelectedAmount
    local var6, var7 = React.useState(false)
    local robuxBalanceAmount = SignalsReact.useSignalState(var4.getRobuxBalanceAmount) or 0
    local recipient = var4.getRecipient(false)
    local var9 = React.useRef(nil)
    local var10 = SignalsReact.useSignalState(var4.getMinimumTransferAmount)
    local var11 = SignalsReact.useSignalState(var4.getMaximumTransferAmount)
    local var12 = GetFFlagCurrencyTransferUseBackendTransferLimits() and var10 or GetFIntCurrencyTransferMinAmount()
    local var13 = GetFFlagCurrencyTransferUseBackendTransferLimits() and var11 or GetFIntCurrencyTransferMaxAmount()
    local var14 = if FFlagShowRemainingTransfersForNonPlus then SignalsReact.useSignalState(var4.getTransferBenefitSource) else nil
    local var15 = if FFlagShowRemainingTransfersForNonPlus then SignalsReact.useSignalState(var4.getNumFreeTransfersRemaining) else nil
    local numFreeTransfersRemaining = if FFlagShowRemainingTransfersForNonPlus and var15 ~= nil then formatNumber(LocalizationService.RobloxLocaleId, var15) else nil
    local var17 = useLocalization({
        FreeTransfersRemaining = if FFlagShowRemainingTransfersForNonPlus and numFreeTransfersRemaining ~= nil then var15 ~= 1
            and {
                "Features.Transfers.RobuxTransfer.FreeTransfersRemaining",
                numFreeTransfersRemaining = numFreeTransfersRemaining
            }
            or nil else nil,
        FreeTransfersRemainingSingular = if FFlagShowRemainingTransfersForNonPlus then if var15 == 1 then "Features.Transfers.RobuxTransfer.FreeTransfersRemainingSingular" else nil else nil
    })

    React.useEffect(function()
        if var5 == 0 or var12 <= var5 and var5 <= var13 then
            var7(false)
        end
    end, { var5, var12, var13 })

    local onActivated = React.useCallback(function()
        if var5 and (var5 < var12 or var13 < var5) then
            var7(true)
            return
        end

        if var5 and robuxBalanceAmount < var5 then
            setTransferPromptState(var4, PromptState.TransferInsufficientBalance)
        else
            proceedToConfirm(var4, var5 or 0)
        end
    end, {
        var4,
        var5,
        robuxBalanceAmount,
        var12,
        var13
    })
    local var19 = React.useCallback(function(num1: number?)
        setSelectedAmount(num1 or 0)
    end, { setSelectedAmount })

    local var20 = React.useCallback(function(bool1: boolean, bool2: boolean)
        if bool1 or not bool2 then
            return
        end
        if var5 and var5 > 0 and (var5 < var12 or var13 < var5) then
            var7(true)
            return
        end
        onActivated()
    end, {
        onActivated,
        var5,
        var12,
        var13
    })
    local var21 = useTextBoxOnChangeRef(var19, var20)
    local triggerOnClose = var4.triggerOnClose
    local ref = if GetFFlagCurrencyTransferFocusNavigation() then useTransferSheetFocus(triggerOnClose) else nil
    local var23 = useAutoFocusTextBoxOnMount(var21, 0.05)
    local var8 = React.useCallback(function(current)
        if current then
            var9.current = current
            var23(current)
        end
    end, { var23 })

    local chips = React.useMemo(function()
        local tbl1 = {
            { amount = 25, text = "25" },
            { amount = 50, text = "50" },
            { amount = 100, text = "100" },
            { amount = 200, text = "200" }
        }

        if not FFlagCurrencyTransferHideAmountChipsAboveMax
            and (not FFlagShowRemainingTransfersForNonPlus or var14 ~= TransferBenefitSource.Free)
        then
            return tbl1
        end

        local result = {}
        for _, value in tbl1 do
            if value.amount <= var13 then
                table.insert(result, value)
            end
        end
        return result
    end, { var14, var13 })

    local onChipSelected = React.useCallback(function(num1: number)
        setSelectedAmount(num1)

        if not GetFFlagCurrencyTransferFlowUIImprovementFix() then
            return
        end

        local current = var9.current
        if current then
            current:ReleaseFocus()
        end
    end, { setSelectedAmount })

    local bool1 = var5 > 0 and (var5 < var12 or var13 < var5)
    local var27 = var6 and bool1
    local var28 = React.useMemo(function()
        if not var27 or not var5 or var5 <= 0 then
            return nil
        end
        if var5 < var12 then
            local var28 = formatNumber(LocalizationService.RobloxLocaleId, var12)
            return transferLocaleFormat.substituteAmount(var1.LowerThanMinAmount or "", tostring(var28))
        end
        if not (var13 < var5) then
            return nil
        end

        local var28 = formatNumber(LocalizationService.RobloxLocaleId, var13)
        return transferLocaleFormat.substituteAmount(var1.GreaterThanMaxAmount or "", tostring(var28))
    end, {
        var27,
        var5,
        var12,
        var13,
        var1.LowerThanMinAmount,
        var1.GreaterThanMaxAmount
    })

    local isDisabled = React.useMemo(function(): boolean
        return not var5 or var5 <= 0
    end, { var5 })

    local var30 = useScaledValue(500)

    local snapPoints = React.useMemo(function(): {number}
        return { var30, 0.62 }
    end, { var30 })

    local disclaimer = var1.Disclaimer

    if FFlagShowRemainingTransfersForNonPlus and var14 == TransferBenefitSource.Free and var15 ~= nil then
        if var15 == 1 then
            disclaimer = var17.FreeTransfersRemainingSingular
        else
            disclaimer = var17.FreeTransfersRemaining
        end
    end
    local createElement = React.createElement
    local root = Sheet.Root
    local tbl1 = {
        preferCenterSheet = true,
        snapPoints = snapPoints,
        onClose = triggerOnClose,
        ref = ref
    }
    local tbl2 = {
        Header = React.createElement(Sheet.Header, {}, {
            TransferRobuxHeader = React.createElement(TransferRobuxHeader, { titleText = var1.SendRobux, robuxBalanceAmount = robuxBalanceAmount })
        }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local tbl3 = { LayoutOrder = 2 }

    local tbl4 = { SheetContentContainer = 0 }

    local createElement3 = React.createElement
    local var32 = View
    local tbl5 = {
        tag = "col align-x-center items-center gap-large size-full-0 auto-y padding-x-large padding-top-xxlarge"
    }
    local tbl6 = { RobuxInputWrapper = 0, ThumbnailAndAmountArea = 0, AmountChips = 0 }
    local var33

    if var3 then
        var33 = nil
    else
        local createElement4 = React.createElement
        local str1 = "Frame"
        local tbl7 = {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            LayoutOrder = 0
        }

        local tbl8 = { RobuxInput = 0 }
        local createElement5 = React.createElement
        local str2 = "Frame"
        local tbl9 = {
            Size = UDim2.new(0, 80, 0, 40),
            Position = UDim2.new(0, -10000, 0, 0),
            BackgroundTransparency = 1
        }
        local tbl10 = {
            TextBox = React.createElement("TextBox", {
                Size = UDim2.new(1, 0, 1, 0),
                Text = if var5 and var5 > 0 then tostring(var5) elseif GetFFlagCurrencyTransferFixTextBoxInput() then "" else "0",
                PlaceholderText = "",
                TextInputType = Enum.TextInputType.Number,
                BackgroundTransparency = 1,
                ClearTextOnFocus = not GetFFlagCurrencyTransferFlowUIImprovementFix(),
                ref = var8
            })
        }
        tbl8.RobuxInput = createElement5(str2, tbl9, tbl10)
        var33 = createElement4(str1, tbl7, tbl8)
    end

    tbl6.RobuxInputWrapper = var33

    local createElement4 = React.createElement
    local str1 = "Frame"
    local tbl7 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl8 = { Content = 0, TapToFocusOverlay = 0 }
    local createElement5 = React.createElement
    local var34 = View
    local tbl9 = {
        tag = "col align-x-center items-center gap-xlarge size-full-0 auto-y padding-top-xlarge"
    }
    local tbl10 = { RecipientProfile = 0, AmountContainer = 0 }
    local element

    if recipient and recipient.targetId then
        element = React.createElement(TransferProfileThumbnail, {
            userId = tostring(recipient.targetId),
            username = if GetFFlagCurrencyTransferFlowUIImprovementFix() then nil else recipient.targetName,
            displayName = if GetFFlagCurrencyTransferFlowUIImprovementFix() then recipient.targetDisplayName else nil,
            showUsername = true,
            size = UDim2.fromOffset(60, 60),
            layoutOrder = 1,
            thumbnailSize = Enum.ThumbnailSize.Size48x48
        })
    else
        element = nil
    end

    tbl10.RecipientProfile = element

    local createElement6 = React.createElement
    local var35 = View
    local tbl11 = { tag = "col align-x-center gap-large size-full-1600", LayoutOrder = 2 }

    local tbl12 = {
        ThumbnailAmountGap = React.createElement(View, { tag = "size-full-0", Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 1 }),
        AmountRow = 0,
        ErrorSlot = 0
    }

    local createElement7 = React.createElement
    local var36 = View
    local tbl13 = { tag = "row align-x-center align-y-center", LayoutOrder = 2 }

    local tbl14 = { AmountWrapper = 0 }
    local createElement8 = React.createElement
    local str2 = "Frame"
    local tbl15 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl16 = {
        SelectedAmountDisplay = if var3 then nil else React.createElement(RobuxText, { amount = var5, layoutOrder = 1 }),
        DesktopInputRow = 0,
        AmountTapTarget = 0
    }
    local var37

    if var3 then
        local createElement9 = React.createElement
        local tbl17 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }

        local tbl18 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            }),
            RobuxIconWrapper = React.createElement("Frame", {
                Size = UDim2.fromOffset(math.round(var2.Typography.HeadingLarge.FontSize), math.round(var2.Typography.DisplaySmall.FontSize)),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            }, {
                RobuxIcon = React.createElement(Icon, {
                    name = "robux",
                    size = var2.Typography.HeadingLarge.FontSize,
                    style = var2.Color.Content.Emphasis,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 4)
                })
            }),
            DesktopTextBox = React.createElement("TextBox", {
                Text = if var5 then if var5 > 0 then tostring(var5) else "" else "",
                PlaceholderText = "0",
                TextInputType = Enum.TextInputType.Number,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(var2.Typography.DisplaySmall.Font),
                TextSize = var2.Typography.DisplaySmall.FontSize,
                TextColor3 = var2.Color.Content.Emphasis.Color3,
                PlaceholderColor3 = var2.Color.Content.Emphasis.Color3,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.fromOffset(0, math.round(var2.Typography.DisplaySmall.FontSize)),
                ClearTextOnFocus = false,
                LayoutOrder = 2,
                ref = var8
            })
        }
        var37 = createElement9("Frame", tbl17, tbl18)
    else
        var37 = nil
    end

    tbl16.DesktopInputRow = var37
    local var38

    if var3 then
        var38 = nil
    else
        local createElement9 = React.createElement
        local tbl17 = {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "",
            BackgroundTransparency = 1,
            ZIndex = 2
        }

        tbl17[React.Event.Activated] = function()
            if var9.current then
                var9.current:CaptureFocus()
            end
        end

        var38 = createElement9("TextButton", tbl17)
    end

    tbl16.AmountTapTarget = var38
    tbl14.AmountWrapper = createElement8(str2, tbl15, tbl16)
    tbl12.AmountRow = createElement7(var36, tbl13, tbl14)

    tbl12.ErrorSlot = React.createElement(View, {
        tag = "col align-x-center align-y-center size-full-0 padding-top-medium",
        Size = UDim2.new(1, 0, 0, 40),
        LayoutOrder = 3
    }, {
        ValidationErrorText = if var28 then React.createElement(
            FoundationText,
            {
                Text = var28,
                tag = "auto-xy text-caption-small text-align-x-center content-system-alert",
                LayoutOrder = 1
            }
        ) else nil
    })
    tbl10.AmountContainer = createElement6(var35, tbl11, tbl12)
    tbl8.Content = createElement5(var34, tbl9, tbl10)
    local var39

    if var3 then
        var39 = nil
    else
        local createElement9 = React.createElement
        local tbl17 = {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "",
            BackgroundTransparency = 1,
            ZIndex = 2
        }

        tbl17[React.Event.Activated] = function()
            if var9.current then
                var9.current:CaptureFocus()
            end
        end

        var39 = createElement9("TextButton", tbl17)
    end

    tbl8.TapToFocusOverlay = var39
    tbl6.ThumbnailAndAmountArea = createElement4(str1, tbl7, tbl8)

    tbl6.AmountChips = React.createElement(
        View,
        { tag = "col align-x-center size-full-1600 auto-y", LayoutOrder = 2, ZIndex = 3 },
        {
            Chips = React.createElement(
                TransferAmountOptionChips,
                {
                    chips = chips,
                    onChipSelected = onChipSelected,
                    selectedAmount = var5,
                    layoutOrder = 1
                }
            )
        }
    )
    tbl4.SheetContentContainer = createElement3(var32, tbl5, tbl6)
    tbl2.Content = createElement2(content, tbl3, tbl4)

    tbl2.Actions = React.createElement(Sheet.Actions, { LayoutOrder = 3 }, { React.createElement(
            View,
            { tag = "col align-x-center align-y-center gap-medium size-full-1000" },
            {
                React.createElement(View, {
                    tag = "row gap-small size-full-0 auto-y",
                    LayoutOrder = 1
                }, { React.createElement(Button, {
                        text = var1.Next,
                        onActivated = onActivated,
                        variant = ButtonVariant.Emphasis,
                        fillBehavior = FillBehavior.Fill,
                        isDisabled = isDisabled
                    }) }),
                Disclaimer = React.createElement(
                    FoundationText,
                    {
                        Text = disclaimer,
                        tag = "wrap size-full-0 auto-y text-caption-small text-wrap text-align-x-center",
                        LayoutOrder = 2
                    }
                )
            }
        ) })
    return createElement(root, tbl1, tbl2)
end

return TransferRobuxInputSheet
