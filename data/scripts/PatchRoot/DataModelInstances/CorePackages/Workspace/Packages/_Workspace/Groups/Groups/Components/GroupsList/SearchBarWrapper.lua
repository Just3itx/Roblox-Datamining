-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)

local TextInput = Foundation.TextInput
local IconName = Foundation.Enums.IconName

local function SearchBar(tbl1)
    local text, var2 = React.useState("")
    local var3 = React.useRef(nil)

    local var4 = React.useCallback(function()
        if var3.current then
            task.cancel(var3.current)
            var3.current = nil
        end
    end, {})

    local onChanged = React.useCallback(function(str1: string)
        var2(str1)
        var4()

        var3.current = task.delay(0.4, function()
            if tbl1.onTextChanged then
                tbl1.onTextChanged(str1)
            end
        end)
    end, { tbl1.onTextChanged, var4 })

    React.useEffect(function()
        return var4
    end, {})

    local onActivated = React.useCallback(function()
        var4()
        var2("")
        if tbl1.onTextChanged then
            tbl1.onTextChanged("")
        end
    end, { tbl1.onTextChanged, var4 })

    return React.createElement(TextInput, {
        label = "",
        text = text,
        width = UDim.new(1, 0),
        placeholder = tbl1.placeholderText or "",
        leadingIcon = "icons/common/search",
        onChanged = onChanged,
        iconTrailing = text ~= "" and {
            name = IconName.CircleX,
            onActivated = onActivated
        } or nil
    })
end

return SearchBar
