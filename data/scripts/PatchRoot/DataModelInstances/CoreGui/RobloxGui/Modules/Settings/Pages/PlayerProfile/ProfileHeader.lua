-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local View = require(CorePackages.Packages.Foundation).View
local Enums = require(CorePackages.Workspace.Packages.ProfilePlatform.Enums)
local useProfileJsonComponent = require(CorePackages.Workspace.Packages.ProfilePlatform.useProfileJsonComponent)
local ProfileWrapperContext = require(CorePackages.Workspace.Packages.ProfilePlatform.ProfileWrapperContext)
local AvatarHeadshotComponent = require(CorePackages.Workspace.Packages.ProfilePlatform.AvatarHeadshotComponent)
local SocialChipCountsRow = require(CorePackages.Workspace.Packages.ProfilePlatform.SocialChipCountsRow)

local function _(arg1, arg2, bool1: boolean?) -- Luacid: unused: defined but never referenced
    local primaryName = arg1.names.primaryName or ""

    if arg2.profileUserNickname and bool1 and arg2.profileUserNickname ~= "" then
        return arg2.profileUserNickname .. " (" .. primaryName .. ")"
    end

    return primaryName
end

return React.memo(function(tbl1) -- name: ProfileHeader
    local var1 = React.useContext(ProfileWrapperContext)

    local var2 = useProfileJsonComponent(Enums.Components.UserProfileHeader)
    local bool1 = var2.counts ~= nil

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "size-full-0 auto-y col gap-large",
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = { AvatarHeadshotComponent = 0, SocialCountsRow = 0 }
    local createElement2 = React.createElement
    local var4 = AvatarHeadshotComponent
    local tbl4 = {
        userId = tbl1.profileId,
        primaryName = 0,
        username = 0,
        isPremium = 0,
        isVerified = 0,
        isRobloxAdmin = 0,
        layoutOrder = 1
    }
    local primaryName = var2.names.primaryName or ""

    local _profileUserNickname = var1.profileUserNickname

    tbl4.primaryName = primaryName
    tbl4.username = var2.names.username
    tbl4.isPremium = var2.isPremium
    tbl4.isVerified = var2.isVerified
    tbl4.isRobloxAdmin = var2.isRobloxAdmin
    tbl3.AvatarHeadshotComponent = createElement2(var4, tbl4)

    tbl3.SocialCountsRow = if bool1 then React.createElement(SocialChipCountsRow, { size = UDim2.fromScale(1, 0), layoutOrder = 2 }) else nil
    return createElement(var3, tbl2, tbl3)
end)
