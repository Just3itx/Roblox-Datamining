-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local React = require(AccountUpgradeParent.React)

local BirthdaySheetView = require(script.Parent.BirthdaySheetView)
local useBirthdaySheetViewModel = require(script.Parent.useBirthdaySheetViewModel)

local function OpenSheet(arg1)
    local var1 = useBirthdaySheetViewModel(arg1)
    return React.createElement(BirthdaySheetView, var1)
end

local function BirthdaySheet(arg1)
    if not arg1.isOpen then
        return nil
    end

    return React.createElement(OpenSheet, arg1)
end

return BirthdaySheet
