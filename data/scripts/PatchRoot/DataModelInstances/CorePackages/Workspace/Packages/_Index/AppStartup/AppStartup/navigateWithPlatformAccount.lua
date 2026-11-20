-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStartupParent = script:FindFirstAncestor("AppStartup").Parent
local AppPage = require(AppStartupParent.RobloxAppEnums).AppPage

local function navigateWithPlatformAccount(bool1: boolean, callback: (...any) -> (...any))
    if bool1 then
        callback(AppPage.SingleSignOnContainer)
        return
    end
    callback(AppPage.Startup)
end

return navigateWithPlatformAccount
