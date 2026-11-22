-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

return {
    once = function(func1: (...any) -> (...any)): RBXScriptConnection
        return RunService.PreRender:Once(func1)
    end
}
