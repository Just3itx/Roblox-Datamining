-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local AppComposition = require(MomentsParent.AppComposition)
local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local useCompositionLayout = AppComposition.useCompositionLayout
local useTokens = Foundation.Hooks.useTokens
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useStatusBarHeight = MomentsCommon.Hooks.useStatusBarHeight
local useIsTvRemoteDevice = require(MomentsParent.RoactUtils).Hooks.useIsTvRemoteDevice
local useSetDrawerVisible = require(MomentsParent.Drawer).Hooks.useSetDrawerVisible
local useLocalization = Localization.Hooks.useLocalization

local FFlagMomentsCreateAvatarPosts = require(MomentsParent.SharedFlags).FFlagMomentsCreateAvatarPosts
local GetFFlagMomentsAndroidTvEnabled = require(Moments.Flags.GetFFlagMomentsAndroidTvEnabled)
local FFlagMomentsFtuxTooltipCreateCopy = require(Moments.Flags.FFlagMomentsFtuxTooltipCreateCopy)
local FFlagMomentsFixFeedForDeviceSafeInsets = require(Moments.Flags.FFlagMomentsFixFeedForDeviceSafeInsets)
local FFlagMomentsFollowingFeed = require(Moments.Flags.FFlagMomentsFollowingFeed)
local shouldUseDeviceSafeInsets = require(MomentsParent.Display).shouldUseDeviceSafeInsets
local MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local _MomentsHeaderView = require(script.Parent.MomentsHeaderView)
local useTrendingFeedLabel = require(Moments.Hooks.useTrendingFeedLabel)

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent

local tbl1 = {
    title = "Feature.Moments.Tooltip.ShareFirstMomentTitle",
    text = "Feature.Moments.Tooltip.ShareFirstMomentBody"
}

local tbl2 = { following = "Feature.Moments.Label.FeedFollowing" }

local function noop() end

local function getAnalyticsFields() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        userId = tostring(if Players.LocalPlayer then Players.LocalPlayer.UserId else 0),
        timestamp = tostring(os.time()),
        identifier = "create_moment"
    }
end

local function useMomentsHeaderViewModel(tbl3, bool1: boolean, showHamburger: boolean)
    local var1 = useTokens()
    local var2 = useDeviceInsets()
    local var3 = useSetDrawerVisible()
    local var4 = useIsTvRemoteDevice()
    local var5 = useCompositionLayout()
    local offset = useStatusBarHeight()
    local size1400 = var1.Size.Size_1400

    local showFtuxTooltip = tbl3.showFtuxTooltip == true
    local title, text

    if FFlagMomentsFtuxTooltipCreateCopy then
        local var6 = useLocalization(tbl1)
        title = var6.title
        text = var6.text
    else
        title = ""
        text = ""
    end
    local var6 = nil
    local bool3 = false
    local num1 = 0
    if FFlagMomentsFollowingFeed then
        local var7 = useLocalization(tbl2)

        local var8 = useTrendingFeedLabel()
        local onFeedTypeSelected = tbl3.onFeedTypeSelected
        if onFeedTypeSelected ~= nil then
            local var9 = tbl3.selectedFeedType or MomentsFeedType.Trending
            var6 = {
                {
                    id = MomentsFeedType.Trending,
                    text = var8,
                    isChecked = var9 == MomentsFeedType.Trending,
                    onActivated = function()
                        onFeedTypeSelected(MomentsFeedType.Trending)
                    end
                },
                {
                    id = MomentsFeedType.Following,
                    text = var7.following,
                    isChecked = var9 == MomentsFeedType.Following,
                    onActivated = function()
                        onFeedTypeSelected(MomentsFeedType.Following)
                    end
                }
            }

            bool3 = true
            if tbl3.variant == "base" then
                num1 = var1.Size.Size_200
            end
        end
    end
    local var7 = tbl3.onFtuxTooltipDismissed or noop
    local var8 = tbl3.onCreatePressed or noop

    React.useEffect(function()
        if showFtuxTooltip then
            fireAnalyticsEvent(EventNames.FTUXTooltipImpression, (getAnalyticsFields()))
        end
    end, { showFtuxTooltip })

    local onFtuxTooltipClosed = React.useCallback(function()
        fireAnalyticsEvent(EventNames.FTUXTooltipDismissed, (getAnalyticsFields()))
        var7()
    end, { var7 })

    local onCreateMomentButtonPressed = React.useCallback(function()
        if showFtuxTooltip then
            onFtuxTooltipClosed()
        end
        var8()
    end, { showFtuxTooltip, onFtuxTooltipClosed, var8 })

    local onHamburgerPressed = React.useCallback(function()
        var3(true)
    end, { var3 })

    local margin = var5.margin

    local headerPadding = {
        left = UDim.new(0, math.max(var2.left, margin)),
        right = UDim.new(0, math.max(var2.right, margin - num1)),
        top = UDim.new(0, offset)
    }
    local var12 = var2.top + var1.Size.Size_2000 + var1.Size.Size_1600
    if var6 ~= nil then
        var12 += var1.Size.Size_800
    end

    local scrimTopOffset = if FFlagMomentsFixFeedForDeviceSafeInsets and shouldUseDeviceSafeInsets then -var2.top else nil
    return {
        layoutOrder = if bool1 then nil else tbl3.layoutOrder,
        variant = tbl3.variant,
        showFtuxTooltip = showFtuxTooltip,
        ftuxTooltipTitle = title,
        ftuxTooltipText = text,
        onCreateMomentButtonPressed = onCreateMomentButtonPressed,
        onCreateAvatarMomentPressed = if FFlagMomentsCreateAvatarPosts then tbl3.onCreateAvatarMomentPressed else nil,
        onFtuxTooltipClosed = onFtuxTooltipClosed,
        onHamburgerPressed = onHamburgerPressed,
        onBack = tbl3.onBack or noop,
        onClose = tbl3.onClose or noop,
        onNavigateToTrending = tbl3.onNavigateToTrending or noop,
        onNavigateToMyMoments = tbl3.onNavigateToMyMoments or noop,
        title = tbl3.title or "",
        showTopScrim = tbl3.showTopScrim == true,
        showInteractiveButtons = not (GetFFlagMomentsAndroidTvEnabled() and var4),
        showHamburger = showHamburger,
        showCreateButton = tbl3.onCreatePressed ~= nil,
        showNavigationMenu = not (tbl3.onNavigateToTrending == nil) and tbl3.onNavigateToMyMoments ~= nil,
        showMyMomentsButton = bool3,
        headerHeight = size1400,
        headerPadding = headerPadding,
        titleTextStyle = var1.Color.Content.Emphasis,
        scrimHeight = var12,
        scrimTopOffset = scrimTopOffset,
        feedTypeChips = var6
    }
end

return useMomentsHeaderViewModel
