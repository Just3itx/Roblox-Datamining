-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BrowserService = game:GetService("BrowserService")

local module = {}

function module.Execute(str1: string, str2: string)
    local javascript = "(function() { CoreRobloxUtilities.hybridResponseService.injectNativeResponse(" .. str1 .. ", " .. str2 .. "); })();"
    BrowserService:ExecuteJavaScript(javascript)
end

return module
