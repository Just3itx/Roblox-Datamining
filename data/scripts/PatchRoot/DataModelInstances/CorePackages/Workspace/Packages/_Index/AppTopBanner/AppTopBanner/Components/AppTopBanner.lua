-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppTopBanner = script:FindFirstAncestor("AppTopBanner")
local AppTopBannerParent = AppTopBanner.Parent

local Cryo = require(AppTopBannerParent.Cryo)
local Foundation = require(AppTopBannerParent.Foundation)
local React = require(AppTopBannerParent.React)
local useSelector = require(AppTopBannerParent.RoactUtils).Hooks.RoactRodux.useSelector
local FFlagUseSignalsForAppTopBanner = require(AppTopBannerParent.SharedFlags).FFlagUseSignalsForAppTopBanner
local useSignalState = if FFlagUseSignalsForAppTopBanner then require(AppTopBannerParent.SignalsReact).useSignalState else nil
local GetAppTopBannerStore = if FFlagUseSignalsForAppTopBanner then require(AppTopBanner.Stores.GetAppTopBannerStore) else nil
local useTokens = Foundation.Hooks.useTokens

local AppTopBannerType = require(AppTopBanner.Enums.AppTopBannerType)

local FocusNavigationUtils = require(AppTopBannerParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local tbl1 = {
    contentMaps = {},
    deviceStatusBarHeight = 0
}

return React.memo(function(tbl2) -- name: AppTopBanner
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useTokens()

    local yOffset, var3 = React.useState(0)
    local appTopBannerStore = if FFlagUseSignalsForAppTopBanner then GetAppTopBannerStore(false) else nil
    local var4, var5, callback, var6, var7

    if FFlagUseSignalsForAppTopBanner then
        var4 = useSignalState(appTopBannerStore.getExpanded)
        var5 = useSignalState(appTopBannerStore.getAppTopBannerContentProps)
        callback = useSignalState(appTopBannerStore.getOnAppTopBannerClick).callback
        var6 = useSignalState(appTopBannerStore.getAppTopBannerContentHeight)
        var7 = useSignalState(appTopBannerStore.getIsDisabled)
    else
        local var8 = React.useCallback(function(arg1)
            return if arg1.AppTopBanner then arg1.AppTopBanner.expanded else false
        end, {})
        var4 = useSelector(var8)
        local var9 = React.useCallback(function(arg1)
            return arg1.AppTopBanner and arg1.AppTopBanner.appTopBannerContentProps
        end, {})
        var5 = useSelector(var9)
        local var10 = React.useCallback(function(arg1)
            return arg1.AppTopBanner and arg1.AppTopBanner.onAppTopBannerClick
        end, {})
        callback = useSelector(var10)
        local var11 = React.useCallback(function(arg1)
            return arg1.AppTopBanner and arg1.AppTopBanner.appTopBannerContentHeight
        end, {})
        var6 = useSelector(var11)
        local var12 = React.useCallback(function(arg1)
            return if arg1.AppTopBanner then arg1.AppTopBanner.isDisabled else false
        end, {})
        var7 = useSelector(var12)
    end

    React.useEffect(function()
        if var4 and not var7 then
            var3(var6 + var1.deviceStatusBarHeight)
            return
        end
        var3(0)
    end, {
        var6,
        var4,
        var1.deviceStatusBarHeight,
        var7
    })

    local var8

    if FFlagUseSignalsForAppTopBanner then
        var8 = useSignalState(appTopBannerStore.getAppTopBannerType)
    else
        local var9 = React.useCallback(function(arg1)
            return if arg1.AppTopBanner then arg1.AppTopBanner.appTopBannerType else AppTopBannerType.None
        end, {})
        var8 = useSelector(var9)
    end
    local contentMap = var1.contentMaps[var8]

    local element = React.createElement(
        Foundation.View,
        {
            Size = UDim2.new(1, 0, 0, yOffset),
            backgroundStyle = var2.Color.Extended.Green.Green_800,
            onActivated = callback,
            padding = {
                left = UDim.new(0, var2.Padding.XLarge),
                right = UDim.new(0, var2.Padding.XLarge),
                top = UDim.new(0, var1.deviceStatusBarHeight)
            }
        },
        {
            content = if contentMap then React.createElement(contentMap, var5) else nil
        }
    )

    return if yOffset > 0 and not var7 then React.createElement(FocusRoot, { surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.Auxiliary }, element) else nil
end)
