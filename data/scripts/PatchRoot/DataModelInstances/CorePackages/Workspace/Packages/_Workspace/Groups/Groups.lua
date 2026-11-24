-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local script2 = script

local module = {
    GroupsInExperienceApp = require(script2.GroupsInExperienceApp),
    GroupsList = require(script2.Components.GroupsList),
    GroupsPage = require(script2.Components.GroupsPage),
    Common = require(script2.Common),
    Networking = require(script2.Networking),
    Contexts = require(script2.Contexts),
    Hooks = require(script2.Hooks),
    Navigation = require(script2.Navigation),
    CommunityListRouting = require(script2.CommunityListRouting)
}

function module.getGroupSidebar()
    return require(script2.Common.GroupSidebar)
end

module["jest.config"] = script["jest.config"]
return module
