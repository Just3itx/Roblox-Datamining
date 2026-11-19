-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local Constants = require(script.Parent.Constants)
local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)

local isConnectDropdownEnabled = require(Chrome.Integrations.Connect.isConnectDropdownEnabled)
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local isTenFootInterface = require(CorePackages.Workspace.Packages.AppCommonLib).isTenFootInterface

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableInExperienceAvatarSwitcher = SharedFlags.FFlagEnableInExperienceAvatarSwitcher
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagAddInviteFriendsIntegration = SharedFlags.FFlagAddInviteFriendsIntegration
local FFlagIntegrateTraversalHistoryInSideSheet = SharedFlags.FFlagIntegrateTraversalHistoryInSideSheet
local FFlagEnableInExperienceShop = SharedFlags.FFlagEnableInExperienceShop
local FFlagRemoveFriendsChatUnibarEntrypoints = SharedFlags.FFlagRemoveFriendsChatUnibarEntrypoints
local FFlagExpChatCanShowFriendsTab = SharedFlags.FFlagExpChatCanShowFriendsTab
local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch
local FFlagEnableSideSheetRobuxWidget = require(Chrome.Flags.FFlagEnableSideSheetRobuxWidget)
local FFlagSideSheetUnifiedMenuOrder = SharedFlags.FFlagSideSheetUnifiedMenuOrder
local Traversal = if FFlagIntegrateTraversalHistoryInSideSheet then require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).Traversal else nil
local FFlagAddTraversalHistory = if Traversal then Traversal.Flags.FFlagAddTraversalHistory else false

local function reorder(tbl1, str1: string, num1: number) -- Luacid: Inlined by compiler; 28 call sites recovered
    if tbl1[str1] ~= nil then
        tbl1[str1] = num1
    end
end

local function removePioneerEntries(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    tbl1.connect_dropdown = nil
    tbl1[Constants.AVATAR_SWITCHER_ID] = nil
    tbl1.emotes = nil
    tbl1.traversal_history = nil
    tbl1.camera_entrypoint = nil
    tbl1.gallery = nil
end

local function buildMenuOrder()
    local var1 = isConnectDropdownEnabled() and not (FFlagRemoveFriendsChatUnibarEntrypoints and FFlagExpChatCanShowFriendsTab)

    local bool1 = not (isSpatial() or isTenFootInterface())
    local bool2 = not (isInExperienceUIVREnabled and isSpatial())
    local var2 = FFlagAddTraversalHistory and FFlagIntegrateTraversalHistoryInSideSheet

    local tbl1 = {
        RobuxWidget = if FFlagEnableSideSheetRobuxWidget then if isSideSheetEnabled then 5 else nil else nil,
        invite_friends = if FFlagAddInviteFriendsIntegration then 10 else nil,
        people = 20,
        settings = 30,
        trust_and_safety = 40,
        connect_dropdown = if var1 then 50 else nil,
        [Constants.AVATAR_SWITCHER_ID] = if FFlagEnableInExperienceAvatarSwitcher then 60 else nil,
        [Constants.SWITCH_SERVER_ID] = if FFlagShowSwitchServerButton then 65 elseif isPioneerLaunch() then 65 else nil,
        [Constants.IN_EXPERIENCE_SHOP_ID] = if FFlagEnableInExperienceShop then 70 else nil,
        leaderboard = 80,
        emotes = 90,
        backpack = 100,
        traversal_history = if var2 then 110 else nil,
        help = 120,
        camera_entrypoint = if bool2 then 130 else nil,
        gallery = 140,
        selfie_view = if bool2 then 150 else nil,
        music_entrypoint = if bool1 then 160 else nil,
        AccountUpsell = if isPioneerLaunch() then 170 else nil,
        [InExperienceSideSheet.Enums.ActionBinding.Leave] = 180,
        [InExperienceSideSheet.Enums.ActionBinding.Respawn] = 190
    }

    if FFlagSideSheetUnifiedMenuOrder and isSideSheetEnabled then
        if isPioneerLaunch() then
            removePioneerEntries(tbl1)
            reorder(tbl1, "AccountUpsell", 185)
        end

        reorder(tbl1, "people", 20)
        reorder(tbl1, "connect_dropdown", 30)
        reorder(tbl1, "invite_friends", 40)
        reorder(tbl1, "settings", 50)
        reorder(tbl1, "leaderboard", 60)
        reorder(tbl1, "emotes", 70)
        reorder(tbl1, Constants.AVATAR_SWITCHER_ID, 80)
        reorder(tbl1, "backpack", 90)
        reorder(tbl1, Constants.IN_EXPERIENCE_SHOP_ID, 100)
        reorder(tbl1, "gallery", 110)
        reorder(tbl1, "camera_entrypoint", 120)
        reorder(tbl1, "help", 130)
        reorder(tbl1, "trust_and_safety", 140)
        reorder(tbl1, "music_entrypoint", 150)
        reorder(tbl1, "selfie_view", 160)
        reorder(tbl1, Constants.SWITCH_SERVER_ID, 170)
        reorder(tbl1, "traversal_history", 180)
        reorder(tbl1, InExperienceSideSheet.Enums.ActionBinding.Leave, 190)
        reorder(tbl1, InExperienceSideSheet.Enums.ActionBinding.Respawn, 200)
    elseif isPioneerLaunch() then
        removePioneerEntries(tbl1)
        reorder(tbl1, Constants.SWITCH_SERVER_ID, 200)
    elseif not isSideSheetEnabled then
        reorder(tbl1, "connect_dropdown", 10)
        reorder(tbl1, Constants.IN_EXPERIENCE_SHOP_ID, 20)
        reorder(tbl1, "selfie_view", 30)
        reorder(tbl1, Constants.AVATAR_SWITCHER_ID, 40)
        reorder(tbl1, "music_entrypoint", 50)
        reorder(tbl1, "camera_entrypoint", 60)
        reorder(tbl1, "trust_and_safety", 70)
        tbl1.respawn = 110

        tbl1.invite_friends = nil
        tbl1.people = nil
        tbl1.settings = nil
        tbl1.traversal_history = nil
        tbl1.help = nil
        tbl1.gallery = nil
        tbl1[InExperienceSideSheet.Enums.ActionBinding.Leave] = nil
        tbl1[InExperienceSideSheet.Enums.ActionBinding.Respawn] = nil
        tbl1[Constants.SWITCH_SERVER_ID] = nil
    end

    local menuOrder = {}
    for value in tbl1 do
        table.insert(menuOrder, value)
    end
    table.sort(menuOrder, function(arg1, arg2): boolean
        return tbl1[arg1] < tbl1[arg2]
    end)

    return menuOrder
end

return buildMenuOrder
