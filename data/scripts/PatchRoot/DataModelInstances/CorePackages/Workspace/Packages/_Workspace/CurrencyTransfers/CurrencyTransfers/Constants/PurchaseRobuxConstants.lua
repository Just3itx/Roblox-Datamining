-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

return {
    getPurchaseRobuxUrl = function()
        local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")
        return string.gsub(var1, "http:", "https:") .. "upgrades/robux?ctx=navpopover"
    end,
    PURCHASE_ROBUX_WEBVIEW_TITLE = "Buy Robux"
}
