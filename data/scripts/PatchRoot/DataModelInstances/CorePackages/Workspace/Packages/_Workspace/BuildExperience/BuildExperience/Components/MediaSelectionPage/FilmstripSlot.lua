-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Image = Foundation.Image
local View = Foundation.View
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local Badge = Foundation.Badge
local Menu = Foundation.Menu

local BadgeVariant = Foundation.Enums.BadgeVariant
local BadgeShape = Foundation.Enums.BadgeShape
local BadgeSize = Foundation.Enums.BadgeSize
local IconPosition = Foundation.Enums.IconPosition
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local useTokens = Foundation.Hooks.useTokens

local _types = require(script.Parent.types)

local function FilmstripSlot(tbl1)
    local video = useLocalization({ video = LocalizationStrings.MEDIA_SELECTION_VIDEO }).video
    local var1 = useTokens()
    local color3 = if tbl1.isSelected then var1.Color.Content.Emphasis.Color3 else var1.Color.Stroke.Default.Color3
    local var2 = if tbl1.isSelected then 0 else var1.Color.Stroke.Default.Transparency
    local thickness = if tbl1.isSelected then var1.Stroke.Thick else var1.Stroke.Standard

    if not tbl1.isFilled then
        local createElement = React.createElement
        local var4 = Menu
        local tbl2 = {
            tag = "size-full",
            isOpen = tbl1.isMenuOpen or false,
            items = tbl1.menuItems or {{
                items = {}
            }},
            side = PopoverSide.Top,
            align = PopoverAlign.Center,
            onPressedOutside = tbl1.onMenuClose,
            onActivated = tbl1.onMenuActivated,
            LayoutOrder = tbl1.LayoutOrder
        }
        local createElement2 = React.createElement
        local var5 = View
        local tbl3 = {
            tag = {
                ["radius-large"] = true,
                ["bg-surface-200"] = true,
                ["size-full-2700"] = true,
                ["aspect-1-1"] = tbl1.aspectRatio == "square",
                ["aspect-16-9"] = tbl1.aspectRatio == "wide"
            }
        }
        local tbl4 = {
            Stroke = React.createElement(
                "UIStroke",
                {
                    Color = color3,
                    Transparency = var2,
                    Thickness = thickness,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }
            ),
            TouchArea = React.createElement("TextButton", {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 1,
                [React.Event.Activated] = tbl1.onEmptySlotPressed or function() end
            }),
            PlusIcon = React.createElement(View, {
                Size = UDim2.fromScale(1, 1),
                tag = "align-x-center align-y-center"
            }, {
                IconElement = React.createElement(Icon, { name = IconName.PlusSmall, size = IconSize.Medium, tag = "auto-xy content-default" })
            })
        }
        return createElement(var4, tbl2, createElement2(var5, tbl3, tbl4))
    end

    local createElement = React.createElement
    local var4 = Menu
    local tbl2 = {
        isOpen = tbl1.isMenuOpen or false,
        items = tbl1.menuItems or {{
            items = {}
        }},
        side = PopoverSide.Top,
        align = PopoverAlign.Center,
        onPressedOutside = tbl1.onMenuClose,
        onActivated = tbl1.onMenuActivated,
        size = InputSize.Medium,
        LayoutOrder = tbl1.LayoutOrder
    }
    local createElement2 = React.createElement
    local var5 = View
    local tbl3 = {
        tag = {
            ["radius-large"] = true,
            ["size-full-2700"] = true,
            ["aspect-1-1"] = tbl1.aspectRatio == "square",
            ["aspect-16-9"] = tbl1.aspectRatio == "wide"
        },
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl4 = {
        Stroke = React.createElement(
            "UIStroke",
            {
                Color = color3,
                Transparency = var2,
                Thickness = thickness,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }
        ),
        TouchArea = React.createElement("TextButton", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 2,
            [React.Event.Activated] = tbl1.onSelect
        }),
        ImageClip = 0,
        EditButton = 0,
        VideoBadge = 0
    }
    local element

    if tbl1.isLoading then
        element = React.createElement(View, { tag = "size-full radius-large bg-surface-200" })
    elseif tbl1.assetSource and tbl1.mediaType == "video" then
        element = React.createElement(
            "VideoFrame",
            {
                Size = UDim2.fromScale(1, 1),
                Video = tbl1.assetSource,
                Looped = false,
                Playing = false,
                Volume = 0,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 12) })
            }
        )
    elseif tbl1.assetSource then
        element = React.createElement(View, { tag = "size-full radius-large clip" }, {
            Thumbnail = React.createElement(
                Image,
                {
                    Image = tbl1.assetSource,
                    tag = "size-full radius-large",
                    ScaleType = Enum.ScaleType.Crop
                }
            )
        })
    else
        element = nil
    end

    tbl4.ImageClip = element
    local element2

    if tbl1.isSelected and tbl1.onEditPressed then
        element2 = React.createElement(View, {
            tag = "auto-xy radius-circle bg-over-media-0 padding-xxsmall",
            Position = UDim2.new(1, -var1.Gap.Small, 0, var1.Gap.Small),
            AnchorPoint = Vector2.new(1, 0),
            ZIndex = 3
        }, {
            Button = React.createElement(IconButton, { icon = IconName.Pencil, size = InputSize.XSmall, onActivated = tbl1.onEditPressed })
        })
    else
        element2 = nil
    end

    tbl4.EditButton = element2
    local element3

    if tbl1.mediaType == "video" then
        element3 = React.createElement(Badge, {
            Position = UDim2.fromOffset(var1.Gap.Small, var1.Gap.Small),
            ZIndex = 3,
            icon = {
                name = IconName.PlaySmall,
                position = IconPosition.Left
            },
            text = video,
            variant = BadgeVariant.OverMedia,
            shape = BadgeShape.Pill,
            size = BadgeSize.Small
        })
    else
        element3 = nil
    end

    tbl4.VideoBadge = element3
    return createElement(var4, tbl2, createElement2(var5, tbl3, tbl4))
end

return FilmstripSlot
