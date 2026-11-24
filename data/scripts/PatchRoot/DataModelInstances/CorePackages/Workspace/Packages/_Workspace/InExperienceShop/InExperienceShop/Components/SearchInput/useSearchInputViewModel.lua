-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local React = require(InExperienceShopParent.React)

local _SearchInputView = require(script.Parent.SearchInputView)

local function useSearchInputViewModel(tbl1)
    local textBoxRef = React.useRef(nil)
    local var2 = React.useRef(false)

    React.useEffect(function()
        if textBoxRef.current then
            textBoxRef.current:CaptureFocus()
        end
    end, {})

    local var3 = React.useRef(tbl1.onTextChanged)
    var3.current = tbl1.onTextChanged

    local onTextChanged = React.useCallback(function(arg1)
        if not var2.current then
            var3.current(arg1.Text)
        end
    end, {})

    local onFocusLost = React.useCallback(function(arg1, bool1: boolean)
        if bool1 then
            tbl1.onSearchSubmit(arg1.Text or "")
        end
    end, { tbl1.onSearchSubmit })

    return {
        onBack = React.useCallback(function()
            var2.current = true
            if textBoxRef.current then
                textBoxRef.current:ReleaseFocus()
            end

            task.defer(tbl1.onBack)
        end, { tbl1.onBack }),
        onClear = React.useCallback(function()
            tbl1.onTextChanged("")
            if textBoxRef.current then
                textBoxRef.current:CaptureFocus()
            end
        end, { tbl1.onTextChanged }),
        onTextChanged = onTextChanged,
        onFocusLost = onFocusLost,
        text = tbl1.text,
        textBoxRef = textBoxRef
    }
end

return useSearchInputViewModel
