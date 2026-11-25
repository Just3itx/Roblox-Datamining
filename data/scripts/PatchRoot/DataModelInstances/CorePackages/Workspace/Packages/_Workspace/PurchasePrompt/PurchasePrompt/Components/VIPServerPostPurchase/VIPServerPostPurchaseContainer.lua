-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local React = require(PurchasePromptParent.React)
local LocalizationProvider = require(PurchasePromptParent.Localization).LocalizationProvider
local Localization = require(PurchasePromptParent.RobloxAppLocales).Localization
local ReactFocusNavigation = require(PurchasePromptParent.ReactFocusNavigation)
local FocusNavigationUtils = require(PurchasePromptParent.FocusNavigationUtils)
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider

local connectToStore = require(PurchasePrompt.connectToStore)
local generateVIPServerLink = require(PurchasePrompt.Thunks.generateVIPServerLink)
local saveVIPServerConfiguration = require(PurchasePrompt.Thunks.saveVIPServerConfiguration)
local searchUsers = require(PurchasePrompt.Thunks.searchUsers)
local selectProductPrice = require(PurchasePrompt.Selectors.selectProductPrice)
local selectVIPServerOfferType = require(PurchasePrompt.Selectors.selectVIPServerOfferType)
local sendPrivateServerConfigEvent = require(PurchasePrompt.Utils.sendPrivateServerConfigEvent)
local teleportToVIPServer = require(PurchasePrompt.Utils.teleportToVIPServer)
local _types = require(PurchasePrompt.types)

local VIPServerConfigurationView = require(script.Parent.VIPServerConfigurationView)
local useVIPServerConfigurationViewModel = require(script.Parent.useVIPServerConfigurationViewModel)
local VIPServerJoinView = require(script.Parent.VIPServerJoinView)
local useVIPServerJoinViewModel = require(script.Parent.useVIPServerJoinViewModel)

local function VIPServerConfiguration(tbl1)
    local var1 = useVIPServerConfigurationViewModel({
        defaultServerName = tbl1.serverName,
        price = tbl1.price,
        offerType = tbl1.offerType,
        generateLink = tbl1.generateLink,
        save = tbl1.save,
        searchUsers = tbl1.searchUsers,
        logEvent = tbl1.logEvent,
        onSaved = tbl1.onSaved,
        onClose = tbl1.onClose,
        players = Players
    })

    return React.createElement(VIPServerConfigurationView, var1)
end

local function VIPServerJoin(tbl1)
    local var1 = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false
    })

    local joinButtonRef, focusRootRef = ReactFocusNavigation.useDefaultFocusBehavior(var1)
    local var4 = useVIPServerJoinViewModel({
        vipServerAccessCode = tbl1.vipServerAccessCode,
        serverName = tbl1.serverName,
        gameName = tbl1.gameName,
        thumbnailUrl = tbl1.thumbnailUrl,
        teleport = teleportToVIPServer,
        logEvent = tbl1.logEvent,
        onClose = tbl1.onClose,
        focusRootRef = focusRootRef,
        joinButtonRef = joinButtonRef
    })

    return React.createElement(VIPServerJoinView, var4)
end

local function VIPServerPostPurchase(tbl1)
    local var1, var2 = React.useState(false)
    local vipServerAccessCode = tbl1.vipServerAccessCode
    local onClose = tbl1.onClose
    local vipServerId = tbl1.vipServerId
    local universeId = tbl1.universeId
    local purchaseFlowUuid = tbl1.purchaseFlowUUID

    local logEvent = React.useCallback(function(arg1)
        local var3 = table.clone(arg1)
        var3.privateServerId = vipServerId
        var3.universeId = universeId
        var3.surface = "in_experience"
        var3.purchase_flow_uuid = purchaseFlowUuid
        sendPrivateServerConfigEvent(var3)
    end, { vipServerId, universeId, purchaseFlowUuid })

    local onSaved = React.useCallback(function()
        if vipServerAccessCode ~= nil then
            var2(true)
            return
        end
        onClose()
    end, { vipServerAccessCode, onClose })

    if var1 and vipServerAccessCode ~= nil then
        return React.createElement(VIPServerJoin, {
            vipServerAccessCode = vipServerAccessCode,
            serverName = tbl1.serverName,
            gameName = tbl1.gameName,
            thumbnailUrl = tbl1.thumbnailUrl,
            logEvent = logEvent,
            onClose = onClose
        })
    end

    return React.createElement(VIPServerConfiguration, {
        serverName = tbl1.serverName,
        price = tbl1.price,
        offerType = tbl1.offerType,
        generateLink = tbl1.generateLink,
        save = tbl1.save,
        searchUsers = tbl1.searchUsers,
        logEvent = logEvent,
        onSaved = onSaved,
        onClose = onClose
    })
end

return connectToStore(function(arg1)
    return {
        serverName = arg1.promptRequest.vipServerName or "",
        vipServerAccessCode = arg1.promptRequest.vipServerAccessCode,
        gameName = arg1.productInfo.name or "",
        thumbnailUrl = arg1.productInfo.imageUrl,
        vipServerId = arg1.promptRequest.vipServerId,
        universeId = if arg1.productPayload then arg1.productPayload.universeId else nil,
        purchaseFlowUUID = arg1.purchaseAnalyticsMetadata.purchaseFlowUUID,
        price = selectProductPrice(arg1),
        offerType = selectVIPServerOfferType(arg1)
    }
end, function(arg1)
    return {
        generateLink = function()
            return arg1(generateVIPServerLink())
        end,
        save = function(arg2)
            return arg1(saveVIPServerConfiguration(arg2))
        end,
        searchUsers = function(str1: string)
            return arg1(searchUsers(str1))
        end
    }
end)(function(tbl1) -- name: VIPServerPostPurchaseContainer
    local value = React.useMemo(function()
        return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
    end, {})
    React.useEffect(function()
        return function()
            value:teardown()
        end
    end, { value })

    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            FocusNavigationProvider = React.createElement(
                ReactFocusNavigation.FocusNavigationContext.Provider,
                { value = value },
                {
                    FocusNavigationRegistryProvider = React.createElement(Provider, nil, { VIPServerPostPurchase = React.createElement(VIPServerPostPurchase, tbl1) })
                }
            )
        }
    )
end)
