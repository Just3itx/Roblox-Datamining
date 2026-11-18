-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:05:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function isRunningInStudio(): boolean
    return game:GetService("RunService"):IsStudio() and not _G.__TESTEZ_RUNNING_TEST__
end

return isRunningInStudio
