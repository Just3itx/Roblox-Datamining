-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local Lumberyak = require(scriptParentParent.Lumberyak)

if game:DefineFastFlag("RoactPolicyLoggerName", false) then
    return (Lumberyak.Logger.new(nil, "LuaRoactPolicyProvider"))
end

return (Lumberyak.Logger.new())
