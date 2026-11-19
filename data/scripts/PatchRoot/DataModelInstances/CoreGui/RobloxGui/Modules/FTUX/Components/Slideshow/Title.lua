-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle

local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization
local scriptParentParentParent = script.Parent.Parent.Parent
local FTUXSlideshowData = require(scriptParentParentParent.Resources.FTUXSlideshowData)

local _PlatformEnum = require(scriptParentParentParent.Enums.PlatformEnum)

local function Title(tbl1)
    local var1 = useStyle()

    local theme = var1.Theme
    local font = var1.Font

    local title = FTUXSlideshowData[tbl1.platform][tbl1.currentIndex].title

    return withLocalization({ titleText = title })(function(arg1)
        return React.createElement(UIBlox.App.Text.StyledTextLabel, {
            text = arg1.titleText,
            fontStyle = font.SubHeader1,
            colorStyle = theme.TextEmphasis,
            textXAlignment = Enum.TextXAlignment.Left,
            size = UDim2.new(1, 0, 0.031, 0),
            layoutOrder = 1
        })
    end)
end

return Title
