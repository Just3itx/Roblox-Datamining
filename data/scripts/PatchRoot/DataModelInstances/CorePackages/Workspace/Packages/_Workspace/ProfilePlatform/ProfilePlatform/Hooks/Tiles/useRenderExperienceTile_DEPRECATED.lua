-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local useDispatch = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useDispatch

local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation
local OpenGameDetails = require(ProfilePlatformParent.GameDetail).OpenGameDetails

local UIBlox = require(ProfilePlatformParent.UIBlox)
local ExperienceTileV3 = UIBlox.App.Tile.ExperienceTileV3
local useStyle = UIBlox.Core.Style.useStyle

local UserLib = require(ProfilePlatformParent.UserLib)
local Constants = UserLib.Utils.Constants

local _Types = require(ProfilePlatform.Common.Types)

local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local function useRenderSquareExperienceTile(str1: string?, callback: ((...any) -> (...any))?, _)
    local var1 = useDispatch()
    local var2 = useNavigation()
    local var3 = useStyle()

    local str2 = str1 or "ProfileExperienceTile_"

    return (React.useCallback(function(arg1, layoutOrder: number, _, num1: number?)
        local function onActivated()
            if callback then
                callback(arg1, layoutOrder, num1)
            end

            var1(OpenGameDetails(arg1.experienceId, var2, { mountAsFullView = false, showBackButton = true }))
        end

        local gameIcon = Constants.RbxthumbTypes.GameIcon
        local thumbnail = getRbxthumbWithTypeSizeAndOptions(arg1.experienceId, gameIcon, 150)

        return React.createElement(
            "Frame",
            {
                LayoutOrder = layoutOrder,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            },
            {
                Tile = React.createElement(ExperienceTileV3, {
                    contextTextLineCount = 1,
                    experienceName = arg1.name,
                    thumbnail = thumbnail,
                    hasBackground = false,
                    isHoverEnabled = false,
                    hasOutline = false,
                    onActivated = onActivated,
                    styleProps = {
                        bottomContentPadding = {
                            Left = 0,
                            Right = 0,
                            Top = var3.Tokens.Padding.Small,
                            Bottom = var3.Tokens.Padding.Small
                        }
                    }
                })
            }
        ), `{str2}{arg1.experienceId}_`
    end, {
        var1,
        var2,
        var3.Tokens.Padding.Small,
        callback,
        str2
    }))
end
return useRenderSquareExperienceTile
