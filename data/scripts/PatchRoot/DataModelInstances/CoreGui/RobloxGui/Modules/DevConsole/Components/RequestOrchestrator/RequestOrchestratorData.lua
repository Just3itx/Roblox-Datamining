-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local function closeAttempt(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local attempts = arg1.attempts
    local attempt = attempts and attempts[#attempts]
    if attempt and not attempt.finish then
        attempt.finish = tick()
    end
end

function module.new()
    return {
        now = tick(),
        allTypes = {},
        typeSeen = {},
        batchesByType = {},
        queues = {},
        observedMaxByType = {},
        lastBatchSizeByType = {},
        cacheByType = {}
    }
end

function module.observeType(arg1, arg2)
    if arg1.typeSeen[arg2] then
        return nil
    end
    arg1.typeSeen[arg2] = true
    table.insert(arg1.allTypes, arg2)
    return #arg1.allTypes
end

function module.observeTypes(arg1, arg2)
    local result = {}
    for _, value in ipairs(arg2) do
        local var1 = module.observeType(arg1, value)
        if var1 then
            table.insert(result, var1)
        end
    end
    return result
end

function module.batchesFor(arg1, arg2)
    if not arg1.batchesByType[arg2] then
        arg1.batchesByType[arg2] = {}
    end
    return arg1.batchesByType[arg2]
end

function module.registerBatch(arg1, arg2, arg3)
    local var1 = module.batchesFor(arg1, arg2)
    local batchId = arg3.batchId
    var1[tostring(batchId)] = {
        state = "pending",
        sentTime = nil,
        settleTime = nil,
        operationCount = 0,
        attempts = {}
    }
end

function module.openSendAttempt(arg1, arg2, arg3)
    local var1 = module.batchesFor(arg1, arg2)
    local str1 = tostring(arg3.batchId)
    local tbl1 = var1[str1]
    if not tbl1 then
        tbl1 = {
            attempts = {}
        }
        var1[str1] = tbl1
    end
    tbl1.state = "inflight"
    local start = tick()
    tbl1.attempts = tbl1.attempts or {}
    table.insert(tbl1.attempts, { start = start, finish = nil })
    tbl1.sentTime = tbl1.sentTime or start
    tbl1.operationCount = arg3.operationCount or 0
end

function module.settleBatch(arg1, arg2, arg3)
    local var1 = arg1.batchesByType[arg2]
    if not var1 then
        return
    end
    local var2 = var1[tostring(arg3.batchId)]
    if not var2 then
        return
    end

    closeAttempt(var2)
    var2.settleTime = tick()
    var2.state = if arg3.success then "success" else "failure"
    var2.httpStatus = arg3.httpStatus
end

function module.reclassifyOnRetry(arg1, arg2, arg3)
    local var1 = arg1.batchesByType[arg2]
    if not var1 then
        return
    end
    local var2 = var1[tostring(arg3.batchId)]
    if not var2 then
        return
    end

    closeAttempt(var2)

    if var2.state == "pending" and not var2.sentTime then
        local var3 = var1[tostring(arg3.batchId - 1)]
        if var3 and var3.state == "failure" then
            var3.state = "retrying"
        end
    end
    var2.state = "retrying"
    var2.attemptNumber = arg3.attemptNumber
end

function module.markExhausted(arg1, arg2, arg3)
    local var1 = arg1.batchesByType[arg2]
    if not var1 then
        return
    end
    local var2 = var1[tostring(arg3.batchId)]
    if var2 then
        closeAttempt(var2)
        var2.state = "exhausted"
        var2.settleTime = tick()
    end
end

function module.trackQueueOnCreated(arg1, arg2, arg3)
    if arg3.maxBatchSize then
        arg1.observedMaxByType[arg2] = arg3.maxBatchSize
    end
    local var1 = arg1.queues[arg2]
    if var1 then
        var1.batchId = arg3.batchId
        return
    end
    arg1.queues[arg2] = {
        batchId = arg3.batchId,
        ops = {},
        createdTime = tick(),
        retryOps = {}
    }
end

function module.drainQueueOnSent(arg1, arg2, arg3)
    local var1 = arg1.queues[arg2]
    local var2 = arg3.operationCount or var1 and #var1.retryOps + #var1.ops or 0
    arg1.lastBatchSizeByType[arg2] = var2
    if not var1 then
        return
    end

    for _ = 1, var2 do
        if #var1.retryOps > 0 then
            table.remove(var1.retryOps, 1)
        else
            if not (#var1.ops > 0) then
                break
            end

            table.remove(var1.ops, 1)
        end
    end

    if #var1.ops == 0 and #var1.retryOps == 0 then
        arg1.queues[arg2] = nil
    end
end

function module.requeueRetryOps(arg1, arg2, arg3)
    local tbl1 = arg1.queues[arg2]
    if not tbl1 then
        tbl1 = {
            batchId = arg3.batchId,
            ops = {},
            createdTime = tick(),
            retryOps = {}
        }
        arg1.queues[arg2] = tbl1
    end
    local var1 = arg1.lastBatchSizeByType[arg2] or arg3.operationCount or 0
    tbl1.retryOps = {}
    for i = 1, var1 do
        table.insert(tbl1.retryOps, "retry-" .. i)
    end
end

function module.clearQueueOnExhausted(arg1, arg2)
    local var1 = arg1.queues[arg2]
    if not var1 then
        return
    end

    var1.retryOps = {}
    if #var1.ops == 0 then
        arg1.queues[arg2] = nil
    end
end

function module.enqueueOperation(arg1, arg2, arg3)
    local tbl1 = arg1.queues[arg2]
    if not tbl1 then
        tbl1 = {
            batchId = arg3.batchId,
            ops = {},
            createdTime = tick(),
            retryOps = {}
        }
        arg1.queues[arg2] = tbl1
    end
    table.insert(tbl1.ops, arg3.message or "?")
end

function module.recordCacheItemAdded(arg1, arg2, arg3)
    local tbl1 = arg1.cacheByType[arg2]
    if not tbl1 then
        tbl1 = {
            items = {}
        }
        arg1.cacheByType[arg2] = tbl1
    end
    local message = arg3.message or ""
    for _, item in ipairs(tbl1.items) do
        if item.key == message then
            return
        end
    end
    table.insert(tbl1.items, { key = message, lastHitTime = nil })
    if #tbl1.items > 48 then
        table.remove(tbl1.items, 1)
    end
end

function module.recordCacheHit(arg1, arg2, arg3)
    local tbl1 = arg1.cacheByType[arg2]
    if not tbl1 then
        tbl1 = {
            items = {}
        }
        arg1.cacheByType[arg2] = tbl1
    end
    local message = arg3.message or ""
    for i = #tbl1.items, 1, -1 do
        if tbl1.items[i].key == message then
            tbl1.items[i].lastHitTime = tick()
            return
        end
    end
    table.insert(tbl1.items, { key = message, lastHitTime = tick() })
    if #tbl1.items > 48 then
        table.remove(tbl1.items, 1)
    end
end

function module.advanceTime(arg1)
    arg1.now = tick()
    local var1 = arg1.now - 30
    for _, value in pairs(arg1.batchesByType) do
        for k, value2 in pairs(value) do
            if value2.settleTime and value2.settleTime < var1 then
                value[k] = nil
            end
        end
    end
end

return module
