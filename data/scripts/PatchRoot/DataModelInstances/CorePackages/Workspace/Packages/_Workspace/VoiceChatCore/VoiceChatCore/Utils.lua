-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:30:37Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local EventEmitter = {}

EventEmitter.__index = EventEmitter

function EventEmitter.new()
    return (setmetatable({ listeners = {} }, EventEmitter))
end

function EventEmitter:addListener(str1: string, func1: (...any) -> (...any))
    if not self.listeners[str1] then
        self.listeners[str1] = {}
    end
    table.insert(self.listeners[str1], func1)
end

function EventEmitter:removeListener(str1: string, func1: (...any) -> (...any))
    local listener = self.listeners[str1]
    if not listener then
        return
    end

    local var1 = table.find(listener, func1)
    if not var1 then
        return
    end

    table.remove(listener, var1)
    if #listener == 0 then
        self.listeners[str1] = nil
    end
end

function EventEmitter:removeAllListeners()
    table.clear(self.listeners)
end

function EventEmitter:emit(str1: string, ...)
    local listener = self.listeners[str1]
    if not listener then
        return
    end

    for _, value in (table.clone(listener)) do
        pcall(function(...)
            value(...)
            return nil
        end, ...)
    end
end

return {
    jsonDecode = function(input: string)
        local success, result = pcall(function()
            return HttpService:JSONDecode(input)
        end)
        return success and result or {}
    end,
    EventEmitter = EventEmitter,
    shorten = function(arg1): string
        return "..." .. string.sub(tostring(arg1), -4)
    end,
    avoidEmitting = function(arg1)
        local function prune(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
            if arg2:HasTag("RbxDefaultVoiceEmitter") then
                task.defer(function()
                    arg2:Destroy()
                end)
            end
        end
        arg1.DescendantAdded:Connect(prune)
        for _, descendant in arg1:GetDescendants() do
            prune(descendant)
        end
    end,
    destroyDefaultEmitter = function(arg1)
        local localPlayer = Players.LocalPlayer
        if not localPlayer then
            return
        end
        local character = localPlayer.Character
        if not character then
            return
        end

        if arg1:IsDescendantOf(character) then
            task.defer(function()
                arg1:Destroy()
            end)
        end
    end,
    bind = function(arg1, arg2)
        return function(...)
            return arg1[arg2](arg1, ...)
        end
    end
}
