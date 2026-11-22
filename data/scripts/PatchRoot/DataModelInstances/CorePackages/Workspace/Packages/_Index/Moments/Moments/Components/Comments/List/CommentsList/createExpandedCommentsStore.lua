-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local function createExpandedCommentsStore()
    local getExpandedCommentIds, var2 = Signals.createSignal({})

    return {
        getExpandedCommentIds = getExpandedCommentIds,
        toggle = function(str1: string)
            var2(function(tbl1)
                local var3 = table.clone(tbl1)
                if var3[str1] then
                    var3[str1] = nil
                else
                    var3[str1] = true
                end
                return var3
            end)
        end
    }
end

return createExpandedCommentsStore
