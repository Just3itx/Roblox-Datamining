-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildExperienceDevProductRecovery = require(BuildExperience.Flags.FFlagBuildExperienceDevProductRecovery)

local FFlagCreatorAgentChatMonetizationToolHelpers = require(BuildExperience.Flags.FFlagCreatorAgentChatMonetizationToolHelpers)
local FoundationCloudAssets = if FFlagBuildExperienceMonetizationNativeUI then require(BuildExperienceParent.FoundationCloudAssets) else nil
local LocalizationService = game:GetService("LocalizationService")
local LocalizationRoactContext = Localization.LocalizationRoactContext
local NumberLocalization = Localization.NumberLocalization
local useLocalization = Localization.Hooks.useLocalization

local AgentCard = require(script.Parent.AgentCard)
local AgentCardActions = require(script.Parent.AgentCardActions)
local ChatCardPriority = require(BuildExperience.Components.Chat.ChatCardEmphasis.ChatCardPriority)
local useChatCardEmphasis = require(BuildExperience.Components.Chat.ChatCardEmphasis.useChatCardEmphasis)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)

local FFlagBuildExperienceMonetizationFailureCauses = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationFailureCauses)

local FFlagBuildExperienceMonetizationCardFixes = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationCardFixes)
local Button = Foundation.Button
local Image = Foundation.Image
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local assetId = nil
if FFlagBuildExperienceMonetizationNativeUI then
    FoundationCloudAssets.preloadAsset("pictograms/robux")
    assetId = FoundationCloudAssets.Assets["pictograms/robux"].assetId
end

local tbl1 = {
    title = LocalizationStrings.AGENT_DEV_PRODUCT_TITLE,
    create = LocalizationStrings.AGENT_DEV_PRODUCT_CREATE,
    update = LocalizationStrings.AGENT_DEV_PRODUCT_UPDATE,
    activate = LocalizationStrings.AGENT_DEV_PRODUCT_ACTIVATE,
    deactivate = LocalizationStrings.AGENT_DEV_PRODUCT_DEACTIVATE
}

local tbl2 = {
    gamePass = {
        title = LocalizationStrings.AGENT_GAME_PASS_TITLE,
        create = LocalizationStrings.AGENT_GAME_PASS_CREATE,
        update = LocalizationStrings.AGENT_GAME_PASS_UPDATE,
        activate = LocalizationStrings.AGENT_GAME_PASS_ACTIVATE,
        deactivate = LocalizationStrings.AGENT_GAME_PASS_DEACTIVATE
    },
    subscription = {
        title = LocalizationStrings.AGENT_SUBSCRIPTION_TITLE,
        create = LocalizationStrings.AGENT_SUBSCRIPTION_CREATE,
        update = LocalizationStrings.AGENT_SUBSCRIPTION_UPDATE,
        activate = LocalizationStrings.AGENT_SUBSCRIPTION_ACTIVATE,
        deactivate = LocalizationStrings.AGENT_SUBSCRIPTION_DEACTIVATE,
        deactivateCancelRenewals = LocalizationStrings.AGENT_SUBSCRIPTION_DEACTIVATE_CANCEL_RENEWALS,
        delete = LocalizationStrings.AGENT_SUBSCRIPTION_DELETE
    }
}

local tbl3 = {
    consumable = LocalizationStrings.AGENT_SUBSCRIPTION_PRODUCT_TYPE_CONSUMABLE,
    currency = LocalizationStrings.AGENT_SUBSCRIPTION_PRODUCT_TYPE_CURRENCY,
    durable = LocalizationStrings.AGENT_SUBSCRIPTION_PRODUCT_TYPE_DURABLE
}

local function summaryKeys(tbl4) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1

    if tbl4.itemKind ~= nil then
        var1 = tbl2[tbl4.itemKind]

        if not var1 then
            return tbl1
        end
    else
        var1 = tbl1
    end

    return var1
end

local function idActionKey(tbl4, tbl5) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl5.action == "create" or tbl5.action == "update" or tbl5.action == "title" then
        return nil
    end

    if tbl5.action == "deactivate" and tbl5.cancelRenewals == true and tbl4.deactivateCancelRenewals ~= nil then
        return tbl4.deactivateCancelRenewals
    end

    return tbl4[tbl5.action]
end

local function itemIdText(tbl4) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl4.itemId or tostring(tbl4.productId)
end

