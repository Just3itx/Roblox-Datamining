-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)
local _networkRequestsTypes = require(scriptParentParent.Types.networkRequestsTypes)

game:DefineFastString("ContactImporterUploadUrl", "contacts")
local fastString = game:GetFastString("ContactImporterUploadUrl")

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "UploadContactsByUser" }, function(arg2, arg3)
        return arg2(API_URL):path("contacts-api"):path("v1"):path(fastString):body(
            {
                countryCode = arg3.countryCode,
                contacts = arg3.contacts
            }
        )
    end)
end
