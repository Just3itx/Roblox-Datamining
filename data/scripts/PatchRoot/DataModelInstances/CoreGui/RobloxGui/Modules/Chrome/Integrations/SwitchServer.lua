-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local MappedSignal = require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal

local SwitchServer = require(CorePackages.Workspace.Packages.SwitchServer)
local GetSwitchServerStore = SwitchServer.GetSwitchServerStore
local Constants2 = SwitchServer.Constants
local switchServerStore = GetSwitchServerStore(false)
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch

local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal
local SignalsUtils = require(CorePackages.Workspace.Packages.SignalsUtils)

local bool1 = false
local signal = Signal.new()
local mappedSignal = MappedSignal.new(signal, function()
    return bool1
end)

SignalsUtils.createDetachedEffect(function(arg1)
    local var1 = switchServerStore.isConfirmationOpen(arg1)
    if bool1 ~= var1 then
        bool1 = var1
        signal:fire()
    end
end)

local tbl1 = {
    initialAvailability = Service.AvailabilitySignal.Unavailable,
    id = Constants.SWITCH_SERVER_ID,
    label = Constants2.BUTTON.LABEL,
    sideSheetPlacement = if isPioneerLaunch() then SideSheetPlacement.SessionAction else SideSheetPlacement.BelowFold,
    activated = 0,
    isActivated = 0,
    components = 0
}

function tbl1.activated()
    switchServerStore.setConfirmationOpen(true)
end
tbl1.isActivated = mappedSignal
tbl1.components = {
    Icon = function(_)
        return CommonIcon("TwoLocationPinsConnectingArrow", nil, mappedSignal)
    end
}

local var1 = Service:register(tbl1)

SignalsUtils.createDetachedEffect(function(arg1)
    if switchServerStore.shouldEnableSwitchServer(arg1) or isPioneerLaunch() then
        var1.availability:available()
        return
    end
    var1.availability:unavailable()
end)

return var1
