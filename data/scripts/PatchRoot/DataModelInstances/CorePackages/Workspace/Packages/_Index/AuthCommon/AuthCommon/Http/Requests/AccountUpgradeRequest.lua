-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local HttpService = game:GetService("HttpService")

local _Http = require(AuthCommonParent.Http)
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

return function(arg1, tbl1)
    local string2 = UrlBuilder.fromString("auth:v1/account/upgrade")

    local postBody = HttpService:JSONEncode({
        upgradeType = tbl1.upgradeType,
        username = tbl1.username,
        password = if tbl1.password == "" then nil else tbl1.password,
        birthday = if tbl1.birthday == "" then nil else tbl1.birthday,
        email = if tbl1.email == "" then nil else tbl1.email,
        gender = tbl1.gender
    })

    return arg1(string2(), "POST", {
        postBody = postBody,
        maxRetryCount = 0,
        headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    })
end
