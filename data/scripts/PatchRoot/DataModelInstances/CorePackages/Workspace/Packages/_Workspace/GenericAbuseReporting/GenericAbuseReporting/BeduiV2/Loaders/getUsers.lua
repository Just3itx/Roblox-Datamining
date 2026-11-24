-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Foundation = require(GenericAbuseReportingParent.Foundation)
local Promise = require(GenericAbuseReportingParent.Promise)

local FFlagAbuseReportInExpPlayerListV3 = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportInExpPlayerListV3
local recentlyLeftSignals = require(GenericAbuseReporting.BeduiV2.Utils.Signals.recentlyLeftSignals)

local AccessoryType = Foundation.Enums.AccessoryType

local function appendRecentlyLeftItems<T>(tbl1, tbl2, recentlyLeft): T
    local var1 = table.clone(recentlyLeft)
    table.sort(var1, function(arg1, arg2): boolean
        return arg1.username:lower() < arg2.username:lower()
    end)

    for _, value in ipairs(var1) do
        if tbl2[tostring(value.userId)] then
            continue
        end

        table.insert(tbl1, {
            leading = {
                type = AccessoryType.Avatar,
                userId = value.userId
            },
            id = tostring(value.userId),
            label = value.displayName,
            description = value.username,
            meta = {
                username = value.username,
                displayName = value.displayName
            }
        })
    end

    return tbl1
end

local function getUsers()
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            local players = Players:GetPlayers()
            table.sort(players, function(player: Player, player2: Player): boolean
                return player.Name:lower() < player2.Name:lower()
            end)

            local result = {}
            local tbl1 = {}
            for _, player in ipairs(players) do
                if LocalPlayer and player.UserId == LocalPlayer.UserId then
                    continue
                end

                if FFlagAbuseReportInExpPlayerListV3 then
                    local userId = player.UserId
                    tbl1[tostring(userId)] = true
                end
                table.insert(result, {
                    leading = {
                        type = AccessoryType.Avatar,
                        userId = player.UserId
                    },
                    id = tostring(player.UserId),
                    label = player.DisplayName,
                    description = player.Name,
                    meta = {
                        username = player.Name,
                        displayName = player.DisplayName
                    }
                })
            end

            if FFlagAbuseReportInExpPlayerListV3 then
                appendRecentlyLeftItems(result, tbl1, recentlyLeftSignals.getRecentlyLeft())
            end

            return result
        end)

        if success then
            callback(result)
            return
        end
        callback2(result)
    end)
end

return getUsers
