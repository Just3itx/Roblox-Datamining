-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _createUniversalShareSheetStore = require(script.Parent.Stores.createUniversalShareSheetStore)
local GetUniversalShareSheetStore = require(script.Parent.Stores.GetUniversalShareSheetStore)
return {
    RecipientSource = require(script.Parent.Recipients.RecipientSource).RecipientSource,
    show = function(arg1)
        GetUniversalShareSheetStore().show(arg1)
    end,
    hide = function()
        GetUniversalShareSheetStore().hide()
    end
}
