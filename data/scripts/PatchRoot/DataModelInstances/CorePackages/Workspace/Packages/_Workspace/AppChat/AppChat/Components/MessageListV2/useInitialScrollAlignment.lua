-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local ViewRecycler = require(AppChatParent.ViewRecycler)

local function useInitialScrollAlignment(bool1: boolean, bool2: boolean, tbl1, bool3: boolean): boolean
    local var1 = React.useRef(nil)
    local var2 = React.useRef(false)
    if var1.current == nil and not bool2 then
        var1.current = if bool1 then ViewRecycler.ScrollAlignment.Start else ViewRecycler.ScrollAlignment.End
    end

    local current = var1.current

    React.useEffect(function()
        if bool2 then
            var2.current = false
            return
        end

        if var2.current or current ~= ViewRecycler.ScrollAlignment.Start then
            return
        end

        local current2 = tbl1.current
        if current2 == nil then
            return
        end
        var2.current = true
        current2.scrollToStart()
    end, { bool2, current, bool3 })

    return current
end

return useInitialScrollAlignment
