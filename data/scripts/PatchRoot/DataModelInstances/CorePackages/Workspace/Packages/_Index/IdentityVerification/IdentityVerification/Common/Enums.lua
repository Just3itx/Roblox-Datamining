-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    IDVSessionStatusEnum = {
        Unknown = 0,
        Success = 1,
        Failure = 2,
        RequiresManualReview = 3,
        RequiresRetry = 4,
        Started = 5,
        Submitted = 6,
        Stored = 7,
        Expired = 8
    },
    IDVSessionErrorEnum = {
        None = 0,
        UnknownError = 1,
        InvalidDocument = 2,
        InvalidSelfie = 3,
        BelowMinimumAge = 4,
        LowQualityMedia = 5
    }
}
