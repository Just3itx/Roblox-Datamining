-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local getSduiComponentRegistry = SduiCoreSystem.getSduiComponentRegistry
local SduiComponentType = SduiCoreSystem.SduiComponentType

local SharedFlags = require(SocialServerDrivenUiParent.SharedFlags)
local FFlagSduiRequestFriendshipAction = SharedFlags.FFlagSduiRequestFriendshipAction
local FFlagLuaAppSduiHomeFriendCarousel = SharedFlags.FFlagLuaAppSduiHomeFriendCarousel
local FFlagLuaAppSduiHomePageSupport = SharedFlags.FFlagLuaAppSduiHomePageSupport
local FFlagSduiUserSearchTile = SharedFlags.FFlagSduiUserSearchTile
local FFlagSduiFriendsOwnedChip = require(SocialServerDrivenUi.Flags.FFlagSduiFriendsOwnedChip)

local function registerSocialComponents()
    local tbl1 = {
        [SduiComponentType.FriendCarousel] = FFlagLuaAppSduiHomeFriendCarousel and {
            getLazyComponent = function()
                return require(SocialServerDrivenUi.Components.SduiFriendCarousel)
            end
        } or nil,
        [SduiComponentType.PymkCarousel] = FFlagLuaAppSduiHomePageSupport and {
            getLazyComponent = function()
                return require(SocialServerDrivenUi.Components.SduiPymkCarousel)
            end
        } or nil,
        [SduiComponentType.FriendRequestButton] = FFlagSduiRequestFriendshipAction and {
            getLazyComponent = function()
                return require(SocialServerDrivenUi.Components.SduiFriendRequestButton)
            end
        } or nil,
        [SduiComponentType.UserSearchTile] = FFlagSduiUserSearchTile and {
            getLazyComponent = function()
                return require(SocialServerDrivenUi.Components.SduiUserSearchTile)
            end
        } or nil,
        [SduiComponentType.FriendsOwnedChip] = FFlagSduiFriendsOwnedChip and {
            getLazyComponent = function()
                return require(SocialServerDrivenUi.Components.SduiFriendsOwnedChip)
            end
        } or nil
    }

    getSduiComponentRegistry().registerComponentDefinitions(tbl1)
end

return registerSocialComponents
