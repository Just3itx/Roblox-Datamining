-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local View = require(AvatarExperienceCatalogParent.Foundation).View

local _AppCommonLib = require(AvatarExperienceCatalogParent.AppCommonLib)

local AvatarExperienceScreenSizeImpressionsDetector = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).AvatarExperienceScreenSizeImpressionsDetector

local function WidgetPanelView(tbl1)
    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.LayoutOrder,
        ref = tbl1.panelRef,
        [React.Change.AbsoluteSize] = tbl1.onAbsoluteSizeChanged
    }, {
        Panel = React.createElement(View, { tag = "col size-full-0 auto-y" }, tbl1.children),
        WidgetImpressionsDetector = React.createElement(AvatarExperienceScreenSizeImpressionsDetector, {
            parentRef = tbl1.panelRef,
            onRequestImpressionsSignal = tbl1.onRequestImpressionsSignal,
            pageFilter = tbl1.pageFilter,
            onImpressionsDetected = tbl1.onImpressionsDetected,
            collectObjectsFunc = tbl1.collectObjectsFunc
        })
    })
end

return WidgetPanelView
