-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local Divider = Foundation.Divider
local DividerOrientation = Foundation.Enums.DividerOrientation
local _ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)

local function ResponsivePanelLayout(tbl1)
    local panelConfig = tbl1.panelConfig

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = panelConfig.tag,
        LayoutOrder = tbl1.LayoutOrder,
        ClipsDescendants = true
    }
    local tbl3 = { FirstPanel = 0, SecondPanel = 0 }
    local element

    if tbl1.renderFirstPanel then
        element = React.createElement(Foundation.View, {
            Size = if tbl1.renderSecondPanel then panelConfig.panelSizes.first else UDim2.new(1, 0, 1, 0),
            LayoutOrder = panelConfig.layoutOrder.first
        }, {
            RightBorder = if panelConfig.showRightBorder then React.createElement(Divider, { orientation = DividerOrientation.Vertical, Position = UDim2.new(1, -1, 0, 0) }) else nil,
            StartSlot = tbl1.renderFirstPanel()
        })
    else
        element = nil
    end

    tbl3.FirstPanel = element
    local element2 = if tbl1.renderSecondPanel then React.createElement(
        Foundation.View,
        {
            Size = if tbl1.renderFirstPanel then panelConfig.panelSizes.second else UDim2.new(1, 0, 1, 0),
            LayoutOrder = panelConfig.layoutOrder.second
        },
        {
            EndSlot = tbl1.renderSecondPanel()
        }
    ) else nil
    tbl3.SecondPanel = element2
    return createElement(view, tbl2, tbl3)
end

return ResponsivePanelLayout
