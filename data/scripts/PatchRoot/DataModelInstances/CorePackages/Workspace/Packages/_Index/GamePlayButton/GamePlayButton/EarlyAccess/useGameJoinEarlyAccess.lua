-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local React = require(GamePlayButtonParent.React)
local SignalsReact = require(GamePlayButtonParent.SignalsReact)
local RobloxSubscriptionPurchaseApp = require(GamePlayButtonParent.RobloxSubscriptionPurchaseApp)
local initiateRobloxSubscriptionPurchase = RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase
local RobloxSubscriptionSignals = RobloxSubscriptionPurchaseApp.RobloxSubscriptionSignals
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext
local useAppPolicy = require(GamePlayButtonParent.UniversalAppPolicy).useAppPolicy
local _PlayabilityRodux = require(GamePlayButtonParent.PlayabilityRodux)
local PlayabilityStatusEnum = require(GamePlayButtonParent.DiscoveryTypes).PlayabilityStatusEnum

local FIntEarlyAccessPollIntervalSeconds = require(script.Parent.FIntEarlyAccessPollIntervalSeconds)
local FIntEarlyAccessMaxPollAttempts = require(script.Parent.FIntEarlyAccessMaxPollAttempts)

local str1 = game:DefineFastString("R20UniverseAccessTime", "")

local function resolveUnlockTimestamp(str2: string, current: number): number? -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = string.sub(str2, 1, 1) == "+"
    if bool1 then
        str2 = string.sub(str2, 2)
    end

    local var1 = tonumber(str2)
    return if var1 == nil or var1 == 0 then nil elseif bool1 then current + var1 else var1
end

local function useGameJoinEarlyAccess(arg1, arg2)
    local var1 = useAppPolicy(function(arg3): boolean
        return not arg3.getDisableBlackbirdEntrypoints()
    end)

    local bool1 = not (arg2 == nil) and arg2.playabilityStatus == PlayabilityStatusEnum.PlusSubscriptionRequired
    local var2 = RobloxSubscriptionSignals.get()
    local var3 = SignalsReact.useSignalState(var2.getGainedRobloxSubscriptionThisSession)

    local var4 = React.useRef(nil)
    if var4.current == nil then
        var4.current = DateTime.now().UnixTimestamp
    end

    local unlockTimestamp = if bool1 then resolveUnlockTimestamp(str1, var4.current) else nil
    local unlockRefetchTick, var7 = React.useState(0)
    React.useEffect(function()
        var7(0)
        if unlockTimestamp == nil then
            return
        end

        local bool2 = false
        local var8 = nil
        local num1 = 0

        local function poll()
            if bool2 then
                return
            end
            num1 += 1
            var7(num1)
            if num1 < FIntEarlyAccessMaxPollAttempts then
                var8 = task.delay(FIntEarlyAccessPollIntervalSeconds, poll)
                return
            end
            var8 = nil
        end

        local num2 = math.max(unlockTimestamp - DateTime.now().UnixTimestamp, 0)
        var8 = task.delay(num2, poll)

        return function()
            bool2 = true
            if var8 ~= nil then
                task.cancel(var8)
                var8 = nil
            end
        end
    end, { unlockTimestamp })

    local openUpsell = React.useCallback(function()
        initiateRobloxSubscriptionPurchase(
            nil,
            nil,
            if arg1 then tonumber(arg1) else nil,
            SurfaceName.GameJoinEarlyAccessUpsell,
            SurfaceContext.InApp
        )
    end, { arg1 })

    return {
        isPendingUnlock = bool1 and unlockRefetchTick > 0,
        unlockRefetchTick = unlockRefetchTick,
        unlockTimestamp = unlockTimestamp,
        showPlusUpsell = bool1 and var1,
        openUpsell = openUpsell,
        gainedSubscription = bool1 and var3
    }
end

return useGameJoinEarlyAccess
