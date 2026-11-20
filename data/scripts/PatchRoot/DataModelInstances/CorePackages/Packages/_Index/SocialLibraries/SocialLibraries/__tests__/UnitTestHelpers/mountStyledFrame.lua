-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Roact = require(script.Parent.Parent.Parent.dependencies).Roact

local mockProviders = require(script.Parent.mockProviders)

return function(arg1, arg2)
    if arg2 == nil then
        arg2 = Instance.new("Frame")
    end
    local var1 = mockProviders(arg1)

    local var2 = Roact.mount(var1, arg2)
    return arg2, function()
        Roact.unmount(var2)
        arg2:Destroy()
    end
end
