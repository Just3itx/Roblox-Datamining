-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local function escapeRichText(text: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return (text:gsub("[&<>\"']", { ["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;", ["'"] = "&apos;" }))
end

local function DesktopOfferBanner(tbl1)
    local name = tbl1.icon and IconName[tbl1.icon] or IconName.Tag

    return React.createElement(View, {
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-x-large padding-y-medium radius-medium bg-shift-200",
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    }, {
        BannerIcon = React.createElement(Icon, {
            name = name,
            size = IconSize.Medium,
            variant = IconVariant.Filled,
            LayoutOrder = 1,
            testId = "DesktopOfferBanner_Icon"
        }),
        Message = React.createElement(FoundationText, {
            Text = tbl1.text,
            tag = "fill auto-y text-body-medium text-wrap text-align-x-left content-emphasis",
            LayoutOrder = 2,
            testId = "DesktopOfferBanner_Text"
        }),
        Link = if tbl1.link then React.createElement(FoundationText, {
            Text = `<u>{escapeRichText(tbl1.link.text)}</u>`,
            RichText = true,
            tag = "auto-xy text-body-medium text-align-x-left content-emphasis",
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = tbl1.link.onActivated,
            LayoutOrder = 3,
            testId = "DesktopOfferBanner_Link"
        }) else nil
    })
end

return DesktopOfferBanner
