-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local scriptParentParent = script.Parent.Parent
local OpenReportSentDialog = require(scriptParentParent.Actions.OpenReportSentDialog)

return function(reason: string, optionalMessage: string, userId: number | User)
    return function(arg1)
        if userId ~= nil then
            local player = Players:GetPlayerByUserId(userId)
            if player then
                coroutine.wrap(function()
                    Players:ReportAbuse(player, reason, optionalMessage)
                    arg1:dispatch(OpenReportSentDialog())
                end)()
            end

            return
        end

        local state = arg1:getState()

        local name = state.gameInfo.name
        local description = state.gameInfo.description

        if name == "" then
            return
        end

        local var1 = string.format(
            "User Report: \n    %s \nPlace Title: \n    %s \nPlaceId: \n    %s \nPlace Description: \n    %s \n",
            optionalMessage,
            name,
            tostring(game.PlaceId),
            description
        )

        coroutine.wrap(function()
            if not RunService:IsStudio() then
                Players:ReportAbuse(nil, reason, var1)
            end
            arg1:dispatch(OpenReportSentDialog())
        end)()
    end
end
