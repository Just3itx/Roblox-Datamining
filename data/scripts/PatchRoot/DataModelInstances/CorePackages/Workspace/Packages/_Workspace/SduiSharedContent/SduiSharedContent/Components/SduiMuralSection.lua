-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local _AppCommonLib = require(SduiSharedContentParent.AppCommonLib)
local Foundation = require(SduiSharedContentParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local CollectionViews = require(SduiSharedContentParent.CollectionViews)
local useCollectionLayout = CollectionViews.useCollectionLayout
local maybeForceDarkTheme = CollectionViews.maybeForceDarkTheme

local _SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local FFlagLuaAppCompositionAlways = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppCompositionAlways

local function MuralArtImage(tbl1)
    local var1 = useTokens()
    return React.createElement("ImageLabel", {
        Size = UDim2.fromScale(1, 1),
        Image = tbl1.image,
        ScaleType = Enum.ScaleType.Crop,
        BackgroundColor3 = var1.Color.Surface.Surface_0.Color3,
        BackgroundTransparency = var1.Color.Surface.Surface_0.Transparency,
        ZIndex = -1
    }, {
        UICorner = if tbl1.cornerRadius > 0 then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil
    })
end

return React.memo(function(tbl1) -- name: SduiMuralSection
    local appCompositionEnabled = FFlagLuaAppCompositionAlways or tbl1.appCompositionEnabled or tbl1.sduiContext.appCompositionEnabled
    local var2 = useCollectionLayout()
    local bool1 = not (tbl1.contentTag == nil) and string.find(tbl1.contentTag, "padding", 1, true) ~= nil
    local var3 = if tbl1.fullBleed and appCompositionEnabled then var2.margin else 0
    local cornerRadius = tbl1.cornerRadius or 0
    local var4, var5 = React.useBinding(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var5(arg1.AbsoluteSize.Y)
    end, {})

    local content = React.useMemo(function()
        if not tbl1.content then
            return nil
        end
        return React.cloneElement(tbl1.content, {
            extraLocalProps = {
                appCompositionEnabled = appCompositionEnabled,
                scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef,
                startRow = tbl1.startRow,
                numUpdatesToDelayImpressions = tbl1.numUpdatesToDelayImpressions,
                index = tbl1.index,
                selectionOrderBase = tbl1.selectionOrderBase,
                pageSideMargin = tbl1.pageSideMargin
            }
        })
    end, {
        tbl1.content,
        appCompositionEnabled,
        tbl1.scrollViewPositionChangedSignal,
        tbl1.verticalScrollingFrameRef,
        tbl1.startRow,
        tbl1.numUpdatesToDelayImpressions,
        tbl1.index,
        tbl1.selectionOrderBase,
        tbl1.pageSideMargin
    })

    local tbl2 = {
        Art = if tbl1.backgroundMuralUrl then React.createElement(View, {
            Position = UDim2.new(0, -var3, 0, 0),
            Size = var4:map(function(num1: number): UDim2
                return UDim2.new(1, 2 * var3, 0, math.ceil(num1))
            end),
            ZIndex = -1,
            testId = "--sdui-mural-section-art"
        }, {
            Image = React.createElement(MuralArtImage, { image = tbl1.backgroundMuralUrl, cornerRadius = cornerRadius })
        }) else nil,
        Content = React.createElement(View, {
            tag = {
                ["col size-full-0 auto-y"] = true,
                ["padding-y-xxlarge"] = not (tbl1.backgroundMuralUrl == nil) and not bool1,
                [tbl1.contentTag or ""] = tbl1.contentTag ~= nil
            },
            testId = "--sdui-mural-section-content",
            onAbsoluteSizeChanged = onAbsoluteSizeChanged
        }, { Content = content })
    }

    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y",
            LayoutOrder = tbl1.layoutOrder,
            testId = tbl1.testId or "--sdui-mural-section"
        },
        {
            Section = maybeForceDarkTheme(React.createElement(React.Fragment, nil, tbl2), tbl1.colorMode == "Dark")
        }
    )
end)
