-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent
local React = require(InExperienceShopParent.React)
local View = require(InExperienceShopParent.Foundation).View
local SharedFlags = require(InExperienceShopParent.SharedFlags)

local ItemDetailsView = require(script.Parent.ItemDetailsView)
local useItemDetailsViewModel = require(script.Parent.useItemDetailsViewModel)
local ShopAbuseReportOverlay = if SharedFlags.FFlagEnableReportingFlowForExperienceShop then require(InExperienceShop.Components.ShopAbuseReportOverlay) else nil

local function ItemDetailsContainer(arg1)
    local var1 = useItemDetailsViewModel(arg1)
    local reportSession = var1.reportSession

    return React.createElement(View, { tag = "size-full" }, {
        Details = React.createElement(ItemDetailsView, var1),
        ReportOverlay = if reportSession and var1.onReportClose and ShopAbuseReportOverlay then React.createElement(
            ShopAbuseReportOverlay,
            {
                abuseVector = reportSession.abuseVector,
                targetId = reportSession.targetId,
                onClose = var1.onReportClose
            }
        ) else nil
    })
end

return ItemDetailsContainer
