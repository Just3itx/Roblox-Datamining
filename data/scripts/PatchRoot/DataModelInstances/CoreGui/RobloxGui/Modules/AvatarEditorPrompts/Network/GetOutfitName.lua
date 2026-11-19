-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local httpRequest = require(RobloxGui.Modules.Common.httpRequest)

local Url = require(CorePackages.Workspace.Packages.Http).Url

local var1 = httpRequest(HttpRbxApiService)

return function(arg1)
    local str1 = string.format("%s/v3/outfits/%s/details", Url.AVATAR_URL, tostring(arg1))

    return var1(str1, "GET"):andThen(function(arg2)
        return arg2.responseBody.name
    end)
end
