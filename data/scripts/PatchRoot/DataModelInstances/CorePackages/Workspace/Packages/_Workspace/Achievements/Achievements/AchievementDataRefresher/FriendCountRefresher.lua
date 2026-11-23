-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Achievements = script:FindFirstAncestor("Achievements")
local AchievementsParent = Achievements.Parent

local Logger = require(Achievements.Logger)
local _Signal = require(AchievementsParent.Signal)

local module = ({})

function module.init(tbl1, fireFriendCountChanged, playersService)
    tbl1.fireFriendCountChanged = fireFriendCountChanged
    tbl1.playersService = playersService
    tbl1.friendIds = {}
    tbl1.friendCount = 0
end

function module.start(arg1)
    arg1.friendIds = arg1:_getFriendIds()
    for _, player in pairs(arg1.playersService:GetPlayers()) do
        arg1:_onPlayerAdded(player)
    end
    arg1.playerAdded = arg1.playersService.PlayerAdded:Connect(function(player: Player)
        arg1:_onPlayerAdded(player)
    end)
    arg1.playerRemoving = arg1.playersService.PlayerRemoving:Connect(function(player: Player)
        arg1:_onPlayerRemoving(player)
    end)
end

function module._getFriendIds(arg1)
    local function iterPageItems(pages) -- Luacid: unused: defined but never referenced
        return coroutine.wrap(function()
            local num1 = 1

            while true do
                for _, value in ipairs(pages:GetCurrentPage()) do
                    coroutine.yield(value, num1)
                end
                if pages.IsFinished then
                    return
                end

                pages:AdvanceToNextPageAsync()
                num1 += 1
            end
        end)
    end

    local success, result = pcall(function()
        local result = {}
        if arg1.playersService.LocalPlayer then
            local friendsAsync = arg1.playersService:GetFriendsAsync(arg1.playersService.LocalPlayer.UserId)

            for value, _ in coroutine.wrap(function()
                local num1 = 1

                while true do
                    for _, value in ipairs(friendsAsync:GetCurrentPage()) do
                        coroutine.yield(value, num1)
                    end
                    if friendsAsync.IsFinished then
                        return
                    end

                    friendsAsync:AdvanceToNextPageAsync()
                    num1 += 1
                end
            end) do
                result[value.Id] = true
            end
        end
        return result
    end)

    if not success then
        Logger:warning(result)
    end

    return success and result or {}
end

function module._onPlayerAdded(tbl1, arg1)
    if tbl1.friendIds[arg1.UserId] then
        tbl1.friendCount += 1
        tbl1.fireFriendCountChanged(tbl1.friendCount)
    end
end

function module._onPlayerRemoving(tbl1, arg1)
    if tbl1.friendIds[arg1.UserId] then
        tbl1.friendCount -= 1
        tbl1.fireFriendCountChanged(tbl1.friendCount)
    end
end

function module.stop(arg1)
    if arg1.playerAdded then
        arg1.playerAdded:Disconnect()
        arg1.playerAdded = nil
    end
    if arg1.playerRemoving then
        arg1.playerRemoving:Disconnect()
        arg1.playerRemoving = nil
    end
    arg1.friendIds = {}
    arg1.friendCount = 0
end

return module
