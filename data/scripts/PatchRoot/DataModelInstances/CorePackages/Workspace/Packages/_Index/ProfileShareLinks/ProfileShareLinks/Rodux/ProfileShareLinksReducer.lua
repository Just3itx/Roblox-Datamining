-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileShareLinks = script:FindFirstAncestor("ProfileShareLinks")
local ProfileShareLinksParent = ProfileShareLinks.Parent
local Rodux = require(ProfileShareLinksParent.Rodux)

local Networking = require(ProfileShareLinks.Networking.Networking)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[Networking.ShareLinksNetworking.GetOrGenerateLink.Succeeded.name] = function(_, arg1)
    return arg1.responseBody
end

return createReducer({}, tbl1)
