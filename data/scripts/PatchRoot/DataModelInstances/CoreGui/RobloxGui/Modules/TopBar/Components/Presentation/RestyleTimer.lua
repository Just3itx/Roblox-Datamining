-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local Chrome = CoreGui:WaitForChild("RobloxGui").Modules.Chrome

local Stores = require(CorePackages.Workspace.Packages.CoreGuiCommon).Stores
local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagTopBarRefactor = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagTopBarRefactor
local RestyleTimer = require(CorePackages.Workspace.Packages.InExperienceCloudPlay.RestyleTimer)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local useObservableValue = require(Chrome.ChromeShared.Hooks.useObservableValue)
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local GamepadConnector = if SharedFlags.FFlagEnableConsoleExpControls and var1 then require(script.Parent.Parent.GamepadConnector) else nil
local uILessStore = if SharedFlags.FFlagAddUILessMode and SharedFlags.FIntAddUILessModeVariant ~= 0 and Stores.GetUILessStore then Stores.GetUILessStore(false) else nil

local computed = Signals.createComputed(function(arg1)
    return not (uILessStore == nil) and uILessStore.getUILessModeEnabled(arg1) and not uILessStore.getUIVisible(arg1)
end)

local var2 = if GamepadConnector == nil then ChromeUtils.ObservableValue.new(true) else GamepadConnector:getShowTopBar()

local function TopBarRestyleTimer(arg1)
    local var3 = useObservableValue(arg1.showTopBar or var2)
    local var4 = SignalsReact.useSignalState(computed)
    local createElement = React.createElement
    local var5 = RestyleTimer
    local tbl1 = {
        buttonSize = arg1.buttonSize,
        layoutOrder = arg1.layoutOrder,
        onAreaChanged = arg1.onAreaChanged,
        onAreaRemoved = arg1.onAreaRemoved,
        isHidden = 0
    }

    if FFlagTopBarRefactor then
        var4 = nil
    elseif var3 == false then
        var4 = true
    elseif arg1.followsUILessMode ~= true then
        var4 = false
    end

    tbl1.isHidden = var4
    return createElement(var5, tbl1)
end

return TopBarRestyleTimer
