-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxNetworking = require(script.Parent.RoduxNetworking)

return function(arg1)
    local networkImpl = RoduxNetworking.getNetworkImpl()
    RoduxNetworking.setNetworkImpl(arg1)

    return function()
        RoduxNetworking.setNetworkImpl(networkImpl)
    end
end
