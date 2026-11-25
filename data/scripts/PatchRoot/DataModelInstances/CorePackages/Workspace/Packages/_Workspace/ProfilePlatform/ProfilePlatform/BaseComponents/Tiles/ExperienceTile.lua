-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local UIBlox = require(ProfilePlatformParent.UIBlox)
local ExperienceTileV3 = UIBlox.App.Tile.ExperienceTileV3
local useStyle = UIBlox.Core.Style.useStyle

local UserLib = require(ProfilePlatformParent.UserLib)
local Constants = UserLib.Utils.Constants
local GameStats = require(ProfilePlatformParent.GameTile).GameStats
local useSelector = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useSelector

local FFlagProfilePlatformEnableExperiencesFooter = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableExperiencesFooter)

local getDeepValue = require(ProfilePlatformParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue

local _Types = require(ProfilePlatform.Common.Types)

local useSetupImpressionsTileTagging = require(ProfilePlatform.Hooks.useSetupImpressionsTileTagging)

local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local tbl1 = {}

local function ExperienceTile(tbl2)
    local var1 = useStyle()

    local ref = React.useRef(nil)
    useSetupImpressionsTileTagging(ref, tbl2.impressionsTag, tbl2.index)

    local gameIcon = Constants.RbxthumbTypes.GameIcon
    local thumbnail = getRbxthumbWithTypeSizeAndOptions(tbl2.item.experienceId, gameIcon, 150)

    local var3 = tbl2.showFooter and FFlagProfilePlatformEnableExperiencesFooter

    local var4 = if var3 then useSelector(function(arg1)
        return getDeepValue(arg1, "GameVotes") or tbl1
    end)[tbl2.item.experienceId] else nil

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = tbl2.index,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ref = ref
    }
    local tbl4 = {
        Tile = React.createElement(ExperienceTileV3, {
            contextTextLineCount = 1,
            experienceName = tbl2.item.name,
            thumbnail = thumbnail,
            hasBackground = false,
            isHoverEnabled = false,
            hasOutline = false,
            onActivated = tbl2.onActivated,
            styleProps = {
                bottomContentPadding = {
                    Left = 0,
                    Right = 0,
                    Top = var1.Tokens.Padding.Small,
                    Bottom = var1.Tokens.Padding.Small
                }
            },
            footer = if var3 then React.createElement(GameStats, {
                isGridTile = true,
                stats = {
                    totalUpVotes = var4 and var4.upVotes or 0,
                    totalDownVotes = var4 and var4.downVotes or 0,
                    playerCount = tbl2.item.playing
                }
            }) else nil,
            footerHeight = if var3 then 32 else nil
        })
    }
    return createElement(str1, tbl3, tbl4)
end

return ExperienceTile
