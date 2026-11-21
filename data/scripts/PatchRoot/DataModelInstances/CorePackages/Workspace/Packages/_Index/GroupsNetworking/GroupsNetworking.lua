-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:50:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.networkRequests
local createJoinGroup = require(networkRequests.createJoinGroup)
local createCancelJoinGroupRequest = require(networkRequests.createCancelJoinGroupRequest)
local createLeaveGroup = require(networkRequests.createLeaveGroup)
local createMakePrimaryGroup = require(networkRequests.createMakePrimaryGroup)
local createRemovePrimaryGroup = require(networkRequests.createRemovePrimaryGroup)

local module = {}

function module.config(tbl1)
    return {
        JoinGroup = createJoinGroup(tbl1),
        CancelJoinGroupRequest = createCancelJoinGroupRequest(tbl1),
        LeaveGroup = createLeaveGroup(tbl1),
        MakePrimaryGroup = createMakePrimaryGroup(tbl1),
        RemovePrimaryGroup = createRemovePrimaryGroup(tbl1)
    }
end

module["jest.config"] = script["jest.config"]
return module
