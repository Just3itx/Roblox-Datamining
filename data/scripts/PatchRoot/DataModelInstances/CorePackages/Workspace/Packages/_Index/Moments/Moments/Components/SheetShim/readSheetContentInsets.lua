-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _SheetShimTypes = require(script.Parent.SheetShimTypes)
local _getSheetStructure = require(script.Parent.getSheetStructure)

local function readSheetContentInsets(arg1)
    local sheet = arg1.sheet
    local scroller = arg1.scroller
    local container = arg1.container
    if scroller ~= nil and container ~= nil then
        local var1 = scroller.CanvasSize.Y.Offset + container.Position.Y.Offset
        local sheetParent = sheet.Parent
        local absoluteSizeY = if sheetParent ~= nil and sheetParent:IsA("GuiBase2d") then sheetParent.AbsoluteSize.Y else sheet.AbsoluteSize.Y
        return {
            bottom = math.clamp(scroller.CanvasPosition.Y - var1, 0, absoluteSizeY),
            right = 0
        }
    end
    if arg1.kind ~= "side" then
        return { bottom = 0, right = 0 }
    end

    return {
        bottom = 0,
        right = math.clamp(-sheet.Position.X.Offset, 0, sheet.Size.X.Offset)
    }
end

return readSheetContentInsets
