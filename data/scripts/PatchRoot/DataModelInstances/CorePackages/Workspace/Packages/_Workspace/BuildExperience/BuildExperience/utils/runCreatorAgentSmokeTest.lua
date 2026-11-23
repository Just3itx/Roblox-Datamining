-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local getCurrentExperienceProject = require(script.Parent.getCurrentExperienceProject)
local getDefaultTemplatePlaceId = require(script.Parent.getDefaultTemplatePlaceId)

local debug2 = CreatorAgentChat.debug

local function awaitRequestHandle(state, num1: number)
    while state(false).status == "pending" do
        if num1 <= os.clock() then
            return state(false)
        end
        task.wait()
    end
    return state(false)
end

local function runSyncRpc(method: string, func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
    local startTime = os.clock()
    local var1 = func1()
    local var2 = awaitRequestHandle(var1.state, os.clock() + 30)
    local elapsedMs = math.floor((os.clock() - startTime) * 1000)

    if var2.status == "succeeded" then
        return {
            method = method,
            status = "ok",
            detail = if func2 then func2(var2.result) else "succeeded",
            elapsedMs = elapsedMs
        }
    elseif var2.status == "pending" then
        return {
            method = method,
            status = "fail",
            detail = "timed out (still pending)",
            elapsedMs = elapsedMs
        }
    end

    return {
        method = method,
        status = "fail",
        detail = var2.error or "failed",
        elapsedMs = elapsedMs
    }
end

local function skipResult(method: string, detail: string) -- Luacid: Inlined by compiler; 6 call sites recovered
    return { method = method, status = "skip", detail = detail, elapsedMs = nil }
end

local function formatResultLine(tbl1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = if tbl1.status == "ok" then "OK" elseif tbl1.status == "skip" then "SKIP" else "FAIL"
    local str2 = if tbl1.elapsedMs then ` ({tbl1.elapsedMs}ms)` else ""
    return `[{str1}] {tbl1.method}{str2} \226\128\148 {tbl1.detail}`
end

local function buildSummary(url: string, tbl1): string
    local tbl2 = { "CAS API smoke test", url, "" }

    for _, value in tbl1 do
        table.insert(tbl2, (formatResultLine(value)))
    end

    local num1 = 0
    local num2 = 0
    local num3 = 0
    for _, value in tbl1 do
        if value.status == "ok" then
            num1 += 1
        elseif value.status == "skip" then
            num3 += 1
        else
            num2 += 1
        end
    end
    table.insert(tbl2, "")
    table.insert(tbl2, `Summary: {num1} ok, {num2} fail, {num3} skip`)

    return table.concat(tbl2, "\n")
end

local function runSessionPromptSmoke(arg1, sessionId: string?, universeId: number?)
    if sessionId == nil then
        return skipResult("session/prompt", "requires session/new to succeed first")
    end

    local startTime = os.clock()
    local tbl1 = { sessionId = sessionId, prompt = "smoke test" }

    if universeId ~= nil then
        tbl1._meta = {
            _roblox = {
                providerConfig = { universeId = universeId }
            }
        }
    end

    local var1 = arg1.sessionPrompt(tbl1)
    local num1 = os.clock() + 30
    while var1.state(false).status == "queued" do
        if num1 <= os.clock() then
            return {
                method = "session/prompt",
                status = "fail",
                detail = "timed out waiting for POST ack (still queued)",
                elapsedMs = math.floor((os.clock() - startTime) * 1000)
            }
        end
        task.wait()
    end

    while not var1.state(false).isDone do
        if num1 <= os.clock() then
            return {
                method = "session/prompt",
                status = "fail",
                detail = "timed out waiting for CAP completion",
                elapsedMs = math.floor((os.clock() - startTime) * 1000)
            }
        end
        task.wait()
    end

    local elapsedMs = math.floor((os.clock() - startTime) * 1000)
    local var2 = var1.state(false)

    if var2.status == "failed" then
        return {
            method = "session/prompt",
            status = "fail",
            detail = var2.error or "POST failed",
            elapsedMs = elapsedMs
        }
    end

    return {
        method = "session/prompt",
        status = "ok",
        detail = if var2.isDone then `CAP completed ({var2.status}, stopReason={var2.stopReason or "?"})` else "POST accepted (202); CAP stream not completed in window",
        elapsedMs = elapsedMs
    }
end

local function runCreatorAgentSmokeTest(arg1, num1: number?, num2: number?)
    local var1 = CreatorAgentChat.resolveCreatorAgentAcp()
    local results = {}
    local currentExperienceProject = getCurrentExperienceProject()
    local universeId = num1 or currentExperienceProject.universeId
    local placeId = num2 or currentExperienceProject.placeId or getDefaultTemplatePlaceId()

    debug2.log("info", "CAS smoke test starting", { acpUrl = var1.url, universeId = universeId, placeId = placeId })

    local sessionId = nil

    table.insert(results, (runSyncRpc("initialize", function()
        return arg1.initialize({ protocolVersion = 2 })
    end, function(arg2): string
        if typeof(arg2) == "table" and typeof(arg2.agentInfo) == "table" then
            return `agent={arg2.agentInfo.name or "?"} v{arg2.agentInfo.version or "?"}`
        end
        return "succeeded"
    end)))
    local tbl2 = universeId == nil
        and {
            method = "session/new",
            status = "skip",
            detail = "requires universeId (game.GameId is 0 or not in an experience)",
            elapsedMs = nil
        }
        or runSyncRpc("session/new", function()
            return arg1.sessionNew({ project = { universeId = universeId, placeId = placeId }, application = "build" })
        end, function(arg2): string
            if typeof(arg2) ~= "table" or typeof(arg2.sessionId) ~= "string" or arg2.sessionId == "" then
                return "succeeded but missing sessionId"
            end
            sessionId = arg2.sessionId
            return `sessionId={sessionId}`
        end)

    if tbl2.status == "ok" and sessionId == nil then
        tbl2 = {
            method = "session/new",
            status = "fail",
            detail = "succeeded but missing sessionId in result",
            elapsedMs = tbl2.elapsedMs
        }
    elseif tbl2.status == "fail" then
        tbl2.detail = debug2.rpcFailureMessage("session/new", { status = "failed", error = tbl2.detail })
    end

    table.insert(results, tbl2)

    table.insert(results, (runSyncRpc("session/list", function()
        return arg1.sessionList()
    end, function(arg2): string
        return `{#((typeof(arg2) ~= "table" or not arg2.sessions) and {} or arg2.sessions)} session(s)`
    end)))
    if sessionId == nil then
        table.insert(results, (skipResult("session/load", "requires session/new")))
        table.insert(results, (skipResult("_roblox/session/update_info", "requires session/new")))
        table.insert(results, (skipResult("session/cancel", "requires session/new")))
        table.insert(results, (skipResult("_roblox/session/delete", "requires session/new")))
        table.insert(results, (skipResult("session/prompt", "requires session/new to succeed first")))
    else
        table.insert(results, (runSyncRpc("session/load", function()
            return arg1.sessionLoad(sessionId)
        end)))
        table.insert(results, (runSyncRpc("_roblox/session/update_info", function()
            return arg1.sessionUpdateInfo(sessionId, "BuildExperience smoke test")
        end)))
        table.insert(results, (runSessionPromptSmoke(arg1, sessionId, universeId)))

        table.insert(results, (runSyncRpc("session/cancel", function()
            return arg1.sessionCancel(sessionId)
        end)))
        table.insert(results, (runSyncRpc("_roblox/session/delete", function()
            return arg1.sessionDelete(sessionId)
        end)))
    end
    local summary = buildSummary(var1.url, results)
    debug2.log("info", "CAS smoke test complete", { results = results, summary = summary })

    return {
        acpUrl = var1.url,
        results = results,
        summary = summary
    }
end

return runCreatorAgentSmokeTest
