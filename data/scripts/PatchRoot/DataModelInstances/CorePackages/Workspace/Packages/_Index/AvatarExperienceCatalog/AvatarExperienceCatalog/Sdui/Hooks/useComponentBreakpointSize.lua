-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local useSignalState = require(AvatarExperienceCatalogParent.SignalsReact).useSignalState

local getBreakpointFromRowWidth = require(AvatarExperienceCatalog.Utils.getBreakpointFromRowWidth)
local getUIScaleFromTokens = require(AvatarExperienceCatalog.Utils.getUIScaleFromTokens)
local useTokens = require(AvatarExperienceCatalogParent.Foundation).Hooks.useTokens
local _WidgetListBreakPointEnum = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListBreakPointEnum)
local GetAXMarketplaceWidgetStore = require(AvatarExperienceCatalog.Stores.GetAXMarketplaceWidgetStore)

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXSduiFeedPublishesBreakpoint = AvatarExperienceFlags.FFlagAXSduiFeedPublishesBreakpoint
local FFlagAXMarketplaceBreakpointMismatchCounter = AvatarExperienceFlags.FFlagAXMarketplaceBreakpointMismatchCounter

local function useCatalogFeedBreakpoint(num1: number?, tbl1)
    local var1 = useTokens()
    local uIScaleFromTokens = getUIScaleFromTokens(var1)

    local var2 = if num1 == nil then 0.2 else num1

    local var3 = if tbl1 and tbl1.horizontalInset then tbl1.horizontalInset else 0
    local bool1 = not (tbl1 == nil) and tbl1.publishToStore == true
    local var4 = if tbl1 and tbl1.measurementSource then tbl1.measurementSource else ""

    local aXMarketplaceWidgetStore = GetAXMarketplaceWidgetStore(false)

    local var5 = useSignalState(aXMarketplaceWidgetStore.getScreenSize)

    local var6, var7 = React.useState(nil)

    local var8 = React.useRef(nil)
    local var9 = if FFlagAXMarketplaceBreakpointMismatchCounter then React.useRef(false) else nil

    React.useEffect(function()
        return function()
            if var8.current then
                task.cancel(var8.current)
                var8.current = nil
            end
        end
    end, {})

    local var10 = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X
        if FFlagAXSduiFeedPublishesBreakpoint and var3 > 0 then
            absoluteSizeX = math.max(absoluteSizeX - var3, 0)
        end
        local breakpointFromRowWidth = getBreakpointFromRowWidth(absoluteSizeX, uIScaleFromTokens)
        if var8.current then
            task.cancel(var8.current)
        end
        var8.current = task.delay(var2, function()
            var8.current = nil

            if FFlagAXMarketplaceBreakpointMismatchCounter and var9 and var4 ~= "" and not var9.current then
                var9.current = true
                aXMarketplaceWidgetStore.reportMeasuredBreakpoint(breakpointFromRowWidth, var4)
            end
            if FFlagAXSduiFeedPublishesBreakpoint and bool1 then
                aXMarketplaceWidgetStore.setScreenSize(breakpointFromRowWidth)
            end
            var7(breakpointFromRowWidth)
        end)
    end, (FFlagAXSduiFeedPublishesBreakpoint or FFlagAXMarketplaceBreakpointMismatchCounter)
        and {
            uIScaleFromTokens,
            var2,
            var3,
            bool1,
            var4,
            aXMarketplaceWidgetStore
        }
        or { uIScaleFromTokens, var2 })

    if var6 == nil then
        var6 = var5
    end

    return var6, var10
end

return useCatalogFeedBreakpoint
