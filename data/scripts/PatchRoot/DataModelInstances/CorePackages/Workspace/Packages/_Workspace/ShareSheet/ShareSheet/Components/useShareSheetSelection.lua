-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local React = require(ShareSheetParent.React)

local function useShareSheetSelection()
    local selectedConversationIds, var2 = React.useState({})
    return {
        onConversationActivated = React.useCallback(function(str1: string)
            var2(function(tbl1)
                local var3 = table.clone(tbl1)
                if var3[str1] then
                    var3[str1] = nil
                else
                    var3[str1] = true
                end
                return var3
            end)
        end, {}),
        onSendActivated = React.useCallback(function()
            var2({})
        end, {}),
        selectedConversationIds = selectedConversationIds
    }
end

return useShareSheetSelection
