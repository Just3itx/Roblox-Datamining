-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local SocialLuaAnalytics = require(MomentsCommonParent.SocialLuaAnalytics)
local SupportedTelemetryBackends = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends

local RealtimeEventNames = require(script.Parent.RealtimeEventNames)
local FFlagMomentsParentTimeLimit = require(MomentsCommon.Flags.FFlagMomentsParentTimeLimit)

local Telemetry = SocialLuaAnalytics.Telemetry

local tbl1 = {
    watch_tab = "watch_tab",
    deeplink = "deeplink",
    profile = "profile",
    flyout_menu = "flyout_menu"
}

local function normalizeViewSource(source: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    return tbl1[source] or "unknown"
end

local function normalizeRequestFailureReason(failureReason: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if failureReason == nil or failureReason == "" then
        return "unknown"
    end

    if failureReason == "requestFailed" or failureReason == "malformedResponse" then
        return failureReason
    end

    if FFlagMomentsParentTimeLimit and failureReason == "parentalTimeLimitReached" then
        return failureReason
    end

    return "unknown"
end

local function normalizeMediaFailureReason(str1: string?): string
    if str1 == nil or str1 == "" then
        return "unknown"
    end

    if string.find(str1, "video load errored:", 1, true) == 1 then
        return "videoLoadErrored"
    end

    if string.find(str1, "video load failed:", 1, true) == 1 then
        return "videoLoadFailed"
    end

    if string.find(str1, "screenshot load failed:", 1, true) == 1 then
        return "screenshotLoadFailed"
    end

    return "unknown"
end

local tbl2 = {
    reaction_add = "reaction_add",
    reaction_remove = "reaction_remove",
    share = "share",
    join = "join",
    report = "report",
    report_click = "report_click"
}

local function normalizeEngagementAction(action: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl2[action] or "unknown"
end

local tbl3 = {
    create_intent = "create_intent",
    gallery_selected = "gallery_selected",
    published = "published",
    upload = "upload",
    post_review = "post_review"
}

local function normalizeCreationStep(step: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl3[step] or "unknown"
end

local function normalizeCreationStatus(status: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if status == "success" or status == "failed" then status else "unknown"
end

local tbl4 = {
    Moderated = "moderated",
    CaptureModerated = "moderated",
    UploadQuotaReached = "quota",
    Timeout = "timeout",
    StartUploadFailed = "startFailed",
    RegistrationFailed = "registrationFailed",
    PollError = "pollError",
    NetworkError = "network",
    ServerError = "serverError",
    InvalidRequest = "invalidRequest",
    GenericFailure = "generic"
}

local function normalizeUploadFailureReason(reason: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl4[reason] or "unknown"
end

local tbl5 = {
    malformed = "malformed",
    duplicate = "duplicate",
    moderated = "moderated",
    deleted = "deleted"
}

local function normalizeFilterReason(reason: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl5[reason] or "unknown"
end

local tbl6 = {
    music = "music",
    trim = "trim",
    text_overlay = "text_overlay",
    sticker = "sticker",
    description = "description",
    tts = "tts"
}

local function normalizePublishedEditType(editType: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl6[editType] or "unknown"
end

local tbl7 = {
    music = "music",
    trim = "trim",
    text = "text",
    sticker = "sticker",
    generateText = "generateText",
    voice = "voice"
}

local function normalizeEditTool(tool: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl7[tool] or "unknown"
end

local function normalizeCaptureType(captureType: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if captureType == "screenshot" or captureType == "video" then captureType else "unknown"
end

local function normalizeGenerateTextStatus(status: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if status == "succeeded" or status == "failed" or status == "filtered" then status else "unknown"
end

local function normalizeCommentsSurface(surface: string): string -- Luacid: Inlined by compiler; 7 call sites recovered
    return if surface == "watch_tab" or surface == "profile" then surface else "unknown"
end

local tbl8 = { attempted = "attempted", succeeded = "succeeded", failed = "failed" }

local function normalizeCommentsListLoadStatus(status: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl8[status] or "unknown"
end

local tbl9 = { initial = "initial", pagination = "pagination", refresh = "refresh" }

local function normalizeCommentsLoadType(loadType: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl9[loadType] or "unknown"
end

local tbl10 = {
    attempted = "attempted",
    success = "success",
    rejected = "rejected",
    failed = "failed",
    unknown = "unknown",
    cancelled = "cancelled"
}

local function normalizeCommentPostStatus(status: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl10[status] or "unknown"
end

local function normalizeCommentsFailureReason(failureReason: string?): string -- Luacid: Inlined by compiler; 4 call sites recovered
    return if failureReason == nil or string.find(failureReason, "^unknown_") ~= nil then "unknown" else failureReason
end

local tbl11 = { rejected = true, failed = true, unknown = true }

local tbl12 = { attempted = "attempted", succeeded = "succeeded", failed = "failed" }

local function normalizeCommentRequestStatus(status: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    return tbl12[status] or "unknown"
end

local function normalizeCommentReactionAction(action: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if action == "add" or action == "remove" then action else "unknown"
end

local function normalizeCommentDeleteStatus(status: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if status == "already_deleted" then
        return status
    end

    return (normalizeCommentRequestStatus(status))
end

local function normalizeCommentReportStatus(status: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if status == "clicked" then status else "unknown"
end

local tbl13 = {
    views = "views",
    lifetime_views = "lifetime_views",
    lifetime_watch_time = "lifetime_watch_time",
    lifetime_watch_time_no_replay = "lifetime_watch_time_no_replay",
    lifetime_joins = "lifetime_joins"
}

local function normalizePostInsightsQuery(query: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl13[query] or "unknown"
end

local function normalizePostInsightsRequestStatus(status: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return if status == "success" or status == "failed" then status else "unknown"
end

local function normalizeCommentTranslationShown(status: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if status == "translated" or status == "original" then status else "unknown"
end

local function formatFeedOperationInfo(tbl14, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl15 = {
        status = tbl14.status,
        feedType = tbl14.feedType
    }
    if tbl14.status == "failed" then
        tbl15.failureReason = func1(tbl14.failureReason)
    end
    return tbl15
end

local tbl14 = {
    [RealtimeEventNames.MomentsFeedLoadAttempt] = Telemetry.new({
        name = RealtimeEventNames.MomentsFeedLoadAttempt,
        description = "Counts Moments feed load attempts in real time, providing the denominator for feed outcome rates.",
        lastUpdated = { 2026, 7, 30 },
        throttlingThousandths = 10000,
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            incrementValue = 1,
            format = function(tbl14)
                return {
                    feedType = tbl14.feedType
                }
            end
        }}
    })
}
local MomentsFeedState = RealtimeEventNames.MomentsFeedState
local new = Telemetry.new
local tbl15 = {
    name = RealtimeEventNames.MomentsFeedState,
    description = "Counts completed Moments top-of-feed outcomes in real time, dimensioned by status, feed type, and bounded failure reason.",
    lastUpdated = { 2026, 7, 30 },
    throttlingThousandths = 10000,
    backendsList = 0
}

local tbl16 = {
    type = SupportedTelemetryBackends.RobloxTelemetryCounter,
    incrementValue = 1,
    format = 0
}
local function format(tbl17) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl18 = {
        status = tbl17.status,
        feedType = tbl17.feedType
    }
    if tbl17.status == "failed" then
        tbl18.failureReason = normalizeRequestFailureReason(tbl17.failureReason)
    end
    return tbl18
end

tbl16.format = format
tbl15.backendsList = { tbl16 }
tbl14[MomentsFeedState] = new(tbl15)

tbl14[RealtimeEventNames.MomentsFeedLoadMore] = Telemetry.new({
    name = RealtimeEventNames.MomentsFeedLoadMore,
    description = "Counts attempted and failed Moments pagination requests in real time.",
    lastUpdated = { 2026, 7, 30 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return format(tbl17)
        end
    }}
})

tbl14[RealtimeEventNames.MomentsFeedMediaLoad] = Telemetry.new({
    name = RealtimeEventNames.MomentsFeedMediaLoad,
    description = "Counts attempted and failed unique Moments media loads in the coordinator download window.",
    lastUpdated = { 2026, 7, 30 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return formatFeedOperationInfo(tbl17, normalizeMediaFailureReason)
        end
    }}
})

tbl14[RealtimeEventNames.MomentsSurfaceLoadAbort] = Telemetry.new({
    name = RealtimeEventNames.MomentsSurfaceLoadAbort,
    description = "Counts Moments surface loads that end before the first frame, dimensioned by bounded abort reason.",
    lastUpdated = { 2026, 7, 30 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                reason = tbl17.reason
            }
        end
    }}
})
tbl14[RealtimeEventNames.MomentsViewBegan] = Telemetry.new({
    name = RealtimeEventNames.MomentsViewBegan,
    description = "Counts Moments views in real time, dimensioned by a bounded source.",
    lastUpdated = { 2026, 7, 30 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                source = normalizeViewSource(tbl17.source)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsSessionStarted] = Telemetry.new({
    name = RealtimeEventNames.MomentsSessionStarted,
    description = "Counts Moments session starts in real time, dimensioned by a bounded entry source.",
    lastUpdated = { 2026, 8, 1 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                source = normalizeViewSource(tbl17.source)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsSessionEnded] = Telemetry.new({
    name = RealtimeEventNames.MomentsSessionEnded,
    description = "Counts Moments session ends in real time, dimensioned by a bounded entry source.",
    lastUpdated = { 2026, 8, 1 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                source = normalizeViewSource(tbl17.source)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsSessionHeartbeat] = Telemetry.new({
    name = RealtimeEventNames.MomentsSessionHeartbeat,
    description = "Counts periodic heartbeats emitted while a Moments session is active; multiply the per-second rate by the heartbeat interval to estimate concurrent sessions (CCU).",
    lastUpdated = { 2026, 8, 1 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                source = normalizeViewSource(tbl17.source)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsEngagement] = Telemetry.new({
    name = RealtimeEventNames.MomentsEngagement,
    description = "Counts Moments engagement actions (reactions, shares, joins, report submissions, report clicks, experience-detail opens) in real time, dimensioned by a bounded action.",
    lastUpdated = { 2026, 10, 2 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                action = normalizeEngagementAction(tbl17.action)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsCreationStep] = Telemetry.new({
    name = RealtimeEventNames.MomentsCreationStep,
    description = "Counts Moments creation-flow steps in real time, dimensioned by bounded step and (for upload) status.",
    lastUpdated = { 2026, 8, 1 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            local tbl18 = {
                step = normalizeCreationStep(tbl17.step)
            }
            if tbl17.status ~= nil then
                tbl18.status = normalizeCreationStatus(tbl17.status)
            end

            if tbl17.reason ~= nil then
                tbl18.reason = normalizeUploadFailureReason(tbl17.reason)
            end
            return tbl18
        end
    }}
})

tbl14[RealtimeEventNames.MomentsFeedItemsReceived] = Telemetry.new({
    name = RealtimeEventNames.MomentsFeedItemsReceived,
    description = "Counts feed items received from the backend before client-side filtering; the denominator for the filtered-item rate.",
    lastUpdated = { 2026, 8, 5 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                feedType = tbl17.feedType
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsFeedItemFiltered] = Telemetry.new({
    name = RealtimeEventNames.MomentsFeedItemFiltered,
    description = "Counts feed items the client dropped, dimensioned by bounded reason. deleted/moderated are dropped by the feed source's availability filter; malformed/duplicate are dropped by the feed store's dedupe. Denominator is MomentsFeedItemsReceived.",
    lastUpdated = { 2026, 8, 5 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                reason = normalizeFilterReason(tbl17.reason),
                feedType = tbl17.feedType
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsPublishedWithEdit] = Telemetry.new({
    name = RealtimeEventNames.MomentsPublishedWithEdit,
    description = "Counts published moments carrying each edit type (one increment per edit type present), dimensioned by bounded editType.",
    lastUpdated = { 2026, 8, 5 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                editType = normalizePublishedEditType(tbl17.editType)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsPublishedEditCount] = Telemetry.new({
    name = RealtimeEventNames.MomentsPublishedEditCount,
    description = "Counts published moments by how many edit types they carry, dimensioned by a bounded bucket (0/1/2/3plus).",
    lastUpdated = { 2026, 8, 5 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                bucket = tbl17.bucket
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsPublishedByCaptureType] = Telemetry.new({
    name = RealtimeEventNames.MomentsPublishedByCaptureType,
    description = "Counts published moments by bounded capture type (screenshot/video).",
    lastUpdated = { 2026, 8, 5 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                captureType = normalizeCaptureType(tbl17.captureType)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsEditToolOpened] = Telemetry.new({
    name = RealtimeEventNames.MomentsEditToolOpened,
    description = "Counts creation edit-tool opens, dimensioned by bounded tool (music/trim/text/sticker/generateText/voice).",
    lastUpdated = { 2026, 8, 5 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                tool = normalizeEditTool(tbl17.tool)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsEditToolAbandoned] = Telemetry.new({
    name = RealtimeEventNames.MomentsEditToolAbandoned,
    description = "Counts creation edit-tool cancels (Back without applying), dimensioned by bounded tool. Pairs with MomentsEditToolOpened for an open→apply conversion.",
    lastUpdated = { 2026, 8, 5 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                tool = normalizeEditTool(tbl17.tool)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsGenerateText] = Telemetry.new({
    name = RealtimeEventNames.MomentsGenerateText,
    description = "Counts AI generate-text attempts by bounded status (succeeded/failed/filtered).",
    lastUpdated = { 2026, 8, 17 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                status = normalizeGenerateTextStatus(tbl17.status)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsCommentsListLoad] = Telemetry.new({
    name = RealtimeEventNames.MomentsCommentsListLoad,
    description = "Counts Moments comment list requests in real time by bounded status, load type, surface and (failed only) failure reason. Mirrors the product list-load events.",
    lastUpdated = { 2026, 9, 29 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            local status = normalizeCommentsListLoadStatus(tbl17.status)
            local tbl18 = {
                status = status,
                loadType = normalizeCommentsLoadType(tbl17.loadType),
                surface = normalizeCommentsSurface(tbl17.surface)
            }
            if status == "failed" then
                tbl18.failureReason = normalizeCommentsFailureReason(tbl17.failureReason)
            end
            return tbl18
        end
    }}
})

tbl14[RealtimeEventNames.MomentsCommentPost] = Telemetry.new({
    name = RealtimeEventNames.MomentsCommentPost,
    description = "Counts Moments comment post requests and outcomes in real time by bounded status, surface and (rejected/failed/unknown only) failure reason. Mirrors the product post events.",
    lastUpdated = { 2026, 9, 29 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            local status = normalizeCommentPostStatus(tbl17.status)
            local tbl18 = {
                status = status,
                surface = normalizeCommentsSurface(tbl17.surface)
            }
            if tbl11[status] then
                tbl18.failureReason = normalizeCommentsFailureReason(tbl17.failureReason)
            end
            return tbl18
        end
    }}
})

tbl14[RealtimeEventNames.MomentsCommentReaction] = Telemetry.new({
    name = RealtimeEventNames.MomentsCommentReaction,
    description = "Counts Moments comment reaction requests in real time, one attempt per network request including retries, by bounded status, action (add/remove), surface and (failed only) failure reason.",
    lastUpdated = { 2026, 10, 1 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            local status = normalizeCommentRequestStatus(tbl17.status)
            local tbl18 = {
                status = status,
                action = normalizeCommentReactionAction(tbl17.action),
                surface = normalizeCommentsSurface(tbl17.surface)
            }
            if status == "failed" then
                tbl18.failureReason = normalizeCommentsFailureReason(tbl17.failureReason)
            end
            return tbl18
        end
    }}
})

tbl14[RealtimeEventNames.MomentsCommentDelete] = Telemetry.new({
    name = RealtimeEventNames.MomentsCommentDelete,
    description = "Counts Moments comment delete requests and outcomes in real time by bounded status (already_deleted = the server reported the comment gone), surface and (failed only) failure reason.",
    lastUpdated = { 2026, 10, 1 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            local status = normalizeCommentDeleteStatus(tbl17.status)
            local tbl18 = {
                status = status,
                surface = normalizeCommentsSurface(tbl17.surface)
            }
            if status == "failed" then
                tbl18.failureReason = normalizeCommentsFailureReason(tbl17.failureReason)
            end
            return tbl18
        end
    }}
})

tbl14[RealtimeEventNames.MomentsCommentReport] = Telemetry.new({
    name = RealtimeEventNames.MomentsCommentReport,
    description = "Counts Moments comment report flow opens in real time by surface, including Block and Report. Counted at the same point as the product report-click event; submission happens in the host abuse-report flow.",
    lastUpdated = { 2026, 10, 1 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                status = normalizeCommentReportStatus(tbl17.status),
                surface = normalizeCommentsSurface(tbl17.surface)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsCommentAuthorBlock] = Telemetry.new({
    name = RealtimeEventNames.MomentsCommentAuthorBlock,
    description = "Counts blocks of a comment author started from a Moments comment in real time by bounded status (attempted on confirm, then succeeded/failed) and surface.",
    lastUpdated = { 2026, 10, 1 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                status = normalizeCommentRequestStatus(tbl17.status),
                surface = normalizeCommentsSurface(tbl17.surface)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsPostInsightsRequest] = Telemetry.new({
    name = RealtimeEventNames.MomentsPostInsightsRequest,
    description = "Counts Post insights Creator Analytics (CAaaS) request outcomes in real time, once per query per page open, by bounded query (views series or one of the four lifetime totals) and status (success or failed).",
    lastUpdated = { 2026, 11, 10 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                query = normalizePostInsightsQuery(tbl17.query),
                status = normalizePostInsightsRequestStatus(tbl17.status)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsPostInsightsRequestLatency] = Telemetry.new({
    name = RealtimeEventNames.MomentsPostInsightsRequestLatency,
    description = "Post insights Creator Analytics (CAaaS) request latency in ms, as a stat (p50/p95/p99), by bounded query and status. Same requests as MomentsPostInsightsRequest: each query's first request on a cold page open, including the gateway's polling.",
    lastUpdated = { 2026, 11, 6 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryStat,
        format = function(tbl17)
            return {
                query = normalizePostInsightsQuery(tbl17.query),
                status = normalizePostInsightsRequestStatus(tbl17.status)
            }
        end
    }}
})

tbl14[RealtimeEventNames.MomentsCommentTranslationToggle] = Telemetry.new({
    name = RealtimeEventNames.MomentsCommentTranslationToggle,
    description = "Counts taps on a Moments comment's translation toggle in real time by the text shown after the tap (translated/original) and surface. Counted at the same point as the product translation-toggled event.",
    lastUpdated = { 2026, 11, 5 },
    throttlingThousandths = 10000,
    backendsList = {{
        type = SupportedTelemetryBackends.RobloxTelemetryCounter,
        incrementValue = 1,
        format = function(tbl17)
            return {
                status = normalizeCommentTranslationShown(tbl17.status),
                surface = normalizeCommentsSurface(tbl17.surface)
            }
        end
    }}
})

return tbl14
