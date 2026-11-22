-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local Image = Foundation.Image

local useCallback = React.useCallback

local function StickerPickerItem(tbl1)
    local stickerUri = tbl1.stickerURI
    local onStickerSelected = tbl1.onStickerSelected

    local var1 = useCallback(function()
        if onStickerSelected then
            onStickerSelected(stickerUri)
        end
    end, { onStickerSelected, stickerUri })

    local createElement = React.createElement
    local var2 = Image
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = 0,
        Image = 0,
        ScaleType = 0,
        BackgroundTransparency = 1,
        tag = "size-1000-1000 radius-medium"
    }

    if not onStickerSelected then
        var1 = nil
    end

    tbl2.onActivated = var1
    tbl2.Image = stickerUri
    tbl2.ScaleType = Enum.ScaleType.Fit
    return createElement(var2, tbl2)
end

return StickerPickerItem
