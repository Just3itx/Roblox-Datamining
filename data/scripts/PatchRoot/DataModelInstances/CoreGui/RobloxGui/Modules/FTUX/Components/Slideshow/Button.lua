-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useStyle = UIBlox.Core.Style.useStyle

local scriptParentParentParent = script.Parent.Parent.Parent
local FTUXSlideshowData = require(scriptParentParentParent.Resources.FTUXSlideshowData)
local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization

local _PlatformEnum = require(scriptParentParentParent.Enums.PlatformEnum)
local ButtonEnum = require(scriptParentParentParent.Enums.ButtonEnum)

local function SlideshowButton(tbl1)
    local font = useStyle().Font

    local var1 = FTUXSlideshowData[tbl1.platform]
    local currentIndex = tbl1.currentIndex
    local increaseCurrentIndex = tbl1.increaseCurrentIndex
    local button = var1[currentIndex].button

    return withLocalization({ skip = "CoreScripts.VRFTUX.Action.Skip", next = "CoreScripts.VRFTUX.Action.Next" })(function(arg1)
        local secondary = ButtonType.Secondary
        local skip = arg1.skip
        if button == ButtonEnum.NextButton then
            secondary = ButtonType.PrimaryContextual
            skip = arg1.next
        end

        return React.createElement(Button, {
            buttonType = secondary,
            text = skip,
            fontStyle = font.Body,
            layoutOrder = 4,
            size = UDim2.new(1, 0, 0.6, 0),
            onActivated = increaseCurrentIndex
        })
    end)
end

return SlideshowButton
