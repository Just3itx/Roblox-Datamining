-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local t = require(CorePackages.Packages.t)
local ArgCheck = require(CorePackages.Workspace.Packages.ArgCheck)

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useStyle = UIBlox.Core.Style.useStyle
local BaseMenu = UIBlox.App.Menu.BaseMenu

local iconsActionsTruncationExpand_small = Images["icons/actions/truncationExpand_small"]

local var1 = ArgCheck.wrap(
    t.strictInterface({
        buttonSize = t.UDim2,
        dropdownList = t.table,
        selectedIndex = t.number,
        onSelection = t.callback,
        layoutOrder = t.number
    })
)
local function DropdownMenu(tbl1)
    assert(var1(tbl1))

    local var2 = useStyle()
    local captionHeader = var2.Font.CaptionHeader
    local textSize = captionHeader.RelativeSize * var2.Font.BaseSize
    local backgroundColor3 = if var2.UIBloxThemeEnabled then var2.color("ControlInputBackground") else Color3.fromRGB(79, 84, 95)
    local var5, var6 = React.useState(false)
    local buttonProps, var8 = React.useState({})

    local var9 = React.useCallback(function()
        var6(not var5)
    end)

    React.useEffect(function()
        local tbl2 = ({})
        for k, text in pairs(tbl1.dropdownList) do
            local tbl3 = {
                text = text,
                fontStyle = {
                    Font = captionHeader.Font,
                    RelativeSize = captionHeader.RelativeSize
                },
                onActivated = 0,
                leftPaddingOffset = -12,
                selected = 0,
                selectedIconPaddingRight = 12
            }
            function tbl3.onActivated()
                tbl1.onSelection(k)
                var6(false)
            end

            tbl3.selected = k == tbl1.selectedIndex
            tbl2[k] = tbl3
        end

        var8(tbl2)
    end, { tbl1.dropdownList, tbl1.selectedIndex })

    local createElement = Roact.createElement
    local tbl2 = {
        Size = tbl1.buttonSize,
        LayoutOrder = tbl1.layoutOrder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 3
    }

    local tbl3 = {
        SpawnButton = Roact.createElement("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            Text = tbl1.dropdownList[tbl1.selectedIndex],
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = textSize,
            FontFace = normalizeFontFace(var2.Tokens.Typography.CaptionLarge.Font),
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundColor3 = backgroundColor3,
            BackgroundTransparency = 0,
            LayoutOrder = tbl1.layoutOrder,
            [Roact.Event.Activated] = var9
        }, {
            UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
            UIPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12) }),
            UIStroke = Roact.createElement(
                "UIStroke",
                {
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = Color3.new(1, 1, 1),
                    Thickness = 1,
                    Transparency = 0.8
                }
            ),
            Arrow = Roact.createElement(ImageSetLabel, {
                Image = iconsActionsTruncationExpand_small,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(1, -28, 0.5, -8)
            })
        }),
        Dropdown = var5
            and Roact.createElement(BaseMenu, {
                buttonProps = buttonProps,
                position = UDim2.new(0, 0, 1, 6),
                layoutOrder = 2,
                elementHeight = 40,
                background = { Color = backgroundColor3 },
                showDropShadow = true
            })
    }
    return createElement("Frame", tbl2, tbl3)
end

return DropdownMenu
