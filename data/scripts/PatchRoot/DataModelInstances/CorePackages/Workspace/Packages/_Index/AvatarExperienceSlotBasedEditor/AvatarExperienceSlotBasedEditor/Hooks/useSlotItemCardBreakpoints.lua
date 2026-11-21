-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)
local Responsive = require(AvatarExperienceSlotBasedEditorParent.Responsive)
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local FFlagAXMigrateBuilderIcons = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXMigrateBuilderIcons

local function getItemWidth(num1: number, visibleItemCount: number, itemGap: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.floor((num1 - (visibleItemCount - 1) * itemGap) / visibleItemCount)
end

local function getItemCardWidthParameters(itemGap: number, medium: string, portrait: string): {itemGap: number, visibleItemCount: number}? -- Luacid: unused: defined but never referenced
    return if medium == Responsive.BreakpointConfig.Enum.Medium or portrait == Responsive.BreakpointConfig.Enum.Portrait then {
        visibleItemCount = 6,
        itemGap = itemGap
    } else nil
end

return function(vector2: Vector2?)
    local var1 = useTokens()
    local var2 = Responsive.useResponsive()
    local var3 = Responsive.useOrientation()
    local small = var1.Gap.Small
    local size1600 = var1.Size.Size_1600
    local size2100 = var1.Size.Size_2100

    local medium = var1.Padding.Medium
    local size1000 = var1.Size.Size_1000
    local bool1 = var3 == Responsive.BreakpointConfig.Enum.Portrait

    local var4 = (if bool1 then var1.Typography.CaptionSmall else var1.Typography.CaptionMedium).FontSize + var1.Gap.Small
    local var5 = if var3 == Responsive.BreakpointConfig.Enum.Portrait then size1600 else size2100
    local var6 = var5 + var4 + medium * 2
    local var7 = var6 + size1000

    local clearAllButtonStyles = {
        text = {
            Size = UDim2.fromScale(1, 0),
            fontStyle = var1.Typography.CaptionMedium
        }
    }

    local slotItemCardThumbnailStyles = { iconFrameStyles = 0 }
    local tbl3

    if bool1 then
        tbl3 = {
            Size = UDim2.fromOffset(var1.Size.Size_500, var1.Size.Size_500),
            iconSize = IconSize.XSmall
        }
    else
        tbl3 = { Size = 0, iconSize = 0 }
        local fromOffset = UDim2.fromOffset
        local var8 = if FFlagAXMigrateBuilderIcons then var1.Size.Size_600 else var1.Size.Size_800
        local var9 = if FFlagAXMigrateBuilderIcons then var1.Size.Size_600 else var1.Size.Size_800
        tbl3.Size = fromOffset(var8, var9)

        tbl3.iconSize = IconSize.Small
    end

    slotItemCardThumbnailStyles.iconFrameStyles = tbl3

    local tbl4 = {
        buttonPadding = var1.Padding.Medium,
        contentPadding = UDim.new(0, var1.Padding.Medium)
    }

    if vector2 ~= nil then
        local vector2X = vector2.X
        local var8 = var2 == Responsive.BreakpointConfig.Enum.Medium and {
            visibleItemCount = 6,
            itemGap = small
        }
            or var3 == Responsive.BreakpointConfig.Enum.Portrait and {
                visibleItemCount = 6,
                itemGap = small
            }
            or nil

        if var8 then
            var5 = math.min(math.max(getItemWidth(vector2X, var8.visibleItemCount, var8.itemGap), size1600), size2100)

            if size1600 <= var5 and var5 < size2100 then
                local tbl5

                if bool1 then
                    tbl5 = {
                        Size = UDim2.fromOffset(var1.Size.Size_500, var1.Size.Size_500),
                        iconSize = IconSize.XSmall
                    }
                else
                    tbl5 = { Size = 0, iconSize = 0 }
                    local fromOffset = UDim2.fromOffset
                    local var9 = if FFlagAXMigrateBuilderIcons then var1.Size.Size_600 else var1.Size.Size_800
                    local var10 = if FFlagAXMigrateBuilderIcons then var1.Size.Size_600 else var1.Size.Size_800
                    tbl5.Size = fromOffset(var9, var10)

                    tbl5.iconSize = IconSize.Small
                end

                slotItemCardThumbnailStyles.iconFrameStyles = tbl5

                tbl4 = {
                    buttonPadding = var1.Padding.Small,
                    contentPadding = UDim.new(0, var1.Padding.Small)
                }
                clearAllButtonStyles.text.Size = UDim2.fromScale(0.8, 0)
                clearAllButtonStyles.text.fontStyle = var1.Typography.CaptionSmall
            end

            var6 = var5 + var4 + medium * 2
            var7 = var6 + size1000
        end
    end

    return {
        navHeight = size1000,
        itemCardSize = UDim2.fromOffset(var5, var5),
        clearAllButtonStyles = clearAllButtonStyles,
        navigationFrameHeight = var7,
        slotItemCardThumbnailStyles = slotItemCardThumbnailStyles,
        scrollingFramePadding = tbl4,
        enableSnapToSelectedSlot = var3 == Responsive.BreakpointConfig.Enum.Landscape,
        slotCardTotalHeight = var6
    }
end
