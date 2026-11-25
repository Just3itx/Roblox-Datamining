-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustAndSafetyIxp = script:FindFirstAncestor("TrustAndSafetyIxp")
local TrustAndSafetyIxpParent = TrustAndSafetyIxp.Parent

local GetFFlagReportAnythingAnnotationIXP = require(TrustAndSafetyIxpParent.SharedFlags).GetFFlagReportAnythingAnnotationIXP

local GetFStringReportAnythingAnnotationIXPLayerName = require(TrustAndSafetyIxpParent.SharedFlags).GetFStringReportAnythingAnnotationIXPLayerName

local GetFFlagForceReportAnythingAnnotationEnabled = require(TrustAndSafetyIxp.Flags.GetFFlagForceReportAnythingAnnotationEnabled)
local IXPServiceWrapper = require(TrustAndSafetyIxpParent.IxpServiceWrapper).IXPServiceWrapper
local var1 = require(TrustAndSafetyIxpParent.CoreScriptsInitializer).CoreLogger:new(script.Name)

local module = {}
module.__index = module

function module.new(_ixpServiceWrapper)
    local tbl1 = {
        _ixpServiceWrapper = _ixpServiceWrapper or IXPServiceWrapper,
        _initialized = false,
        _ixpInitialized = false,
        _optionalScreenshotEnabled = false,
        _reportAnythingExperienceEnabled = false,
        _reportAnythingAvatarEnabled = false,
        _callbacks = {}
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:getReportAnythingExperienceEnabled()
    return if GetFFlagForceReportAnythingAnnotationEnabled() then true else self._reportAnythingExperienceEnabled or self._optionalScreenshotEnabled
end

function module:getReportAnythingAvatarEnabled()
    return if GetFFlagForceReportAnythingAnnotationEnabled() then true else self._reportAnythingAvatarEnabled or self._optionalScreenshotEnabled
end

function module:waitForInitialization(callback)
    if self._ixpInitialized then
        callback()
        return
    end
    table.insert(self._callbacks, callback)
end

function module:initialize()
    if self._initialized then
        return
    end
    self._initialized = true

    local function invokeCallbacks()
        for _, _callback in ipairs(self._callbacks) do
            _callback()
        end
        self._callbacks = {}
    end

    if not GetFFlagReportAnythingAnnotationIXP() then
        self._ixpInitialized = true
        invokeCallbacks()
        return
    end

    task.spawn(function()
        self._ixpServiceWrapper:WaitForInitialization()
        local layerData = self._ixpServiceWrapper:GetLayerData(GetFStringReportAnythingAnnotationIXPLayerName())
        if layerData then
            self._optionalScreenshotEnabled = layerData.OptionalScreenshotEnabled or false
            self._reportAnythingExperienceEnabled = layerData.OptionalScreenshotExperience or false
            self._reportAnythingAvatarEnabled = layerData.OptionalScreenshotAvatar or false
        end

        var1:debug(
            "RA Optional Screenshot enabled (Avatar and/or Experience) or Select In Scene enabled? Both Avatar and Exp: {}, Exp: {}, Avatar: {}, Select in Scene: {}. Invoking {} callbacks.",
            self._optionalScreenshotEnabled,
            self._reportAnythingExperienceEnabled,
            self._reportAnythingAvatarEnabled,
            self._selectInSceneEnabled,
            #self._callbacks
        )

        self._ixpInitialized = true
        invokeCallbacks()
    end)
end

module.default = module.new()
return module