local function formatSummary(arg1, str1: string, tbl4) -- Luacid: Inlined by compiler; 4 call sites recovered
    return arg1:Format(str1, tbl4)
end

local function formatPrice(priceInRobux: number) -- Luacid: Inlined by compiler; 6 call sites recovered
    return NumberLocalization.localize(tostring(priceInRobux), LocalizationService.RobloxLocaleId)
end

local function kindText(tbl4, arg1)
    return formatSummary(
        arg1,
        LocalizationStrings.AGENT_SUBSCRIPTION_PRODUCT_TYPE,
        {
            PRODUCT_TYPE = formatSummary(arg1, summaryKeys(tbl4).title, {})
        }
    )
end

local function createCardTitle(tbl4, arg1, str1: string, price: string) -- Luacid: unused: defined but never referenced
    local func1 = formatSummary
    local agentMonetizationCreateTitle = LocalizationStrings.AGENT_MONETIZATION_CREATE_TITLE
    local tbl5 = {
        NAME = tbl4.name or str1,
        PRICE = 0
    }

    if tbl4.priceInRobux ~= nil then
        price = formatPrice(tbl4.priceInRobux)
    end

    tbl5.PRICE = price
    return func1(arg1, agentMonetizationCreateTitle, tbl5)
end

local function appendSubscriptionProductType(tbl4, tbl5, arg1)
    if tbl5.itemKind ~= "subscription" or tbl5.productType == nil then
        return
    end
    local var1 = tbl3[tbl5.productType]
    if var1 == nil then
        return
    end

    table.insert(
        tbl4,
        formatSummary(
            arg1,
            LocalizationStrings.AGENT_SUBSCRIPTION_PRODUCT_TYPE,
            {
                PRODUCT_TYPE = formatSummary(arg1, var1, {})
            }
        )
    )
end

local function devProductSummaryText(tbl4, arg1, defaultName: string, price: string)
    local action = tbl4.action
    if action == "create" then
        local name = tbl4.name or defaultName
        if tbl4.priceInRobux ~= nil then
            price = formatPrice(tbl4.priceInRobux)
        end

        if FFlagBuildExperienceMonetizationNativeUI then
            local var2 = formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_PRICE, { PRICE = price })
            if FFlagBuildExperienceMonetizationCardFixes then
                return `{var2}\n{kindText(tbl4, arg1)}`
            end

            return var2
        end
        local tbl5 = { formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_CREATE, { NAME = name, PRICE = price }) }

        if tbl4.description ~= nil then
            table.insert(
                tbl5,
                formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_DESCRIPTION, { DESCRIPTION = tbl4.description })
            )
        end

        return table.concat(tbl5, "\n")
    end

    if action ~= "update" then
        if action == "activate" then
            local productId = tostring(tbl4.productId)
            return formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_ACTIVATE, { PRODUCT_ID = productId })
        end
        if action ~= "deactivate" then
            return formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_MANAGE, {})
        end

        local productId = tostring(tbl4.productId)
        return formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_DEACTIVATE, { PRODUCT_ID = productId })
    end

    local productId = tostring(tbl4.productId)
    local tbl5 = { formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_UPDATE, { PRODUCT_ID = productId }) }

    if tbl4.name ~= nil then
        table.insert(tbl5, formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_NAME, { NAME = tbl4.name }))
    end

    if tbl4.description ~= nil then
        table.insert(
            tbl5,
            formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_DESCRIPTION, { DESCRIPTION = tbl4.description })
        )
    end

    if tbl4.priceInRobux ~= nil then
        local var1 = formatPrice(tbl4.priceInRobux)
        table.insert(tbl5, formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_PRICE, { PRICE = var1 }))
    end

    return table.concat(tbl5, "\n")
end

