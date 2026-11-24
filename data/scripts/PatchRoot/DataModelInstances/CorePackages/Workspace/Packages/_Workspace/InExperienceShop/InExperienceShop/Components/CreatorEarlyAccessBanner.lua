-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local FeedbackAlert = Foundation.FeedbackAlert
local AlertSeverity = Foundation.Enums.AlertSeverity

local tbl1 = { message = "Feature.InExperienceShop.Label.PreviewBanner" }

local function CreatorEarlyAccessBanner(tbl2)
    local var1 = useLocalization(tbl1)

    return React.createElement(FeedbackAlert, {
        severity = AlertSeverity.Info,
        title = var1.message,
        LayoutOrder = tbl2.LayoutOrder,
        testId = "CreatorEarlyAccessBanner"
    })
end

return CreatorEarlyAccessBanner
