-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local View = Foundation.View
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper

return React.memo(function(tbl1) -- name: SduiActionBar
    if tbl1.items == nil or #tbl1.items == 0 then
        return nil
    end

    local tbl2 = ({})
    for layoutOrder, componentConfig in tbl1.items do
        local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)
        local str1 = "item_" .. tostring(layoutOrder)
        tbl2[str1] = React.createElement(
            sduiComponentWrapper,
            {
                componentConfig = componentConfig,
                sduiContext = tbl1.sduiContext,
                extraLocalProps = { layoutOrder = layoutOrder }
            }
        )
    end

    if tbl1.footer == nil then
        return React.createElement(View, {
            tag = tbl1.rowTag or "row size-full-0 auto-y gap-small",
            size = tbl1.size,
            anchorPoint = tbl1.anchorPoint,
            position = tbl1.position,
            LayoutOrder = tbl1.layoutOrder,
            testId = tbl1.testId
        }, tbl2)
    end

    local itemsRow = React.createElement(View, { tag = tbl1.rowTag or "row size-full-0 auto-y gap-small", layoutOrder = 1 }, tbl2)

    return React.createElement(View, {
        tag = tbl1.wrapperTag or "col size-full-0 auto-y gap-small",
        size = tbl1.size,
        anchorPoint = tbl1.anchorPoint,
        position = tbl1.position,
        LayoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }, {
        ItemsRow = itemsRow,
        Footer = tbl1.footer
    })
end)
