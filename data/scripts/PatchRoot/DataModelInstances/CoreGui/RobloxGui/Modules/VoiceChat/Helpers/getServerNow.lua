-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local MockableProxyServices = require(CorePackages.Workspace.Packages.MockableProxyServices)

local function getServerNow()
    local success, result = pcall(function()
        return MockableProxyServices.Workspace:GetServerTimeNow()
    end)

    if success then
        return result
    end

    return DateTime.now().UnixTimestamp
end

return getServerNow
