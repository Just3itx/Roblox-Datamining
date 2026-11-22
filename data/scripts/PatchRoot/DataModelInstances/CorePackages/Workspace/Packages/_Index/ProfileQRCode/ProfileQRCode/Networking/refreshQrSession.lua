-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local Http = require(ProfileQRCodeParent.Http)

local function func1(func2: (...any) -> (...any), _)
    return func2(Http.Url.FRIEND_URL):path("my"):path("friends"):path("refresh-qr-session"):body({})
end

return (function(arg1)
    return arg1.POST(script.Name, func1)
end)((require(script.Parent.configuredRoduxNetworking)))
