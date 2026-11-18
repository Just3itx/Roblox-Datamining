-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T22:56:47Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {
    ["jest.config"] = script["jest.config"],
    game = game
}

function module.waitProxy(arg1)
    wait(arg1)
end

function module.settingsProxy()
    return settings()
end

setmetatable(module, {
    __index = function(_, className: string): Instance
        return game:GetService(className)
    end
})

return module
