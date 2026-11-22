-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local Players = game:GetService("Players")

local playWithRewardComponent = script:FindFirstAncestor("PlayWithRewardComponent")
local PlayWithRewardBlackoutCurtain = require(playWithRewardComponent.PlayWithRewardBlackoutCurtain)
local PlayWithRewardCoachmark = require(playWithRewardComponent.PlayWithRewardCoachmark)
local PlayWithRewardTelemetry = require(playWithRewardComponent.PlayWithRewardTelemetry)
local shouldRenderPlayWithRewardBanner = require(playWithRewardComponent.shouldRenderPlayWithRewardBanner)

local playWithRewardComponentParent = playWithRewardComponent.Parent
local PlayWithRewardState = require(playWithRewardComponentParent.PlayWithRewardState)
local Foundation = require(playWithRewardComponentParent.Foundation)
local GamePlayButton = require(playWithRewardComponentParent.GamePlayButton)
local React = require(playWithRewardComponentParent.React)
local RobloxAppHooks = require(playWithRewardComponentParent.RobloxAppHooks)
local RobloxAppUpdate = require(playWithRewardComponentParent.RobloxAppUpdate)
local RoactServiceTags = require(playWithRewardComponentParent.RoactServiceTags)
local RoactUtils = require(playWithRewardComponentParent.RoactUtils)
local SharedFlags = require(playWithRewardComponentParent.SharedFlags)

local SetPlayWithRewardState = PlayWithRewardState.SetPlayWithRewardState

local Button = Foundation.Button
local Enums = Foundation.Enums
local Icon = Foundation.Icon
local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local PlayButtonReferralSource = GamePlayButton.PlayButtonReferralSource
local usePlayButtonLaunchGame = GamePlayButton.usePlayButtonLaunchGame
local RoactAnalytics = RoactServiceTags.RoactAnalytics
local AppUpdateService = RoactServiceTags.AppUpdateService
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useRoactService = RobloxAppHooks.useRoactService
local HandleUpdate = RobloxAppUpdate.HandleUpdate

local engineFeature = game:GetEngineFeature("CanPerformBinaryUpdateEnabled")

local FIntPlayWithRewardFallbackBannerProductImageAssetId = SharedFlags.FIntPlayWithRewardFallbackBannerProductImageAssetId
local num1 = game:DefineFastInt("LuaAppPlayWithRewardMobileEdpLayoutOrder", 120)
local FFlagEnablePlayWithRewardNonPeekviewEdp = SharedFlags.FFlagEnablePlayWithRewardNonPeekviewEdp
local FFlagSduiPlayWithReward = SharedFlags.FFlagSduiPlayWithReward
local FFlagLuaAppEnableContainedRewardUi = PlayWithRewardState.FFlagLuaAppEnableContainedRewardUi

