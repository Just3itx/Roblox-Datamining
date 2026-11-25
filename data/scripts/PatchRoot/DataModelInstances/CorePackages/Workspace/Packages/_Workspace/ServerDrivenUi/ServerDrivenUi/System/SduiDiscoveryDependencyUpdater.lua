-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiInstrumentation = SduiCoreSystem.SduiInstrumentation
local getSduiServiceDependenciesStore = SduiCoreSystem.getSduiServiceDependenciesStore
local getSduiTokensStore = SduiCoreSystem.getSduiTokensStore
local getSduiPolicyStore = SduiCoreSystem.getSduiPolicyStore

local useAppPolicy = require(ServerDrivenUiParent.UniversalAppPolicy).useAppPolicy
local FFlagInitializeSduiForApp = require(ServerDrivenUiParent.SharedFlags).FFlagInitializeSduiForApp

local registerDiscoveryActions = require(ServerDrivenUi.Actions.registerDiscoveryActions)

local registerDiscoveryActionTelemetryHandlers = require(ServerDrivenUi.Actions.TelemetryHandlers.registerDiscoveryActionTelemetryHandlers)
local registerDiscoveryImpressions = require(ServerDrivenUi.Impressions.registerDiscoveryImpressions)
local registerDiscoveryUiComponents = require(ServerDrivenUi.Content.registerDiscoveryUiComponents)
local useSduiDependencies = require(ServerDrivenUi.System.useSduiDependencies)
local useSduiSocialData = require(ServerDrivenUi.DataStore.useSduiSocialData)
local SduiInGameFriendsData = require(ServerDrivenUi.DataStore.SduiInGameFriendsData)

return React.memo(function() -- name: SduiDiscoveryDependencyUpdater
    local var1 = React.useMemo(function()
        return SduiInstrumentation.new()
    end, {})

    local var2 = useSduiDependencies(var1)

    React.useEffect(function()
        getSduiServiceDependenciesStore().setDependencies(var2)
    end, { var2 })

    local var3 = useTokens()
    React.useEffect(function()
        getSduiTokensStore().setTokens(var3)
    end, { var3 })
    local var4 = useAppPolicy(function<T>(arg1: T): T
        return arg1
    end)
    React.useEffect(function()
        getSduiPolicyStore().setAppPolicy(var4)
    end, { var4 })

    if not FFlagInitializeSduiForApp then
        React.useEffect(function()
            registerDiscoveryActions()
            registerDiscoveryUiComponents()
            registerDiscoveryImpressions()
            registerDiscoveryActionTelemetryHandlers()
        end, {})
    end

    local var5 = useSduiSocialData()
    React.useEffect(function()
        SduiInGameFriendsData.setInGameFriendsByGameSignal(var5.getInGameFriendsByGame)
    end, { var5 })
    return nil
end)
