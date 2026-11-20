-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local console = require(scriptParentParent.LuauPolyfill).console
local consoleWithStackDev = require(scriptParent.consoleWithStackDev)

if not ReactGlobals.__DEV__ then
    return console
end

return (setmetatable({ warn = consoleWithStackDev.warn, error = consoleWithStackDev.error }, { __index = console }))
