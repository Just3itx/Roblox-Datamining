-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:31:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SentryReporter = require(script.Sentry.SentryReporter)

return {
    ["jest.config"] = script["jest.config"],
    BacktraceReporter = require(script.Backtrace.BacktraceReporter),
    SentryReporter = SentryReporter,
    ErrorReport = require(script.Sentry.ErrorReport),
    ErrorQueue = require(script.ErrorQueue),
    TokenBucketRateLimiter = require(script.TokenBucketRateLimiter),
    FFlagLuaAppEnableBacktraceSessionInfo = require(script.Backtrace.Flags.FFlagLuaAppEnableBacktraceSessionInfo)
}
