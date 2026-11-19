-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:02:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local StarterPlayer = game:GetService("StarterPlayer")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local FFlagFixEmotesMenuAvailability = require(scriptParentParent.Flags.FFlagFixEmotesMenuAvailability)

local var1 = Roact.PureComponent:extend("WheelText")

function var1.getWheelText(arg1)
    local currentEmotes = arg1.props.emotesPage.currentEmotes
    local locale = arg1.props.locale
    local numberEmotesLoaded = arg1.props.emotesPage.numberEmotesLoaded

    if next(currentEmotes) == nil then
        if StarterPlayer.UserEmotesEnabled and (FFlagFixEmotesMenuAvailability or numberEmotesLoaded == 0) then
            return RobloxTranslator:FormatByKeyForLocale(Constants.LocalizationKeys.NoEmotesEquipped, locale)
        end
        return RobloxTranslator:FormatByKeyForLocale(Constants.LocalizationKeys.EmotesDisabled, locale)
    end

    local var2 = currentEmotes[arg1.props.emotesWheel.focusedSegmentIndex]

    if var2 then
        return var2
    end
    return RobloxTranslator:FormatByKeyForLocale(Constants.LocalizationKeys.SelectAnEmote, locale)
end

function var1.render(arg1)
    local layout = Constants.Layouts[arg1.props.layout]
    local wheelText = arg1:getWheelText()

    return Roact.createElement(
        "TextLabel",
        {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(
                Constants.InnerCircleSizeRatio,
                -Constants.TextPadding,
                Constants.InnerCircleSizeRatio,
                -Constants.TextPadding
            ),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            Text = wheelText,
            TextScaled = true,
            TextSize = layout.MiddleTextSize,
            TextColor3 = Constants.Colors.White,
            Font = layout.MiddleTextFont,
            ZIndex = 5
        },
        {
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = layout.MiddleTextSize })
        }
    )
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        emotesWheel = arg1.emotesWheel,
        emotesPage = arg1.emotesPage,
        layout = arg1.layout,
        locale = arg1.locale
    }
end, nil)(var1)
