-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local _Http = require(AuthCommonParent.Http)
local getSingleSignOnUrls = require(AuthCommon.Utils.getSingleSignOnUrls)
local ConsoleAuthRequestWrapper = require(AuthCommonParent.Http).Utils.ConsoleAuthRequestWrapper
local Promise = require(AuthCommonParent.Promise)

return function(arg1)
    local disconnect = getSingleSignOnUrls().disconnect
    if disconnect then
        return ConsoleAuthRequestWrapper(arg1, disconnect(), "POST", { postBody = "", maxRetryCount = 0 })
    end

    return Promise.reject({})
end
