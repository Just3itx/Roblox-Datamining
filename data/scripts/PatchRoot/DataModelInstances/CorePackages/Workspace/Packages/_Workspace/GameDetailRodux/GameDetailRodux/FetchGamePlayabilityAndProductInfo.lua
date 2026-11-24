-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent
local Promise = require(GameDetailRoduxParent.Promise)
local PlayabilityStatusEnum = require(GameDetailRoduxParent.DiscoveryTypes).PlayabilityStatusEnum
local ApiFetchPlayabilityStatus = require(GameDetailRoduxParent.PlayabilityRodux).PlayabilityStatus.ApiFetchPlayabilityStatus
local PerformFetch = require(GameDetailRoduxParent.Http).PerformFetch
local FetchGamesProductInfo = require(GameDetailRoduxParent.GameProductInfoRodux).FetchGamesProductInfo

local function keyMapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.playability-and-productinfo." .. arg1
end

local module = { KeyMapper = keyMapper }

function module.Fetch(arg1, str1: string)
    assert(type(str1) == "string", "FetchPlayabilityAndProductInfo thunk expects universeId to be a string")

    return PerformFetch.Single(keyMapper(str1), function(arg2)
        return arg2:dispatch(ApiFetchPlayabilityStatus.Fetch(arg1, { str1 })):andThen(function(arg3)
            local var1, _ = arg3[ApiFetchPlayabilityStatus.KeyMapper(str1)]:unwrap()
            if not var1 then
                return Promise.reject()
            end

            local var2 = arg2:getState().PlayabilityStatus[str1]

            if var2.isPlayable ~= false
                or var2.playabilityStatus ~= PlayabilityStatusEnum.PurchaseRequired
                    and var2.playabilityStatus ~= PlayabilityStatusEnum.FiatPurchaseRequired
            then
                return Promise.resolve(var2.playabilityStatus)
            end

            return arg2:dispatch(FetchGamesProductInfo.Fetch(arg1, { str1 })):andThen(function(arg4)
                local var3, _ = arg4[FetchGamesProductInfo.KeyMapper(str1)]:unwrap()
                if var3 then
                    return Promise.resolve(var2.playabilityStatus)
                end
                return Promise.reject()
            end)
        end)
    end)
end

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (keyMapper(arg2)))
end

return module
