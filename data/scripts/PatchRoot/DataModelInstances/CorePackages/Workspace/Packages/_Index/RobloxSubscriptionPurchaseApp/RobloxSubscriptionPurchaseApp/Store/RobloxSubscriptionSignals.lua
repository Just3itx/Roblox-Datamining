-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local Players = game:GetService("Players")
local Signals = require(RobloxSubscriptionPurchaseAppParent.Signals)

local bool1 = game:DefineFastFlag("AXSubscriptionSignalsPlayersServiceOverride", false)

local var1 = nil
local var2 = nil

local function getPlayersService() -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 and var2 ~= nil then var2 else Players
end

local function func1()
    local localPlayer = getPlayersService().LocalPlayer
    local bool2 = localPlayer.HasRobloxSubscription == true
    local getHasRobloxSubscription, setHasRobloxSubscriptionForTesting = Signals.createSignal(bool2)
    local getGainedRobloxSubscriptionThisSession, setGainedRobloxSubscriptionThisSessionForTesting = Signals.createSignal(false)

    local getHasRobloxSubscriptionUpgradedThisSession, setHasRobloxSubscriptionUpgradedThisSession = Signals.createSignal(false)

    local getExistingSubscriptionUpgradedThisSession, setExistingSubscriptionUpgradedThisSession = Signals.createSignal(false)

    local connection = localPlayer:GetPropertyChangedSignal("HasRobloxSubscription"):Connect(function()
        local bool3 = localPlayer.HasRobloxSubscription == true
        local var11 = getHasRobloxSubscription()
        setHasRobloxSubscriptionForTesting(bool3)
        if bool3 and not var11 then
            setGainedRobloxSubscriptionThisSessionForTesting(true)
        end
    end)

    return {
        getHasRobloxSubscription = getHasRobloxSubscription,
        getGainedRobloxSubscriptionThisSession = getGainedRobloxSubscriptionThisSession,
        getHasRobloxSubscriptionUpgradedThisSession = getHasRobloxSubscriptionUpgradedThisSession,
        setHasRobloxSubscriptionUpgradedThisSession = setHasRobloxSubscriptionUpgradedThisSession,
        getExistingSubscriptionUpgradedThisSession = getExistingSubscriptionUpgradedThisSession,
        setExistingSubscriptionUpgradedThisSession = setExistingSubscriptionUpgradedThisSession,
        setHasRobloxSubscriptionForTesting = setHasRobloxSubscriptionForTesting,
        setGainedRobloxSubscriptionThisSessionForTesting = setGainedRobloxSubscriptionThisSessionForTesting,
        cleanup = function()
            if connection then
                connection:Disconnect()
            end
        end
    }
end

local module = {}

function module.get()
    if var1 == nil then
        var1 = Signals.createComputed(func1)(false)
    end
    return var1
end

function module.setPlayersServiceForTesting(arg1)
    if bool1 then
        var2 = arg1
    end
end

function module.cleanup()
    var1 = nil
    var2 = nil
end

return module
