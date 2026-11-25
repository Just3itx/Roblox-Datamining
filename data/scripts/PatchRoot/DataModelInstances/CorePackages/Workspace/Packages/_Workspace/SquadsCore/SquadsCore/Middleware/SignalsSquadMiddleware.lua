-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")

local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)
local GetSquadExperienceInviteStore = require(SquadsCore.Stores.GetSquadExperienceInviteStore)

local tbl1 = {}
tbl1[NetworkingSquads.GetExperienceInvite.Succeeded.name] = function(arg1)
    GetSquadExperienceInviteStore(false).getExperienceInviteSucceeded(arg1.responseBody)
end

tbl1[NetworkingSquads.VoteForExperienceInvite.Succeeded.name] = function(arg1)
    GetSquadExperienceInviteStore(false).voteForExperienceInviteSucceeded(arg1.responseBody)
end

local function SignalsSquadMiddleware(arg1, _)
    return function(arg2)
        local var1 = arg1(arg2)

        local var2 = tbl1[arg2.type]
        if var2 then
            var2(arg2)
        end

        return var1
    end
end

return SignalsSquadMiddleware
