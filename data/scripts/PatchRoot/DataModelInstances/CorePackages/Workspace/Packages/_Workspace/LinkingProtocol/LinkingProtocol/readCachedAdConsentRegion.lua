-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local MockableProxyServices = require(scriptParentParent.MockableProxyServices)

local function readCachedAdConsentRegion()
    return MockableProxyServices.AppStorageService:GetItem("CountryCode")
end

return readCachedAdConsentRegion
