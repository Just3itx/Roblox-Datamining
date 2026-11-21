-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local BuilderIcons = require(FlyoutSidePanelParent.BuilderIcons)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local useSetDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useSetDrawerVisible
local FlyoutAlternateEntryPoint = require(script.Parent.FlyoutAlternateEntryPoint)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local UIBlox = require(FlyoutSidePanelParent.UIBlox)
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local FlyoutTooltipManager = require(script.Parent.Parent.FlyoutTooltipManager)
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local useOpenFlyoutSidePanel = require(script.Parent.Parent.Hooks.useOpenFlyoutSidePanel)
local useRoactService = require(FlyoutSidePanelParent.RobloxAppHooks).useRoactService
local AppEventIngestService = require(FlyoutSidePanelParent.RoactServiceTags).AppEventIngestService
local RoactUtils = require(FlyoutSidePanelParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local getTestId = RoactUtils.getTestId
local StatusIndicator = Foundation.StatusIndicator
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant
local useTokens = Foundation.Hooks.useTokens

local FFlagLuaAppFixNotificationBadgeCountsSync = require(FlyoutSidePanelParent.SharedFlags).FFlagLuaAppFixNotificationBadgeCountsSync
local FFlagEnableFlyoutOnNavRail = require(FlyoutSidePanelParent.SharedFlags).FFlagEnableFlyoutOnNavRail
local FFlagFlyoutUseOpenHook = require(FlyoutSidePanelParent.SharedFlags).FFlagFlyoutUseOpenHook
local FFlagFlyoutHeaderFixPadding = require(FlyoutSidePanelParent.SharedFlags).FFlagFlyoutHeaderFixPadding
local FFlagLuaAppAddTestIdsForArrow = require(FlyoutSidePanelParent.SharedFlags).FFlagLuaAppAddTestIdsForArrow

local function getTotalNotificationCount(arg1, num1: number, num2: number)
    local num3 = 0
    if arg1.MorePageSettings and arg1.MorePageSettings > 0 then
        num3 += arg1.MorePageSettings
    end
    if FFlagLuaAppFixNotificationBadgeCountsSync then
        if num1 > 0 then
            num3 += num1
        end
        if num2 > 0 then
            return num3 + num2
        end
    else
        if arg1.MorePageFriends and arg1.MorePageFriends > 0 then
            num3 += arg1.MorePageFriends
        end
        if arg1.MorePageMessages and arg1.MorePageMessages > 0 then
            num3 += arg1.MorePageMessages
        end
    end
    return num3
end

local function FlyoutHamburgerButton(tbl1)
    local var1 = useSelector(function(arg1)
        return arg1.NotificationBadgeCounts or {}
    end)
    local var2 = useSelector(function(arg1)
        if not FFlagLuaAppFixNotificationBadgeCountsSync then
            return 0
        end
        local friendsCarousel = arg1.FriendsCarousel
        local requests = friendsCarousel and friendsCarousel.Friends and friendsCarousel.Friends.requests
        return requests and requests.receivedCount or 0
    end)
    local var3 = useSelector(function(arg1)
        if FFlagLuaAppFixNotificationBadgeCountsSync then
            return arg1.SocialTab and arg1.SocialTab.UnreadConversationCount or 0
        end

        return 0
    end)

    local totalNotificationCount = getTotalNotificationCount(var1, var2, var3)
    local var4 = useTokens()
    local var5

    if FFlagFlyoutUseOpenHook then
        var5 = useOpenFlyoutSidePanel(tbl1.titleText)
    else
        local var6 = useSetDrawerVisible()
        local var7 = useRoactService(AppEventIngestService)
        var5 = React.useCallback(function()
            FlyoutAnalytics.sendPageLoadEvent(var7, tbl1.titleText)
            var6(true)
            FlyoutTooltipManager:flyoutSidePanelOpened()
        end, {})
    end

    local var6, var7 = React.useState(FlyoutTooltipManager:isTooltipActive())
    local var8 = useLocalization({ itemName = "CommonUI.Features.Label.More" })

    local var9 = useLocalization({
        title = {
            "Feature.FlyoutSidePanel.Label.TooltipTitle",
            itemName = var8.itemName
        },
        body = "Feature.FlyoutSidePanel.Label.TooltipBody"
    })
    local tbl2, tbl3

    if var6 then
        tbl2 = {
            active = true,
            guiTarget = CoreGui,
            DisplayOrder = 10,
            preferredOrientation = TooltipOrientation.Top
        }
        tbl3 = {
            headerText = var9.title,
            bodyText = var9.body,
            textAlignment = Enum.TextXAlignment.Left,
            useLargeDropShadow = false,
            headerRichText = true
        }
    else
        tbl3 = nil
        tbl2 = nil
    end

    local var10 = React.useCallback(function(_)
        if var6 then
            var7(false)
            FlyoutAnalytics.onFlyoutTooltipDismissed({ source = "click" })
        end
    end, { var6 })

    React.useEffect(function()
        local connection = nil
        if var6 then
            local count = FlyoutTooltipManager:getTooltipCount()
            FlyoutAnalytics.onFlyoutTooltipShown({ count = count })
            connection = UserInputService.InputBegan:Connect(var10)
        end
        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { var6, var10 })

    local var11

    if tbl1.isAlternateEntryPointEnabled then
        if FFlagEnableFlyoutOnNavRail and tbl1.isIconCentered then
            var11 = UDim2.new(1, 0, 0, var4.Size.Size_100)
        else
            var11 = UDim2.new(1, if FFlagFlyoutHeaderFixPadding then 0 else -var4.Size.Size_100, 0, var4.Size.Size_100)
        end
    elseif FFlagEnableFlyoutOnNavRail and tbl1.isIconCentered then
        var11 = UDim2.new(1, -var4.Size.Size_100, 0, var4.Size.Size_150)
    else
        var11 = UDim2.new(1, if FFlagFlyoutHeaderFixPadding then -var4.Size.Size_200 else -var4.Size.Size_300, 0, var4.Size.Size_150)
    end

    local uDim2 = if FFlagEnableFlyoutOnNavRail and tbl1.isIconCentered then UDim2.new(0.5, 0, 0.5, 0) else UDim2.new(0, 0, 0.5, 0)
    local vector2 = if FFlagEnableFlyoutOnNavRail and tbl1.isIconCentered then Vector2.new(0.5, 0.5) else Vector2.new(0, 0.5)
    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl4 = {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        Size = UDim2.fromOffset(if FFlagFlyoutHeaderFixPadding then var4.Size.Size_900 else var4.Size.Size_1000, var4.Size.Size_1000),
        Selectable = if FFlagEnableFlyoutOnNavRail then tbl1.selectable else nil,
        [React.Event.Activated] = var5,
        [React.Tag] = if FFlagLuaAppAddTestIdsForArrow then getTestId("core-ui-flyout-hamburger") else nil,
        ref = tbl1.buttonRef
    }

    local tbl5 = {
        StatusIndicatorContainer = if totalNotificationCount > 0 then React.createElement(
            Foundation.View,
            {
                Position = var11,
                AnchorPoint = Vector2.new(1, 0),
                tag = "auto-xy padding-xxsmall radius-circle bg-surface-0",
                ZIndex = 2
            },
            {
                StatusIndicator = React.createElement(StatusIndicator, { variant = StatusIndicatorVariant.Emphasis })
            }
        ) else nil,
        HamburgerButton = React.createElement(Foundation.View, {
            Position = uDim2,
            AnchorPoint = vector2,
            tag = "auto-xy"
        }, {
            Hamburger = if tbl1.isAlternateEntryPointEnabled then React.createElement(FlyoutAlternateEntryPoint) else React.createElement(Icon, { name = BuilderIcons.Icon.ThreeBarsHorizontal, size = IconSize.Large }),
            Tooltip = if var6 then withTooltip(tbl3, tbl2, function(arg1)
                return React.createElement("Frame", {
                    Visible = false,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    [React.Change.AbsolutePosition] = arg1,
                    [React.Change.AbsoluteSize] = arg1
                })
            end) else nil
        })
    }

    return createElement(str1, tbl4, tbl5)
end

return FlyoutHamburgerButton
