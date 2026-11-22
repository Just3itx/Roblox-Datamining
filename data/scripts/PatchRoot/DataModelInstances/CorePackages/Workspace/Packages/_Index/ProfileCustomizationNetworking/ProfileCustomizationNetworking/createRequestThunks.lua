-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.Parent.networkRequests
local createUpdateProfileCustomization = require(networkRequests.createUpdateProfileCustomization)
local createGetProfileCustomization = require(networkRequests.createGetProfileCustomization)

return function(tbl1)
    return {
        UpdateProfileCustomization = createUpdateProfileCustomization(tbl1),
        GetProfileCustomization = createGetProfileCustomization(tbl1)
    }
end
