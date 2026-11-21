-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local HttpService = game:GetService("HttpService")

local Promise = require(AuthCommonParent.Promise)
local Url = require(AuthCommonParent.Http).Url

local function getChangePasswordUrl(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("%sv2/user/passwords/change", Url.AUTH_URL)
end

return function(arg1, newPassword)
    local postBody = HttpService:JSONEncode({ currentPassword = nil, newPassword = newPassword })

    return arg1(getChangePasswordUrl(), "POST", { postBody = postBody }):andThen(function(arg2)
        return Promise.resolve(arg2)
    end, function(arg2)
        return Promise.reject(arg2)
    end)
end
