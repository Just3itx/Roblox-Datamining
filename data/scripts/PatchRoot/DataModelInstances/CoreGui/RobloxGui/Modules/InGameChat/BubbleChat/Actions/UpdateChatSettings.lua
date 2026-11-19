-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator
local t = require(CorePackages.Packages.t)
local maybeAssert = require(script.Parent.Parent.Helpers.maybeAssert)

return makeActionCreator(script.Name, function(settings)
    maybeAssert(t.table(settings))

    return { settings = settings }
end)
