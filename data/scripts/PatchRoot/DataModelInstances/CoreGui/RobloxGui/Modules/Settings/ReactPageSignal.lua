-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Signals = require(CorePackages.Packages.Signals)

local _EnumReactPage = require(script.Parent.EnumReactPage)

return Signals.createComputed(function() -- name: ReactPageSignal
    local currentReactPage, setCurrentReactPage = Signals.createSignal(nil)
    return { currentReactPage = currentReactPage, setCurrentReactPage = setCurrentReactPage }
end)
