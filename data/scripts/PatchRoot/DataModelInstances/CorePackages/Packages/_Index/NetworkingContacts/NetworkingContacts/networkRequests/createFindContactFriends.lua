-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)
local _networkRequestsTypes = require(scriptParentParent.Types.networkRequestsTypes)

game:DefineFastString("ContactImporterFindFriendsUrl", "contacts")
local fastString = game:GetFastString("ContactImporterFindFriendsUrl")

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "FindContactFriends" }, function(arg2)
        return arg2(API_URL):path("contacts-api"):path("v1"):path(fastString)
    end)
end
