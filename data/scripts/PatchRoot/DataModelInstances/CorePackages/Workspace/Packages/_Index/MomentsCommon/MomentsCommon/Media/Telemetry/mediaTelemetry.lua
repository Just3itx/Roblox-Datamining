-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function noop() end

return {
    noopSink = {
        recordDownload = noop,
        recordDecode = noop,
        recordTimeToFirstFrame = noop,
        recordCache = noop,
        recordSoftwareFallback = noop,
        recordDwell = noop
    },
    createLoggingSink = function(func1: ((...any) -> (...any))?)
        local var1 = func1 or print

        return {
            recordDownload = function(arg1)
                var1(
                    `[media] download moment={arg1.momentId} kind={arg1.assetKind} dt={arg1.durationSeconds}s ok={arg1.success}`
                )
            end,
            recordDecode = function(arg1)
                var1(`[media] decode moment={arg1.momentId} dt={arg1.durationSeconds}s ok={arg1.success}`)
            end,
            recordTimeToFirstFrame = function(arg1)
                var1(`[media] ttff moment={arg1.momentId} dt={arg1.durationSeconds}s`)
            end,
            recordCache = function(arg1)
                var1(`[media] cache moment={arg1.momentId} stage={arg1.stage} kind={arg1.assetKind} hit={arg1.hit}`)
            end,
            recordSoftwareFallback = function(arg1)
                var1(`[media] software-fallback moment={arg1.momentId}`)
            end,
            recordDwell = function(arg1)
                var1(`[media] dwell moment={arg1.momentId} dt={arg1.durationSeconds}s`)
            end
        }
    end
}
