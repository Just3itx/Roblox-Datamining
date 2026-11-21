-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAvailabilityParent = script:FindFirstAncestor("DiscoveryAvailability").Parent
local AppBlox = require(DiscoveryAvailabilityParent.AppBlox)
local React = require(DiscoveryAvailabilityParent.React)
local Responsive = require(DiscoveryAvailabilityParent.Responsive)
local Foundation = require(DiscoveryAvailabilityParent.Foundation)
local useLocalization = require(DiscoveryAvailabilityParent.Localization).Hooks.useLocalization
local CollectionViews = require(DiscoveryAvailabilityParent.CollectionViews)
local UIBlox = require(DiscoveryAvailabilityParent.UIBlox)
local _LuauPolyfill = require(DiscoveryAvailabilityParent.LuauPolyfill)
local NotificationModalsManager = require(DiscoveryAvailabilityParent.NotificationModalsManager)
local usePageSideMargin = CollectionViews.usePageSideMargin

local Banner = AppBlox.Banner
local View = Foundation.View
local Enums = Foundation.Enums
local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({
        errorTitle = "Feature.Home.ClientCacheFallbackBanner.Label.Error",
        errorMessage = "Feature.Home.ClientCacheFallbackBanner.Label.RefreshPageToLoadContents",
        refreshButton = "Feature.Home.ClientCacheFallbackBanner.Action.Refresh",
        errorRefreshingToastTitle = "Feature.Home.ClientCacheFallbackBanner.Label.ErrorRefreshingToastTitle"
    })

    local ref = React.useRef(nil)

    local offset = usePageSideMargin(ref.current)

    local var4 = Responsive.useBreakpointXOrSmaller(Responsive.Keys.Small)

    local isLoading, var6 = React.useState(false)

    local onActivated = React.useCallback(function()
        var6(true)
        tbl1.onRefreshButtonClick():andThen(function(_)
            var6(false)
        end):catch(function(_)
            var6(false)
            NotificationModalsManager.SetUIBloxToast({
                iconImage = UIBlox.App.ImageSet.Images["icons/status/alert"],
                toastTitle = var2.errorRefreshingToastTitle,
                sequenceNumber = DateTime.now().UnixTimestamp
            })
        end)
    end, { tbl1.onRefreshButtonClick, var2.errorRefreshingToastTitle })

    return React.createElement(View, {
        position = tbl1.Position,
        [React.Change.AbsoluteSize] = tbl1[React.Change.AbsoluteSize],
        ref = ref,
        tag = "size-full-0 auto-y"
    }, {
        Padding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, offset),
            PaddingRight = UDim.new(0, offset),
            PaddingTop = UDim.new(0, var1.Padding.Large),
            PaddingBottom = UDim.new(0, if var4 then 0 else var1.Padding.Large)
        }),
        BannerContent = React.createElement(Banner, {
            icon = Enums.IconName.CircleX,
            iconVariant = Enums.IconVariant.Filled,
            iconStyle = var1.Color.System.Alert,
            title = var2.errorTitle,
            body = var2.errorMessage,
            buttons = {{
                text = var2.refreshButton,
                isLoading = isLoading,
                onActivated = onActivated
            }}
        })
    })
end
