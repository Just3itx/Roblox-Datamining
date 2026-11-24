-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = ({})
module.__index = module

function module.new()
    local self = setmetatable({}, module)
    self.connections = {}
    return self
end

function module:connect(arg1, rbxScriptSignal, arg2)
    if self.connections[arg1] then
        self.connections[arg1]()
    end
    local connection = rbxScriptSignal:Connect(arg2)

    self.connections[arg1] = function()
        connection:Disconnect()
    end
end

function module:connectManual(arg1, arg2)
    if self.connections[arg1] then
        self.connections[arg1]()
    end
    self.connections[arg1] = arg2
end

function module:disconnect(arg1)
    if self.connections[arg1] then
        self.connections[arg1]()
        self.connections[arg1] = nil
    end
end

function module:disconnectAll()
    for _, connection in pairs(self.connections) do
        connection()
    end
    self.connections = {}
end

return module
