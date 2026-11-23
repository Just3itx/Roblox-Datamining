-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local GameDetailRodux = require(AppChatParent.GameDetailRodux)
local Http = require(AppChatParent.Http)
local PlayabilityRodux = require(AppChatParent.PlayabilityRodux)
local Rodux = require(AppChatParent.Rodux)
local Constants = require(AppChatParent.SquadsCore.Constants)
local installReducer = require(AppChatParent.SquadsCore.installReducer)
local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagRemoveUnusedFriendCountRoduxSlice = require(AppChatParent.SharedFlags).FFlagRemoveUnusedFriendCountRoduxSlice

local FormFactorReducer = require(AppChatParent.FormFactor).FormFactorReducer
local UserLib = require(AppChatParent.UserLib)

local GameDetailReducer = GameDetailRodux.GameDetails.GameDetailReducer
local FetchingStatus = Http.Reducers.FetchingStatus
local UserReducer = UserLib.Reducers.UserReducer
local LocalUserIdReducer = UserLib.Reducers.LocalUserIdReducer
local PlayabilityStatusReducer = PlayabilityRodux.PlayabilityStatus.PlayabilityStatusReducer
local SocialBlockingModal = require(AppChatParent.SocialBlockingModal)

local installReducer2 = require(AppChat.installReducer)
local ScreenSize = require(AppChat.installReducer.ScreenSize)

local FriendCount = require(AppChatParent.LegacyFriendsRodux).Reducers.FriendCount
local PlayerContextualMenu = require(AppChatParent.PlayerContextualMenu)

local SquadLocation = require(AppChatParent.SquadsCore.Enums).SquadLocation

local PartyPageCarouselExperimentation = require(AppChatParent.SocialExperiments).PartyPageCarouselExperimentation

local combineReducers = Rodux.combineReducers
local tbl1 = {
    PlayerContextualMenu = PlayerContextualMenu.installReducer(),
    EventReceievers = Rodux.combineReducers({ NetworkStatus = require(AppChat.Http.RoduxNetworking).installReducer() }),
    ChatAppReducer = installReducer2(),
    FetchingStatus = FetchingStatus,
    GameDetails = GameDetailReducer,
    LocalUserId = LocalUserIdReducer
}

if FFlagRemoveUnusedFriendCountRoduxSlice then
    FriendCount = nil
end

tbl1.FriendCount = FriendCount
tbl1.PlayabilityStatus = PlayabilityStatusReducer
if not PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then
    ScreenSize = nil
end

tbl1.ScreenSize = ScreenSize
tbl1.FormFactor = FormFactorReducer
tbl1.Users = UserReducer
local RODUX_KEY = Constants.RODUX_KEY
tbl1[RODUX_KEY] = if GetFFlagIsSquadEnabled() then installReducer(SquadLocation.InExperience) else nil

tbl1[SocialBlockingModal.RoduxKey] = SocialBlockingModal.installReducer()
return (combineReducers(tbl1))
