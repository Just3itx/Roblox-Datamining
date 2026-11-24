-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local var1 = require(ExpChatShared.Logger):new("ExpChat/Command/Team")

local Actions = ExpChatShared.Actions
local ChatInputBarActivatedTeamMode = require(Actions.ChatInputBarActivatedTeamMode)

local _types = require(script.Parent.types)

return {
    name = script.Name,
    alias = { "/team", "/t", "%%" },
    clientRun = function(arg1, _, _)
        if arg1:getState().LocalTeam then
            arg1:dispatch(ChatInputBarActivatedTeamMode())

            return { key = "", metadata = "Roblox.Team.Info.Success" }
        end

        var1:debug("Could not team chat because not in team")
        return {
            key = "CoreScripts.TextChat.TeamChat.Error.NotOnTeam",
            metadata = "Roblox.Team.Error.CannotTeamChatIfNotInTeam"
        }
    end
}
