-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)

local Foundation = require(CurrencyTransfersParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Sheet = Foundation.Sheet
local Button = Foundation.Button
local View = Foundation.View
local FoundationText = Foundation.Text
local FillBehavior = Foundation.Enums.FillBehavior
local Enums = Foundation.Enums
local IconVariant = Foundation.Enums.IconVariant
local getIconRichText = Foundation.Utility.getIconRichText

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local TransferRobuxHeader = require(CurrencyTransfers.Components.Generic.TransferRobuxHeader)
local TransferProfileThumbnail = require(CurrencyTransfers.Components.Generic.TransferProfileThumbnail)
local RobuxText = require(CurrencyTransfers.Components.Generic.RobuxText)

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local setTransferPromptState = require(CurrencyTransfers.Actions.Send.setTransferPromptState)
local processTransfer = require(CurrencyTransfers.Actions.Send.processTransfer)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local GetFFlagCurrencyTransferFlowUIImprovementFix = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFlowUIImprovementFix)

local GetFIntCurrencyTransferDeveloperCommissionRate = require(CurrencyTransfers.Flags.GetFIntCurrencyTransferDeveloperCommissionRate)
local GetFIntCurrencyTransferPlatformFeeRate = require(CurrencyTransfers.Flags.GetFIntCurrencyTransferPlatformFeeRate)
local GetFFlagCurrencyTransferFocusNavigation = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFocusNavigation)
local useTransferSheetFocus = require(CurrencyTransfers.Hooks.useTransferSheetFocus)

