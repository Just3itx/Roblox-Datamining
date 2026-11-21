-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local useTokens = require(FlyoutSidePanelParent.Foundation).Hooks.useTokens

local FlyoutNavigationItem = require(script.Parent.FlyoutNavigationItem)

local function FlyoutNavigationList(tbl1)
    local var1 = useTokens()
    local var2 = React.useMemo(function()
        local tbl2 = {
            ListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, var1.Gap.Small)
            })
        }

        for layoutOrder, navigationItem in ipairs(tbl1.navigationItems) do
            if not (navigationItem and navigationItem.textKey) then
                continue
            end

            local itemType = navigationItem.itemType
            tbl2[itemType] = React.createElement(FlyoutNavigationItem, {
                item = navigationItem,
                layoutOrder = layoutOrder,
                closeDrawer = tbl1.closeDrawer,
                buildCreatorWebNavUrl = tbl1.buildCreatorWebNavUrl
            })
        end

        return tbl2
    end, {
        tbl1.navigationItems,
        tbl1.buildCreatorWebNavUrl,
        tbl1.closeDrawer,
        var1.Gap.Small
    })
    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }, var2)
end

return FlyoutNavigationList
