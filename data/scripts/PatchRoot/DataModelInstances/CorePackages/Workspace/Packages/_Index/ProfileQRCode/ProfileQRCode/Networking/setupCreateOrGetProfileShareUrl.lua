-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local Http = require(ProfileQRCodeParent.Http)

local function buildUrl(func2: (...any) -> (...any), _)
    return func2(Http.Url.APIS_URL .. "sharelinks"):path("v1"):path("get-or-create-link"):body({ linkType = "Profile" })
end

return {
    profileLinkType = "Profile",
    buildUrl = buildUrl,
    setupRequest = function(arg1)
        return arg1.POST(script.Name, buildUrl)
    end
}
