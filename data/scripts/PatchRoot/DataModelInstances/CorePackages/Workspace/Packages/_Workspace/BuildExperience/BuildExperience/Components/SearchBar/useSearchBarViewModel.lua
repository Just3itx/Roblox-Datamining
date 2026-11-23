-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local _Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _SearchBarView = require(script.Parent.SearchBarView)

local function useSearchBarViewModel(tbl1)
    local clear = tbl1.clear
    local onDismiss = tbl1.onDismiss
    local setQuery = tbl1.setQuery
    local onFocusGained = tbl1.onFocusGained
    local onFocusLost = tbl1.onFocusLost
    local shouldFocus = tbl1.shouldFocus
    local textInputRef = React.useRef(nil)

    local var2 = React.useRef(false)

    React.useEffect(function()
        if shouldFocus and textInputRef.current then
            textInputRef.current.focus()
        end
    end, { shouldFocus })

    local var1 = React.useCallback(function()
        var2.current = true
        if onFocusGained then
            onFocusGained()
        end
    end, { onFocusGained })

    local var3 = React.useCallback(function(arg1)
        var2.current = false
        if onFocusLost then
            onFocusLost(arg1)
        end
    end, { onFocusLost })

    local onChanged = React.useCallback(function(str1: string)
        if str1 == "" then
            clear()
            if not var2.current and onDismiss then
                onDismiss()
            end
        else
            setQuery(str1)
        end
    end, { clear, onDismiss, setQuery })

    return {
        LayoutOrder = tbl1.LayoutOrder,
        onChanged = onChanged,
        onFocusGained = var1,
        onFocusLost = var3,
        placeholder = tbl1.placeholder,
        query = tbl1.query,
        textInputRef = textInputRef
    }
end

return useSearchBarViewModel
