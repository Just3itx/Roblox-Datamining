-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local SocialService = game:GetService("SocialService")

local SharedFlags = require(SquadsCoreParent.SharedFlags)

local validateSquadId = require(SquadsCore.Common.validateSquadId)

local tbl1 = {}
tbl1.__index = tbl1

local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = SharedFlags.FFlagPartyDevAPIToRespectThirdPartySettingsEnabled

function tbl1.new()
    return (setmetatable({ isLeaveSquadPending = false, lastFiredSquadId = "" }, tbl1))
end

function tbl1.setLeaveSquadPendingAndFireEvent(tbl2, bool1: boolean, bool2: boolean)
    if tbl2:_setLeaveSquadPending(bool1) then
        tbl2:fireSquadChangeEvent(nil, bool2)
    end
end

function tbl1:fireSquadChangeEvent(str1: string?, bool1: boolean)
    local lastFiredSquadId = str1 or ""
    assert(lastFiredSquadId == "" or validateSquadId(lastFiredSquadId), "Try to fire with wrong squadId")

    if lastFiredSquadId ~= "" then
        self:_setLeaveSquadPending(false)
    end

    if (not self.isLeaveSquadPending or lastFiredSquadId ~= "") and self.lastFiredSquadId ~= lastFiredSquadId then
        self.lastFiredSquadId = lastFiredSquadId
        SocialService:UpdatePlayerPartyData(
            lastFiredSquadId,
            if FFlagPartyDevAPIToRespectThirdPartySettingsEnabled then not bool1 else nil
        )
    end
end

function tbl1:_setLeaveSquadPending(isLeaveSquadPending: boolean): boolean
    if self.isLeaveSquadPending == isLeaveSquadPending then
        return false
    end

    self.isLeaveSquadPending = isLeaveSquadPending
    return true
end

tbl1.default = tbl1.new()
return tbl1.default
