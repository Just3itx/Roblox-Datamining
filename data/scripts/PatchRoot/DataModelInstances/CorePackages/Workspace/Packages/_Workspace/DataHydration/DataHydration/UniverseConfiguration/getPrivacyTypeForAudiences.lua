-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local Audience = require(DataHydration.UniverseActivation.UniverseActivationStoreTypes).Audience
local PrivacyType = require(script.Parent.UniverseConfigurationStoreTypes).PrivacyType

local tbl1 = {
    {
        audience = Audience.Public,
        privacyType = PrivacyType.Public
    },
    {
        audience = Audience.Friends,
        privacyType = PrivacyType.FriendsOnly
    }
}

return function(tbl2)
    for _, value in tbl1 do
        if table.find(tbl2, value.audience) then
            return value.privacyType
        end
    end

    return PrivacyType.Private
end
