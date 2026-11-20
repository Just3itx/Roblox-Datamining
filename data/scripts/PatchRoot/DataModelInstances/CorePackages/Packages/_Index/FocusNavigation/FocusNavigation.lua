-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local _EventPropagation = require(script.Parent.EventPropagation)

local FocusNavigationService = require(script.FocusNavigationService)
local isValidFocusTarget = require(script.isValidFocusTarget)

local EngineInterface = require(script.EngineInterface)
local _types = require(script.types)

return {
    isValidFocusTarget = isValidFocusTarget,
    FocusNavigationService = FocusNavigationService,
    EngineInterface = {
        CoreGui = EngineInterface.CoreGui,
        PlayerGui = EngineInterface.PlayerGui
    }
}
