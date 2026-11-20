-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Modules = CoreGui.RobloxGui.Modules
local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper

local GetFStringInExperienceNotificationsLayer = require(Modules.Flags.GetFStringInExperienceNotificationsLayer)

local GetFFlagEnableNewInviteMenuIXP = require(Modules.Flags.GetFFlagEnableNewInviteMenuIXP)
local GetFFlagInviteListRerank = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagInviteListRerank

local module = {}
module.__index = module

function module.new(_ixpServiceWrapper)
    local tbl1 = {
        _ixpServiceWrapper = _ixpServiceWrapper or IXPServiceWrapper,
        _styleEnabled = false,
        _customizationEnabled = false,
        _newSendEndpointEnabled = false,
        _inviteListSortOrder = if GetFFlagInviteListRerank() then 0 else nil
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:getStyleEnabled()
    return self._styleEnabled
end

function module:getCustomizationEnabled()
    return self._customizationEnabled
end

function module:getNewSendEndpointEnabled()
    return self._newSendEndpointEnabled
end

if GetFFlagInviteListRerank() then
    function module:getInviteListSortOrder()
        return self._inviteListSortOrder
    end
end

function module.initialize(arg1)
    if not GetFFlagEnableNewInviteMenuIXP() then
        return
    end

    task.spawn(function()
        arg1._ixpServiceWrapper:WaitForInitialization()
        local layerData = arg1._ixpServiceWrapper:GetLayerData(GetFStringInExperienceNotificationsLayer())
        if not layerData then
            return
        end

        arg1._styleEnabled = layerData.NewInviteMenuStyleEnabled or false
        arg1._customizationEnabled = layerData.NewInviteMenuCustomizationEnabled or false
        arg1._newSendEndpointEnabled = layerData.NewInviteMenuEndpointEnabled or false
        local var1 = arg1
        var1._inviteListSortOrder = if GetFFlagInviteListRerank() then layerData.invite_list_sort_order or 0 else nil
    end)
end

module.default = module.new()
return module
