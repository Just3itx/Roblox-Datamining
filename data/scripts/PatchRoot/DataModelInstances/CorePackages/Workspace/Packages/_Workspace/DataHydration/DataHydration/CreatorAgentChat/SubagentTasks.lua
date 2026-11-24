-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local types = require(script.Parent.types)

local SubagentTaskStatus = types.SubagentTaskStatus
local SubagentTaskCategory = types.SubagentTaskCategory

local tbl1 = {
    pending = SubagentTaskStatus.Pending,
    in_progress = SubagentTaskStatus.InProgress,
    done = SubagentTaskStatus.Done,
    error = SubagentTaskStatus.Error,
    deleted = SubagentTaskStatus.Deleted
}

local tbl2 = {
    gameplay = SubagentTaskCategory.Gameplay,
    art = SubagentTaskCategory.Art,
    audio = SubagentTaskCategory.Audio,
    marketing = SubagentTaskCategory.Marketing
}
local tbl3 = {
    [SubagentTaskStatus.InProgress] = 1,
    [SubagentTaskStatus.Done] = 2,
    [SubagentTaskStatus.Pending] = 3,
    [SubagentTaskStatus.Error] = 4,
    [SubagentTaskStatus.Deleted] = 5
}

local function toTaskStatus(status) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(status) == "string" then
        return tbl1[string.lower(status)] or status
    end

    return SubagentTaskStatus.Pending
end

local function toTaskCategory(category) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(category) == "string" then
        return tbl2[string.lower(category)] or category
    end

    return nil
end

local function valueLooksLikeToolName(arg1): boolean -- Luacid: Inlined by compiler; 20 call sites recovered
    return typeof(arg1) == "string" and string.lower(arg1) == "manage_tasks"
end

