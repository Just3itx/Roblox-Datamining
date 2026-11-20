-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Roact = require(script.Parent.Parent.Parent.dependencies).Roact

local mockProviders = require(script.Parent.mockProviders)

return function(arg1, arg2)
    arg2 = arg2 or {}
    local parent = arg2.parent

    if parent == nil then
        parent = Instance.new("Frame")
        local str1 = HttpService:GenerateGUID(false)
        parent.Name = str1
    end

    local var1 = mockProviders(arg1, arg2)
    local var2 = Roact.mount(var1, parent)
    return parent, function()
        Roact.unmount(var2)
        parent:Destroy()
    end
end
