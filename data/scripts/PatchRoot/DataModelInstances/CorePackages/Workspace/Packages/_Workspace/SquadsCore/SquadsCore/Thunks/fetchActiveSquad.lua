-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)

local Logger = require(SquadsCoreParent.Loggers).Logger
local Promise = require(SquadsCoreParent.Promise)

local logger = Logger.new(Logger, "SquadsCore")

return function()
    return function(arg1)
        return arg1:dispatch(NetworkingSquads.GetSquadActive.API({})):catch(function(arg2)
            logger:warning("Error fetching active squad: {}", if arg2.StatusCode then arg2.StatusCode else -1)
            return Promise.reject(arg2)
        end)
    end
end
