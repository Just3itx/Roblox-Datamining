-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local React = require(ShareSheetParent.React)

local num1 = game:DefineFastInt("ShareSheetPeoplePickerSearchDebounceMs", 250)

local function usePeoplePickerSearch()
    local query, setQuery = React.useState("")
    local debouncedQuery, var4 = React.useState("")

    React.useEffect(function()
        if query == debouncedQuery then
            return
        end

        local bool1 = false
        local var5 = task.delay(num1 / 1000, function()
            if not bool1 then
                var4(query)
            end
        end)
        return function()
            bool1 = true
            pcall(task.cancel, var5)
        end
    end, { debouncedQuery, query })

    return {
        debouncedQuery = debouncedQuery,
        query = query,
        reset = React.useCallback(function()
            setQuery("")
            var4("")
        end, {}),
        setQuery = setQuery
    }
end

return usePeoplePickerSearch
