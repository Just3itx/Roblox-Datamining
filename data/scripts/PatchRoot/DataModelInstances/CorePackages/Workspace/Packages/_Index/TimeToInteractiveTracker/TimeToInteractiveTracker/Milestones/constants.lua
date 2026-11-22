-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local _types = require(script.Parent.types)

return {
    RenderStarted = "RenderStarted",
    SurfaceMounted = "SurfaceMounted",
    FunctionallyReady = "FunctionallyReady",
    SurfaceReady = "SurfaceReady",
    NavigationCommitted = "NavigationCommitted",
    PrimaryDataStarted = {
        Name = "PrimaryDataStarted",
        Subphase = {
            NetworkQueue = "NetworkQueue",
            NetworkFetch = "NetworkFetch",
            ResponseReceived = "ResponseReceived"
        }
    },
    PrimaryDataReady = {
        Name = "PrimaryDataReady",
        Subphase = {
            NetworkQueue = "NetworkQueue",
            NetworkFetch = "NetworkFetch",
            ResponseReceived = "ResponseReceived"
        }
    },
    DataProcessingStarted = {
        Name = "DataProcessingStarted",
        Subphase = { Decode = "Decode", DataUpdate = "DataUpdate", TreeBuild = "TreeBuild" }
    },
    DataProcessingCompleted = {
        Name = "DataProcessingCompleted",
        Subphase = { Decode = "Decode", DataUpdate = "DataUpdate", TreeBuild = "TreeBuild" }
    }
}
