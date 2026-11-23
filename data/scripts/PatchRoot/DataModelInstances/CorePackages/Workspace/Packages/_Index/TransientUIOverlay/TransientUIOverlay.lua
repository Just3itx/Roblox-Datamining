-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetTransientUIOverlayStore = require(script.Stores.GetTransientUIOverlayStore)
local _Types = require(script.Types)

local module = {
    ["jest.config"] = script["jest.config"],
    GetTransientUIOverlayStore = GetTransientUIOverlayStore,
    OverlayScreen = require(script.OverlayScreen)
}

function module.displayDialog(arg1)
    GetTransientUIOverlayStore(false).displayDialog(arg1)
end

function module.displaySnackbar(arg1, num1: number)
    GetTransientUIOverlayStore(false).displaySnackbar(arg1, num1)
end

function module.clearDialog()
    GetTransientUIOverlayStore(false).clearDialog()
end

function module.clearSnackbar()
    GetTransientUIOverlayStore(false).clearSnackbar()
end

return module
