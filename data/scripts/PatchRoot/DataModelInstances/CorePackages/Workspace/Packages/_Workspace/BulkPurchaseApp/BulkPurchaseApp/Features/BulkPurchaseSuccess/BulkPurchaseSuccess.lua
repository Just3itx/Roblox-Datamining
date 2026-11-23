-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useLocalization = require(BulkPurchaseAppParent.Localization).Hooks.useLocalization

local AlertPrompt = require(BulkPurchaseApp.Components.AlertPrompt)

local function BulkPurchaseSuccess(tbl1)
    local var1 = useLocalization({
        title = "CoreScripts.BulkPurchasePrompt.SuccessPrompt.Heading",
        bodyText = "CoreScripts.BulkPurchasePrompt.SuccessPrompt.Body",
        dismissCTA = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.DismissCTA"
    })

    local createElement = React.createElement
    local var2 = AlertPrompt
    local tbl2 = {
        title = var1.title,
        bodyText = 0,
        dismissCTA = 0,
        onDismiss = 0
    }
    local bodyText = var1.bodyText
    local itemCount = tbl1.itemCount
    tbl2.bodyText = bodyText:gsub("{.*}", tostring(itemCount))
    tbl2.dismissCTA = var1.dismissCTA
    tbl2.onDismiss = tbl1.onDismiss
    return createElement(var2, tbl2)
end

return BulkPurchaseSuccess
