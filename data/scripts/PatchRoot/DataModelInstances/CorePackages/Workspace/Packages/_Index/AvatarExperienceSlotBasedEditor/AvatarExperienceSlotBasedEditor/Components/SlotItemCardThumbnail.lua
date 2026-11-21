-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)

local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local ItemCardThumbnail = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail

local FFlagAXMigrateBuilderIcons = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXMigrateBuilderIcons

local function SlotItemCardThumbnail(tbl1)
    local var1 = useTokens()
    local name = if tbl1.icon then if FFlagAXMigrateBuilderIcons then tbl1.icon.name else tbl1.icon else Foundation.Enums.IconName.PlusLarge
    local variant = if FFlagAXMigrateBuilderIcons then if tbl1.icon then tbl1.icon.variant else Foundation.Enums.IconVariant.Regular else nil

    if tbl1.url then
        return React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 3
        }, {
            Thumbnail = React.createElement(ItemCardThumbnail, { url = tbl1.url }),
            Overlay = tbl1.enableThumbnailOverlay
                and React.createElement(
                    "Frame",
                    {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundColor3 = var1.Color.Surface.Surface_200.Color3,
                        BackgroundTransparency = var1.Color.Common.Shadow.Transparency,
                        ZIndex = 2
                    },
                    {
                        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) })
                    }
                )
        })
    end
    local createElement = React.createElement
    local fragment = React.Fragment
    local var4 = nil
    local tbl2 = { AddIconFrame = 0, SlotIcon = 0 }
    local element

    if tbl1.icon and not tbl1.ignoredUrl then
        element = React.createElement("Frame", {
            Size = tbl1.iconFrameStyles and tbl1.iconFrameStyles.Size or UDim2.fromOffset(30, 30),
            Position = if FFlagAXMigrateBuilderIcons then UDim2.new(0.5, 4, 0.5, 4) else UDim2.new(0.5, 3, 0.5, 3),
            BackgroundColor3 = var1.Color.Surface.Surface_200.Color3,
            BackgroundTransparency = var1.Color.Surface.Surface_200.Transparency,
            ZIndex = 2
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            AddIcon = React.createElement(Icon, {
                name = if FFlagAXMigrateBuilderIcons then Foundation.Enums.IconName.PlusLarge else "icons/common/plus_heavy_small",
                size = tbl1.iconFrameStyles and tbl1.iconFrameStyles.iconSize or IconSize.Small,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5)
            })
        })
    else
        element = nil
    end

    tbl2.AddIconFrame = element

    tbl2.SlotIcon = React.createElement(Icon, {
        name = name,
        variant = variant,
        size = if FFlagAXMigrateBuilderIcons then var1.Size.Size_800 else IconSize.Large,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        style = var1.Color.Shift.Shift_400
    })
    return createElement(fragment, var4, tbl2)
end

return SlotItemCardThumbnail
