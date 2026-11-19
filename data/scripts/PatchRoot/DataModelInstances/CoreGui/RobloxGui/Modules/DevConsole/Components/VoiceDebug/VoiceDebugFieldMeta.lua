-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local thresholds = { warn = 30, error = 50 }

local var1 = nil

var1 = {
    rttMs = {
        label = "Round-trip time",
        unit = "ms",
        plottable = true,
        thresholds = { warn = 150, error = 300 },
        group = "Connection"
    },
    incomingStreams = { label = "Incoming streams", group = "Connection" },
    outgoingStreams = { label = "Outgoing streams", group = "Connection" },
    incomingJitterMs = {
        label = "Incoming jitter",
        unit = "ms",
        plottable = true,
        thresholds = thresholds,
        group = "Incoming"
    },
    outgoingJitterMs = {
        label = "Outgoing jitter",
        unit = "ms",
        plottable = true,
        thresholds = thresholds,
        group = "Outgoing"
    },
    incomingPackets = { label = "Incoming packets", group = "Incoming" },
    outgoingPackets = { label = "Outgoing packets", group = "Outgoing" },
    incomingPacketsLost = { label = "Incoming packets lost", group = "Incoming" },
    outgoingPacketsLost = { label = "Outgoing packets lost", group = "Outgoing" },
    incomingPacketsDiscarded = { label = "Incoming packets discarded", group = "Incoming" },
    outgoingPacketsDiscarded = { label = "Outgoing packets discarded", group = "Outgoing" },
    jitterBufferDelayMs = {
        label = "Jitter buffer delay",
        unit = "ms",
        thresholds = { warn = 60, error = 150 },
        group = "Incoming"
    },
    incomingFecPackets = { label = "Incoming FEC packets", group = "Incoming" },
    incomingFecPacketsDiscarded = { label = "Incoming FEC packets discarded", group = "Incoming" },
    totalConcealmentEvents = { label = "Concealment events", group = "Incoming" },
    incomingBytes = { label = "Incoming bytes", group = "Incoming" },
    outgoingBytes = { label = "Outgoing bytes", group = "Outgoing" },
    lastPublisherAudioLevelDbov = {
        label = "Publisher audio level",
        unit = "dBov",
        group = "Outgoing"
    },
    lastSubscriberAudioLevelDbov = {
        label = "Subscriber audio level",
        unit = "dBov",
        group = "Incoming"
    },
    incomingBitrateKbps = {
        label = "Incoming bitrate",
        unit = "kbps",
        plottable = true,
        group = "Incoming"
    },
    outgoingBitrateKbps = {
        label = "Outgoing bitrate",
        unit = "kbps",
        plottable = true,
        group = "Outgoing"
    },
    outgoingCodec = { label = "Outgoing codec", group = "Outgoing" },
    incomingLossPercent = {
        label = "Incoming loss",
        unit = "%",
        plottable = true,
        thresholds = {
            warn = 3,
            error = math.huge
        },
        group = "Incoming"
    },
    getFieldSeverity = function(str1: string, arg1)
        local var2 = var1[str1]
        local thresholds = var2 and var2.thresholds

        if not thresholds or type(arg1) ~= "number" then
            return nil
        end

        if thresholds.error <= arg1 then
            return "error"
        end

        if thresholds.warn <= arg1 then
            return "warn"
        end

        return "ok"
    end
}
return var1
