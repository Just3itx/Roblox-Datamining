-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EventIngestService = game:GetService("EventIngestService")

local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local _TnSAvatarIdentification = require(CorePackages.Workspace.Packages.TnSAvatarIdentification)
local EventIngest = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventIngest

local tbl1 = {
    EventType = { AvatarsIdentified = "ReportAnythingAvatarsIdentified" },
    Context = { LegacyMenu = "ReportAbuseLegacyMenu" }
}

local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        previewBackCount = 0,
        previewAttachCount = 0,
        retakeCount = 0,
        retakeAbandon = false,
        highlightSceneCount = 0,
        annotationBackCount = 0,
        annotationPlaceCount = 0,
        annotationUndoCount = 0,
        annotationRedoCount = 0,
        annotationNext = false
    }
end

local getAccumulatedParameters = func1()

local var1 = nil
local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
    var1 = var1 or EventIngest.new(EventIngestService)

    return var1
end

return {
    incrementPreviewBack = function()
        local tbl3 = getAccumulatedParameters
        tbl3.previewBackCount += 1
    end,
    incrementPreviewAttach = function()
        local tbl3 = getAccumulatedParameters
        tbl3.previewAttachCount += 1
    end,
    incrementRetake = function()
        local tbl3 = getAccumulatedParameters
        tbl3.retakeCount += 1
    end,
    setRetakeAbandon = function()
        getAccumulatedParameters.retakeAbandon = true
    end,
    incrementHighlightScene = function()
        local tbl3 = getAccumulatedParameters
        tbl3.highlightSceneCount += 1
    end,
    incrementAnnotationBack = function()
        local tbl3 = getAccumulatedParameters
        tbl3.annotationBackCount += 1
    end,
    incrementAnnotationPlace = function()
        local tbl3 = getAccumulatedParameters
        tbl3.annotationPlaceCount += 1
    end,
    incrementAnnotationUndo = function()
        local tbl3 = getAccumulatedParameters
        tbl3.annotationUndoCount += 1
    end,
    incrementAnnotationRedo = function()
        local tbl3 = getAccumulatedParameters
        tbl3.annotationRedoCount += 1
    end,
    setAnnotationNext = function()
        getAccumulatedParameters.annotationNext = true
    end,
    getAccumulatedParameters = function()
        return getAccumulatedParameters
    end,
    emitAvatarsIdentifiedStats = function(arg1)
        local var2 = Cryo.Dictionary.join(arg1, { duration = arg1.duration * 1000000 })

        func2():sendEventDeferred(tbl1.Context.LegacyMenu, tbl1.EventType.AvatarsIdentified, var2)
    end,
    clear = function()
        getAccumulatedParameters = func1()
    end
}
