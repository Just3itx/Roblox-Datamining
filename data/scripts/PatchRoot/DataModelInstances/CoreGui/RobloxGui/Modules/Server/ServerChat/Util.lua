-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local StandardPriority = require(ClientChatModules:WaitForChild("ChatConstants")).StandardPriority
StandardPriority = if StandardPriority == nil then 10 else StandardPriority

local module = {}
module.__index = module

local tbl1 = {}

local tbl2 = {}
tbl2.__index = tbl2

function tbl2:RebuildProcessCommandsPriorities()
    self.RegisteredPriorites = {}
    for k, value in pairs(self.FunctionMap) do
        local bool1 = false

        for k2, value2 in pairs(value) do
            local _, _ = k2, value2
            bool1 = true
            break
        end

        if bool1 then
            table.insert(self.RegisteredPriorites, k)
        end
    end
    table.sort(self.RegisteredPriorites, function(arg1, arg2): boolean
        return arg2 < arg1
    end)
end

function tbl2:HasFunction(arg1): boolean
    return self.RegisteredFunctions[arg1] ~= nil
end

function tbl2:RemoveFunction(arg1)
    local registeredFunction = self.RegisteredFunctions[arg1]
    self.RegisteredFunctions[arg1] = nil
    self.FunctionMap[registeredFunction][arg1] = nil
    self:RebuildProcessCommandsPriorities()
end

function tbl2:AddFunction(arg1, arg2, arg3)
    if arg3 == nil then
        arg3 = StandardPriority
    end

    if self.RegisteredFunctions[arg1] then
        error(arg1 .. " is already in use!")
    end

    self.RegisteredFunctions[arg1] = arg3

    if self.FunctionMap[arg3] == nil then
        self.FunctionMap[arg3] = {}
    end

    self.FunctionMap[arg3][arg1] = arg2
    self:RebuildProcessCommandsPriorities()
end

function tbl2.GetIterator(arg1)
    local num1 = 1
    local var1 = nil
    local var2 = nil

    return function()
        while not (num1 > #arg1.RegisteredPriorites) do
            local var3 = arg1.RegisteredPriorites[num1]
            var1, var2 = next(arg1.FunctionMap[var3], var1)
            if var1 ~= nil then
                return var1, var2, var3
            end

            num1 += 1
        end
    end
end

function tbl1.new()
    local self = setmetatable({}, tbl2)

    self.RegisteredFunctions = {}
    self.RegisteredPriorites = {}
    self.FunctionMap = {}

    return self
end

function module.NewSortedFunctionContainer(_)
    return tbl1.new()
end

return module
