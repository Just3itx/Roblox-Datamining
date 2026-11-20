-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local GetCanSendAndCanCustomizeInvites = require(CorePackages.Workspace.Packages.GameInvite).GetCanSendAndCanCustomizeInvites

local HttpRbxApiService = game:GetService("HttpRbxApiService")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local httpRequest = require(RobloxGui.Modules.Common.httpRequest)

return function(str1: string, num1: number?)
    local var1 = httpRequest(HttpRbxApiService)

    local var2, var3 = GetCanSendAndCanCustomizeInvites(var1, str1, num1):await()
    if var2 and var3 and var3.responseBody then
        return var3.responseBody.canPrompt, var3.responseBody.canCustomize
    end
    return false, false
end
