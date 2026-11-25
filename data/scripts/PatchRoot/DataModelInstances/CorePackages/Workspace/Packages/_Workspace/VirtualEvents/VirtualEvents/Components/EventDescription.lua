-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local Skeleton = require(VirtualEvents.Parent.Foundation).Skeleton

local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization

local ExperienceTileV3 = UIBlox.App.Tile.ExperienceTileV3
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset

local uDim2 = UDim2.new(0, 150, 0, 210)

local function EventDescription(tbl1)
    local var1 = useStyle()
    local var2 = useLocalization({ header = "Feature.VirtualEvents.DescriptionLabel" })

    local var3 = useTextSizeOffset()
    local var4 = uDim2 + UDim2.fromOffset(0, var3 * 2)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 32) }),
        DescriptionHeader = React.createElement(StyledTextLabel, {
            layoutOrder = 0,
            text = var2.header,
            automaticSize = Enum.AutomaticSize.XY,
            fontStyle = var1.Font.Header1,
            colorStyle = var1.Theme.TextEmphasis
        }),
        Description = 0,
        ExperienceTileWrapper = 0
    }
    local element

    if tbl1.description then
        element = React.createElement(StyledTextLabel, {
            layoutOrder = 1,
            text = tbl1.description,
            automaticSize = Enum.AutomaticSize.XY,
            fontStyle = var1.Font.Body,
            colorStyle = var1.Theme.TextDefault
        })
    else
        element = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, var1.Font.BaseSize) })
    end

    tbl3.Description = element

    tbl3.ExperienceTileWrapper = React.createElement(
        "Frame",
        { LayoutOrder = 2, Size = var4, BackgroundTransparency = 1 },
        {
            ExperienceTile = React.createElement(ExperienceTileV3, {
                experienceName = tbl1.experienceName,
                thumbnail = tbl1.experienceThumbnail,
                onActivated = tbl1.onExperienceTileActivated,
                styleProps = {
                    overlayColors = {
                        Hover = var1.Theme.BackgroundOnHover
                    }
                }
            })
        }
    )
    return createElement(str1, tbl2, tbl3)
end

return EventDescription
