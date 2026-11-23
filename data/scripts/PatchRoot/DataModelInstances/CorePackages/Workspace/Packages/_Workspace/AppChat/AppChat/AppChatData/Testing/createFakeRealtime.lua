-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RobloxEventReceiver = require(AppChatParent.RealtimeDelivery).RobloxEventReceiver

local createRealtimePort = require(AppChat.AppChatData.Ports.createRealtimePort)

local function createEngineSignal()
    local tbl1 = {}
    return {
        Connect = function(_, func1: (...any) -> (...any))
            table.insert(tbl1, func1)
            return {
                Disconnect = function()
                    local var1 = table.find(tbl1, func1)
                    if var1 ~= nil then
                        table.remove(tbl1, var1)
                    end
                end
            }
        end,
        Fire = function(_, ...)
            for _, value in table.clone(tbl1) do
                value(...)
            end
        end
    }
end

local function createFakeRealtime()
    local tbl1 = {
        RobloxEventReceived = createEngineSignal(),
        RobloxConnectionChanged = createEngineSignal()
    }

    return {
        port = createRealtimePort(function()
            return RobloxEventReceiver.new(tbl1)
        end),
        push = function(namespace: string, input)
            tbl1.RobloxEventReceived:Fire({ namespace = namespace, detail = HttpService:JSONEncode(input) })
        end
    }
end
return createFakeRealtime
