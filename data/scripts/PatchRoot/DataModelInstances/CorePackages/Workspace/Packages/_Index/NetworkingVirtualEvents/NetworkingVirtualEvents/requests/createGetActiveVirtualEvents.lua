-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NetworkingVirtualEvents = script:FindFirstAncestor("NetworkingVirtualEvents")

local Http = require(NetworkingVirtualEvents.Parent.Http)

return function(arg1)
    return (arg1.GET(script.Name, function(arg2, tbl1)
        local var1 = arg2(Http.Url.APIS_URL):path("virtual-events"):path("v1"):path("virtual-events"):path("active")

        if tbl1 then
            var1 = var1:queryArgs(tbl1)
        end

        return var1
    end))
end
