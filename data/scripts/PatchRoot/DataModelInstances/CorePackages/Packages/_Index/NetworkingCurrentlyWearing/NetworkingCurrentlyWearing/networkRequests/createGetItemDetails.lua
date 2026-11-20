-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NetworkingCurrentlyWearingParent = script:FindFirstAncestor("NetworkingCurrentlyWearing").Parent
local Dash = require(NetworkingCurrentlyWearingParent.Dash)

local CATALOG_URL = require(script.Parent.Parent.CATALOG_URL)

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "GetItemDetails" }, function(arg2, arg3)
        return arg2(CATALOG_URL):path("v1"):path("catalog"):path("items"):path("details"):body({
            items = Dash.map(arg3, function(id)
                return { itemType = "Asset", id = id }
            end)
        })
    end)
end
