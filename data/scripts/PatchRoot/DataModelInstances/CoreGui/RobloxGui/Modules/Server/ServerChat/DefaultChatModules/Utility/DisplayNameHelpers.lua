-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

local CommandErrorCodes = { ChattingToSelf = 1, NoMatches = 2, MultipleMatches = 3 }

return {
    CommandErrorCodes = CommandErrorCodes,
    getUserNameFromChattedName = function(arg1, name, arg2)
        if name == arg1 then
            return name, CommandErrorCodes.ChattingToSelf
        end

        local players = Players:GetPlayers()

        for _, player in pairs(players) do
            if string.lower(player.Name) == string.lower(arg1) then
                return player.Name, nil
            end
        end

        local num1 = 0
        local name2 = nil

        if ChatSettings.PlayerDisplayNamesEnabled then
            for _, player in pairs(players) do
                if player.Name ~= name and string.lower(player.DisplayName) == string.lower(arg1) then
                    num1 += 1
                    name2 = player.Name
                end
            end
        end

        if num1 == 1 then
            return name2, nil
        elseif num1 == 0 then
            if arg2 == arg1 then
                return arg2, CommandErrorCodes.ChattingToSelf
            end
            return arg1, CommandErrorCodes.NoMatches
        elseif num1 >= 2 then
            return arg1, CommandErrorCodes.MultipleMatches
        end
    end,
    getUsersWithDisplayNameString = function(arg1, name)
        local tbl2 = {}
        local str1 = ""

        local players = Players:GetPlayers()

        for _, player in pairs(players) do
            if player.Name ~= name and string.lower(player.DisplayName) == string.lower(arg1) then
                table.insert(tbl2, player.Name)
            end
        end

        for k, value in pairs(tbl2) do
            if k ~= #tbl2 then
                str1 ..= "@" .. value .. ", "
            else
                str1 ..= "@" .. value
            end
        end

        return str1
    end
}
