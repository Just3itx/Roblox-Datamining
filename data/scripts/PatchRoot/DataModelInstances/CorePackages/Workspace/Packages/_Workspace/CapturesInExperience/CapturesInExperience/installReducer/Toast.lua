-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Dash = require(scriptParentParentParent.Dash)
local Rodux = require(scriptParentParentParent.Rodux)

local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local ToastDismissed = require(scriptParentParent.Actions.ToastDismissed)
local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)
local ToastVanished = require(scriptParentParent.Actions.ToastVanished)
local _Types = require(scriptParentParent.Types)

local tbl1 = {
    IsDismissed = false,
    ToastType = CapturesToastType.None,
    ToastConfig = nil
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[ToastVanished.name] = function(tbl3, _): {[any]: any} | {IsDismissed: boolean, ToastType: any}
    return if tbl3.ToastType == CapturesToastType.None then tbl3 else {
        IsDismissed = false,
        ToastType = CapturesToastType.None
    }
end

tbl2[ToastDismissed.name] = function(tbl3, _)
    if tbl3.IsDismissed or tbl3.ToastType == CapturesToastType.None then
        return tbl3
    end

    return Dash.join(tbl3, { IsDismissed = true })
end

tbl2[ToastTriggered.name] = function(tbl3, arg1): {[any]: any} | {IsDismissed: boolean, ToastConfig: any, ToastType: any}
    local var1 = Dash.shallowEqual(tbl3.ToastConfig, arg1.toastConfig)
    return if tbl3.ToastType == arg1.toastType and not tbl3.IsDismissed and var1 then tbl3 else {
        IsDismissed = false,
        ToastType = arg1.toastType,
        ToastConfig = arg1.toastConfig
    }
end

return createReducer(tbl1, tbl2)
