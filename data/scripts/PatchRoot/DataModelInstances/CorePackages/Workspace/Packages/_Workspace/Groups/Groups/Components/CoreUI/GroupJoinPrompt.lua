-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local Enums = require(GroupsParent.ProfilePlatform.Enums)

local Foundation = require(GroupsParent.Foundation)
local GetTextSize = require(GroupsParent.Style).GetTextSize
local Localization = require(GroupsParent.Localization)
local React = require(GroupsParent.React)
local UIBlox = require(GroupsParent.UIBlox)
local UserLib = require(GroupsParent.UserLib)
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = UserLib.Utils.Constants
local VerifiedBadges = require(GroupsParent.VerifiedBadges)

local MouseIconOverrideService = require(GroupsParent.CoreScriptsCommon).MouseIconOverrideService
local useScreenSize = require(GroupsParent.CoreScriptsRoactCommon).useScreenSize

local LoadableImage = UIBlox.App.Loading.LoadableImage

local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local useLocalization = Localization.Hooks.useLocalization
local useAbbreviatedNumberLocalization = Localization.Hooks.useAbbreviatedNumberLocalization

local FoundationText = Foundation.Text
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local useTokens = Foundation.Hooks.useTokens

local _Types = require(Groups.Common.Types)
local constants = require(Groups.Common.constants)

local tbl1 = {
    [Enums.DisabledReasons.BannedFromCommunity] = "subTextBannedFromCommunity",
    [Enums.DisabledReasons.CommunityIsClosed] = "subTextGroupClosed",
    [Enums.DisabledReasons.MaxCommunitiesJoined] = "subTextPremiumMaxGroups",
    [Enums.DisabledReasons.AccountCreatedLessThanOneDay] = "subTextRequiresAccountTenureTooltipOneDay",
    [Enums.DisabledReasons.AccountCreatedLessThanThreeDays] = "subTextRequiresAccountTenureTooltipThreeDays",
    [Enums.DisabledReasons.AccountCreatedLessThanOneWeek] = "subTextRequiresAccountTenureTooltipOneWeek",
    [Enums.DisabledReasons.AccountCreatedLessThanOneMonth] = "subTextRequiresAccountTenureTooltipOneMonth",
    [Enums.DisabledReasons.AccountCreatedLessThanThreeMonths] = "subTextRequiresAccountTenureTooltipThreeMonths",
    [Enums.DisabledReasons.InsufficientVerificationLevelHigh] = "subTextInsufficientVerificationLevelHigh",
    [Enums.DisabledReasons.InsufficientVerificationLevelMedium] = "subTextInsufficientVerificationLevelMedium",
    [Enums.DisabledReasons.InsufficientVerificationLevelLow] = "subTextInsufficientVerificationLevelLow"
}