function PlayWithRewardComponent(tbl1)
    local var1 = useTokens()
    local var2 = useRoactService(RoactAnalytics)
    local var3 = useRoactService(AppUpdateService)
    local var4 = useDispatch()
    local localPlayer = Players.LocalPlayer
    local var5 = React.useRef(nil)

    local var6 = React.useRef(false)

    local playWithRewardAdData = tbl1.playWithRewardAdData
    local productId = playWithRewardAdData and playWithRewardAdData.productId or ""
    local variantId = playWithRewardAdData
        and playWithRewardAdData.experimentVariantData
        and playWithRewardAdData.experimentVariantData.variantId
        or ""
    local isAdDataExpected = not (tbl1.flowId == "") and tbl1.isAdDataExpected
    local bool1

    if FFlagEnablePlayWithRewardNonPeekviewEdp then
        bool1 = shouldRenderPlayWithRewardBanner(tbl1.universeId, tbl1.flowId, tbl1.fetchedUniverseId, tbl1.playWithRewardAdData)
    else
        local bool2

        if localPlayer == nil
            or tbl1.flowId == ""
            or tbl1.fetchedUniverseId == nil
            or tbl1.fetchedUniverseId ~= tbl1.universeId
            or playWithRewardAdData == nil
            or playWithRewardAdData.adAvailabilityResult ~= Enum.AdAvailabilityResult.IsAvailable
            or playWithRewardAdData.experimentVariantData == nil
            or playWithRewardAdData.experimentVariantData.titleText == ""
                and playWithRewardAdData.experimentVariantData.subtitleText == ""
        then
            bool2 = false
        else
            bool2 = (tonumber(productId) or 0) ~= 0
        end

        bool1 = bool2
    end

    local var7 = tbl1.placeIdOverride or tbl1.placeId
    local var8 = usePlayButtonLaunchGame(
        tbl1.universeId,
        var7,
        tbl1.placeId,
        PlayButtonReferralSource.PlayWithReward,
        "PlayWithRewardGameDetails",
        "PlayWithRewardButton",
        tbl1.experienceJoinData
    )

    React.useEffect(function()
        if bool1 then
            var6.current = true
            PlayWithRewardTelemetry.logPlayWithRewardBannerShown(tbl1.flowId, tbl1.universeId, "startShow", productId, variantId)
        end

        return function()
            if var6.current then
                var6.current = false
                PlayWithRewardTelemetry.logPlayWithRewardBannerShown(tbl1.flowId, tbl1.universeId, "endShow", productId, variantId)
            end
        end
    end, {
        bool1,
        tbl1.flowId,
        tbl1.universeId,
        productId,
        variantId
    })
    local var9 = if playWithRewardAdData then playWithRewardAdData.productName else ""
    local var10 = if playWithRewardAdData then playWithRewardAdData.productImageAssetId else ""
    local bool2 = var10 == ""

    local onActivated = React.useCallback(function()
        HandleUpdate(var4, var3, engineFeature, var2, "PlayWithRewardGameDetails", function() -- name: showAdThenLaunch
            PlayWithRewardTelemetry.logPlayWithRewardBlackoutCurtainAction(tbl1.flowId, tbl1.universeId, "shown", productId)

            PlayWithRewardBlackoutCurtain.show()

            PlayWithRewardTelemetry.logPlayWithRewardButtonClicked(tbl1.flowId, tbl1.universeId, productId)

            local success, result = pcall(function(): Enum.ShowAdResult
                var4(SetPlayWithRewardState(tbl1.flowId, tbl1.universeId, false, nil))
                PlayWithRewardTelemetry.logPlayWithRewardAdPlaybackAttempted(tbl1.flowId, tbl1.universeId, productId)

                return AdService:ShowRewardedVideoAdAtClientAsync(tbl1.universeId)
            end)

            pcall(function()
                PlayWithRewardTelemetry.logPlayWithRewardAdPlaybackStopped(tbl1.flowId, tbl1.universeId, tostring(result), productId)

                AdService:SubmitAdNotification(
                    tonumber(tbl1.universeId) or 0,
                    success and result ~= nil,
                    result == Enum.ShowAdResult.ShowCompleted,
                    var9,
                    if bool2 then FIntPlayWithRewardFallbackBannerProductImageAssetId else tonumber(var10) or FIntPlayWithRewardFallbackBannerProductImageAssetId
                )
            end)

            PlayWithRewardTelemetry.logPlayWithRewardBlackoutCurtainAction(tbl1.flowId, tbl1.universeId, "hidden", productId)

            PlayWithRewardBlackoutCurtain.hide()

            if var8 then
                PlayWithRewardTelemetry.logPlayWithRewardGameJoinInitiated(tbl1.flowId, tbl1.universeId, productId)

                var8(nil)
            end
        end)
    end, {
        tbl1.flowId,
        tbl1.universeId,
        var4,
        var3,
        var2,
        var8,
        var10,
        var9,
        bool2,
        productId
    })

    local var12 = nil
    local offset = nil
    local xOffset = nil
    local var13 = nil

    local var14 = nil
    local var15 = nil
    local var16 = nil
    local var17 = nil
    local var18 = nil
    local var19 = nil

    local var20 = nil
    local offset2 = nil
    local var21 = if FFlagLuaAppEnableContainedRewardUi then if tbl1.useLargerStyles then 108 else 76 else nil

    if not FFlagLuaAppEnableContainedRewardUi then
        local var22

        if tbl1.useLargerStyles then
            offset = var1.Padding.XLarge
            xOffset = var1.Padding.XLarge
            var13 = var1.Padding.XLarge
            var22 = var1.Gap.XLarge

            var20 = var1.Size.Size_1200
            var12 = 98
            var14 = "padding-top-large"
            var17 = "gap-xxsmall"
            var18 = true
            var19 = "size-1000-1200"
            var16 = "text-body-medium"
            var15 = "text-heading-small"
        else
            offset = var1.Padding.Medium
            xOffset = var1.Padding.Small
            var13 = var1.Padding.Medium
            var22 = var1.Gap.Medium

            var20 = var1.Size.Size_1000
            var12 = 66
            var14 = "padding-top-medium"
            var17 = ""
            var18 = false
            var19 = "size-800-1000"
            var16 = "text-body-small"
            var15 = "text-title-medium"
        end

        offset2 = xOffset + var12 + var22
    end

    local layoutOrder = if FFlagSduiPlayWithReward then tbl1.layoutOrder or num1 else num1

    if isAdDataExpected then
        local createElement = React.createElement
        local var23 = Skeleton
        local tbl2 = { tag = 0, Size = 0, LayoutOrder = 0 }
        if FFlagLuaAppEnableContainedRewardUi then
            var14 = nil
        end

        tbl2.tag = var14
        local new = UDim2.new
        local num2 = 1
        local num3 = 0
        local num4 = 0
        if not FFlagLuaAppEnableContainedRewardUi then
            var21 = var20 + offset * 2 + var13
        end

        tbl2.Size = new(num2, num3, num4, var21)

        tbl2.LayoutOrder = layoutOrder
        return createElement(var23, tbl2)
    end

    if not bool1 then
        return nil
    end

    local titleText = playWithRewardAdData.experimentVariantData.titleText
    local subtitleText = playWithRewardAdData.experimentVariantData.subtitleText
    local buttonText = playWithRewardAdData.experimentVariantData.buttonText
    local coachmarkTitleText = playWithRewardAdData.experimentVariantData.coachmarkTitleText
    local coachmarkSubtitleText = playWithRewardAdData.experimentVariantData.coachmarkSubtitleText
    local showButton = playWithRewardAdData.experimentVariantData.showButton
    local keepRewardContained = FFlagLuaAppEnableContainedRewardUi and playWithRewardAdData.experimentVariantData.keepRewardContained
    local localUserId = if localPlayer then localPlayer.UserId else 0
    local bool3 = not (coachmarkTitleText == "") and coachmarkSubtitleText ~= ""

    if FFlagLuaAppEnableContainedRewardUi then
        local var23

        if tbl1.useLargerStyles then
            var12 = if keepRewardContained then 76 else 98
            if keepRewardContained then
                offset = var1.Padding.Large
            else
                offset = var1.Padding.XLarge
            end

            xOffset = var1.Padding.XLarge
            var13 = var1.Padding.XLarge
            var23 = var1.Gap.XLarge
            var17 = "gap-xxsmall"
            var18 = true
            var19 = "size-1000-1200"
            var16 = "text-body-medium"
            var15 = if keepRewardContained then "text-title-large" else "text-heading-small"
            var14 = "padding-top-large"
        else
            var12 = if keepRewardContained then 60 else 66
            if keepRewardContained then
                offset = var1.Padding.Small
            else
                offset = var1.Padding.Medium
            end

            xOffset = var1.Padding.Small
            var13 = var1.Padding.Medium
            var23 = var1.Gap.Medium
            var17 = ""
            var18 = false
            var19 = "size-800-1000"
            var16 = "text-body-small"
            var15 = "text-title-medium"
            var14 = "padding-top-medium"
        end

        offset2 = xOffset + var12 + var23
    end

    local element

    if bool2 then
        element = React.createElement(Icon, {
            name = Enums.IconName.GiftBox,
            size = var12,
            Position = if keepRewardContained then nil else UDim2.fromOffset(xOffset, -var13),
            ZIndex = 2
        })
    else
        element = React.createElement(Image, {
            Size = UDim2.fromOffset(var12, var12),
            Position = if keepRewardContained then nil else UDim2.fromOffset(xOffset, -var13),
            Image = "rbxassetid://" .. var10,
            BackgroundTransparency = 1,
            ZIndex = 2
        })
    end

    local createElement = React.createElement
    local var23 = View
    local tbl2 = {
        tag = if keepRewardContained then "size-full-0 auto-y" else `size-full-0 auto-y {var14}`,
        LayoutOrder = layoutOrder
    }
    local tbl3 = { Banner = 0, PlayWithRewardCoachmark = 0 }
    local createElement2 = React.createElement
    local var24 = View
    local tbl4 = {
        tag = "size-full-0 auto-y radius-medium no-clip bg-shift-300",
        onActivated = if showButton then nil else onActivated,
        ref = var5
    }
    local tbl5 = {
        ProductImage = if keepRewardContained then nil else element,
        ContentView = 0
    }
    local createElement3 = React.createElement
    local var25 = View
    local tbl6 = {
        tag = "row align-y-center gap-medium size-full-0 auto-y",
        padding = not keepRewardContained
            and {
                left = UDim.new(0, offset2),
                top = UDim.new(0, offset),
                right = UDim.new(0, offset),
                bottom = UDim.new(0, offset)
            }
            or offset
    }
    local tbl7 = { ContainedProductImage = 0, TextContainer = 0, ClickableIndicator = 0 }
    if not keepRewardContained then
        element = nil
    end

    tbl7.ContainedProductImage = element
    tbl7.TextContainer = React.createElement(View, {
        tag = `col fill auto-y {var17}`,
        LayoutOrder = 1
    }, {
        RewardTitle = if titleText == "" then nil else React.createElement(
            FoundationText,
            {
                tag = `auto-xy text-wrap text-align-x-left content-emphasis {var15}`,
                Text = titleText,
                LayoutOrder = 1
            }
        ),
        RewardDescription = if subtitleText == "" then nil else React.createElement(FoundationText, {
            tag = `auto-xy text-wrap text-align-x-left content-emphasis {var16}`,
            Text = subtitleText,
            LayoutOrder = 2
        })
    })
    local element2

    if showButton then
        element2 = React.createElement(Button, {
            text = buttonText,
            onActivated = onActivated,
            variant = Enums.ButtonVariant.SoftEmphasis,
            size = if var18 then Enums.InputSize.Large else Enums.InputSize.Medium,
            LayoutOrder = 2
        })
    else
        local createElement4 = React.createElement
        local var26 = View
        local tbl8 = {
            tag = `align-x-center align-y-center {var19}`,
            LayoutOrder = 2
        }
        local tbl9 = {
            Icon = React.createElement(Icon, {
                name = Enums.IconName.ChevronLargeRight,
                style = var1.Color.Content.Emphasis,
                size = if var18 then Enums.IconSize.Large else Enums.IconSize.Medium
            })
        }
        element2 = createElement4(var26, tbl8, tbl9)
    end

    tbl7.ClickableIndicator = element2
    tbl5.ContentView = createElement3(var25, tbl6, tbl7)
    tbl3.Banner = createElement2(var24, tbl4, tbl5)

    tbl3.PlayWithRewardCoachmark = if bool3 then React.createElement(PlayWithRewardCoachmark, {
        anchorRef = var5,
        flowId = tbl1.flowId,
        localUserId = localUserId,
        productId = productId,
        title = coachmarkTitleText,
        text = coachmarkSubtitleText,
        universeId = tbl1.universeId
    }) else nil
    return createElement(var23, tbl2, tbl3)
end

return PlayWithRewardComponent
