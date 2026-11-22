-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _sponsoredAdViewabilityRegistry = require(script.sponsoredAdViewabilityRegistry)
return {
    useSponsoredAdViewabilityDetector = require(script.useSponsoredAdViewabilityDetector),
    useTagAsSponsoredAdViewabilityCandidate = require(script.useTagAsSponsoredAdViewabilityCandidate),
    ["jest.config"] = script["jest.config"]
}
