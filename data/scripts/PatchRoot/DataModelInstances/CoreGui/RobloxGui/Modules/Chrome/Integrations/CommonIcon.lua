-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)

local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local _ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local SubMenuContext = require(Chrome.ChromeShared.Unibar.SubMenuContext)
local IconVariant = Foundation.Enums.IconVariant
local IconSize = Foundation.Enums.IconSize
local IconName = Foundation.Enums.IconName

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(Chrome.ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider
local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local useMappedSignal = Chrome2.Hooks.useMappedSignal
local UnibarStyle = Chrome2.UnibarStyle

local function isFoundationIconName(icon): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return IconName[icon] ~= nil
end

function CommonIconComponent(arg1)
    local iconSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_SIZE else Constants.ICON_SIZE
    local var1 = if arg1.activeSignalValue then useMappedSignal(arg1.activeSignalValue) or false else false
    local icon = arg1.icon
    if var1 and arg1.iconOn then
        icon = arg1.iconOn
    end

    local var2 = useStyle()
    local var3 = React.useContext(SubMenuContext)
    local iconEmphasisColor = var2.Theme.IconEmphasis.Color
    local iconEmphasisTransparency = var2.Theme.IconEmphasis.Transparency

    if not isFoundationIconName(arg1.icon) then
        if typeof(icon) == "string" and icon:sub(1, 11) ~= "rbxasset://" then
            icon = Images[icon]
        end

        return React.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Image = icon,
            Size = UDim2.new(0, iconSize, 0, iconSize),
            ImageColor3 = iconEmphasisColor,
            ImageTransparency = if var3 then var3:map(function(arg2): number
                return iconEmphasisTransparency + (1 - iconEmphasisTransparency) * (1 - arg2)
            end) else iconEmphasisTransparency
        })
    end

    local style = not var3 and {
        Color3 = iconEmphasisColor,
        Transparency = iconEmphasisTransparency
    } or var3:map(function(arg2)
        return {
            Color3 = iconEmphasisColor,
            Transparency = iconEmphasisTransparency + (1 - iconEmphasisTransparency) * (1 - arg2)
        }
    end)

    return React.createElement(Foundation.Icon, {
        name = IconName[arg1.icon],
        size = IconSize.Large,
        style = style,
        variant = if var1 then IconVariant.Filled else IconVariant.Regular
    })
end

function CommonIcon(icon, iconOn, activeSignalValue)
    return React.createElement(CommonIconComponent, { icon = icon, iconOn = iconOn, activeSignalValue = activeSignalValue })
end

return CommonIcon
