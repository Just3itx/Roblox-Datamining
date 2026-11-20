-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local APIUtil = require(scriptParentParent.util.APIUtil)

local HttpService = game:GetService("HttpService")

local baseDomain = APIUtil.getBaseDomain()
local str1 = string.format("https://apis.%s", baseDomain) .. "assets/rcc/v1/assets/%s"

local function getAssetCreationDetailsRCC(str2: string)
    local str3 = string.format(str1, str2)
    local var1, input = APIUtil.requestAndRetryGet(str3)

    if var1 then
        return true, HttpService:JSONDecode(input)
    end
    return false, input
end

return getAssetCreationDetailsRCC
