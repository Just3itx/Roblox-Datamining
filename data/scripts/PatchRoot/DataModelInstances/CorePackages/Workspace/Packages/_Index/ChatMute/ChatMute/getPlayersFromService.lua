-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getPlayersFromService(str1: string?)
    local Players = game:GetService("Players")
    if not str1 then
        return {}
    end

    local str2 = string.lower(str1)

    if string.sub(str2, 1, 1) ~= "@" then
        local playersFromService = {}
        for _, player in Players:GetPlayers() do
            if string.lower(player.DisplayName) ~= str2 then
                continue
            end

            table.insert(
                playersFromService,
                {
                    userId = tostring(player.UserId),
                    username = player.Name,
                    displayName = player.DisplayName
                }
            )
        end
        return playersFromService
    end

    local str3 = string.sub(str2, 2)
    for _, player in Players:GetPlayers() do
        if string.lower(player.Name) ~= str3 then
            continue
        end

        return {{
            userId = tostring(player.UserId),
            username = player.Name,
            displayName = player.DisplayName
        }}
    end

    return {}
end

return getPlayersFromService
