-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local PolicyProvider = require(scriptParentParent.PolicyProvider)
local Logger = require(scriptParentParent.Loggers).Logger

local UniversalAppPolicy = require(script.Parent.UniversalAppPolicy)

PolicyProvider.Logger:setParent(Logger)

return UniversalAppPolicy
