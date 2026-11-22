-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local Foundation = require(ServerTriggeredModalsParent.Foundation)
local AppNavBar = require(ServerTriggeredModalsParent.AppNavBar)
local SduiSharedUtilities = require(ServerTriggeredModalsParent.SduiSharedUtilities)
local SignalsReact = require(ServerTriggeredModalsParent.SignalsReact)
local RobloxAppHooks = require(ServerTriggeredModalsParent.RobloxAppHooks)

local View = Foundation.View
local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local useComponentConfig = SduiSharedUtilities.useComponentConfig
local useStatusBarHeight = RobloxAppHooks.useStatusBarHeight
local useTopBarHeight = RobloxAppHooks.useTopBarHeight
local VisibilityControl = AppNavBar.VisibilityControl
local FFlagPromptsActionEventLogging = require(ServerTriggeredModals.Flags.FFlagPromptsActionEventLogging)

local function noopGetter()
    return nil
end

return React.memo(function(tbl1) -- name: SurfaceBanner
    local var1 = useStatusBarHeight()
    local var2 = useTopBarHeight()
    local var3, var4 = React.useState(0)
    local headerBinding = VisibilityControl.getHeaderBinding()

    local bool1 = tbl1.identifier ~= nil
    local var5 = useComponentConfig(tbl1.configKey, tbl1.identifier)
    if not bool1 then
        var5 = nil
    end

    local backgroundStyle = if var5 and var5.props then var5.props.backgroundStyle else nil
    local var6 = if var5 and var5.propSignals and var5.propSignals.backgroundStyle then var5.propSignals.backgroundStyle else noopGetter
    local var7 = SignalsReact.useSignalState(var6)
    if backgroundStyle == nil then
        if var7 == nil then
            backgroundStyle = nil
        else
            backgroundStyle = var7.data
        end
    end

    local var8 = headerBinding:map(function(num1: number)
        return UDim2.new(0, 0, 0, math.max(var1, num1 * var2))
    end)

    local var9 = headerBinding:map(function(num1: number)
        return UDim2.new(1, 0, 0, math.max(0, var1 - num1 * var2))
    end)

    local surfaceBannerContent = tbl1.surfaceBannerContent
    local canvasTopPadding = surfaceBannerContent and surfaceBannerContent.props and surfaceBannerContent.props.canvasTopPadding or 0
    local content = if surfaceBannerContent then React.cloneElement(surfaceBannerContent, { canvasTopPadding = canvasTopPadding + var3 }) else nil
    local createElement = React.createElement
    local var11 = View
    local tbl2 = { tag = "size-full" }

    local tbl3 = {
        Content = content,
        Filler = if bool1 then React.createElement(
            View,
            {
                backgroundStyle = backgroundStyle,
                AnchorPoint = Vector2.new(0, 1),
                Position = var8,
                Size = var9,
                ZIndex = 2
            }
        ) else nil,
        Banner = 0
    }

    local createElement2 = React.createElement
    local var12 = View

    local tbl4 = {
        Position = var8,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 2,
        onAbsoluteSizeChanged = function(arg1)
            var4(arg1.AbsoluteSize.Y)
        end
    }

    local tbl5 = { SurfaceBanner = 0 }
    local var13

    if bool1 then
        local createElement3 = React.createElement
        local var14 = SduiFeatureEntryPoint
        local tbl6 = {
            configKey = tbl1.configKey,
            identifier = tbl1.identifier,
            appPage = tbl1.appPage,
            additionalAnalyticsData = if FFlagPromptsActionEventLogging then {
                promptInstanceId = if tbl1.identifier then tbl1.identifier else nil
            } else nil,
            shouldDisplayLoading = false,
            shouldDisplayError = false
        }
        var13 = createElement3(var14, tbl6)
    else
        var13 = nil
    end

    tbl5.SurfaceBanner = var13
    tbl3.Banner = createElement2(var12, tbl4, tbl5)
    return createElement(var11, tbl2, tbl3)
end)
