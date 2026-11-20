-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local AppUserLayers = require(CorePackages.Workspace.Packages.ExperimentLayers).AppUserLayers
local makeExperiment = require(script.Parent.makeExperiment)
local bool1 = game:DefineFastFlag("XboxPrimaryNavABIXPEnabled", false)
local bool2 = game:DefineFastFlag("XboxPrimaryNavABIXPEnrolledForAll", false)

local str1 = game:DefineFastString("XboxPrimaryNavABIXPVariable", "tenFootPrimaryNavEnabled")

local tbl1 = {}

local function setExperimentState(arg1)
    tbl1 = arg1
end

local function isEnrolledForAll() -- Luacid: Inlined by compiler; 2 call sites recovered
    return bool2
end

local function isEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isEnrolledForAll() or bool1
end

local function isUserEnrolled()
    return if bool2 then true elseif isEnabled() then (tbl1[AppUserLayers.XboxClassicUILayer] or {})[str1] or false else false
end

local experiment = makeExperiment(
    "OnUserLayerLoadingStatusChanged",
    "GetUserLayerLoadingStatus",
    "GetUserLayerVariables",
    "LogUserLayerExposure",
    "GetUserStatusForLayer"
)

return {
    isEnabled = isEnabled,
    isEnrolledForAll = isEnrolledForAll,
    isUserEnrolled = isUserEnrolled,
    layer = AppUserLayers.XboxClassicUILayer,
    experiment = experiment,
    setExperimentState = setExperimentState
}
