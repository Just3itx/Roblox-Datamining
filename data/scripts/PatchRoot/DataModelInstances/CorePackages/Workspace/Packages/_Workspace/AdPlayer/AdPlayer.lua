-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local CoreGui = game:GetService("CoreGui")

local script = script
local scriptParent = script.Parent
local AdPlayerComponent = require(script.components.AdPlayerComponent)
local AdsDisplayOrder = require(scriptParent.AdGuiInteractivity).AdsDisplayOrder
local ReactRoblox = require(scriptParent.ReactRoblox)
local React = require(scriptParent.React)
local BaseComponent = require(script.components.BaseComponent)

local module = {
    ["jest.config"] = script["jest.config"]
}

function module.init()
    local rewardedVideoAdPlayer = Instance.new("ScreenGui")
    rewardedVideoAdPlayer.Name = "RewardedVideoAdPlayer"
    rewardedVideoAdPlayer.DisplayOrder = AdsDisplayOrder.AdPlayer
    rewardedVideoAdPlayer.IgnoreGuiInset = true
    rewardedVideoAdPlayer.ResetOnSpawn = false
    rewardedVideoAdPlayer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    rewardedVideoAdPlayer.Parent = CoreGui

    local root = ReactRoblox.createRoot(rewardedVideoAdPlayer)

    function AdService.onDemandVideoPlayInUI(data)
        local function onVideoCompleted(showAdResult: Enum.ShowAdResult) -- Luacid: Inlined by compiler; 2 call sites recovered
            root:render(nil)

            AdService:onDemandVideoCompleteFromUI(
                showAdResult,
                data.encryptedAdTrackingData,
                data.encryptionMetadata,
                data.rewardDetails
            )
        end

        local bindableEvent = Instance.new("BindableEvent")
        local var1 = nil
        root:render(
            React.createElement(BaseComponent, {}, {
                React.createElement(AdPlayerComponent, {
                    isEligible = data.isEligible,
                    creativeAssetUrl = data.creativeAssetUrl,
                    onVideoFrameLoaded = function(arg1)
                        var1 = arg1
                        if bindableEvent then
                            bindableEvent:Fire()
                        end
                    end,
                    onCancel = function()
                        onVideoCompleted(Enum.ShowAdResult.ShowInterrupted)
                    end,
                    onComplete = function()
                        onVideoCompleted(Enum.ShowAdResult.ShowCompleted)
                    end,
                    showWhyThisAd = function()
                        AdService:HandleWhyThisAdClicked("advertiserName", "payerName")
                    end,
                    getReportAdInfo = function()
                        return {
                            assetId = data.creativeAssetUrl,
                            adUnitName = "Rewarded Video Ad",
                            encryptionMetadata = data.encryptionMetadata,
                            encryptedAdTrackingData = data.encryptedAdTrackingData
                        }
                    end
                })
            })
        )
        if not var1 then
            bindableEvent.Event:Wait()
        end

        bindableEvent:Destroy()
        return var1
    end
end

return module