return function(tbl2)
    local var1 = useTokens()
    local var2 = tbl2.enableInputDelayed == nil or tbl2.enableInputDelayed
    local var3 = if useScreenSize().Y < constants.SMALL_SCREEN_HEIGHT_THRESHOLD then constants.THUMBNAIL_SIZE_SMALL else constants.THUMBNAIL_SIZE
    local data = tbl2.data
    local bool1 = data == nil
    local groupName = if data then data.groupName else nil
    local ownerName = if data then data.ownerName else nil
    local ownerIsVerified = if data then data.ownerIsVerified else false
    local var4 = if data then data.membersCount else 0
    local isAlreadyMember = if data then data.isAlreadyMember else false
    local hasPendingRequest = if data then data.hasPendingRequest else false
    local isEligible = if data then data.isEligible else false
    local disabledReason = if data then data.disabledReason else nil
    local var5 = not data or data.hasSocialModules == nil or data.hasSocialModules

    local var6 = useLocalization({
        joinGroup = "Feature.Groups.Action.JoinGroup",
        followGroup = "Feature.Groups.Action.Follow",
        notNowButton = "Feature.Groups.Action.NotNow",
        closeButton = "Feature.Groups.Action.Close",
        titleJoin = {
            "Feature.Groups.Title.Join",
            groupName = groupName or ""
        },
        titleFollow = {
            "Feature.Groups.Title.Follow",
            groupName = groupName or ""
        },
        titleAlreadyRequested = {
            "Feature.Groups.Title.RequestedToJoin",
            groupName = groupName or ""
        },
        titleAlreadyMember = {
            "Feature.Groups.Title.AlreadyMember",
            groupName = groupName or ""
        },
        titleAlreadyFollowing = {
            "Feature.Groups.Title.AlreadyFollowing",
            groupName = groupName or ""
        },
        titleUnableToJoin = {
            "Feature.Groups.Title.UnableToJoin",
            groupName = groupName or ""
        },
        ownerBy = {
            "Feature.Groups.Label.ByOwnerWithFormat",
            ownerName = ownerName or ""
        },
        members = "Feature.Groups.Heading.Members",
        followers = "Feature.Groups.Heading.Followers",
        subTextPendingRequest = "Feature.Groups.Description.JoinGroupPending",
        subTextBannedFromCommunity = "Feature.Groups.Message.BannedFromGroup",
        subTextGroupClosed = "Feature.Groups.Message.GroupClosed",
        subTextPremiumMaxGroups = "Feature.Groups.Description.PremiumMaxGroups",
        subTextRequiresAccountTenureTooltipOneDay = "Feature.Groups.Description.RequiresAccountTenureTooltipOneDay",
        subTextRequiresAccountTenureTooltipThreeDays = "Feature.Groups.Description.RequiresAccountTenureTooltipThreeDays",
        subTextRequiresAccountTenureTooltipOneWeek = "Feature.Groups.Description.RequiresAccountTenureTooltipOneWeek",
        subTextRequiresAccountTenureTooltipOneMonth = "Feature.Groups.Description.RequiresAccountTenureTooltipOneMonth",
        subTextRequiresAccountTenureTooltipThreeMonths = "Feature.Groups.Description.RequiresAccountTenureTooltipThreeMonths",
        subTextInsufficientVerificationLevelHigh = "Feature.Groups.Modal.ContentTextHigh",
        subTextInsufficientVerificationLevelMedium = "Feature.Groups.Modal.ContentTextMedium",
        subTextInsufficientVerificationLevelLow = "Feature.Groups.Modal.ContentTextLow",
        subTextNotEligible = "Feature.Groups.Description.NotEligibleToJoin"
    })

    React.useEffect(function()
        MouseIconOverrideService.push("GroupJoinPromptOverride", Enum.OverrideMouseIconBehavior.ForceShow)

        return function()
            MouseIconOverrideService.pop("GroupJoinPromptOverride")
        end
    end, {})

    local ref = React.useRef(nil)
    local x, var8 = React.useState(nil)
    local var7 = React.useRef(nil)
    local var10, var11 = React.useState(nil)

    React.useEffect(function()
        local connection = nil
        if ref.current then
            local current = ref.current
            if current.AbsoluteSize.X > 0 then
                var8(current.AbsoluteSize.X)
            end
            connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                if current.AbsoluteSize.X > 0 and current.AbsoluteSize.X ~= x then
                    var8(current.AbsoluteSize.X)
                end
            end)
        end
        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { x })

    React.useEffect(function()
        local connection = nil
        if var7.current then
            local current = var7.current
            if current.AbsoluteSize.X > 0 then
                var11(current.AbsoluteSize.X)
            end
            connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                if current.AbsoluteSize.X > 0 and current.AbsoluteSize.X ~= var10 then
                    var11(current.AbsoluteSize.X)
                end
            end)
        end
        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { var10 })

    local var12 = React.useMemo(function()
        if hasPendingRequest then
            return var6.subTextPendingRequest
        end

        if isAlreadyMember or isEligible or not disabledReason then
            return nil
        end

        local disabledReason2 = Enums.DisabledReasons[disabledReason]
        if disabledReason2 then
            local var12 = tbl1[disabledReason2]
            if var12 then
                return var6[var12]
            end
        end

        return var6.subTextNotEligible
    end, {
        var6,
        isAlreadyMember,
        hasPendingRequest,
        isEligible,
        disabledReason
    })
    local var13 = React.useMemo(function()
        if bool1 then
            return nil
        end

        local var13 = if var5 then var6.titleJoin else var6.titleFollow

        if isAlreadyMember then
            if var5 then
                var13 = var6.titleAlreadyMember
            else
                var13 = var6.titleAlreadyFollowing
            end
        elseif hasPendingRequest then
            var13 = var6.titleAlreadyRequested
        elseif not isEligible then
            var13 = var6.titleUnableToJoin
        end

        return var13 or groupName
    end, {
        var6,
        groupName,
        isAlreadyMember,
        hasPendingRequest,
        isEligible,
        var5,
        bool1
    })

    local font = var1.Typography.HeadingSmall.Font
    local fontSize = var1.Typography.HeadingSmall.FontSize
    local font2 = var1.Typography.BodyMedium.Font
    local fontSize2 = var1.Typography.BodyMedium.FontSize
    local medium = var1.Padding.Medium

    local title = React.useMemo(function()
        if var13 and var13 ~= "" and x and x > 0 then
            return (GetTextSize(var13, fontSize, font, Vector2.new(x, math.huge), { addTemporaryPadding = false }))
        end
        return nil
    end, {
        var13,
        x,
        font,
        fontSize
    })

    local subText = React.useMemo(function()
        if var12 and var10 and var10 > 0 then
            local x2 = var10 - medium * 2
            if x2 > 0 then
                return (GetTextSize(var12, fontSize2, font2, Vector2.new(x2, math.huge), { addTemporaryPadding = false }))
            end
        end
        return nil
    end, {
        var12,
        var10,
        font2,
        fontSize2,
        medium
    })
    local var16 = React.useMemo(function()
        local result = {}
        if title then
            result.title = title
        end
        if subText then
            result.subText = subText
        end
        return result
    end, { title, subText })

    local image = if tbl2.groupId then getRbxthumbWithTypeSizeAndOptions(tostring(tbl2.groupId), Constants.RbxthumbTypes.GroupIcon, constants.THUMBNAIL_SIZE) else nil

    local var17 = React.useCallback(function()
        if not image then
            return nil
        end

        return (React.createElement(View, {
            tag = "col size-full-0 auto-y align-x-center",
            LayoutOrder = 0
        }, {
            UIPadding = React.createElement(
                "UIPadding",
                {
                    PaddingTop = UDim.new(0, var1.Padding.Medium),
                    PaddingBottom = UDim.new(0, var1.Padding.Medium)
                }
            ),
            ImageContainer = React.createElement(View, {
                Size = UDim2.new(0, var3, 0, var3)
            }, {
                UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(var3, var3) }),
                LoadableImage = React.createElement(LoadableImage, {
                    Size = UDim2.fromScale(1, 1),
                    Image = image,
                    BackgroundTransparency = 1,
                    useShimmerAnimationWhileLoading = true,
                    showFailedStateWhenLoadingFailed = true,
                    cornerRadius = UDim.new(0, var1.Radius.Medium)
                })
            })
        }))
    end, { image, var1, var3 })

    local var18 = React.useCallback(function()
        local createElement = React.createElement
        local var18 = View
        local tbl3 = { tag = "col size-full-0 auto-y", LayoutOrder = 1, ref = ref }
        local tbl4 = { TitleText = 0 }
        local element

        if var13 and var13 ~= "" and not bool1 and var16 and var16.title then
            element = React.createElement(FoundationText, {
                tag = "text-align-x-left",
                Text = var13,
                TextWrapped = true,
                fontStyle = var1.Typography.HeadingSmall,
                textStyle = var1.Color.Content.Emphasis,
                Size = UDim2.fromOffset(math.ceil(var16.title.X), math.ceil(var16.title.Y)),
                AutomaticSize = Enum.AutomaticSize.None
            }, {
                UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(not x and math.huge or x, math.huge) })
            })
        elseif var13 and var13 ~= "" and not bool1 then
            element = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-align-x-left",
                Text = var13,
                TextWrapped = true,
                fontStyle = var1.Typography.HeadingSmall,
                textStyle = var1.Color.Content.Emphasis
            })
        elseif bool1 then
            element = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, fontSize) })
        else
            element = nil
        end

        tbl4.TitleText = element
        return createElement(var18, tbl3, tbl4)
    end, {
        var13,
        bool1,
        var16,
        x,
        var1,
        ref,
        fontSize
    })
    local var19 = React.useCallback(function()
        if ownerName == nil or ownerName == "" or bool1 then
            if bool1 then
                return (React.createElement(View, {
                    tag = "col size-full-0 auto-y",
                    LayoutOrder = 2
                }, {
                    UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, var1.Padding.XSmall) }),
                    Shimmer = React.createElement(Skeleton, { Size = UDim2.new(0.6, 0, 0, fontSize2) })
                }))
            end
            return nil
        end

        return (React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = 2 }, {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, var1.Padding.XSmall) }),
            Content = React.createElement(VerifiedBadges.EmojiWrapper, {
                emoji = if ownerIsVerified then VerifiedBadges.emoji.verified else "",
                size = UDim2.new(1, 0, 0, 0),
                automaticSize = Enum.AutomaticSize.Y,
                horizontalAlignment = Enum.HorizontalAlignment.Left
            }, {
                Text = React.createElement(
                    FoundationText,
                    {
                        tag = "size-full-0 auto-y text-body-medium text-align-x-left",
                        Text = var6.ownerBy,
                        TextWrapped = true
                    }
                )
            })
        }))
    end, {
        ownerName,
        ownerIsVerified,
        bool1,
        var1,
        var6,
        fontSize2
    })
    local var20 = useAbbreviatedNumberLocalization(var4)

    local var21 = React.useCallback(function()
        local createElement = React.createElement
        local var21 = View
        local tbl3 = { tag = "col size-full-0 auto-y", LayoutOrder = 3, ref = var7 }
        local tbl4 = {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, var1.Padding.Medium) }),
            Content = 0
        }
        local element

        if bool1 then
            element = React.createElement(Skeleton, { Size = UDim2.new(0.4, 0, 0, fontSize2) })
        elseif var12 ~= nil and var16 and var16.subText then
            element = React.createElement(FoundationText, {
                tag = "text-body-medium text-align-x-left",
                Text = var12,
                TextWrapped = true,
                Size = UDim2.fromOffset(math.ceil(var16.subText.X), math.ceil(var16.subText.Y)),
                AutomaticSize = Enum.AutomaticSize.None
            }, {
                UISizeConstraint = React.createElement(
                    "UISizeConstraint",
                    {
                        MaxSize = Vector2.new(not var10 and math.huge or var10 - var1.Padding.Medium * 2, math.huge)
                    }
                )
            })
        elseif var12 ~= nil then
            element = React.createElement(
                FoundationText,
                {
                    tag = "size-full-0 auto-y text-body-medium text-align-x-left",
                    Text = var12,
                    TextWrapped = true
                }
            )
        elseif var4 and var4 > 0 then
            element = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-body-medium text-align-x-left",
                Text = var20 .. " " .. (if var5 then var6.members else var6.followers),
                TextWrapped = true
            })
        else
            element = nil
        end

        tbl4.Content = element
        return createElement(var21, tbl3, tbl4)
    end, {
        bool1,
        var12,
        var16,
        var10,
        var1,
        var4,
        var20,
        var5,
        var6,
        var7,
        fontSize2
    })

    local var22, var23 = React.useState(false)

    local onActivated = React.useCallback(function()
        if var22 then
            return
        end

        var23(true)
        if tbl2.onJoin then
            tbl2.onJoin()
        end
    end, { tbl2.onJoin })

    local var25 = React.useCallback(function()
        if not var22 and tbl2.onClose then
            tbl2.onClose()
        end
    end, { tbl2.onClose, var22 })

    local actions = React.useMemo(function()
        if bool1 then
            return {{
                variant = ButtonVariant.Standard,
                isLoading = true,
                isDisabled = true
            }}
        end

        if isAlreadyMember or not isEligible or hasPendingRequest then
            return {{
                variant = ButtonVariant.Standard,
                text = var6.closeButton,
                onActivated = var25,
                isDisabled = var22
            }}
        end

        return {
            {
                variant = ButtonVariant.Emphasis,
                text = var5 and var6.joinGroup or var6.followGroup,
                onActivated = onActivated,
                inputDelay = if var2 then constants.ACCEPT_DELAY_SECONDS else nil,
                isLoading = var22,
                isDisabled = var22
            },
            {
                variant = ButtonVariant.Standard,
                text = var6.notNowButton,
                onActivated = var25,
                isDisabled = var22
            }
        }
    end, {
        var6,
        onActivated,
        var25,
        var2,
        hasPendingRequest,
        isEligible,
        isAlreadyMember,
        var22,
        var5
    })

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small,
        onClose = var25
    }, {
        DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 1 }, {
            Content = React.createElement(View, { tag = "col size-full-0 auto-y" }, {
                UIListLayout = React.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 0)
                    }
                ),
                GroupImage = var17(),
                Title = var18(),
                OwnerName = var19(),
                SubContent = var21()
            })
        }),
        DialogActions = React.createElement(Dialog.Actions, { LayoutOrder = 2, actions = actions })
    })
end
