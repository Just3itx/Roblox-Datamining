-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local scriptParentParent = script.Parent.Parent
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local UIBlox = require(CorePackages.Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.PureComponent:extend("LimitedLabel")

local GetFFlagIBEnableCollectiblesSystemSupport = require(scriptParentParent.Flags.GetFFlagIBEnableCollectiblesSystemSupport)

function var1.render(arg1)
    local frameSize = arg1.props.frameSize
    local framePosition = arg1.props.framePosition
    local imageSize = arg1.props.imageSize
    local imagePosition = arg1.props.imagePosition
    local textSize = arg1.props.textSize
    local textPosition = arg1.props.textPosition
    local text = arg1.props.text

    local iconsStatusItemLimited = Images["icons/status/item/limited"]

    return Roact.createElement("Frame", {
        Size = frameSize,
        BorderSizePixel = 0,
        LayoutOrder = 3,
        Position = framePosition,
        BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    }, {
        Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        CollectiblesIcon = Roact.createElement(ImageSetLabel, {
            Position = imagePosition,
            Size = imageSize,
            BackgroundTransparency = 1,
            ZIndex = 2,
            Visible = true,
            Image = iconsStatusItemLimited
        }),
        CollectiblesText = if GetFFlagIBEnableCollectiblesSystemSupport() and not text then nil else Roact.createElement(
            "TextLabel",
            {
                Position = textPosition,
                Size = textSize,
                BackgroundTransparency = 1,
                Text = text,
                Font = AppFonts.default:getDefault(),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 12,
                TextColor3 = Color3.new(1, 1, 1)
            }
        )
    })
end

return var1