local function itemSummaryText(tbl4, arg1, defaultName: string, price: string)
    local action = tbl4.action
    local var1 = summaryKeys(tbl4)

    if action == "create" then
        local name = tbl4.name or defaultName
        if tbl4.priceInRobux ~= nil then
            price = formatPrice(tbl4.priceInRobux)
        end

        local tbl5 = FFlagBuildExperienceMonetizationNativeUI
            and { formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_PRICE, { PRICE = price }) }
            or { formatSummary(arg1, var1.create, { NAME = name, PRICE = price }) }
        if FFlagBuildExperienceMonetizationCardFixes and FFlagBuildExperienceMonetizationNativeUI then
            table.insert(tbl5, kindText(tbl4, arg1))
        end
        appendSubscriptionProductType(tbl5, tbl4, arg1)
        if FFlagBuildExperienceMonetizationNativeUI then
            return table.concat(tbl5, "\n")
        end
        if tbl4.description ~= nil then
            table.insert(
                tbl5,
                formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_DESCRIPTION, { DESCRIPTION = tbl4.description })
            )
        end

        return table.concat(tbl5, "\n")
    elseif action == "update" then
        local tbl5 = { formatSummary(arg1, var1.update, { PRODUCT_ID = itemIdText(tbl4) }) }

        if tbl4.name ~= nil then
            table.insert(tbl5, formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_NAME, { NAME = tbl4.name }))
        end

        if tbl4.description ~= nil then
            table.insert(
                tbl5,
                formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_DESCRIPTION, { DESCRIPTION = tbl4.description })
            )
        end

        if tbl4.priceInRobux ~= nil then
            local var2 = formatPrice(tbl4.priceInRobux)
            table.insert(tbl5, formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_PRICE, { PRICE = var2 }))
        end

        return table.concat(tbl5, "\n")
    else
        local var2 = idActionKey(var1, tbl4)

        if var2 ~= nil then
            return formatSummary(arg1, var2, { PRODUCT_ID = itemIdText(tbl4) })
        end
        return formatSummary(arg1, LocalizationStrings.AGENT_DEV_PRODUCT_MANAGE, {})
    end
end

