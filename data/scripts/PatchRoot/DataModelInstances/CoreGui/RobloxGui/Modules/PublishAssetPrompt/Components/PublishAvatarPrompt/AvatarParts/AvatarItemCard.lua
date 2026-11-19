-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local useStyle = UIBlox.Core.Style.useStyle

local AvatarPartViewport = require(script.Parent.AvatarPartViewport)

local GetFFlagSingleUploadMakeupSupport = require(script.Parent.Parent.Parent.Parent.Flags.GetFFlagSingleUploadMakeupSupport)

local function AvatarItemCard(tbl1)
    local var1 = useStyle()
    local font = var1.Font
    local theme = var1.Theme
    local asset = tbl1.asset

    local captionHeader = font.CaptionHeader
    local textEmphasisColor = theme.TextEmphasis.Color
    if GetFFlagSingleUploadMakeupSupport() then
        assert(
            typeof(asset) == "table" or asset:IsA("MeshPart") or asset:IsA("Accessory") or asset:IsA("Decal"),
            "Assert that asset is a table, MeshPart, Accessory, or Decal"
        )
    else
        assert(
            typeof(asset) == "table" or asset:IsA("MeshPart") or asset:IsA("Accessory"),
            "Assert that asset is a table, MeshPart, or Accessory"
        )
    end

    local bodyName = tbl1.bodyName
    local partName = tbl1.partName

    local var2 = nil
    local bool1

    if GetFFlagSingleUploadMakeupSupport() then
        if bodyName and partName then
            var2 = bodyName .. "'s " .. partName
        else
            var2 = partName or var2
        end

        bool1 = var2 ~= nil
    else
        if bodyName == nil then
            bool1 = false
        else
            bool1 = partName ~= nil
        end

        if bodyName and partName then
            var2 = bodyName .. "'s " .. partName
        end
    end
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        LayoutOrder = tbl1.LayoutOrder,
        BackgroundTransparency = 1
    }
    local tbl3 = {
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5)
            }
        ),
        AvatarPartViewport = React.createElement(AvatarPartViewport, {
            asset = asset,
            assetType = if GetFFlagSingleUploadMakeupSupport() then tbl1.assetType else nil,
            LayoutOrder = 1,
            viewportSize = tbl1.viewportSize
        }),
        TitleText = bool1
            and React.createElement("TextLabel", {
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                Text = var2,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                Size = UDim2.new(1, 0, 0, 50),
                TextColor3 = textEmphasisColor,
                TextWrapped = true,
                FontFace = normalizeFontFace(var1.Tokens.Typography.CaptionLarge.Font),
                TextSize = captionHeader.RelativeSize * font.BaseSize,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
    }
    return createElement(str1, tbl2, tbl3)
end

return AvatarItemCard
