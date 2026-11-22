-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SQUAD_URL = require(script.Parent.Parent.SQUAD_URL)
local _networkingSquadTypes = require(script.Parent.Parent.networkingSquadTypes)

local Packages = script:FindFirstAncestor("Packages")
local FFlagEnableSquadRegroupExperimentation = require(Packages.SharedFlags).FFlagEnableSquadRegroupExperimentation
local FFlagEnablePrivatePartyStartJoin = require(Packages.SharedFlags).FFlagEnablePrivatePartyStartJoin

return function(arg1)
    return (arg1.roduxNetworking.POST("CreateExperienceInvite", function(arg2, arg3)
        local var1 = arg2(SQUAD_URL):path("group-up"):path("v1"):path("invite-to-experience")
        local tbl1 = {
            membershipEntityId = arg3.membershipEntityId,
            placeId = arg3.placeId,
            requestId = HttpService:GenerateGUID(false),
            voteIdentifier = arg3.voteIdentifier,
            source = if FFlagEnableSquadRegroupExperimentation then arg3.source else nil,
            inviteType = if FFlagEnablePrivatePartyStartJoin then arg3.inviteType else nil
        }
        return var1:body(tbl1)
    end))
end
