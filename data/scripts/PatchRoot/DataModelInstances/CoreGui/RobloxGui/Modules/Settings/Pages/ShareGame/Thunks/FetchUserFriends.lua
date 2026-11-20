-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame

local RetrievalStatus = require(CorePackages.Workspace.Packages.Http).Enum.RetrievalStatus
local ApiFetchUsersFriends = require(ShareGame.Thunks.ApiFetchUsersFriends)

local Constants = require(ShareGame.Constants)
local UserSorts = require(RobloxGui.Modules.Settings.Enum.UserSorts)

local GetFFlagInviteListRerank = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagInviteListRerank

return function(arg1, arg2)
    return function(arg3)
        if arg3:getState().Friends.retrievalStatus[arg2] == RetrievalStatus.Fetching then
            return
        end

        local var1 = ApiFetchUsersFriends
        local var2 = arg1
        local var3 = arg2
        local inviteToGame = Constants.ThumbnailRequest.InviteToGame
        local statusFrequents = if GetFFlagInviteListRerank() then UserSorts.StatusFrequents else nil
        arg3:dispatch(var1(var2, var3, inviteToGame, statusFrequents))
    end
end
