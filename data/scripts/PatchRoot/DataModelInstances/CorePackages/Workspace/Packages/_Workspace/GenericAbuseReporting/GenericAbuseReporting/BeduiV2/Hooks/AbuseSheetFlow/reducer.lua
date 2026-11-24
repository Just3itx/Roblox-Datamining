-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local HttpService = game:GetService("HttpService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local Dash = require(GenericAbuseReportingParent.Dash)

local _AbuseSheetFlowTypes = require(script.Parent.AbuseSheetFlowTypes)

local function getInitialState(runId: string, num1: number, nodeId: string)
    return {
        runId = runId,
        userId = if LocalPlayer then LocalPlayer.UserId else 0,
        stack = {{
            nodeId = nodeId,
            store = {},
            enterTime = num1
        }},
        navigationState = "idle",
        submissionState = "idle",
        openTime = num1
    }
end

return {
    getInitialState = getInitialState,
    getNewRunId = function(): string
        return HttpService:GenerateGUID(false)
    end,
    selectStore = function(tbl1)
        local result = ({})
        for _, value in tbl1.stack do
            if not value.store then
                continue
            end

            for value2, value3 in value.store do
                result[value2] = value3
            end
        end

        return result
    end,
    reducer = function(tbl1, tbl2)
        local var1 = nil
        if tbl2.type == "gotoNode" then
            if not (tbl2.payload and tbl2.payload.nodeId) then
                error(`gotoNode action requires payload.nodeId, got: {Dash.pretty(tbl2, { depth = 5 })}`)
            end

            local tbl3 = {
                nodeId = tbl2.payload.nodeId,
                store = {},
                enterTime = tbl2.payload.enterTime
            }

            local stack = table.clone(tbl1.stack)
            table.insert(stack, tbl3)

            return (Dash.join(tbl1, { navigationState = "idle", lastNavigationDirection = "forward", stack = stack }))
        elseif tbl2.type == "replaceAndGotoNode" then
            local var2 = Dash.last(tbl1.stack)
            if not var2 then
                error("Stack is empty, cannot replace and go to node")
            end
            local stack = Dash.slice(tbl1.stack, 1, #tbl1.stack - 1)
            table.insert(stack, { nodeId = tbl2.payload.nodeId, store = var2.store, enterTime = tbl2.payload.enterTime })

            return (Dash.join(tbl1, { navigationState = "idle", lastNavigationDirection = "forward", stack = stack }))
        elseif tbl2.type == "goBack" then
            if not (#tbl1.stack <= 1) then
                return (Dash.join(tbl1, { lastNavigationDirection = "back", stack = Dash.slice(tbl1.stack, 1, #tbl1.stack - 1) }))
            end

            warn("Cannot go back from stack with only one or zero items")
            return tbl1
        elseif tbl2.type == "updateDataAndNavigateNext" then
            local var2 = Dash.last(tbl1.stack)
            if not var2 then
                error("Stack is empty, cannot update data")
            end

            if tbl2.payload.expectedFromNodeId ~= var2.nodeId then
                return tbl1
            end
            if tbl1.navigationState ~= "idle" then
                return tbl1
            end
            local var3 = Dash.join(var2, { store = Dash.join(var2.store, tbl2.payload.store) })

            local stack = Dash.slice(tbl1.stack, 1, #tbl1.stack - 1)
            table.insert(stack, var3)
            return (Dash.join(tbl1, { stack = stack, navigationState = "gotoNext" }))
        elseif tbl2.type == "navigateFailure" then
            local var2 = Dash.last(tbl1.stack)
            if not var2 then
                error("Stack is empty, cannot navigate after failure")
            end
            if tbl2.payload.expectedFromNodeId ~= var2.nodeId or tbl1.navigationState ~= "idle" then
                return tbl1
            end

            return (Dash.join(tbl1, { navigationState = "gotoFailure" }))
        else
            if tbl2.type == "startedSubmission" then
                return (Dash.join(tbl1, { submissionState = "submitting" }))
            elseif tbl2.type == "completedSubmission" then
                return (Dash.join(tbl1, { submissionState = "completed" }))
            elseif tbl2.type == "submissionFailed" then
                return (Dash.join(tbl1, { submissionState = "failed" }))
            elseif tbl2.type == "reset" then
                return (getInitialState(tbl2.payload.runId, tbl2.payload.initialEnterTime, tbl2.payload.startNodeId))
            end
            error("Unknown action type: " .. tostring(tbl2.type))

            return var1
        end
    end
}
