-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local Signals = require(MomentsCommonParent.Signals)
local SignalsReact = require(MomentsCommonParent.SignalsReact)

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local useHasPresentedFrame = require(MomentsCommon.Media.useHasPresentedFrame)
local MomentsSurfaceLoadManager = require(script.Parent.MomentsSurfaceLoadManager)
local CaptureKind = require(MomentsCommon.Enums.CaptureKind)

local function useMomentsSurfaceReadyTracking(tbl1)
    local controller = tbl1.controller
    local isVideo = tbl1.isVideo
    local enabled = tbl1.enabled

    local var1 = React.useRef(nil)

    local var2 = useHasPresentedFrame(controller, enabled and isVideo)

    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if controller == nil then
                return nil
            end

            return controller.getState(arg1).readiness
        end)
    end, { controller })
    local var4 = SignalsReact.useSignalState(var3)

    if not isVideo then
        var2 = var4 == "Ready"
    end
    React.useEffect(function()
        if enabled and var2 and controller ~= nil and var1.current ~= controller then
            var1.current = controller
            MomentsSurfaceLoadManager.markSurfaceReady(if isVideo then CaptureKind.Video else CaptureKind.Screenshot)
        end
    end, {
        enabled,
        var2,
        isVideo,
        controller
    })
end
return useMomentsSurfaceReadyTracking
