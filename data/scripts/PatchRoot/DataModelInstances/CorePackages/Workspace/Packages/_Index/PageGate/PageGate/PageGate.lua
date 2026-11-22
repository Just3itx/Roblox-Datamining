-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagEnablePLTPrefetchCallbacks = game:DefineFastFlag("EnablePLTPrefetchCallbacks", false)

local resolveEnumItem = require(script.Parent.resolveEnumItem)
local signalWith = require(script.Parent.signalWith)

local module = {
    FFlagEnablePLTPrefetchCallbacks = FFlagEnablePLTPrefetchCallbacks,
    Page = {
        AvatarEditor = "AvatarEditor",
        Party = "Party",
        ExperienceDetail = "ExperienceDetail",
        AvatarMarketplace = "AvatarMarketplace"
    },
    Milestone = {
        Interactive = "Interactive",
        SurfaceMounted = "SurfaceMounted",
        FunctionallyReady = "FunctionallyReady",
        SurfaceReady = "SurfaceReady"
    }
}

local tbl1 = {
    isEnabled = function(): boolean
        return game:GetEngineFeature("PageMilestoneSignalEnabled")
    end,
    getService = function(): AppLifecycleObserverService
        return game:GetService("AppLifecycleObserverService")
    end,
    resolveEnumItem = resolveEnumItem,
    defer = function(func1: (...any) -> (...any))
        task.defer(func1)
    end,
    warn = warn
}

function module.signal(str1: string, str2: string)
    signalWith(tbl1, str1, str2)
end

return module
