-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local FlatList = require(InExperienceShopParent.VirtualizedList).FlatList

local View = Foundation.View
local _Types = require(InExperienceShop.Types)

local function ShopHomePageView(tbl1)
    return React.createElement(View, {
        tag = "fill size-full-0 padding-x-xlarge",
        testId = "ShopHomePageView",
        LayoutOrder = tbl1.LayoutOrder,
        Visible = tbl1.Visible
    }, {
        List = React.createElement(FlatList, {
            renderItem = tbl1.renderItem,
            data = tbl1.data,
            keyExtractor = tbl1.keyExtractor,
            onScroll = tbl1.onScroll,
            windowSize = 3,
            initialNumToRender = 2,
            maxToRenderPerBatch = 1,
            updateCellsBatchingPeriod = 100,
            contentContainerStyle = { BackgroundTransparency = 1 },
            style = { BackgroundTransparency = 1, ScrollBarThickness = 0 }
        })
    })
end

return ShopHomePageView
