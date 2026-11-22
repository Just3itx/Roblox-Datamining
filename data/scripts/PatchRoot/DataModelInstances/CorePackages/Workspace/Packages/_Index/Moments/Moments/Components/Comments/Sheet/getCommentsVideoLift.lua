-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommentsSheetSnapPoints = require(script.Parent.CommentsSheetSnapPoints)

local function getCommentsVideoLift(tbl1, tbl2)
    if tbl1.sheetInset <= 0 then
        return nil
    end

    if tbl1.isKeyboardVisible and tbl2 ~= nil then
        return tbl2
    end

    local var1 = CommentsSheetSnapPoints[1] * tbl1.overlayHeight
    if var1 <= 0 then
        return nil
    end
    return {
        progress = math.min(tbl1.sheetInset / var1, 1),
        bandTop = tbl1.overlayTop,
        bandBottom = tbl1.overlayTop + tbl1.overlayHeight - var1
    }
end

return getCommentsVideoLift
