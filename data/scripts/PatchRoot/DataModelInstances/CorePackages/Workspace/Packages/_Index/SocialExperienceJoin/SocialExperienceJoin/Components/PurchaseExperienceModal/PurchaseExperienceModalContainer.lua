-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent

local React = require(SocialExperienceJoinParent.React)
local RoactUtils = require(SocialExperienceJoinParent.RoactUtils)
local Navigation = require(SocialExperienceJoinParent.Navigation)
local RobloxAppNavigation = require(SocialExperienceJoinParent.RobloxAppNavigation)
local RobloxAppHooks = require(SocialExperienceJoinParent.RobloxAppHooks)
local Promise = require(SocialExperienceJoinParent.Promise)

local PurchaseExperienceModal = require(script.Parent.PurchaseExperienceModal)
local PurchaseProductById = require(SocialExperienceJoin.Networking.PurchaseProductById)
local Constants = require(SocialExperienceJoin.Common.Constants)

local initializeSocialExperienceJoinAnalytics = require(SocialExperienceJoin.Analytics.initializeSocialExperienceJoinAnalytics)
local EventNames = require(SocialExperienceJoin.Analytics.EventNames)

local RODUX_KEY = Constants.RODUX_KEY
local useNavigation = Navigation.useNavigation

local useNavigationProps = RobloxAppNavigation.useNavigationProps
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useScreenSize = RobloxAppHooks.useScreenSize

local PurchaseExperienceStatus = require(SocialExperienceJoin.Analytics.PurchaseExperienceStatus)

return function()
    local var1 = useNavigation()
    local var2 = useDispatch()
    local var3 = useNavigationProps(function(universeId: string, tbl1)
        return {
            universeId = universeId,
            userId = tbl1.userId,
            openGameDetailsPeekView = tbl1.openGameDetailsPeekView,
            analyticProps = tbl1.analyticProps
        }
    end)
    local screenSize = useScreenSize()

    local var5 = React.useMemo(function()
        return initializeSocialExperienceJoinAnalytics(var3.analyticProps)
    end, { var3.analyticProps })

    local var6 = useSelector(function(arg1)
        return arg1[RODUX_KEY].Games.productInfoByGameId[var3.universeId]
    end)
    local var7 = useSelector(function(arg1)
        return arg1[RODUX_KEY].Games.byGameId[var3.universeId]
    end)

    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        var5.fireAnalyticsEvent(
            EventNames.PurchaseExperienceAttempt,
            {
                status = PurchaseExperienceStatus.Success,
                universeId = var3.universeId,
                profileUserId = var3.userId
            }
        )
    end

    local function func2(_) -- Luacid: Inlined by compiler; 1 call site recovered
        var5.fireAnalyticsEvent(
            EventNames.PurchaseExperienceAttempt,
            {
                status = PurchaseExperienceStatus.PurchaseError,
                universeId = var3.universeId,
                profileUserId = var3.userId
            }
        )
    end

    local function func3(_) -- Luacid: Inlined by compiler; 1 call site recovered
        var5.fireAnalyticsEvent(
            EventNames.PurchaseExperienceAttempt,
            {
                status = PurchaseExperienceStatus.NetworkError,
                universeId = var3.universeId,
                profileUserId = var3.userId
            }
        )
    end

    local var8 = React.useCallback(function()
        var1.pop()
    end, { var1 })

    local cancelPurchase = React.useCallback(function()
        var5.fireAnalyticsEvent(
            EventNames.CancelPurchaseExperience,
            {
                universeId = var3.universeId,
                profileUserId = var3.userId
            }
        )
        var8()
    end, { var8, var5, var3.universeId })

    local purchaseExperience = React.useCallback(function()
        var5.fireAnalyticsEvent(EventNames.PurchaseExperience, { universeId = var3.universeId, profileUserId = var3.userId })

        local function func4() -- Luacid: Inlined by compiler; 1 call site recovered
            return var2(
                PurchaseProductById.API(
                    var6.productId,
                    {
                        expectedCurrency = Constants.RobuxCurrency,
                        expectedPrice = var6.price,
                        expectedSellerId = var6.sellerId
                    }
                )
            )
        end

        func4():andThen(function(arg1)
            local responseBody = arg1.responseBody
            return type(responseBody) == "table" and responseBody or Promise.reject()
        end):andThen(function(arg1)
            var8()

            if arg1.purchased then
                func1()
                return
            end

            func2(nil)
        end):catch(function(_)
            var8()
            func3(nil)
        end)
    end, {
        var2,
        var6.productId,
        var6.price,
        var6.sellerId,
        var8
    })
    return React.createElement(PurchaseExperienceModal, {
        cancelPurchase = cancelPurchase,
        experienceName = var7.name,
        price = var6.price,
        purchaseExperience = purchaseExperience,
        screenSize = screenSize
    })
end
