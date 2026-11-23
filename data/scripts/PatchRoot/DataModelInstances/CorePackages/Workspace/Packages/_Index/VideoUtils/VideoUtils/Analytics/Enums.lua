-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    VideoEndReason = {
        AppBackgrounded = "appBackgrounded",
        Completed = "completed",
        ExitViewport = "exitViewport",
        ExperienceLaunched = "experienceLaunched",
        HoverTakeover = "hoverTakeover",
        OverlayTakeover = "overlayTakeover",
        PlayabilityCheckFailed = "playabilityCheckFailed",
        ScrollStart = "scrollStart",
        ScrollSettled = "scrollSettled",
        TileClicked = "tileClicked",
        Unhovered = "unhovered",
        Unmounted = "unmounted",
        Unselected = "unselected",
        ViewportResized = "viewportResized"
    },
    VideoEngagementEvents = {
        VIDEO_UNKNOWN_EVENT = "VIDEO_UNKNOWN_EVENT",
        VIDEO_IMPRESSION = "VIDEO_IMPRESSION",
        VIDEO_ACTION = "VIDEO_ACTION",
        VIDEO_PROGRESS = "VIDEO_PROGRESS"
    },
    VideoActions = {
        unknown = "unknown",
        complete = "complete",
        ended = "end",
        exit_fullscreen = "exit_fullscreen",
        fullscreen = "fullscreen",
        hover = "hover",
        load = "load",
        loop = "loop",
        navigate = "navigate",
        pause = "pause",
        play = "play",
        scrub = "scrub",
        volume = "volume"
    },
    VideoSources = { community = "community", MediaGallery = "MediaGallery" }
}
