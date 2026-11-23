-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local AssetCardTypes = require(AppChat.Components.ChatConversation.AssetCardView.AssetCardTypes)
local _MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)
local loadFoundationCloudAsset = require(AppChat.Utils.loadFoundationCloudAsset)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId

local FIntPlusReferralRewardRobux = require(AppChatParent.SharedFlags).FIntPlusReferralRewardRobux

local FFlagEnablePlusReferralEntrypointTelemetry = require(AppChatParent.SharedFlags).FFlagEnablePlusReferralEntrypointTelemetry
local FFlagAppChatPlusReferralHideSenderJoin = require(AppChat.Flags.FFlagAppChatPlusReferralHideSenderJoin)
local FFlagAppChatPlusReferralLargerPictogram = require(AppChat.Flags.FFlagAppChatPlusReferralLargerPictogram)

local function usePlusReferralAssetCardViewModel(tbl1)
    local image = React.useMemo(function(): Content
        local uri = loadFoundationCloudAsset("pictograms/plus_robux")
        return Content.fromUri(uri)
    end, {})

    local var2 = useLocalization({
        title = {
            "Feature.RobloxSubscription.Heading.ReferralRecipientEntry",
            amount = tostring(FIntPlusReferralRewardRobux)
        },
        join = "Feature.Chat.Drawer.Join"
    })

    local var3 = useIsInExperience()
    local var4 = if FFlagAppChatPlusReferralHideSenderJoin then useLocalUserId() else nil
    local var5 = FFlagAppChatPlusReferralHideSenderJoin and tostring(var4) == tbl1.referrerId
    local referrerId = tbl1.referrerId
    local onActivated = React.useCallback(function()
        local robloxSubscriptionPurchaseApp = require(AppChatParent.RobloxSubscriptionPurchaseApp)
        robloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase(
            nil,
            nil,
            nil,
            robloxSubscriptionPurchaseApp.SurfaceName.PlusReferralLandingSheet,
            if var3 then robloxSubscriptionPurchaseApp.SurfaceContext.InGame else robloxSubscriptionPurchaseApp.SurfaceContext.InApp,
            nil,
            FFlagEnablePlusReferralEntrypointTelemetry and {
                entrypoint = robloxSubscriptionPurchaseApp.Entrypoint.AppChat
            } or nil,
            tonumber(referrerId)
        )
    end, { referrerId, var3 })

    local var1 = if var5 then nil else onActivated

    return React.useMemo(function()
        return {
            status = AssetCardTypes.Status.Ready,
            groupShape = tbl1.groupShape,
            mediaRef = tbl1.mediaRef,
            media = {
                image = image,
                aspectRatio = 1,
                isPictogram = true,
                pictogramScale = if FFlagAppChatPlusReferralLargerPictogram then 1 else nil,
                onActivated = var1,
                isSelectable = not var5
            },
            footer = {
                titleText = var2.title,
                titleMaxLines = 2,
                onActivated = var1,
                action = not var5 and {
                    label = var2.join,
                    onActivated = onActivated,
                    isSelectable = false
                } or nil
            }
        }
    end, {
        tbl1.groupShape,
        tbl1.mediaRef,
        image,
        var2.title,
        var2.join,
        onActivated,
        var5,
        var1
    })
end

return usePlusReferralAssetCardViewModel
