-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent
local ErrorKind = require(GenericChallenges.Types.ErrorKind)
local LuauPolyfill = require(GenericChallengesParent.LuauPolyfill)

local module = ({})
module.__index = module

function module.new(kind, tbl1)
    return (setmetatable({ kind = kind, data = tbl1 }, module))
end

function module.match(arg1)
    return LuauPolyfill.instanceof(arg1, module)
end

function module:matchAbandoned()
    return module.match(self) and self.kind == ErrorKind.Abandoned
end

return module
