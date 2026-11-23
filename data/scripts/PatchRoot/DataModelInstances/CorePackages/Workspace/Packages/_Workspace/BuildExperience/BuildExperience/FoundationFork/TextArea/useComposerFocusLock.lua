-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = game:GetService("CorePackages").Packages._Index.Foundation.Foundation.Parent

local React = require(FoundationParent.React)

local function useComposerFocusLock(bool1: boolean, tbl1)
    React.useEffect(function()
        for _, value in tbl1 do
            local current = value.current
            if current == nil then
                continue
            end

            if bool1 then
                current.TextEditable = false
                current.Active = false
                current:ReleaseFocus()
            else
                current.TextEditable = true
                current.Active = true
            end
        end
    end, { bool1 })
end

return useComposerFocusLock
