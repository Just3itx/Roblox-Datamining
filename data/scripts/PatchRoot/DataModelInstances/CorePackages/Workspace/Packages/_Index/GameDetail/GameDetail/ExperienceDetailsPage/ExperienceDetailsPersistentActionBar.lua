-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local Foundation = require(GameDetailParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonSize = Foundation.Enums.ButtonSize
local useTokens = Foundation.Hooks.useTokens

local GamePlayButton = require(GameDetailParent.GamePlayButton)
local PlayButton = GamePlayButton.PlayButton
local usePlayButtonState = GamePlayButton.usePlayButtonState
local usePlayButtonContextualMessage = GamePlayButton.usePlayButtonContextualMessage
local PlayButtonContextualMessageImpressionsDetector = GamePlayButton.PlayButtonContextualMessageImpressionsDetector
local PlusEarlyAccessUpsellBanner = GamePlayButton.PlusEarlyAccessUpsellBanner

local ExperienceDetailsPageConstants = require(script.Parent.ExperienceDetailsPageConstants)
local ExperienceDetailsFallbackActionBar = require(script.Parent.Fallback.ExperienceDetailsFallbackActionBar)

local SduiFeatureEntryPoint = require(GameDetailParent.SduiSharedUtilities).SduiFeatureEntryPoint

local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage

local useRoactService = require(GameDetailParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(GameDetailParent.RoactServiceTags)

local SharedFlags = require(GameDetailParent.SharedFlags)
local FFlagLuaAppLaunchWhenLoadingEdp = SharedFlags.FFlagLuaAppLaunchWhenLoadingEdp
local FFlagEnableGameJoinEarlyAccess = SharedFlags.FFlagEnableGameJoinEarlyAccess
local FFlagEnableSplitPaneEDPFix = SharedFlags.FFlagEnableSplitPaneEDPFix

local str1 = if FFlagEnableSplitPaneEDPFix then "col size-full-0 auto-y gap-small bg-surface-0 align-x-center padding-x-medium padding-top-medium" else "col size-full-0 auto-y gap-small bg-surface-0 align-x-center padding-x-medium padding-top-medium stroke-default"

local function PersistentActionBarContextualMessage(tbl1)
    local var1 = useRoactService(RoactServiceTags.RoactNetworking)
    local var2 = useTokens()
    local var3 = React.useRef(nil)

    local var4 = usePlayButtonState(var1, tbl1.universeId)
    local contextualMessage = usePlayButtonContextualMessage(tbl1.universeId, var4.playButtonState, var4.playabilityStatus)

    if contextualMessage == nil or contextualMessage == "" then
        return nil
    end

    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-xy",
            LayoutOrder = 2,
            testId = "--edp-persistent-action-bar-contextual-message"
        },
        {
            Text = React.createElement(FoundationText, {
                tag = "auto-xy text-body-medium text-wrap text-align-x-left",
                textStyle = var2.Color.Content.Emphasis,
                Text = contextualMessage,
                ref = var3
            }),
            ImpressionsDetector = React.createElement(PlayButtonContextualMessageImpressionsDetector, {
                containerRef = var3,
                universeId = tbl1.universeId,
                playabilityStatus = var4.playabilityStatus,
                contextualMessage = contextualMessage,
                pageContext = AppPage.GameDetail,
                scrollViewPositionChangedSignal = nil
            })
        }
    )
end

return React.memo(function(tbl1) -- name: ExperienceDetailsPersistentActionBar
    local playBtn = React.createElement(PlayButton, {
        universeId = tbl1.universeId,
        referralSource = tbl1.referralSource,
        launchSource = tbl1.launchSource,
        experienceJoinData = tbl1.experienceJoinData,
        useUIBloxButton = true,
        placeId = tbl1.placeIdOverride,
        buttonSize = ButtonSize.Large,
        fillBehavior = Foundation.Enums.FillBehavior.Fill,
        launchWhenLoading = if FFlagLuaAppLaunchWhenLoadingEdp then true else nil,
        launchOnReleaseAfterUnmount = true,
        enableEarlyAccessPlusTooltip = if FFlagEnableGameJoinEarlyAccess then true else nil,
        enableEarlyAccessState = if FFlagEnableGameJoinEarlyAccess then true else nil,
        testId = "--edp-persistent-play-button"
    })

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        [React.Change.AbsoluteSize] = tbl1.onAbsoluteSizeChange
    }
    local tbl3 = {
        Content = React.createElement(View, {
            tag = if FFlagEnableSplitPaneEDPFix then {
                [str1] = true,
                ["stroke-default"] = tbl1.showOutline ~= false,
                ["padding-bottom-xsmall"] = FFlagEnableGameJoinEarlyAccess
            } elseif FFlagEnableGameJoinEarlyAccess then str1 .. " padding-bottom-xsmall" else str1,
            testId = "--edp-persistent-action-bar"
        }, {
            Row = React.createElement(View, {
                tag = "row size-full-0 auto-y gap-small",
                LayoutOrder = 1
            }, {
                EntryPoint = React.createElement(SduiFeatureEntryPoint, {
                    appPage = AppPage.GameDetail,
                    configKey = tbl1.configKey,
                    identifier = ExperienceDetailsPageConstants.EDP_ACTION_BAR_IDENTIFIER,
                    loadTimer = tbl1.loadTimer,
                    Size = UDim2.fromScale(0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    LayoutOrder = 1,
                    loadingSlot = React.createElement(ExperienceDetailsFallbackActionBar.Skeleton, {
                        universeId = tbl1.universeId,
                        launchSource = tbl1.launchSource,
                        referralSource = tbl1.referralSource,
                        experienceJoinData = tbl1.experienceJoinData,
                        placeIdOverride = tbl1.placeIdOverride
                    }),
                    errorSlot = React.createElement(ExperienceDetailsFallbackActionBar.Error, {
                        universeId = tbl1.universeId,
                        launchSource = tbl1.launchSource,
                        referralSource = tbl1.referralSource,
                        experienceJoinData = tbl1.experienceJoinData,
                        placeIdOverride = tbl1.placeIdOverride
                    })
                }),
                PersistentPlayButton = React.createElement(View, { tag = "grow auto-y", LayoutOrder = 2 }, { PlayBtn = playBtn })
            }),
            ContextualMessage = React.createElement(PersistentActionBarContextualMessage, { universeId = tbl1.universeId }),
            PlusUpsell = if FFlagEnableGameJoinEarlyAccess then React.createElement(PlusEarlyAccessUpsellBanner, { universeId = tbl1.universeId, LayoutOrder = 3 }) else nil
        })
    }
    return createElement(str2, tbl2, tbl3)
end)
