-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local React = require(MusicPickerParent.React)

local _MusicPickerTypes = require(MusicPicker.Types.MusicPickerTypes)

local function useMusicPickerViewModel(tbl1)
    local tabs = tbl1.tabs
    local onQueryChanged = tbl1.onQueryChanged
    local onTabChanged = tbl1.onTabChanged

    local initialQuery = tbl1.initialQuery or ""

    local searchText, var2 = React.useState(initialQuery)

    local submittedQuery, var4 = React.useState(initialQuery)
    local id = if #tabs > 0 then tabs[1].id else nil
    local activeTabId, var6 = React.useState(id)

    React.useEffect(function()
        local bool1 = false
        for _, tab in tabs do
            if tab.id == activeTabId then
                bool1 = true
                break
            end
        end

        if not bool1 then
            var6(if #tabs > 0 then tabs[1].id else nil)
        end
    end, { tabs, activeTabId })

    local onSearchChanged = React.useCallback(function(str1: string)
        var2(str1)

        if str1 ~= "" then
            return
        end

        var4("")
        if onQueryChanged ~= nil then
            onQueryChanged("")
        end
    end, { onQueryChanged })

    local onSubmitSearch = React.useCallback(function()
        if searchText == submittedQuery then
            return
        end
        var4(searchText)
        if onQueryChanged ~= nil then
            onQueryChanged(searchText)
        end
    end, { onQueryChanged, searchText, submittedQuery })

    React.useEffect(function()
        if searchText == "" or searchText == submittedQuery then
            return nil
        end
        local bool1 = false
        task.delay(0.3, function()
            if bool1 then
                return
            end
            var4(searchText)
            if onQueryChanged ~= nil then
                onQueryChanged(searchText)
            end
        end)
        return function()
            bool1 = true
        end
    end, { searchText, submittedQuery, onQueryChanged })

    return {
        searchText = searchText,
        submittedQuery = submittedQuery,
        mode = if submittedQuery == "" then "tabs" else "search",
        activeTabId = activeTabId,
        onSearchChanged = onSearchChanged,
        onSubmitSearch = onSubmitSearch,
        onTabSelected = React.useCallback(function(str1: string)
            var6(str1)
            if onTabChanged ~= nil then
                onTabChanged(str1)
            end
        end, { onTabChanged })
    }
end

return useMusicPickerViewModel
