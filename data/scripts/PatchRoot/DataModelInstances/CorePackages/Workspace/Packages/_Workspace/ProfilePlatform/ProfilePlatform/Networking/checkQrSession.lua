-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local myRoduxNetworking = require(ProfilePlatform.Networking.myRoduxNetworking)
local ProfilePlatformParent = ProfilePlatform.Parent
local Http = require(ProfilePlatformParent.Http)

return myRoduxNetworking.GET("CheckQRSession", function(arg1, arg2) -- name: buildUrl
    return arg1(Http.Url.FRIEND_URL):path("my"):path("friends"):path(tostring(arg2)):path("check-qr-session")
end)
