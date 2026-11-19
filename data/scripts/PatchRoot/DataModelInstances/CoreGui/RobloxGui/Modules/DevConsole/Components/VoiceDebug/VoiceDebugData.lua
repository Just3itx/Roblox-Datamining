-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local CircularBuffer = require(script.Parent.Parent.Parent.CircularBuffer)
local Signal = require(script.Parent.Parent.Parent.Signal)
local VoiceDebugFieldMeta = require(script.Parent.VoiceDebugFieldMeta)
local VoiceDebugSource = require(script.Parent.VoiceDebugSource)

local VoiceChatService = game:GetService("VoiceChatService")

local num1 = tonumber(settings():GetFVariable("NewDevConsoleMaxGraphCount")) or 60

local default = require(CorePackages.Workspace.Packages.CrossExperienceVoice).CrossExperienceVoiceManager.default

local InExperience = VoiceDebugSource.InExperience
local Party = VoiceDebugSource.Party

local GetFFlagVoiceDebugConsoleV2 = require(script.Parent.GetFFlagVoiceDebugConsoleV2)

local function parseCodecFromSdp(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not str1 or str1 == "" then
        return nil
    end
    local _, var1, var2, var3 = string.match(str1, "a=rtpmap:(%d+) (%a+)/(%d+)/(%d+)")
    if not (var1 and var2 and var3) then
        return nil
    end
    return string.format("%s/%s/%s", var1, var2, var3)
end

local function computeBitrateKbps(num2: number?, num3: number?, num4: number?) -- Luacid: Inlined by compiler; 5 call sites recovered
    if type(num2) == "number" and type(num3) == "number" and type(num4) == "number" and not (num4 <= 0) then
        if num2 < num3 then
            return nil
        end

        return (num2 - num3) * 8 / num4 / 1000
    end

    return nil
end

local function computeSubscriptionBitrates(tbl1, tbl2, num2: number?)
    local tbl3 = ({})
    for _, value in tbl1 do
        local audioSsrc = value.audioSsrc
        if type(audioSsrc) ~= "number" or audioSsrc ~= audioSsrc or audioSsrc % 1 ~= 0 then
            continue
        end

        tbl3[audioSsrc] = true
        local var1 = tbl2[audioSsrc]
        local bool1 = not (var1 == nil) and var1.userId == value.userId
        local incomingBytes = value.incomingBytes
        local bytes = if bool1 then var1.bytes or nil else nil
        value.incomingBitrateKbps = computeBitrateKbps(incomingBytes, bytes, num2)

        tbl2[audioSsrc] = {
            userId = value.userId,
            bytes = value.incomingBytes
        }
    end
    for value in tbl2 do
        if not tbl3[value] then
            tbl2[value] = nil
        end
    end
end

local function computeLossPercent(num2: number?, num3: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(num2) ~= "number" or type(num3) ~= "number" then
        return nil
    end
    local num4 = num2 + num3
    return if num4 <= 0 then nil else num3 / num4 * 100
end

local function deltaSince(num2: number?, num3: number?): number? -- Luacid: Inlined by compiler; 4 call sites recovered
    return if type(num2) == "number" and type(num3) == "number" and not (num2 < num3) then num2 - num3 else nil
end

local function computeJitterBufferDelayMs(num2: number?, num3: number?, num4: number?, num5: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(num2) ~= "number" or type(num3) ~= "number" or type(num4) ~= "number" or type(num5) ~= "number" then
        return nil
    end
    local num6 = num4 - num5
    local num7 = num2 - num3
    return if num6 <= 0 or num7 < 0 then nil else num7 * 1000 / num6
end

local function nativeSecondsToWallClockSeconds(num2: number, num3: number, num4: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num4 + (num2 - num3)
end

local function formatWallClockTime(num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return (os.date("%H:%M:%S", num2))
end

local function decorateOperationEntries(tbl1, num2: number, num3: number)
    local var1 = table.create(#tbl1)
    for value, value2 in tbl1 do
        local timestampText = if value2.timestampSeconds then formatWallClockTime((nativeSecondsToWallClockSeconds(value2.timestampSeconds, num2, num3))) else nil
        local tbl2 = {
            name = value2.name,
            operationType = value2.operationType,
            timestampSeconds = value2.timestampSeconds,
            timestampText = timestampText
        }
        var1[value] = tbl2
    end

    return var1
end

local function decorateRemoteOperationsPayload(arg1)
    local now = os.time()
    local nativeNowSeconds = arg1.nativeNowSeconds or 0
    return {
        sent = decorateOperationEntries(arg1.sent or {}, nativeNowSeconds, now),
        received = decorateOperationEntries(arg1.received or {}, nativeNowSeconds, now),
        operations = decorateOperationEntries(arg1.operations or {}, nativeNowSeconds, now),
        sentCaptureEnabled = arg1.sentCaptureEnabled == true,
        receivedCaptureEnabled = arg1.receivedCaptureEnabled == true,
        opQueueCaptureEnabled = arg1.opQueueCaptureEnabled == true
    }
end

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._statsUpdated = Signal.new()
    result._statsData = {}
    result._series = {}
    result._connectivityData = {}
    result._subscriptionsData = {}
    result._remoteOperationsData = {}
    result._prevSubscriptionBytesBySsrc = {}
    result._isRunning = false

    result._source = InExperience
    result._partyStatsData = {}
    result._partySeries = {}
    result._partyConnectivityData = {}
    result._partySubscriptionsData = {}
    result._partyRemoteOperationsData = {}
    result._isPartyActive = false
    result._partyPollTask = nil
    result._partyPollGeneration = 0
    result._prevPartyJitterBufferDelaySeconds = nil
    result._prevPartyJitterBufferEmittedCount = nil
    result._prevPartyIncomingBytes = nil
    result._prevPartyOutgoingBytes = nil

    result._prevPartySubscriptionBytesBySsrc = {}

    result._prevBytesClock = nil
    result._prevIncomingBytes = nil
    result._prevOutgoingBytes = nil
    result._prevIncomingPackets = nil
    result._prevIncomingPacketsLost = nil
    result._prevJitterBufferDelaySeconds = nil
    result._prevJitterBufferEmittedCount = nil

    return result
end

function module:Signal()
    return self._statsUpdated
end

function module:getCurrentData()
    return if self._source == Party then self._partyStatsData else self._statsData
end

function module:getSeries()
    return if self._source == Party then self._partySeries else self._series
end

function module.getSeriesSnapshot(arg1)
    local seriesSnapshot = ({})
    for value, value2 in arg1:getSeries() do
        local tbl1 = {
            max = value2.max,
            min = value2.min,
            dataSet = value2.dataSet:clone()
        }
        seriesSnapshot[value] = tbl1
    end

    return seriesSnapshot
end

function module:isRunning()
    return self._isRunning
end

function module:getConnectivity()
    return if self._source == Party then self._partyConnectivityData else self._connectivityData
end

function module:getSource()
    return self._source
end

function module:isPartyVoiceActive()
    return self._isPartyActive
end

function module:setSource(_source: string)
    if self._source == _source then
        return
    end
    self._source = _source
    self._statsUpdated:Fire(self:getCurrentData())
end

function module:getSubscriptions()
    if self._source == Party then
        return self._partySubscriptionsData.subscriptions or {}
    end

    return self._subscriptionsData.subscriptions or {}
end

function module:getRemoteOperations()
    return if self._source == Party then self._partyRemoteOperationsData else self._remoteOperationsData
end

function module:_updateSeriesValueInto(tbl1, str1: string, num2: number, time: number)
    if not tbl1[str1] then
        local circularBuffer = CircularBuffer.new(num1)
        circularBuffer:push_back({ value = num2, time = time })

        tbl1[str1] = { max = num2, min = num2, dataSet = circularBuffer }

        return
    end

    local var1 = tbl1[str1]
    local max = var1.max
    local min = var1.min

    local var2 = var1.dataSet:push_back({ value = num2, time = time })
    local value, value2

    if var2 and (max == var2.value or min == var2.value) then
        local var3 = var1.dataSet:iterator()
        local var4 = var3:next()
        value = var4 and var4.value
        if var4 then
            value2 = var4.value
        else
            value2 = var4
        end

        while var4 do
            value = var4.value < value and value or var4.value
            value2 = value2 < var4.value and value2 or var4.value
            var4 = var3:next()
        end
        if max ~= var2.value then
            value = max
        end

        if min ~= var2.value then
            value2 = min
        end
    else
        value2 = min
        value = max
    end

    var1.max = value < num2 and num2 or value
    if value2 < num2 then
        num2 = value2 or num2
    end

    var1.min = num2
end

function module:_updateSeriesValue(str1: string, num2: number, num3: number)
    self:_updateSeriesValueInto(self._series, str1, num2, num3)
end

function module:start()
    if not VoiceChatService or self._statsListenerConnection then
        return
    end

    self._statsListenerConnection = VoiceChatService.VoiceChatStatsCollected:Connect(function()
        self._statsData = VoiceChatService:lastVoiceChatStats()

        self._connectivityData = VoiceChatService:lastVoiceChatConnectivity()
        self._subscriptionsData = VoiceChatService:lastVoiceChatSubscriptions() or {}
        local var1 = VoiceChatService:lastVoiceChatRemoteOperations() or {}

        local now = os.time()

        if GetFFlagVoiceDebugConsoleV2() then
            if var1.nativeNowSeconds then
                self._remoteOperationsData = decorateRemoteOperationsPayload(var1)
            else
                self._remoteOperationsData = {}
            end
            local _prevBytesClock = os.clock()
            local var2 = if self._prevBytesClock then _prevBytesClock - self._prevBytesClock or nil else nil
            self._statsData.incomingBitrateKbps = computeBitrateKbps(self._statsData.incomingBytes, self._prevIncomingBytes, var2)
            self._statsData.outgoingBitrateKbps = computeBitrateKbps(self._statsData.outgoingBytes, self._prevOutgoingBytes, var2)
            self._prevIncomingBytes = self._statsData.incomingBytes
            self._prevOutgoingBytes = self._statsData.outgoingBytes
            self._prevBytesClock = _prevBytesClock

            self._statsData.outgoingCodec = parseCodecFromSdp(self._connectivityData.sdpPublishOffer)

            self._statsData.incomingLossPercent = computeLossPercent(
                deltaSince(self._statsData.incomingPackets, self._prevIncomingPackets),
                (deltaSince(self._statsData.incomingPacketsLost, self._prevIncomingPacketsLost))
            )
            self._prevIncomingPackets = self._statsData.incomingPackets
            self._prevIncomingPacketsLost = self._statsData.incomingPacketsLost

            local jitterBufferDelayMs = self._statsData.jitterBufferDelayMs
            local jitterBufferEmittedCount = self._statsData.jitterBufferEmittedCount
            self._statsData.jitterBufferDelayMs = computeJitterBufferDelayMs(
                jitterBufferDelayMs,
                self._prevJitterBufferDelaySeconds,
                jitterBufferEmittedCount,
                self._prevJitterBufferEmittedCount
            )
            self._prevJitterBufferDelaySeconds = jitterBufferDelayMs
            self._prevJitterBufferEmittedCount = jitterBufferEmittedCount

            computeSubscriptionBitrates(self._subscriptionsData.subscriptions or {}, self._prevSubscriptionBytesBySsrc, var2)
        end

        for value, value2 in self._statsData do
            local var2 = VoiceDebugFieldMeta[value]
            if var2 and var2.plottable and type(value2) == "number" then
                self:_updateSeriesValue(value, value2, now)
            end
        end

        if self._source == InExperience then
            self._statsUpdated:Fire(self._statsData)
        end
    end)
    self._isRunning = true

    if GetFFlagVoiceDebugConsoleV2() then
        self:_startPartyPipeline()
    end
end

function module:_correctPartyJitterBufferDelay()
    local jitterBufferDelayMs = self._partyStatsData.jitterBufferDelayMs
    local jitterBufferEmittedCount = self._partyStatsData.jitterBufferEmittedCount
    self._partyStatsData.jitterBufferDelayMs = computeJitterBufferDelayMs(
        jitterBufferDelayMs,
        self._prevPartyJitterBufferDelaySeconds,
        jitterBufferEmittedCount,
        self._prevPartyJitterBufferEmittedCount
    )
    self._prevPartyJitterBufferDelaySeconds = jitterBufferDelayMs
    self._prevPartyJitterBufferEmittedCount = jitterBufferEmittedCount
end

function module:_correctPartyAggregateStats(num2: number?)
    if not GetFFlagVoiceDebugConsoleV2() then
        return
    end

    self._partyStatsData.incomingBitrateKbps = computeBitrateKbps(self._partyStatsData.incomingBytes, self._prevPartyIncomingBytes, num2)
    self._partyStatsData.outgoingBitrateKbps = computeBitrateKbps(self._partyStatsData.outgoingBytes, self._prevPartyOutgoingBytes, num2)
    self._prevPartyIncomingBytes = self._partyStatsData.incomingBytes
    self._prevPartyOutgoingBytes = self._partyStatsData.outgoingBytes

    self._partyStatsData.outgoingCodec = parseCodecFromSdp(self._partyConnectivityData.sdpPublishOffer)

    self._partyStatsData.incomingLossPercent = computeLossPercent(
        deltaSince(self._partyStatsData.incomingPackets, self._prevPartyIncomingPackets),
        (deltaSince(self._partyStatsData.incomingPacketsLost, self._prevPartyIncomingPacketsLost))
    )
    self._prevPartyIncomingPackets = self._partyStatsData.incomingPackets
    self._prevPartyIncomingPacketsLost = self._partyStatsData.incomingPacketsLost
end

function module:_startPartyPipeline()
    if self._partyPollTask then
        return
    end

    self._partyPollGeneration += 1
    local _partyPollGeneration = self._partyPollGeneration

    self._partyPollTask = task.spawn(function()
        local var1 = nil

        while self._isRunning and _partyPollGeneration == self._partyPollGeneration do
            local var2, var3

            if game:GetEngineFeature("CEVGetBackgroundState") then
                var2, var3 = default:getIsBackgroundDMActive():await()
            else
                var2 = false
                var3 = false
            end
            if not self._isRunning or _partyPollGeneration ~= self._partyPollGeneration then
                break
            end

            self._isPartyActive = var2 and var3 == true

            local now = os.clock()
            if self._isPartyActive and (not var1 or now - var1 >= 30) then
                local var4, var5 = default:getPartyVoiceDebugStats():await()
                if not self._isRunning or _partyPollGeneration ~= self._partyPollGeneration then
                    break
                end

                if var4 and var5 then
                    local now2 = os.clock()
                    local var6 = if var1 then now2 - var1 or nil else nil
                    self._partyStatsData = var5.stats or {}
                    self._partyConnectivityData = var5.connectivity or {}
                    self._partySubscriptionsData = var5.subscriptions or {}
                    local var7 = var5.remoteOperations or {}
                    self._partyRemoteOperationsData = var7.nativeNowSeconds and decorateRemoteOperationsPayload(var7) or {}

                    self:_correctPartyJitterBufferDelay()
                    self:_correctPartyAggregateStats(var6)
                    computeSubscriptionBitrates(
                        self._partySubscriptionsData.subscriptions or {},
                        self._prevPartySubscriptionBytesBySsrc,
                        var6
                    )

                    local now3 = os.time()
                    var1 = now2

                    for value, value2 in self._partyStatsData do
                        local var8 = VoiceDebugFieldMeta[value]
                        if var8 and var8.plottable and type(value2) == "number" then
                            self:_updateSeriesValueInto(self._partySeries, value, value2, now3)
                        end
                    end

                    if self._source == Party then
                        self._statsUpdated:Fire(self._partyStatsData)
                    end
                end
            end

            task.wait(1)
        end
    end)
end

function module:stop()
    self._isRunning = false
    if self._statsListenerConnection then
        self._statsListenerConnection:Disconnect()
        self._statsListenerConnection = nil
    end
    self._partyPollTask = nil
    self._partyPollGeneration += 1

    self._prevBytesClock = nil
    self._prevIncomingBytes = nil
    self._prevOutgoingBytes = nil
    self._prevIncomingPackets = nil
    self._prevIncomingPacketsLost = nil
    self._prevJitterBufferDelaySeconds = nil
    self._prevJitterBufferEmittedCount = nil
    self._prevSubscriptionBytesBySsrc = {}

    self._prevPartyIncomingBytes = nil
    self._prevPartyOutgoingBytes = nil
    self._prevPartyIncomingPackets = nil
    self._prevPartyIncomingPacketsLost = nil
    self._prevPartyJitterBufferDelaySeconds = nil
    self._prevPartyJitterBufferEmittedCount = nil
    self._prevPartySubscriptionBytesBySsrc = {}
end

module._parseCodecFromSdp = parseCodecFromSdp
module._computeBitrateKbps = computeBitrateKbps
module._computeLossPercent = computeLossPercent
module._deltaSince = deltaSince
module._computeJitterBufferDelayMs = computeJitterBufferDelayMs
module._computeSubscriptionBitrates = computeSubscriptionBitrates
module._nativeSecondsToWallClockSeconds = nativeSecondsToWallClockSeconds
module._formatWallClockTime = formatWallClockTime
module._decorateOperationEntries = decorateOperationEntries
module._decorateRemoteOperationsPayload = decorateRemoteOperationsPayload

return module
