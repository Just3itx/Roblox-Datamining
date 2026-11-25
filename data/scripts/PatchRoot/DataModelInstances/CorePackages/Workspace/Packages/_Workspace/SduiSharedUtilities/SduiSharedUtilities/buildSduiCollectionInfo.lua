-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local CollectionViews = require(SduiSharedUtilitiesParent.CollectionViews)
local Display = require(SduiSharedUtilitiesParent.Display)
local SharedFlags = require(SduiSharedUtilitiesParent.SharedFlags)
local getPreferredTextSizeLineBudget = require(SduiSharedUtilities.getPreferredTextSizeLineBudget)

local FIntLuaAppSduiCarouselPlaceholderHeaderHeightPx = SharedFlags.FIntLuaAppSduiCarouselPlaceholderHeaderHeightPx
local FFlagSduiPreferredTextSizeLineBudgets = SharedFlags.FFlagSduiPreferredTextSizeLineBudgets

local function buildSduiCollectionInfo(str1: string, uDim: UDim, num1: number?)
    local displayStore = Display.GetDisplayStore(false)
    local mainCollectionLayoutStore = CollectionViews.getMainCollectionLayoutStore(false)

    local viewportSize = displayStore.getViewportSize(false)
    local topBarHeight = displayStore.getTopBarHeight(false)
    local platformScale = displayStore.getPlatformScale(false)
    local var1 = platformScale and platformScale > 0 and platformScale or 1

    local designSpaceContainerWidth = mainCollectionLayoutStore.getDesignSpaceContainerWidth(false)
    local itemsPerRow = mainCollectionLayoutStore.getNumItemsForAllCategories(false)

    local var2 = (viewportSize.Y - topBarHeight) / var1

    local var3 = designSpaceContainerWidth / math.max(1, itemsPerRow[str1] or 1) * uDim.Scale + uDim.Offset
    if FFlagSduiPreferredTextSizeLineBudgets then
        local num2 = math.max(num1 or 0, 0)
        if num2 > 0 then
            local var4 = require(SduiSharedUtilitiesParent.TextSize).getTextSizeStore(false).getTextSizeOffset(false) or 0
            var3 += getPreferredTextSizeLineBudget(var4, num2) / var1
        end
    end

    local var4 = FIntLuaAppSduiCarouselPlaceholderHeaderHeightPx + 12 + var3 + 16
    local var5 = if var4 > 0 then math.max(1, math.floor(var2 / var4)) + 1 else 1
    return { items_per_row = itemsPerRow, rows_above_fold = var5 }
end

return buildSduiCollectionInfo
