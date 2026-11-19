-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator
local maybeAssert = require(script.Parent.Parent.Helpers.maybeAssert)
local Types = require(script.Parent.Parent.Types)

return makeActionCreator(script.Name, function(message)
    maybeAssert(Types.IMessage(message))

    return { message = message }
end)
