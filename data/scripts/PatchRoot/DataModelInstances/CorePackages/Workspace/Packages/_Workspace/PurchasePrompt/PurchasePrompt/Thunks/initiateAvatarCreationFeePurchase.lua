-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local RequestAvatarCreationFeePurchase = require(scriptParentParent.Actions.RequestAvatarCreationFeePurchase)
local Promise = require(scriptParentParent.Promise)
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local ExternalSettings = require(scriptParentParent.Services.ExternalSettings)
local getBalanceInfo = require(scriptParentParent.Network.getBalanceInfo)
local getAccountInfo = require(scriptParentParent.Network.getAccountInfo)
local ErrorOccurred = require(scriptParentParent.Actions.ErrorOccurred)
local getUnifiedPurchaseFlowEligibility = require(scriptParentParent.Network.getUnifiedPurchaseFlowEligibility)
local resolvePromptState = require(script.Parent.resolvePromptState)

local tbl1 = { Network, ExternalSettings }

local function initiateAvatarCreationFeePurchase(arg1, arg2, arg3, priceInRobux)
    return Thunk.new(script.Name, tbl1, function(arg4, arg5)
        local var1 = arg5[Network]
        local var2 = arg5[ExternalSettings]

        arg4:dispatch(RequestAvatarCreationFeePurchase(arg3, arg2))

        return Promise.all({
            accountInfo = getAccountInfo(var1, var2),
            balanceInfo = getBalanceInfo(var1, var2, true),
            isUserEligibleForUnifiedPurchaseFlow = getUnifiedPurchaseFlowEligibility(var1)
        }):andThen(
            function(arg6)
                local tbl2 = {
                    PriceInRobux = priceInRobux,
                    Name = arg1.name,
                    Description = arg1.description
                }
                arg4:dispatch(
                    resolvePromptState(
                        tbl2,
                        arg6.accountInfo,
                        arg6.balanceInfo,
                        false,
                        true,
                        priceInRobux,
                        arg6.isUserEligibleForUnifiedPurchaseFlow
                    )
                )
            end
        ):catch(
            function(arg6)
                arg4:dispatch(ErrorOccurred(arg6))
            end
        )
    end)
end
return initiateAvatarCreationFeePurchase
