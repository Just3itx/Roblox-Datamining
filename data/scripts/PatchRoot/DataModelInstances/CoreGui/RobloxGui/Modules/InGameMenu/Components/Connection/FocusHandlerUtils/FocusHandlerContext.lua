-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
return require(CorePackages.Packages.InGameMenuDependencies).Roact.createContext({
    currentHandlerId = nil,
    candidateHandlerId = nil,
    previousSelections = {},
    requestFocusForHandlerId = function() end,
    forgetLastSelectionForHandlerId = function() end,
    blurCurrentFocusHandler = function() end
})
