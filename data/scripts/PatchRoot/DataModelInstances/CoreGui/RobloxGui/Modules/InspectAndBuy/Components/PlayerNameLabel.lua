-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local Colors = require(scriptParentParent.Colors)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local VerifiedBadges = require(CorePackages.Workspace.Packages.VerifiedBadges)
local UserLib = require(CorePackages.Workspace.Packages.UserLib)

local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)

local var1 = Roact.PureComponent:extend("PlayerNameLabel")

local verified = VerifiedBadges.emoji.verified

function var1.render(arg1)
    local locale = arg1.props.locale
    local view = arg1.props.view
    local playerName = arg1.props.playerName
    local var2 = tonumber(arg1.props.playerId)
    local playerByUserId = var2 and Players:GetPlayerByUserId(var2)
    local var3 = if playerByUserId then UserLib.Utils.isPlayerVerified(playerByUserId) else false
    local str1 = if playerName == "" then "" elseif var3 then RobloxTranslator:FormatByKeyForLocale(
        "InGame.InspectMenu.Label.VerifiedAvatar",
        locale,
        { PLAYER_NAME = playerName, VERIFIED_BADGE = verified }
    ) else RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.Avatar", locale, { PLAYER_NAME = playerName })

    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(arg2)
            local var4 = arg2[view]
            local var5 = var4.AvatarHeadShotSize + var4.BorderPaddingSize * 2 + 10

            return Roact.createElement(
                "TextLabel",
                {
                    Size = UDim2.new(1, -var5, 0, var4.TopSizeY),
                    BackgroundTransparency = 1,
                    TextColor3 = Colors.White,
                    TextScaled = true,
                    Text = str1,
                    TextSize = 36,
                    Font = AppFonts.default:getBlack(),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = 2
                },
                {
                    TextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = 36 })
                }
            )
        end
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        view = arg1.view,
        playerName = arg1.playerName,
        playerId = arg1.playerId,
        locale = arg1.locale
    }
end)(var1)
