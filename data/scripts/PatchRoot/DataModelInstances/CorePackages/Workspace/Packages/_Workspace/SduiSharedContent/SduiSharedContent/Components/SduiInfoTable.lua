-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local AppBlox = require(SduiSharedContentParent.AppBlox)
local Foundation = require(SduiSharedContentParent.Foundation)

local InfoTable = AppBlox.InfoTable
local View = Foundation.View
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper

return React.memo(function(tbl1) -- name: SduiInfoTable
    local layoutOrder = tbl1.layoutOrder

    local items = ({})
    local var1 = if tbl1.numColumns and tbl1.numColumns > 0 then tbl1.numColumns else 1
    local itemsLen = #tbl1.items

    local num1 = math.ceil(itemsLen / var1)

    for k, componentConfig in tbl1.items do
        local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)

        local num2 = math.floor((k - 1) / num1) + 1
        local selectionOrder = ((k - 1) % num1 + 1 - 1) * var1 + num2

        local createElement = React.createElement
        local tbl3 = {
            componentConfig = componentConfig,
            sduiContext = tbl1.sduiContext,
            parentAnalyticsContext = tbl1.analyticsContext,
            extraLocalProps = {
                numColumns = tbl1.numColumns,
                isLastInSingleColumn = if var1 == 1 then k == itemsLen else nil,
                selectionOrder = selectionOrder
            }
        }
        items[k] = createElement(sduiComponentWrapper, tbl3)
    end

    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        tag = if tbl1.tag then {
            [tbl1.tag] = true,
            ["col size-full-0 auto-y"] = true
        } else { ["col size-full-0 auto-y"] = true },
        LayoutOrder = layoutOrder
    }
    return createElement(var2, tbl3, {
        Header = if tbl1.headerComponent then React.cloneElement(tbl1.headerComponent, { layoutOrder = 1 }) else nil,
        Content = React.createElement(InfoTable, { LayoutOrder = 2, numColumns = tbl1.numColumns, gridTag = tbl1.gridTag, items = items })
    })
end)
