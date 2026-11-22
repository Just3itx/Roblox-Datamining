-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RealtimeDeliveryParent = script:FindFirstAncestor("RealtimeDelivery").Parent

local Signal = require(RealtimeDeliveryParent.AppCommonLib).Signal

local HttpService = game:GetService("HttpService")

local module = {}
module.__index = module

function module:observeEvent(str1: string, arg1)
    assert(type(str1) == "string", "Expected namespace to be a string")
    assert(type(arg1) == "function", "Expected callback to be a function")

    local var1 = self.namespaceTable[str1]
    if var1 == nil then
        var1 = Signal.new()
        self.namespaceTable[str1] = var1
    end

    return var1:connect(arg1)
end

function module.new(arg1)
    local tbl1 = {
        namespaceTable = {}
    }
    setmetatable(tbl1, module)

    tbl1.connections = {
        arg1.RobloxEventReceived:Connect(function(arg2)
            local var1 = tbl1.namespaceTable[arg2.namespace]
            if var1 == nil then
                return
            end

            local var2

            if arg2.detail and arg2.detail ~= "" then
                local success, result = pcall(function()
                    return HttpService:JSONDecode(arg2.detail)
                end)

                var2 = success and result or arg2.detail
            else
                var2 = {}
            end

            var1:fire(var2, arg2.detailType)
        end),
        arg1.RobloxConnectionChanged:Connect(function(connectionName: string, connectionState: Enum.ConnectionState, sequenceNumber: string, namespaceSequenceNumbers: string)
            local var1 = tbl1.namespaceTable[connectionName]
            if var1 == nil then
                return
            end

            local var2

            if namespaceSequenceNumbers then
                local success, result = pcall(function()
                    return HttpService:JSONDecode(namespaceSequenceNumbers)
                end)

                var2 = not success and {} or result
            else
                var2 = nil
            end

            var1:fire(connectionState, sequenceNumber, var2)
        end)
    }

    return tbl1
end

return module
