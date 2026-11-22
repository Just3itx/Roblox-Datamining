-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function findBackdrop(arg1)
    for _ = 1, 3 do
        if arg1 == nil or arg1:IsA("LayerCollector") then
            return nil
        end
        local backdrop = arg1:FindFirstChild("Backdrop")
        if backdrop ~= nil and backdrop:IsA("GuiObject") then
            return backdrop
        end
        arg1 = arg1.Parent
    end
    return nil
end

local function getSheetStructure(sheet)
    local scrollingFrame = sheet:FindFirstChildOfClass("ScrollingFrame")
    local sheetContainer = if scrollingFrame == nil then nil else scrollingFrame:FindFirstChild("SheetContainer")

    if scrollingFrame == nil or sheetContainer == nil or not sheetContainer:IsA("GuiObject") then
        return {
            kind = if sheet.Position.X.Scale == 1 then "side" else "center",
            sheet = sheet,
            scroller = nil,
            container = nil,
            backdrop = findBackdrop(sheet.Parent)
        }
    end

    return {
        kind = "bottom",
        sheet = sheet,
        scroller = scrollingFrame,
        container = sheetContainer,
        backdrop = findBackdrop(scrollingFrame)
    }
end

return getSheetStructure
