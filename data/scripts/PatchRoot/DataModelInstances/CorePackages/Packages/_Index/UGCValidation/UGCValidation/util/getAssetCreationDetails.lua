-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local APIUtil = require(scriptParentParent.util.APIUtil)

local HttpService = game:GetService("HttpService")

local baseDomain = APIUtil.getBaseDomain()
local str1 = string.format("https://itemconfiguration.%s", baseDomain) .. "v1/creations/get-asset-details"

local function getAssetCreationDetails(assetIds)
    local var1, input = APIUtil.requestAndRetryPost(str1, HttpService:JSONEncode({ assetIds = assetIds }))

    if var1 then
        return true, HttpService:JSONDecode(input)
    end
    return false, input
end

return getAssetCreationDetails
