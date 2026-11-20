-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppPageShell = script:FindFirstAncestor("AppPageShell")
local AppPageShellParent = AppPageShell.Parent

local Foundation = require(AppPageShellParent.Foundation)
local React = require(AppPageShellParent.React)
local Responsive = require(AppPageShellParent.Responsive)

local _PageTypes = require(AppPageShell.PageTypes)
local computeStickyOffset = require(AppPageShell.computeStickyOffset)

local View = Foundation.View
local useDeviceInsets = Responsive.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local FFlagSduiFeedScrollBarFixes = require(AppPageShellParent.SharedFlags).FFlagSduiFeedScrollBarFixes

return React.memo(function(tbl1) -- name: PageStickyHeader
    local topPadding = tbl1.topPadding
    local backgroundStyle = tbl1.backgroundStyle
    local slots = tbl1.slots
    local chromeHeight = tbl1.chromeHeight or 0
    local liveChromeHeightBinding = tbl1.liveChromeHeightBinding

    local var1 = useTokens()
    local var2, var3 = React.useBinding(0)
    local var4

    if FFlagSduiFeedScrollBarFixes then
        var4 = nil
    else
        local top = useDeviceInsets().top

        var4 = React.useMemo(function()
            if liveChromeHeightBinding == nil or chromeHeight <= 0 then
                return UDim2.fromOffset(0, 0)
            end
            return liveChromeHeightBinding:map(function(num1: number): UDim2
                return UDim2.fromOffset(0, computeStickyOffset(num1, chromeHeight, top))
            end)
        end, { liveChromeHeightBinding, chromeHeight, top })
    end

    local var5 = React.useMemo(function()
        return var2:map(function(num1: number): UDim2
            return UDim2.new(1, 0, 0, num1 + chromeHeight)
        end)
    end, { var2, chromeHeight })

    local var6 = React.useMemo(function()
        if slots == nil or next(slots) == nil then
            return nil
        end
        local result = {}
        for k, slot in slots do
            result[`Sticky{k}`] = slot
        end
        return result
    end, { slots })

    local var7 = React.useMemo(function()
        return var2:map(function(yOffset: number): UDim2
            return UDim2.new(1, 0, 0, yOffset)
        end)
    end, { var2 })

    local var8 = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.Y)
    end, {})

    if var6 == nil then
        return nil
    end

    local createElement = React.createElement
    local var9 = View
    local tbl2 = { Size = var7, LayoutOrder = 1, ZIndex = 2, ClipsDescendants = false }

    local tbl3 = { Translation = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl4 = { BackgroundTransparency = 1, BorderSizePixel = 0 }
    if FFlagSduiFeedScrollBarFixes then
        var4 = nil
    end

    tbl4.Position = var4
    tbl4.Size = UDim2.new(1, 0, 0, 0)
    tbl4.AutomaticSize = Enum.AutomaticSize.Y
    tbl4.ClipsDescendants = false
    tbl4[React.Change.AbsoluteSize] = var8
    local tbl5 = {
        Background = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            Size = var5,
            BackgroundColor3 = if backgroundStyle then backgroundStyle.Color3 else var1.Color.Surface.Surface_0.Color3,
            BackgroundTransparency = if backgroundStyle then if backgroundStyle.Transparency == nil then 0 else backgroundStyle.Transparency else 0,
            BorderSizePixel = 0,
            ZIndex = 0
        }),
        Content = React.createElement(View, {
            tag = `col size-full-0 auto-y {tbl1.tag or ""}`
        }, {
            TopSpacer = if topPadding and topPadding > 0 then React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, topPadding),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 1
                }
            ) else nil,
            Body = React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = 2 }, var6)
        })
    }
    tbl3.Translation = createElement2(str1, tbl4, tbl5)
    return createElement(var9, tbl2, tbl3)
end)