local function summaryText(tbl4, arg1, defaultName: string, unavailablePrice: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not FFlagCreatorAgentChatMonetizationToolHelpers and tbl4.itemKind == nil then
        return devProductSummaryText(tbl4, arg1, defaultName, unavailablePrice)
    end
    return itemSummaryText(tbl4, arg1, defaultName, unavailablePrice)
end

local function AgentDevProductCard(tbl4)
    local var1 = React.useContext(LocalizationRoactContext)
    local var2 = useLocalization({
        title = summaryKeys(tbl4).title,
        approve = LocalizationStrings.AGENT_DEV_PRODUCT_APPROVE,
        reject = if FFlagBuildExperienceMonetizationNativeUI then LocalizationStrings.MONETIZATION_CANCEL else LocalizationStrings.AGENT_DEV_PRODUCT_REJECT,
        defaultName = LocalizationStrings.AGENT_DEV_PRODUCT_DEFAULT_NAME,
        unavailablePrice = LocalizationStrings.AGENT_DEV_PRODUCT_PRICE_UNAVAILABLE,
        preview = if FFlagBuildExperienceMonetizationNativeUI then LocalizationStrings.GAME_CONFIGURATION_PREVIEW else nil,
        create = if FFlagBuildExperienceMonetizationNativeUI then LocalizationStrings.MONETIZATION_EMPTY_CREATE_PRODUCT else nil,
        error = if FFlagBuildExperienceDevProductRecovery then LocalizationStrings.BUILD_ELIGIBILITY_ERROR_TITLE else nil,
        retry = if FFlagBuildExperienceDevProductRecovery then LocalizationStrings.MONETIZATION_RETRY else nil,
        imageInReview = if FFlagBuildExperienceMonetizationFailureCauses then LocalizationStrings.MONETIZATION_CAUSE_IMAGE_IN_REVIEW else nil,
        imagePreparing = if FFlagBuildExperienceMonetizationFailureCauses then LocalizationStrings.MONETIZATION_CAUSE_IMAGE_PREPARING else nil,
        imageTooLarge = if FFlagBuildExperienceMonetizationFailureCauses then LocalizationStrings.MONETIZATION_CAUSE_IMAGE_TOO_LARGE else nil,
        imageTimedOut = if FFlagBuildExperienceMonetizationFailureCauses then LocalizationStrings.MONETIZATION_CAUSE_IMAGE_TIMED_OUT else nil,
        imageFailed = if FFlagBuildExperienceMonetizationFailureCauses then LocalizationStrings.MONETIZATION_CAUSE_IMAGE_FAILED else nil,
        moderated = if FFlagBuildExperienceMonetizationFailureCauses then LocalizationStrings.MONETIZATION_MODERATION_ERROR else nil,
        noUniverse = if FFlagBuildExperienceMonetizationFailureCauses then LocalizationStrings.MONETIZATION_CAUSE_NO_UNIVERSE else nil,
        rateLimited = if FFlagBuildExperienceMonetizationFailureCauses then LocalizationStrings.MONETIZATION_CAUSE_RATE_LIMITED else nil
    })

    local testId = tbl4.testId or "agent-dev-product-card"
    local var3 = FFlagBuildExperienceDevProductRecovery and tbl4.isPending == true
    local var4 = FFlagBuildExperienceDevProductRecovery and tbl4.canRetry == true
    local bool1 = tbl4.isReadOnly == true
    local var5 = tbl4.isActionDisabled == true or var3
    local isDisabled = var5 or bool1
    local var7 = if FFlagBuildExperienceDevProductRecovery then React.useRef(false) else nil
    local var8 = FFlagBuildExperienceMonetizationNativeUI and tbl4.action == "create"
    local var9 = if FFlagBuildExperienceChatCardEmphasis then useChatCardEmphasis(if isDisabled then nil else ChatCardPriority.AgentProposal) else nil
    local bool2 = false
    local var10 = nil
    local var11

    if FFlagBuildExperienceMonetizationNativeUI then
        bool2, var10 = React.useState(false)
        var11 = React.useCallback(function()
            if var7 ~= nil then
                var7.current = false
            end
            var10(true)
        end, { var10 })
    else
        var11 = nil
    end

    local var12

    if var8 then
        local createElement = React.createElement
        local root = Sheet.Root

        local tbl5 = {
            isOpen = bool2,
            onClose = function()
                if not (FFlagBuildExperienceDevProductRecovery or bool2 or isDisabled) then
                    tbl4.onApprove()
                end
                var10(false)
            end,
            snapPoints = { 0.5, 1 },
            testId = `{testId}-preview`
        }

        local tbl6 = {
            Header = React.createElement(Sheet.Header, nil, {
                Title = React.createElement(FoundationText, {
                    Text = tbl4.name or var2.defaultName,
                    tag = "size-full-0 auto-y text-title-large text-wrap text-align-x-left content-emphasis"
                })
            }),
            Content = 0,
            Actions = 0
        }

        local createElement2 = React.createElement
        local content = Sheet.Content
        local var13 = nil
        local tbl7 = { Details = 0 }
        local createElement3 = React.createElement
        local var14 = View
        local tbl8 = { tag = "col align-x-center gap-large size-full-0 auto-y" }

        local tbl9 = { Image = 0, Price = 0, Description = 0 }
        local element

        if tbl4.imageAssetId ~= nil then
            element = React.createElement(Image, {
                LayoutOrder = 1,
                Image = `rbxassetid://{tbl4.imageAssetId}`,
                ScaleType = Enum.ScaleType.Fit,
                tag = "size-3000-3000 radius-medium",
                testId = `{testId}-preview-image`
            })
        else
            element = React.createElement(Image, {
                LayoutOrder = 1,
                Image = assetId,
                ScaleType = Enum.ScaleType.Fit,
                tag = "size-3000-3000 content-emphasis",
                testId = `{testId}-preview-image`
            })
        end

        tbl9.Image = element

        tbl9.Price = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = summaryText(tbl4, var1, var2.defaultName, var2.unavailablePrice),
            tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left content-emphasis",
            testId = `{testId}-preview-summary`
        })
        tbl9.Description = React.createElement(FoundationText, {
            LayoutOrder = 3,
            Text = tbl4.description or "",
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
            testId = `{testId}-preview-description`
        })
        tbl7.Details = createElement3(var14, tbl8, tbl9)
        tbl6.Content = createElement2(content, var13, tbl7)
        local var15

        if isDisabled then
            var15 = nil
        else
            local createElement4 = React.createElement
            local actions = Sheet.Actions
            local var16 = nil
            local tbl10 = { Create = 0 }
            local createElement5 = React.createElement
            local var17 = Button
            local tbl11 = {
                text = if var4 then var2.retry else var2.create,
                size = InputSize.Large,
                variant = ButtonVariant.Emphasis,
                fillBehavior = FillBehavior.Fill,
                isDisabled = not bool2,
                onActivated = 0,
                testId = 0
            }

            function tbl11.onActivated()
                if isDisabled or not bool2 then
                    return
                end
                if var7 ~= nil then
                    if var7.current then
                        return
                    end
                    var7.current = true
                    tbl4.onApprove()
                end
                var10(false)
            end
            tbl11.testId = `{testId}-create-button`
            tbl10.Create = createElement5(var17, tbl11)
            var15 = createElement4(actions, var16, tbl10)
        end

        tbl6.Actions = var15
        var12 = createElement(root, tbl5, tbl6)
    else
        var12 = nil
    end

    local var13 = React.useCallback(function()
        if isDisabled then
            return
        end
        tbl4.onApprove()
    end, { isDisabled, tbl4.onApprove })

    local onActivated = React.useCallback(function()
        if isDisabled then
            return
        end
        tbl4.onReject()
    end, { isDisabled, tbl4.onReject })

    local createElement = React.createElement
    local var15 = AgentCardActions
    local tbl5 = {
        layoutOrder = if FFlagBuildExperienceDevProductRecovery then 5 elseif var8 then 3 elseif tbl4.imageAssetId == nil then 3 else 4
    }
    local tbl6 = { Approve = 0, Reject = 0 }
    local createElement2 = React.createElement
    local var16 = Button
    local tbl7 = {
        LayoutOrder = 1,
        text = if var4 then var2.retry elseif var8 then var2.preview else var2.approve,
        size = InputSize.Small,
        variant = if var9 == false then ButtonVariant.SoftEmphasis else ButtonVariant.Emphasis,
        fillBehavior = FillBehavior.Fill,
        isDisabled = if var8 then var3 or bool1 else isDisabled,
        onActivated = 0,
        testId = 0
    }

    if var8 and not var4 then
        var13 = var11
    end

    tbl7.onActivated = var13
    tbl7.testId = if var8 then `{testId}-preview-button` else `{testId}-approve-button`
    tbl6.Approve = createElement2(var16, tbl7)

    tbl6.Reject = if var8 and var5 then nil else React.createElement(Button, {
        LayoutOrder = 2,
        text = var2.reject,
        size = InputSize.Small,
        variant = ButtonVariant.Standard,
        fillBehavior = FillBehavior.Fill,
        isDisabled = isDisabled,
        onActivated = onActivated,
        testId = `{testId}-reject-button`
    })
    local element = createElement(var15, tbl5, tbl6)

    local var17 = FFlagBuildExperienceMonetizationCardFixes and FFlagBuildExperienceMonetizationNativeUI and var8

    local createElement3 = React.createElement
    local var18 = AgentCard
    local tbl8 = {
        title = 0,
        fitToContent = 0,
        textContent = 0,
        layoutOrder = 0,
        testId = 0,
        footer = 0
    }
    local title

    if var17 then
        local defaultName = var2.defaultName
        local unavailablePrice = var2.unavailablePrice
        local agentMonetizationCreateTitle = LocalizationStrings.AGENT_MONETIZATION_CREATE_TITLE
        local tbl9 = {
            NAME = tbl4.name or defaultName,
            PRICE = 0
        }

        if tbl4.priceInRobux ~= nil then
            unavailablePrice = formatPrice(tbl4.priceInRobux)
        end

        tbl9.PRICE = unavailablePrice
        title = formatSummary(var1, agentMonetizationCreateTitle, tbl9)
    elseif var8 then
        title = tbl4.name or var2.defaultName
    else
        title = var2.title
    end

    tbl8.title = title

    tbl8.fitToContent = if var8 then true elseif FFlagBuildExperienceMonetizationCardFixes then true else nil
    tbl8.textContent = if var17 then tbl4.description or "" else summaryText(tbl4, var1, var2.defaultName, var2.unavailablePrice)

    tbl8.layoutOrder = tbl4.layoutOrder
    tbl8.testId = testId
    tbl8.footer = if FFlagBuildExperienceDevProductRecovery then element else nil
    local tbl9 = {
        Preview = var12,
        ImagePreview = if var8 or tbl4.imageAssetId == nil then nil else React.createElement(Image, {
            LayoutOrder = 3,
            Image = `rbxassetid://{tbl4.imageAssetId}`,
            ScaleType = Enum.ScaleType.Fit,
            tag = "size-3000-3000 radius-medium",
            testId = `{testId}-image-preview`
        }),
        Error = if FFlagBuildExperienceDevProductRecovery and tbl4.hasError and not var3 then React.createElement(
            FoundationText,
            {
                LayoutOrder = 4,
                Text = (if tbl4.errorCause == nil then nil else var2[tbl4.errorCause]) or var2.error,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-alert",
                testId = `{testId}-error`
            }
        ) else nil,
        Actions = 0
    }

    if FFlagBuildExperienceDevProductRecovery then
        element = nil
    end

    tbl9.Actions = element
    return createElement3(var18, tbl8, tbl9)
end

return AgentDevProductCard
