-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local Host = table.freeze({ InExperience = "InExperience", DeferredJoin = "DeferredJoin" })

local Page = table.freeze({ TiltLoadingScreen = "TiltLoadingScreen", LoadingScreenView = "LoadingScreenView" })

local AbortReason = table.freeze({
    Cancelled = "cancelled",
    VRHandoff = "vr_handoff",
    Unmounted = "unmounted",
    Replaced = "replaced",
    InitializationFailed = "initialization_failed"
})

local Outcome = table.freeze({ Completed = "completed", InstrumentationError = "instrumentation_error" })

local DismissSource = table.freeze({ NormalReady = "NormalReady", DeveloperOverride = "DeveloperOverride" })

local ContentId = table.freeze({ Title = "Title", Creator = "Creator", Thumbnail = "Thumbnail" })

local Milestone = table.freeze({
    ScreenVisible = "ScreenVisible",
    ContentVisible = "ContentVisible",
    DismissRequested = "DismissRequested",
    DismissGateReleased = "DismissGateReleased",
    DismissStarted = "DismissStarted",
    ScreenHidden = "ScreenHidden"
})

return table.freeze({
    Host = Host,
    Page = Page,
    DismissSource = DismissSource,
    ContentId = ContentId,
    Milestone = Milestone,
    AbortReason = AbortReason,
    Outcome = Outcome,
    CATEGORY = "ExperienceLoading",
    EVENT_NAME = "ExperienceLoadingScreen"
})
