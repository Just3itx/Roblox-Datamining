-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Achievements = script:FindFirstAncestor("Achievements")
local AchievementsParent = Achievements.Parent

local _Signal = require(AchievementsParent.Signal)
local Logger = require(Achievements.Logger)
local GetUserVoteCount = require(Achievements.Requests.GetUserVoteCount)
local Promise = require(AchievementsParent.Promise)
local _LuauPolyfill = require(AchievementsParent.LuauPolyfill)
local Dash = require(AchievementsParent.Dash)

local module = ({})

function module.init(arg1, fireVoteCountChanged, store, requestImpl, platformCloudStorageService)
    arg1.fireVoteCountChanged = fireVoteCountChanged
    arg1.store = store
    arg1.requestImpl = requestImpl
    arg1.platformCloudStorageService = platformCloudStorageService
end

function module.start(arg1)
    arg1.storeChangedConnection = arg1.store.changed:connect(function(arg2, arg3)
        local localUserGameVoteCounter = arg3.LocalUserGameVoteCounter
        local localUserGameVoteCounter2 = arg2.LocalUserGameVoteCounter
        if localUserGameVoteCounter ~= localUserGameVoteCounter2 and localUserGameVoteCounter2.voteCountSinceAppStart > 0 then
            local lastUniverseId = localUserGameVoteCounter2.lastUniverseId
            arg1:_checkPollster(lastUniverseId):catch(function(arg4)
                Logger:warning(arg4)
            end)
        end
    end)
end

function module._checkPollster(arg1, arg2)
    if arg1.platformCloudStorageService and arg1.platformCloudStorageService:IsUserDataAvailable() then
        return Promise.new(function()
            local data = arg1.platformCloudStorageService:GetUserDataAsync("UniversesVoted").data or {}
            if #data < 5 and not Dash.includes(data, arg2) then
                table.insert(data, arg2)
                arg1.platformCloudStorageService:SetUserDataAsync("UniversesVoted", { data = data })
            end
            arg1.fireVoteCountChanged(#data)
        end)
    end
    return GetUserVoteCount(arg1.requestImpl):andThen(function(arg3)
        if arg3.responseBody == nil then
            Logger:warning("Response has no body.")
            return
        end

        local voteCount = arg3.responseBody.voteCount

        if voteCount == nil then
            Logger:warning("Response has no voteCount field.")
            return
        end

        arg1.fireVoteCountChanged(voteCount)
    end)
end

function module.stop(arg1)
    if arg1.storeChangedConnection then
        arg1.storeChangedConnection:disconnect()
        arg1.storeChangedConnection = nil
    end
end

return module