local function toolCallLooksLikeManageTasks(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if valueLooksLikeToolName(arg1.kind) or valueLooksLikeToolName(arg1.title) then
        return true
    end

    local rawInput = arg1.rawInput
    return typeof(rawInput) == "table" and (valueLooksLikeToolName(rawInput.name) or valueLooksLikeToolName(rawInput.toolName))
end

local function toTaskMetadata(metadata)
    if metadata == nil then
        return nil
    end
    if typeof(metadata) == "table" then
        return metadata
    end

    if typeof(metadata) == "string" then
        local success, result = pcall(function()
            return HttpService:JSONDecode(metadata)
        end)
        if success and typeof(result) == "table" then
            return result
        end
    end
    return nil
end

local function toTaskItem(arg1): {category: any, created_timestamp: number, description: any, metadata: any, status: any, text: any}?
    if typeof(arg1) ~= "table" or typeof(arg1.text) ~= "string" or arg1.text == "" then
        return nil
    end

    local category = toTaskCategory(arg1.category)
    if category == nil then
        return nil
    end

    return {
        text = arg1.text,
        description = arg1.description,
        status = toTaskStatus(arg1.status),
        category = category,
        metadata = toTaskMetadata(arg1.metadata),
        created_timestamp = if typeof(arg1.created_timestamp) == "string" then arg1.created_timestamp else nil
    }
end

local function isTaskComplete(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.status == SubagentTaskStatus.Done
end

local function isTaskLoading(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.status == SubagentTaskStatus.InProgress
end

local function getTaskStatusPriority(status) -- Luacid: Inlined by compiler; 4 call sites recovered
    return if status == nil then 6 else tbl3[status] or 6
end

local function sortTasksByStatus(tasks) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(tasks)
    table.sort(var1, function(arg1, arg2): boolean
        return getTaskStatusPriority(arg1.status) < getTaskStatusPriority(arg2.status)
    end)
    return var1
end

local function appendTasksFromPayload(arg1, tbl4)
    local tasks = if typeof(arg1) == "table" then arg1.tasks else nil

    if typeof(tasks) ~= "table" then
        return
    end

    for _, task in tasks do
        local var1 = toTaskItem(task)
        if var1 ~= nil then
            table.insert(tbl4, var1)
        end
    end
end

local function appendTasksFromMaybeJson(rawInput, tbl4)
    if typeof(rawInput) == "table" then
        appendTasksFromPayload(rawInput, tbl4)
        return
    end

    if typeof(rawInput) ~= "string" then
        return
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(rawInput)
    end)
    if not success then
        return
    end

    local text = if typeof(result) == "table" then result.text else nil

    if typeof(text) == "string" then
        local success2, result2 = pcall(function()
            return HttpService:JSONDecode(text)
        end)
        if success2 then
            appendTasksFromPayload(result2, tbl4)
        end
    end
    appendTasksFromPayload(result, tbl4)
end

local function extractTasksFromToolCall(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not toolCallLooksLikeManageTasks(arg1) then
        return nil
    end

    local tbl4 = {}
    appendTasksFromMaybeJson(arg1.rawInput, tbl4)
    return if #tbl4 > 0 then tbl4 else nil
end

local function orderedManageTasksToolCalls(arg1)
    local result = {}
    local tbl4 = {}

    for _, activityItem in arg1.activityItems do
        if activityItem.kind ~= "tool_call" then
            continue
        end

        local toolCall = arg1.toolCalls[activityItem.toolCallId]

        if toolCall ~= nil and toolCallLooksLikeManageTasks(toolCall) then
            table.insert(result, toolCall)
            tbl4[toolCall.toolCallId] = true
        end
    end

    local tbl5 = {}
    for k, toolCall in arg1.toolCalls do
        if not tbl4[k] and toolCallLooksLikeManageTasks(toolCall) then
            table.insert(tbl5, k)
        end
    end
    table.sort(tbl5)
    for _, value in tbl5 do
        table.insert(result, arg1.toolCalls[value])
    end

    return result
end

local function taskKey(arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `{arg1.category}:{arg1.text}`
end

local function applyTasks(tbl4, tbl5, tbl6)
    for _, value in tbl4 do
        local str1 = taskKey(value)

        if tbl6[str1] == nil then
            table.insert(tbl5, value)
        end
        tbl6[str1] = value
    end
end

local function groupTasks(tbl4)
    local result = {}
    local tbl5 = {}

    for _, value in tbl4 do
        local tbl6 = tbl5[value.category]
        if tbl6 == nil then
            tbl6 = {
                name = value.category,
                tasks = {},
                isComplete = true,
                isLoading = false
            }

            tbl5[value.category] = tbl6
            table.insert(result, tbl6)
        end

        table.insert(tbl6.tasks, value)

        if not isTaskComplete(value) then
            tbl6.isComplete = false
        end
    end

    for _, value in result do
        value.tasks = sortTasksByStatus(value.tasks)
        value.isLoading = false
        for _, task in value.tasks do
            if isTaskLoading(task) then
                value.isLoading = true
                break
            end
        end
    end

    return result
end

local function toTaskState(tbl4, tbl5)
    if #tbl4 == 0 then
        return nil
    end

    local tbl6 = {}
    for _, value in tbl4 do
        table.insert(tbl6, tbl5[taskKey(value)])
    end

    local groups = groupTasks(tbl6)
    local bool1 = #groups > 0
    for _, value in groups do
        if not value.isComplete then
            bool1 = false
            break
        end
    end

    return { groups = groups, allComplete = bool1 }
end

return {
    TOOL_NAME = "manage_tasks",
    extractTasksFromToolCall = extractTasksFromToolCall,
    fromTasks = function(arg1)
        if typeof(arg1) ~= "table" then
            return nil
        end

        local tbl4 = {}
        local tbl5 = {}
        local tbl6 = {}
        for _, value in arg1 do
            local var1 = toTaskItem(value)
            if var1 ~= nil then
                table.insert(tbl6, var1)
            end
        end
        applyTasks(tbl6, tbl4, tbl5)
        return (toTaskState(tbl4, tbl5))
    end,
    fromTurnState = function(arg1)
        local tbl4 = {}
        local tbl5 = {}

        for _, value in orderedManageTasksToolCalls(arg1) do
            local var1 = extractTasksFromToolCall(value)

            if var1 ~= nil then
                applyTasks(var1, tbl4, tbl5)
            end
        end

        return (toTaskState(tbl4, tbl5))
    end,
    isTaskComplete = isTaskComplete,
    isTaskLoading = isTaskLoading
}
