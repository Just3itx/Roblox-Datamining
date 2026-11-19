-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local t = require(CorePackages.Packages.t)

local playerInterface = require(RobloxGui.Modules.Interfaces.playerInterface)

local scriptParentParent = script.Parent.Parent
local Connection = scriptParentParent.Connection
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local useLayoutValues = PlayerList.Common.useLayoutValues

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagHidePremiumIconography = SharedFlags.FFlagHidePremiumIconography
local FFlagCoreUiMigrateUIBloxToFoundation = SharedFlags.FFlagCoreUiMigrateUIBloxToFoundation

local scriptParentParentParent = scriptParentParent.Parent
local FFlagPlayerListReduceRerenders = require(scriptParentParentParent.Flags.FFlagPlayerListReduceRerenders)
local FFlagPlayerListFoundationSubscriptionIcon = PlayerList.Flags.FFlagPlayerListFoundationSubscriptionIcon

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local function isFoundationImage(str1: string?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (str1 == nil or str1 == "") and str1:match("^%w+://.*$") == nil
end

local var1 = Roact.PureComponent:extend("PlayerIcon")

var1.validateProps = t.strictInterface({
    player = playerInterface,
    layoutOrder = t.optional(t.integer),
    isSmallTouchDevice = t.optional(t.boolean),
    playerIconInfo = t.strictInterface(
        {
            isPlaceOwner = t.boolean,
            avatarIcon = t.optional(t.table),
            specialGroupIcon = t.optional(t.table)
        }
    ),
    playerRelationship = t.strictInterface(
        {
            isBlocked = t.boolean,
            friendStatus = t.enum(Enum.FriendStatus),
            isFollowing = t.boolean,
            isFollower = t.boolean
        }
    ),
    layoutValues = t.optional(t.table)
})

local function getSocialIconImage(arg1, playerRelationship) -- Luacid: Inlined by compiler; 1 call site recovered
    local friendIcon = arg1.FriendIcons[playerRelationship.friendStatus]

    return if playerRelationship.isBlocked then arg1.BlockedIcon else friendIcon or nil
end

local function getIconImage(arg1, player, playerIconInfo, playerRelationship)
    local socialIconImage = getSocialIconImage(arg1, playerRelationship)

    if socialIconImage then
        return socialIconImage
    end

    if playerIconInfo.isPlaceOwner then
        return arg1.PlaceOwnerIcon
    end

    if arg1.CustomPlayerIcons[player.UserId] then
        return arg1.CustomPlayerIcons[player.UserId]
    end

    if playerIconInfo.specialGroupIcon then
        return playerIconInfo.specialGroupIcon
    end

    if playerRelationship.isFollowing then
        return arg1.FollowingIcon
    end

    local bool1 = player.MembershipType == Enum.MembershipType.Premium

    if FFlagEnableBlackbirdCheck then
        if game:GetEngineFeature("ReadHasRobloxSubscriptionLua") and player.HasRobloxSubscription then
            return arg1.SubscriptionIcon
        end

        if not FFlagHidePremiumIconography and bool1 then
            local membershipIcon = arg1.MembershipIcons[player.MembershipType]
            if membershipIcon then
                return membershipIcon
            end
        end
    elseif bool1 then
        local membershipIcon = arg1.MembershipIcons[player.MembershipType]
        if membershipIcon then
            return membershipIcon
        end
    end

    return ""
end

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        arg2 = arg1.props.layoutValues

        local avatarIcon = arg1.props.playerIconInfo and arg1.props.playerIconInfo.avatarIcon
        if avatarIcon == nil then
            avatarIcon = arg2.DefaultThumbnail
        end

        if arg2.IsTenFoot then
            return Roact.createElement("ImageLabel", {
                LayoutOrder = arg1.props.layoutOrder or 1,
                Size = arg2.PlayerIconBackgroundSize,
                BackgroundTransparency = 1,
                Image = arg2.PlayerBackgroundImage
            }, { Roact.createElement("ImageLabel", {
                    Size = arg2.PlayerIconSize,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Image = avatarIcon,
                    BorderSizePixel = 0
                }) })
        elseif arg1.props.isSmallTouchDevice then
            local image = getIconImage(arg2, arg1.props.player, arg1.props.playerIconInfo, arg1.props.playerRelationship)

            if not FFlagCoreUiMigrateUIBloxToFoundation
                and (not FFlagPlayerListFoundationSubscriptionIcon or typeof(image) ~= "table" or not image.isFoundationIcon)
            then
                return Roact.createElement(ImageSetLabel, {
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, arg2.PlayerNamePaddingXMobile, 0.5, 0),
                    Size = arg2.PlayerIconSizeMobile,
                    BackgroundTransparency = 1,
                    Image = image,
                    BorderSizePixel = 0
                })
            end

            local var2 = if typeof(image) == "table" then image.name else image

            if FFlagCoreUiMigrateUIBloxToFoundation then
                if typeof(image) == "table" and image.Image ~= nil then
                    var2 = image.Image
                end

                if not isFoundationImage(var2) then
                    local imageRect = typeof(image) == "table" and {
                        offset = image.ImageRectOffset,
                        size = image.ImageRectSize
                    } or nil

                    return Roact.createElement(Foundation.Image, {
                        Image = var2,
                        imageRect = imageRect,
                        Size = arg2.PlayerIconSizeMobile,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, arg2.PlayerNamePaddingXMobile, 0.5, 0)
                    })
                end
            end

            return Roact.createElement(Foundation.Icon, {
                name = var2,
                size = Foundation.Enums.IconSize.Medium,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, arg2.PlayerNamePaddingXMobile, 0.5, 0)
            })
        else
            local image = getIconImage(arg2, arg1.props.player, arg1.props.playerIconInfo, arg1.props.playerRelationship)

            if not FFlagCoreUiMigrateUIBloxToFoundation
                and (not FFlagPlayerListFoundationSubscriptionIcon or typeof(image) ~= "table" or not image.isFoundationIcon)
            then
                return Roact.createElement(ImageSetLabel, {
                    LayoutOrder = arg1.props.layoutOrder,
                    Size = arg2.PlayerIconSize,
                    BackgroundTransparency = 1,
                    Image = image,
                    BorderSizePixel = 0
                })
            end

            local var2 = if typeof(image) == "table" then image.name else image

            if FFlagCoreUiMigrateUIBloxToFoundation then
                if typeof(image) == "table" and image.Image ~= nil then
                    var2 = image.Image
                end

                if not isFoundationImage(var2) then
                    local imageRect = typeof(image) == "table" and {
                        offset = image.ImageRectOffset,
                        size = image.ImageRectSize
                    } or nil

                    return Roact.createElement(
                        Foundation.Image,
                        {
                            Image = var2,
                            imageRect = imageRect,
                            Size = arg2.PlayerIconSize,
                            LayoutOrder = arg1.props.layoutOrder
                        }
                    )
                end
            end
            return Roact.createElement(
                Foundation.Icon,
                {
                    name = var2,
                    size = Foundation.Enums.IconSize.Small,
                    LayoutOrder = arg1.props.layoutOrder
                }
            )
        end
    end)
end

local function mapStateToProps(arg1)
    return {
        isSmallTouchDevice = arg1.displayOptions.isSmallTouchDevice
    }
end

local function func1(arg1)
    local layoutValues = useLayoutValues()

    return React.createElement(var1, Cryo.Dictionary.join(arg1, { layoutValues = layoutValues }))
end

if FFlagPlayerListReduceRerenders then
    return React.memo(RoactRodux.connect(mapStateToProps, nil)(func1))
end

return RoactRodux.connect(mapStateToProps, nil)(func1)
