-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local MessageBusService = game:GetService("MessageBusService")

local _MessageBus = require(scriptParentParent.MessageBus)
local Promise = require(scriptParentParent.Promise)

local getFFlagEnableToSwitchToSettingsAppWithRouteLua = require(script.Parent.Flags.getFFlagEnableToSwitchToSettingsAppWithRouteLua)
local getFFlagEnableAdConsentAttribution = require(script.Parent.Flags.getFFlagEnableAdConsentAttribution)

local _LinkingProtocolTypes = require(script.Parent.LinkingProtocolTypes)
local DeepLinkSource = require(script.Parent.Enums.DeepLinkSource)
local _SettingsRoute = require(script.Parent.Enums.SettingsRoute)

local LinkingService = require(scriptParentParent.MockableProxyServices).LinkingService

local module = ({})
module.__index = module
module.DeepLinkSource = DeepLinkSource

local function getEngineFeature(name: string): boolean
    return game:GetEngineFeature(name)
end

function module.new(_getEngineFeature: ((...any) -> (...any))?)
    return (setmetatable(
        {
            _getEngineFeature = _getEngineFeature or getEngineFeature,
            isListeningForURLs = false,
            urlConnection = nil
        },
        module
    ))
end

function module:registerURL(str1: string, arg1)
    local engineHandlingPolicy = if arg1 then arg1.engineHandlingPolicy else nil

    if engineHandlingPolicy and self._getEngineFeature("ExternalOriginOnlyUrlRegistration") then
        LinkingService:RegisterLuaUrlWithPolicy(str1, engineHandlingPolicy)
        return
    end
    LinkingService:RegisterLuaUrl(str1)
end

function module.getUID(_)
    if not game:GetEngineFeature("EnableAppflyerUIDReporting") then
        return Promise.resolve("")
    end

    return Promise.new(function(callback, _)
        MessageBusService:MakeRequest("Linking", "getUID", {}, function(tbl1)
            callback(tbl1.uid)
        end, {})
    end)
end

function module.detectURL(_, str1: string)
    LinkingService:DetectUrl(str1)
end

function module:isInternalDlicEnabled()
    return self._getEngineFeature("EnableDLICInternalIngressSeeding")
end

function module.createInternalDlic(_, str1: string, arg1)
    return LinkingService:CreateInternalDlic(str1, arg1)
end

function module.detectDeeplinkIntent(_, str1: string)
    LinkingService:DetectDlic(str1)
end

function module.adConsentResolved(_, tbl1)
    if not getFFlagEnableAdConsentAttribution() then
        return
    end
    MessageBusService:Publish("Linking.adConsentResolved", tbl1)
end

function module.getLastLuaURL(_)
    return LinkingService:GetLastLuaUrl()
end

function module:listenForLuaURLs(callback: (...any) -> (...any), _: boolean?)
    self:stopListeningForLuaURLs()
    self.urlConnection = LinkingService.OnLuaUrl:Connect(function(url: string, _: string, attributionUrl: string?)
        callback(url, attributionUrl)
    end)
    self.isListeningForURLs = true
    local var1 = LinkingService:StartLuaUrlDelivery()
    if var1 and var1.url then
        callback(var1.url, var1.attributionUrl)
    end
end

function module:stopListeningForLuaURLs()
    if self.isListeningForURLs then
        self.urlConnection:Disconnect()
        LinkingService:StopLuaUrlDelivery()
        self.isListeningForURLs = false
    end
end

function module.openURL(_, str1: string)
    return Promise.new(function(callback, _)
        callback(LinkingService:OpenUrl(str1))
    end)
end

function module.isURLRegistered(_, str1: string)
    return Promise.new(function(callback, _)
        callback(LinkingService:IsUrlRegistered(str1))
    end)
end

function module.getAndClearLastPendingURL(_)
    if not game:GetEngineFeature("LinkingProtocolGetLastPendingUrlEnabled") then
        return Promise.resolve({ hasPendingUrl = false })
    end

    return Promise.new(function(callback, _)
        callback(LinkingService:GetAndClearLastPendingUrl())
    end)
end

function module.switchToSettingsApp(_, arg1)
    if not getFFlagEnableToSwitchToSettingsAppWithRouteLua() then
        arg1 = nil
    end

    return Promise.new(function(callback, _)
        callback(LinkingService:SwitchToSettingsApp(arg1))
    end)
end

function module.supportsSwitchToSettingsApp(_, _)
    return Promise.new(function(callback, _)
        callback(LinkingService:SupportsSwitchToSettingsApp())
    end)
end

module.default = module.new()

return module
