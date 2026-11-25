-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local scriptParentParent = script.Parent.Parent
local Promise = require(scriptParentParent.Promise)

local AdsRewardServiceApi = require(script.Parent.AdsRewardServiceApi)

local module = {}
module.__index = module

function module.new()
    local tbl1 = {
        adShowsByPlayer = {}
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:abandonAdShow(arg1, str1: string, bool1: boolean): (Enum.ShowAdResult, string)
    self.adShowsByPlayer[arg1] = nil
    if bool1 then
        error(str1, 0)
    end
    return Enum.ShowAdResult.InternalError, str1
end

function module:onShowRewardedVideoAd(arg1, productId: number, num1: number?)
    if self.adShowsByPlayer[arg1] then
        return Enum.ShowAdResult.AdAlreadyShowing
    end

    local tbl1 = { productId = productId, resolvePlayback = nil }
    self.adShowsByPlayer[arg1] = tbl1

    local var1, var2 = AdsRewardServiceApi.validateRewardAndPlacement(productId, num1)
    if not var1 then
        return self:abandonAdShow(arg1, `Reward validation failed - {var2}`, false)
    elseif not var1.isValidReward then
        return self:abandonAdShow(arg1, `Reward is invalid for product id {productId}`, true)
    elseif arg1.Parent ~= Players then
        return self:abandonAdShow(arg1, "Player instance is null in validation callback", false)
    elseif num1 ~= nil and not var1.isValidPlacement then
        return self:abandonAdShow(arg1, `AdService:ShowRewardedVideoAdAsync - Invalid placementId '{num1}'`, true)
    else
        local success, result = pcall(function()
            AdService:PlayRewardedVideoAdOnClient(
                arg1,
                {
                    productId = productId,
                    productName = var1.productName,
                    imageAssetIdString = var1.imageAssetIdString
                },
                num1 or var1.defaultPlacementId
            )
        end)

        if not success then
            return self:abandonAdShow(arg1, `Failed to start playback - {result}`, false)
        end

        return Promise.new(function(resolvePlayback)
            tbl1.resolvePlayback = resolvePlayback
        end):expect()
    end
end

function module:onRewardedVideoAdResult(arg1, showAdResult, str1: string, str2: string)
    local var1 = self.adShowsByPlayer[arg1]
    if not (var1 and var1.resolvePlayback) then
        return
    end

    self.adShowsByPlayer[arg1] = nil
    var1.resolvePlayback(showAdResult)
    if showAdResult ~= Enum.ShowAdResult.ShowCompleted then
        return
    end

    task.spawn(function()
        if not RunService:IsStudio() then
            local var2, var3 = AdsRewardServiceApi.grantAdReward(arg1.UserId, var1.productId, str1, str2)

            if not var2 then
                warn(`Failed to grant ad reward: {var3}`)
                return
            end
        end

        AdService:CompleteRewardedVideoGrant(arg1.UserId, var1.productId)
    end)
end

function module:onPlayerRemoving(arg1)
    local var1 = self.adShowsByPlayer[arg1]
    self.adShowsByPlayer[arg1] = nil
    if var1 and var1.resolvePlayback then
        var1.resolvePlayback(Enum.ShowAdResult.ShowInterrupted)
    end
end

return module