local function TransferRobuxConfirmSheet(_)
    local var1 = useLocalization(TransferLocalizationKeys.Presets.TransferRobuxConfirmSheet)

    local var2 = useTransferStore()

    React.useEffect(function()
        logCurrencyTransferCounter(var2, CurrencyTransferTelemetry.CurrencyTransferConfirmSheetShownCounter)
        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.confirm_shown)
        end
        return nil
    end, { var2 })

    local robuxBalanceAmount = SignalsReact.useSignalState(var2.getRobuxBalanceAmount) or 0
    local amount = SignalsReact.useSignalState(var2.getSelectedAmount) or 0
    local userRelationshipDetail = var2.getUserRelationshipDetail(false)
    local recipient = var2.getRecipient(false)
    local bool1 = var2.getTransferOrigination(false) == TransferOrigination.InExperience
    local triggerOnClose = var2.triggerOnClose
    local var5, var6

    if GetFFlagCurrencyTransferFocusNavigation() then
        var5, var6 = useTransferSheetFocus(triggerOnClose)
    else
        var5 = nil
        var6 = nil
    end
    local year = os.date("*t").year

    local var7, var8 = React.useState(userRelationshipDetail)
    local var9, var10 = React.useState(recipient)

    React.useEffect(function()
        if userRelationshipDetail then
            var8(userRelationshipDetail)
        end
    end, { userRelationshipDetail })

    React.useEffect(function()
        if recipient then
            var10(recipient)
        end
    end, { recipient })

    local var11 = React.useMemo(function()
        if not GetFFlagCurrencyTransferFlowUIImprovementFix() then
            if not (var7 and var7.friendSinceYear) then
                return var1.NewConnection
            else
                local friendSinceYear = var7.friendSinceYear
                local var11 = year - friendSinceYear
                if var11 == 0 then
                    return var1.NewConnection
                end
                return string.gsub(var1.ConnectedYear, "{year}", tostring(var11))
            end
        end

        if not (var7 and var7.friendSinceDate) then
            return var1.NewConnection
        end
        local friendSinceDate = var7.friendSinceDate
        local now = os.time()
        local num1 = math.floor(
            (now - os.time(
                {
                    year = friendSinceDate.year,
                    month = friendSinceDate.month,
                    day = friendSinceDate.day,
                    hour = 0,
                    min = 0,
                    sec = 0
                }
            )) / 86400
        )

        if num1 < 1 then
            return var1.NewConnection
        end
        local var11 = os.date("*t", now)
        local var12 = (var11.year - friendSinceDate.year) * 12 + (var11.month - friendSinceDate.month)
        if var11.day < friendSinceDate.day then
            var12 -= 1
        end
        if var12 >= 12 then
            local num2 = math.floor(var12 / 12)
            return string.gsub(var1.ConnectedYear, "{year}", tostring(num2))
        elseif var12 >= 1 then
            if var12 <= 1 then
                return string.gsub(var1.ConnectedMonthsSingular, "{amount}", tostring(var12))
            end
            return string.gsub(var1.ConnectedMonths, "{amount}", tostring(var12))
        elseif num1 <= 1 then
            return string.gsub(var1.ConnectedDaysSingular, "{amount}", tostring(num1))
        else
            return string.gsub(var1.ConnectedDays, "{amount}", tostring(num1))
        end
    end, {
        year,
        var7,
        var1.ConnectedYear,
        var1.ConnectedMonths,
        var1.ConnectedMonthsSingular,
        var1.ConnectedDays,
        var1.ConnectedDaysSingular,
        var1.NewConnection
    })

    local var12 = React.useMemo(function()
        local mutualFriendsCount = var7.mutualFriendsCount

        if GetFFlagCurrencyTransferFlowUIImprovementFix() and var7.areFriends and mutualFriendsCount <= 1 then
            return string.gsub(var1.MutualConnectionSingular, "{amount}", tostring(mutualFriendsCount))
        end
        return string.gsub(var1.MutualConnection, "{amount}", tostring(mutualFriendsCount))
    end, {
        var7.mutualFriendsCount,
        var7.areFriends,
        var1.MutualConnection,
        var1.MutualConnectionSingular
    })

    local var13 = React.useMemo(function()
        return string.gsub(var1.JoinedInYear, "{year}", tostring(var7.userAccountSinceYear))
    end, { var7.userAccountSinceYear })

    local var14 = React.useMemo(function()
        if not GetFFlagCurrencyTransferFlowUIImprovementFix() then
            if not (bool1 and amount) then
                return nil
            end
            local fIntCurrencyTransferDeveloperCommissionRate = GetFIntCurrencyTransferDeveloperCommissionRate()
            local fIntCurrencyTransferPlatformFeeRate = GetFIntCurrencyTransferPlatformFeeRate()
            local num1 = math.ceil(amount * (1 - (fIntCurrencyTransferDeveloperCommissionRate + fIntCurrencyTransferPlatformFeeRate) / 100))
            return (string.gsub(var1.RecipientWillGet, "{amount}", tostring(num1)))
        end

        if bool1 and amount then
            local fIntCurrencyTransferDeveloperCommissionRate = GetFIntCurrencyTransferDeveloperCommissionRate()
            local fIntCurrencyTransferPlatformFeeRate = GetFIntCurrencyTransferPlatformFeeRate()
            local num1 = math.ceil(amount * (1 - (fIntCurrencyTransferDeveloperCommissionRate + fIntCurrencyTransferPlatformFeeRate) / 100))
            local fIntCurrencyTransferDeveloperCommissionRate2 = GetFIntCurrencyTransferDeveloperCommissionRate()
            local var14 = string.gsub(var1.RecipientWillGetInGame, "{amount}", tostring(num1))
            return (string.gsub(var14, "{commissionPercentage}", tostring(fIntCurrencyTransferDeveloperCommissionRate2)))
        elseif amount then
            return string.gsub(var1.RecipientWillGetInApp, "{amount}", tostring(amount))
        else
            return nil
        end
    end, {
        bool1,
        amount,
        var1.RecipientWillGet,
        var1.RecipientWillGetInGame,
        var1.RecipientWillGetInApp,
        GetFFlagCurrencyTransferFlowUIImprovementFix()
    })

    local tag = if GetFFlagCurrencyTransferFlowUIImprovementFix() then "size-full-0 auto-y text-body-small text-wrap text-align-x-center content-default" else "auto-xy text-caption-small text-align-x-center content-muted"

    local str1 = if GetFFlagCurrencyTransferFlowUIImprovementFix() then "col align-x-center align-y-center size-full-0 auto-y radius-medium bg-shift-100 padding-large" else "col align-x-center align-y-center size-full-2000 radius-medium bg-shift-100"
    local var15 = if GetFFlagCurrencyTransferFlowUIImprovementFix() then nil else UDim2.new(1, 0, 0, 250)
    local str2 = if GetFFlagCurrencyTransferFlowUIImprovementFix() then "col gap-xlarge align-x-center bg-shift-100 size-full-0 auto-y radius-medium padding-large" else "col gap-xlarge align-x-center bg-shift-100 align-y-center radius-medium padding-large"

    local var16 = GetFFlagCurrencyTransferFlowUIImprovementFix() and not var7.areFriends

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl1 = { preferCenterSheet = true, onClose = triggerOnClose, ref = var5 }
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
    local var17 = View
    local tbl5 = { tag = "col gap-large auto-y size-full-0 align-x-center" }

    local tbl6 = { ProfileCard = 0, AmountDisplay = 0 }
    local createElement4 = React.createElement
    local var18 = View
    local tbl7 = { Size = var15, tag = str2, LayoutOrder = 1 }

    local tbl8 = {
        RecipientProfile = if var9 and var9.targetId then React.createElement(TransferProfileThumbnail, {
            userId = tostring(var9.targetId),
            username = var9.targetName,
            displayName = var9.targetDisplayName,
            showUsername = true,
            size = UDim2.fromOffset(60, 60),
            layoutOrder = 1,
            thumbnailSize = Enum.ThumbnailSize.Size48x48
        }) else nil,
        InfoRow = 0
    }

    local createElement5 = React.createElement
    local var19 = View
    local tbl9 = {
        tag = "col gap-medium align-x-center align-y-start auto-y size-full-0",
        LayoutOrder = 2
    }

    local tbl10 = {
        FirstRow = React.createElement(View, {
            tag = "row align-x-center align-y-center auto-xy",
            LayoutOrder = 1
        }, {
            ConnectedDetail = if var7 and var7.areFriends then React.createElement(FoundationText, {
                Text = `{getIconRichText(Enums.IconName.Calendar, IconVariant.Filled)} {var11}`,
                tag = "auto-xy text-body-medium content-default text-no-wrap",
                RichText = true,
                LayoutOrder = 1
            }) else nil,
            Spacer = if var7 and var7.areFriends then React.createElement(View, { tag = "auto-xy", Size = UDim2.new(0, 8, 0, 0), LayoutOrder = 2 }) else nil,
            MutualDetail = React.createElement(FoundationText, {
                Text = `{getIconRichText(Enums.IconName.TwoPeople, IconVariant.Filled)} {var12}`,
                tag = "auto-xy text-body-medium content-default text-no-wrap",
                RichText = true,
                LayoutOrder = 3
            }),
            Spacer2 = if var16 then React.createElement(View, { tag = "auto-xy", Size = UDim2.new(0, 8, 0, 0), LayoutOrder = 4 }) else nil,
            InlineJoinedDetail = if var16 then React.createElement(FoundationText, {
                Text = `{getIconRichText(Enums.IconName.CircleI, IconVariant.Filled)} {var13}`,
                tag = "auto-xy text-body-medium content-default text-no-wrap",
                RichText = true,
                LayoutOrder = 5
            }) else nil
        }),
        JoinedDetail = if var16 then nil else React.createElement(FoundationText, {
            Text = `{getIconRichText(Enums.IconName.CircleI, IconVariant.Filled)} {var13}`,
            tag = "auto-xy text-body-medium content-default text-no-wrap padding-y-xsmall",
            RichText = true,
            LayoutOrder = 2
        })
    }
    tbl8.InfoRow = createElement5(var19, tbl9, tbl10)
    tbl6.ProfileCard = createElement4(var18, tbl7, tbl8)

    tbl6.AmountDisplay = React.createElement(View, { tag = str1, LayoutOrder = 2 }, {
        Amount = React.createElement(RobuxText, { amount = amount or 0, layoutOrder = 1 }),
        RecipientText = if var14 then React.createElement(FoundationText, { Text = var14, tag = tag, LayoutOrder = 2 }) else nil
    })
    tbl4.SheetContentContainer = createElement3(var17, tbl5, tbl6)
    tbl2.Content = createElement2(content, tbl3, tbl4)

    local createElement6 = React.createElement
    local actions = Sheet.Actions
    local tbl11 = { LayoutOrder = 3 }

    local createElement7 = React.createElement
    local var20 = View
    local tbl12 = { tag = "col align-x-center align-y-center gap-medium size-full-1000" }

    local createElement8 = React.createElement
    local var21 = View
    local tbl13 = { tag = "row gap-small size-full-0 auto-y", LayoutOrder = 1 }

    local tbl14 = {
        SendButton = React.createElement(Button, {
            LayoutOrder = 1,
            ref = var6,
            text = var1.Send,
            onActivated = function()
                if amount and robuxBalanceAmount < amount then
                    setTransferPromptState(var2, PromptState.TransferInsufficientBalance)
                    return
                end
                processTransfer(var2, amount or 0)
            end,
            inputDelay = if bool1 then 2.5 else nil,
            variant = ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill
        }),
        EditButton = if bool1 then nil else React.createElement(Button, {
            LayoutOrder = 2,
            text = var1.Edit,
            onActivated = function()
                setTransferPromptState(var2, PromptState.TransferInput)
            end,
            variant = ButtonVariant.Standard,
            fillBehavior = FillBehavior.Fill
        })
    }

    local tbl15 = {
        createElement8(var21, tbl13, tbl14),
        Disclaimer = React.createElement(Foundation.Text, {
            Text = var1.AgeEstimationDisclaimer,
            tag = "wrap size-full-0 auto-y text-caption-small text-wrap text-align-x-left",
            LayoutOrder = 2
        })
    }
    tbl2.Actions = createElement6(actions, tbl11, { createElement7(var20, tbl12, tbl15) })
    return createElement(root, tbl1, tbl2)
end

return TransferRobuxConfirmSheet
