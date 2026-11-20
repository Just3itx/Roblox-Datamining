-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local Players = game:GetService("Players")

local Modules = CoreGui.RobloxGui.Modules
local ShareGame = Modules.Settings.Pages.ShareGame

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local httpRequest = require(Modules.Common.httpRequest)

local ShareGamePageFrame = require(ShareGame.Components.ShareGamePageFrame)
local Constants = require(ShareGame.Constants)
local FetchUserFriends = require(ShareGame.Thunks.FetchUserFriends)

local ClosePage = require(ShareGame.Actions.ClosePage)

local var1 = Roact.PureComponent:extend("ShareGameContainer")
var1.defaultProps = { skeletonComponent = ShareGamePageFrame }

function var1.init(arg1)
    arg1.props.reFetch(arg1.props.requestImpl)
end

function var1.render(arg1)
    return Roact.createElement(arg1.props.skeletonComponent, arg1.props)
end

return (RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        deviceLayout = arg1.DeviceInfo.DeviceLayout,
        searchAreaActive = arg1.ConversationsSearch.SearchAreaActive,
        searchText = arg1.ConversationsSearch.SearchText
    }
end, function(callback)
    return {
        closePage = function()
            callback(ClosePage(Constants.PageRoute.SHARE_GAME))
        end,
        reFetch = function(arg1)
            local str1 = tostring(Players.LocalPlayer.UserId)
            arg1 = arg1 or httpRequest(HttpRbxApiService)

            callback(FetchUserFriends(arg1, str1))
        end
    }
end)(var1))
