-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local withStyle = UIBlox.Core.Style.withStyle
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Badge = UIBlox.App.Indicator.Badge

local iconsMenuChat_on = Images["icons/menu/chat_on"]
local iconsMenuChat_off = Images["icons/menu/chat_off"]

local var1 = Roact.PureComponent:extend("ChatIcon")

var1.validateProps = t.strictInterface({ chatVisible = t.boolean, unreadMessages = t.integer })

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme

        local var2 = iconsMenuChat_on
        if not arg1.props.chatVisible then
            var2 = iconsMenuChat_off
        end

        return Roact.createElement(ImageSetLabel, {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Image = var2,
            ImageColor3 = theme.IconEmphasis.Color,
            ImageTransparency = theme.IconEmphasis.Transparency,
            ZIndex = 2
        }, {
            Badge = arg1.props.unreadMessages > 0
                and Roact.createElement(Badge, {
                    position = UDim2.new(0, 24, 0.5, 0),
                    anchorPoint = Vector2.new(0, 0.5),
                    hasShadow = false,
                    value = arg1.props.unreadMessages
                })
        })
    end)
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        chatVisible = arg1.chat.visible,
        unreadMessages = arg1.chat.unreadMessages
    }
end, nil)(var1)
