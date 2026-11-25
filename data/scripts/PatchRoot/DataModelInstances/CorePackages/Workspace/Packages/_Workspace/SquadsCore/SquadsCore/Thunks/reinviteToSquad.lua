-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)
local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)

local Logger = require(SquadsCoreParent.Loggers).Logger
local Promise = require(SquadsCoreParent.Promise)

local logger = Logger.new(Logger, "SquadsCore")

return function(squadId: string, callback: (...any) -> (...any))
    return function(arg1)
        return arg1:dispatch(NetworkingSquads.ReinviteToSquad.API({ squadId = squadId })):catch(function(arg2)
            logger:warning(
                "Error reinviting parent channel participants to squad: {}",
                if arg2.StatusCode then arg2.StatusCode else -1
            )

            callback(arg1, { hideCancelButton = true, promptType = SquadPromptType.Error })

            return Promise.reject(arg2)
        end)
    end
end
