-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)
local RoduxSquads = require(SquadsCore.RoduxSquads)
local Logger = require(SquadsCore.Logger)

local SquadsCoreParent = SquadsCore.Parent
local FFlagEnableSquadRegroupExperimentation = require(SquadsCoreParent.SharedFlags).FFlagEnableSquadRegroupExperimentation

return function(groupUpId: string)
    return function(arg1)
        if not FFlagEnableSquadRegroupExperimentation then
            return
        end

        arg1:dispatch(NetworkingSquads.SetRegroupPromptShown.API({ groupUpId = groupUpId })):andThen(function(arg2)
            if arg2.success then
                arg1:dispatch(RoduxSquads.Actions.SelfPermissionUpdated({ canSeeRegroupPromptToast = false }))
            end
        end):catch(function(arg2)
            Logger:error("Error occured with NetworkingSquads.SetRegroupPromptShown: {}", tostring(arg2))
        end)
    end
end
