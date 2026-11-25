-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local Players = game:GetService("Players")

local RewardedVideoAdShowController = require(script.RewardedVideoAdShowController)

local module = {}

function module.serverStarterScript()
    local rewardedVideoAdShowController = RewardedVideoAdShowController.new()

    function AdService.OnShowRewardedVideoAd(arg1, tbl1)
        return rewardedVideoAdShowController:onShowRewardedVideoAd(arg1, tbl1.productId, tbl1.placementId)
    end

    function AdService.OnRewardedVideoAdResult(arg1, arg2, str1: string, str2: string)
        rewardedVideoAdShowController:onRewardedVideoAdResult(arg1, arg2, str1, str2)
    end

    Players.PlayerRemoving:Connect(function(player: Player)
        rewardedVideoAdShowController:onPlayerRemoving(player)
    end)
end

module["jest.config"] = script["jest.config"]
return module
