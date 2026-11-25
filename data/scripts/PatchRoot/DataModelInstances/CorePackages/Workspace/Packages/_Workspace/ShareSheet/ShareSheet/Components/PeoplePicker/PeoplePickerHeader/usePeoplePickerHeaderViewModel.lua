-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local useLocalization = require(ShareSheetParent.Localization).Hooks.useLocalization

local _PeoplePickerHeaderView = require(script.Parent.PeoplePickerHeaderView)

local function usePeoplePickerHeaderViewModel(tbl1)
    local var1 = useLocalization({ searchPlaceholder = "CommonUI.Controls.Action.Search" })

    return {
        goBack = tbl1.goBack,
        onQueryChanged = tbl1.setQuery,
        query = tbl1.query,
        searchPlaceholder = var1.searchPlaceholder
    }
end

return usePeoplePickerHeaderViewModel
