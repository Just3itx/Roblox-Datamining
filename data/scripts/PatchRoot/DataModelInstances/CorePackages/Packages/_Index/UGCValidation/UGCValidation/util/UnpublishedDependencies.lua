-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local APIUtil = require(scriptParentParent.util.APIUtil)
local _Types = require(scriptParentParent.util.Types)
local getFFlagUGCValidateDescendantIdsPublished = require(scriptParentParent.flags.getFFlagUGCValidateDescendantIdsPublished)

local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local str1 = `https://apis.{APIUtil.getBaseDomain()}assets/rcc/v1/assets/`

local module = {}

function module.getLatestVersionNumber(str2: string): number?
    local revisionId = HttpService:JSONDecode(HttpRbxApiService:GetAsyncFullUrl(str1 .. str2)).revisionId
    return assert(tonumber(revisionId), `Unexpected revisionId {revisionId}`)
end

function module.getVersion(str2: string, num1: number?)
    local var1 = num1 or module.getLatestVersionNumber(str2)
    return HttpService:JSONDecode(HttpRbxApiService:GetAsyncFullUrl(`{str1}{str2}/versions/{var1}`))
end

function module.shouldReturnOnLoadFailure(arg1)
    local fFlagUgcValidateDescendantIdsPublished = getFFlagUGCValidateDescendantIdsPublished()
    return fFlagUgcValidateDescendantIdsPublished
        and arg1.universeId == nil
        and arg1.token == nil
        and not arg1.allowEditableInstances
end

return module
