-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Players = game:GetService("Players")

local _ErrorOccurred = require(scriptParentParent.Actions.ErrorOccurred)
local _SetPromptState = require(scriptParentParent.Actions.SetPromptState)
local UpsellFlow = require(scriptParentParent.Enums.UpsellFlow)
local _PromptState = require(scriptParentParent.Enums.PromptState)
local _PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local hideWindow = require(scriptParentParent.Thunks.hideWindow)
local getUpsellFlow = require(scriptParentParent.NativeUpsell.getUpsellFlow)
local Analytics = require(scriptParentParent.Services.Analytics)
local ExternalSettings = require(scriptParentParent.Services.ExternalSettings)
local Network = require(scriptParentParent.Services.Network)
local PlatformInterface = require(scriptParentParent.Services.PlatformInterface)
local Thunk = require(scriptParentParent.Thunk)
local _Promise = require(scriptParentParent.Promise)

local tbl1 = {
    Analytics,
    ExternalSettings,
    Network,
    PlatformInterface
}

local function openSecuritySettings(str1: string?)
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Analytics]
        local var2 = arg2[ExternalSettings]
        local var3 = arg2[PlatformInterface]
        local state = arg1:getState()

        if getUpsellFlow(var2.getPlatform()) == UpsellFlow.Web then
            local productId = state.productInfo.productId
            local requestType = state.requestType

            var1.signalTwoSVSettingsErrorConfirmed(productId, requestType)
            if str1 then
                var3.openSecuritySettings(str1)
            else
                var3.openSecuritySettings()
            end
        end
        arg1:dispatch(hideWindow())
    end)
end

return openSecuritySettings
