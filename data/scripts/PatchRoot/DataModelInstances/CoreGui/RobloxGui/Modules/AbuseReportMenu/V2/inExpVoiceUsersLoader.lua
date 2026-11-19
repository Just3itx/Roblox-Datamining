-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Foundation = require(CorePackages.Packages.Foundation)
local RobloxGui = CoreGui.RobloxGui

local AccessoryType = Foundation.Enums.AccessoryType

local Promise = require(CorePackages.Packages.Promise)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

return {
    type = "listItem",
    fetch = function(_)
        local success, result = pcall(function()
            return default:getRecentUsersInteractionData()
        end)

        if not success then
            return Promise.reject("Failed to fetch voice users")
        end

        if not result then
            return Promise.resolve({})
        end
        local localPlayer = Players.LocalPlayer
        local tbl1 = {}
        for _, value in pairs(result) do
            local player = value.player
            local bool1 = if localPlayer then player.UserId == localPlayer.UserId else false

            if not player or bool1 then
                continue
            end

            table.insert(tbl1, {
                leading = {
                    type = AccessoryType.Avatar,
                    userId = player.UserId
                },
                id = tostring(player.UserId),
                label = player.DisplayName,
                description = "@" .. player.Name,
                meta = {
                    username = player.Name,
                    displayName = player.DisplayName
                }
            })
        end
        table.sort(tbl1, function(arg1, arg2): boolean
            return arg1.label < arg2.label
        end)
        return Promise.resolve(tbl1)
    end
}
