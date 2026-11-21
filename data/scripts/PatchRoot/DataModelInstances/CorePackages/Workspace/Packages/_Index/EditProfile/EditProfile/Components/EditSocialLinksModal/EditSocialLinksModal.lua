-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local React = require(EditProfileParent.React)
local UIBlox = require(EditProfileParent.UIBlox)
local normalizeFontFace = require(EditProfileParent.Foundation).Utility.normalizeFontFace
local useStyle = UIBlox.Core.Style.useStyle
local EditSocialNetworksItem = require(EditProfile.Components.EditSocialNetworksItem)
local DropdownMenu = UIBlox.App.Menu.DropdownMenu
local VerticalScrollView = UIBlox.App.Container.VerticalScrollView
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local TextKeys = require(EditProfile.Common.TextKeys)
local useScreenSize = require(EditProfileParent.RobloxAppHooks).useScreenSize
local useNavigationProps = require(EditProfileParent.RobloxAppNavigation).useNavigationProps
local Constants = require(EditProfile.Common.Constants)
local _Types = require(EditProfile.Common.Types)
local SocialNetworksInEditProfileIXP = require(EditProfile.Flags.SocialNetworksInEditProfileIXP)
local FFlagEditProfileFixFocusNavigation = require(EditProfile.Flags.FFlagEditProfileFixFocusNavigation)
local FocusNavigatorWrapper = require(EditProfile.Utils.FocusNavigatorWrapper)

return function(tbl1)
    local initialText, textChanged = React.useState(tbl1.socialNetworks.facebook)
    local var1, var2 = React.useState(tbl1.socialNetworks.twitter)
    local var3, var4 = React.useState(tbl1.socialNetworks.youtube)
    local var5, var6 = React.useState(tbl1.socialNetworks.twitch)
    local var7, var8 = React.useState(tbl1.socialNetworks.guilded)
    local defaultKey, var12 = React.useState(tbl1.socialNetworksVisbility)
    local var13, setKeyboardOffset = React.useState(0)
    local isVisibilityNoOne = defaultKey == Constants.VisibilitySettings.NoOne
    local var15 = useLocalization({
        cancelButtonText = TextKeys.CancelButtonText,
        saveButtonText = TextKeys.SaveButtonText,
        socialNetworks = TextKeys.SocialNetworks,
        Facebook = TextKeys.Facebook,
        X = TextKeys.X,
        YouTube = TextKeys.YouTube,
        Twitch = TextKeys.Twitch,
        Guilded = TextKeys.Guilded,
        FacebookExample = TextKeys.FacebookExample,
        TwitterExample = TextKeys.TwitterExample,
        YouTubeExample = TextKeys.YouTubeExample,
        TwitchExample = TextKeys.TwitchExample,
        GuildedExample = TextKeys.GuildedExample,
        AllUsers = TextKeys.AllUsersDropDown,
        Friends = TextKeys.FriendsDropDown,
        NoOne = TextKeys.NoOneDropDown,
        FriendsFollowingAndFollowers = TextKeys.FriendsFollowingAndFollowersDropDown,
        FriendsAndFollowing = TextKeys.FriendsAndFollowingDropDown,
        VisibleTo = TextKeys.VisibleTo
    })
    local var16 = useNavigationProps(function(_, arg1)
        return {
            focusOn = arg1.focusOn
        }
    end)

    local var17 = SocialNetworksInEditProfileIXP.useGetExperimentVariant({ isExposureEnabled = true })

    local var18 = useStyle()
    local font = var18.Font
    local theme = var18.Theme
    local textSize = font.BaseSize * font.Body.RelativeSize
    local screenSize = useScreenSize()

    local function onSave()
        tbl1.saveOnActivated(defaultKey, initialText, var1, var3, var5, var7)
    end

    local onChange = React.useCallback(function(arg1)
        var12(arg1)
    end, {})

    if FFlagEditProfileFixFocusNavigation then
        return FocusNavigatorWrapper({
            onClose = tbl1.cancelOnActivated
        }, {
            React.createElement(
                VerticalScrollView,
                {
                    useAutomaticCanvasSize = true,
                    canvasSizeY = UDim.new(),
                    elasticBehavior = Enum.ElasticBehavior.Never
                },
                {
                    React.createElement(InteractiveAlert, {
                        title = var15.socialNetworks,
                        screenSize = screenSize,
                        anchorPoint = Vector2.new(0.5, 0),
                        position = UDim2.new(0.5, 0, 0, 30 + var13),
                        middleContent = function()
                            local createElement = React.createElement
                            local tbl2 = {
                                BackgroundTransparency = 1,
                                AutomaticSize = Enum.AutomaticSize.XY
                            }
                            local tbl3 = {
                                UIListLayout = React.createElement("UIListLayout", {
                                    FillDirection = Enum.FillDirection.Vertical,
                                    VerticalAlignment = Enum.VerticalAlignment.Center,
                                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                                    SortOrder = Enum.SortOrder.LayoutOrder
                                }),
                                Facebook = React.createElement(EditSocialNetworksItem, {
                                    textChanged = textChanged,
                                    networkTitle = var15.Facebook,
                                    initialText = initialText,
                                    placeholderText = var15.FacebookExample,
                                    layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 1 else 2,
                                    focusOn = var16.focusOn == 1,
                                    isVisibilityNoOne = isVisibilityNoOne,
                                    setKeyboardOffset = setKeyboardOffset
                                }),
                                Twitter = React.createElement(EditSocialNetworksItem, {
                                    textChanged = var2,
                                    networkTitle = var15.X,
                                    initialText = var1,
                                    placeholderText = var15.TwitterExample,
                                    layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 2 else 3,
                                    focusOn = var16.focusOn == 2,
                                    isVisibilityNoOne = isVisibilityNoOne,
                                    setKeyboardOffset = setKeyboardOffset
                                }),
                                YouTube = React.createElement(EditSocialNetworksItem, {
                                    textChanged = var4,
                                    networkTitle = var15.YouTube,
                                    initialText = var3,
                                    placeholderText = var15.YouTubeExample,
                                    layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 3 else 4,
                                    focusOn = var16.focusOn == 3,
                                    isVisibilityNoOne = isVisibilityNoOne,
                                    setKeyboardOffset = setKeyboardOffset
                                }),
                                Twitch = React.createElement(EditSocialNetworksItem, {
                                    textChanged = var6,
                                    networkTitle = var15.Twitch,
                                    initialText = var5,
                                    placeholderText = var15.TwitchExample,
                                    layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 4 else 5,
                                    focusOn = var16.focusOn == 4,
                                    isVisibilityNoOne = isVisibilityNoOne,
                                    setKeyboardOffset = setKeyboardOffset
                                }),
                                Guilded = React.createElement(EditSocialNetworksItem, {
                                    textChanged = var8,
                                    networkTitle = var15.Guilded,
                                    initialText = var7,
                                    placeholderText = var15.GuildedExample,
                                    layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 5 else 6,
                                    focusOn = var16.focusOn == 5,
                                    isVisibilityNoOne = isVisibilityNoOne,
                                    setKeyboardOffset = setKeyboardOffset
                                }),
                                Visibility = 0
                            }

                            local createElement2 = React.createElement
                            local tbl4 = {
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 0),
                                AutomaticSize = Enum.AutomaticSize.Y,
                                LayoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 6 else 1,
                                ZIndex = 2
                            }

                            local tbl5 = {
                                UIListLayout = React.createElement(
                                    "UIListLayout",
                                    {
                                        FillDirection = Enum.FillDirection.Vertical,
                                        SortOrder = Enum.SortOrder.LayoutOrder,
                                        Padding = UDim.new(0, 12)
                                    }
                                ),
                                NetworkLabel = React.createElement("TextLabel", {
                                    LayoutOrder = -1,
                                    BackgroundTransparency = 1,
                                    FontFace = normalizeFontFace(var18.Tokens.Typography.BodyLarge.Font),
                                    Text = var15.VisibleTo,
                                    TextSize = textSize,
                                    TextColor3 = theme.TextDefault.Color,
                                    AutomaticSize = Enum.AutomaticSize.XY,
                                    RichText = true,
                                    ZIndex = 0
                                }),
                                Dropdown = React.createElement(DropdownMenu, {
                                    placeholder = var15[defaultKey],
                                    onChange = onChange,
                                    screenSize = Vector2.new(math.clamp(screenSize.X - 48, 272, 400) - 48, 640),
                                    height = UDim.new(0, textSize + 20),
                                    dropdownMenuListPositionFixed = true,
                                    cellDatas = {
                                        {
                                            text = var15.AllUsers,
                                            key = Constants.VisibilitySettings.AllUsers
                                        },
                                        {
                                            text = var15.FriendsFollowingAndFollowers,
                                            key = Constants.VisibilitySettings.FriendsFollowingAndFollowers
                                        },
                                        {
                                            text = var15.FriendsAndFollowing,
                                            key = Constants.VisibilitySettings.FriendsAndFollowing
                                        },
                                        {
                                            text = var15.Friends,
                                            key = Constants.VisibilitySettings.Friends
                                        },
                                        {
                                            text = var15.NoOne,
                                            key = Constants.VisibilitySettings.NoOne
                                        }
                                    },
                                    showDropShadow = true,
                                    defaultKey = defaultKey
                                })
                            }
                            tbl3.Visibility = createElement2("Frame", tbl4, tbl5)
                            return createElement("Frame", tbl2, tbl3)
                        end,
                        buttonStackInfo = {
                            buttons = {
                                {
                                    buttonType = ButtonType.Secondary,
                                    props = {
                                        onActivated = tbl1.cancelOnActivated,
                                        text = var15.cancelButtonText
                                    }
                                },
                                {
                                    buttonType = ButtonType.PrimarySystem,
                                    props = {
                                        onActivated = onSave,
                                        text = var15.saveButtonText
                                    }
                                }
                            },
                            buttonHeight = 48,
                            marginBetween = 6,
                            forcedFillDirection = Enum.FillDirection.Horizontal
                        }
                    })
                }
            )
        })
    end

    return React.createElement(
        VerticalScrollView,
        {
            useAutomaticCanvasSize = true,
            canvasSizeY = UDim.new(),
            elasticBehavior = Enum.ElasticBehavior.Never
        },
        {
            React.createElement(InteractiveAlert, {
                title = var15.socialNetworks,
                screenSize = screenSize,
                anchorPoint = Vector2.new(0.5, 0),
                position = UDim2.new(0.5, 0, 0, 30 + var13),
                middleContent = function()
                    local createElement = React.createElement
                    local tbl2 = {
                        BackgroundTransparency = 1,
                        AutomaticSize = Enum.AutomaticSize.XY
                    }
                    local tbl3 = {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Vertical,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Left,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }),
                        Facebook = React.createElement(EditSocialNetworksItem, {
                            textChanged = textChanged,
                            networkTitle = var15.Facebook,
                            initialText = initialText,
                            placeholderText = var15.FacebookExample,
                            layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 1 else 2,
                            focusOn = var16.focusOn == 1,
                            isVisibilityNoOne = isVisibilityNoOne,
                            setKeyboardOffset = setKeyboardOffset
                        }),
                        Twitter = React.createElement(EditSocialNetworksItem, {
                            textChanged = var2,
                            networkTitle = var15.X,
                            initialText = var1,
                            placeholderText = var15.TwitterExample,
                            layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 2 else 3,
                            focusOn = var16.focusOn == 2,
                            isVisibilityNoOne = isVisibilityNoOne,
                            setKeyboardOffset = setKeyboardOffset
                        }),
                        YouTube = React.createElement(EditSocialNetworksItem, {
                            textChanged = var4,
                            networkTitle = var15.YouTube,
                            initialText = var3,
                            placeholderText = var15.YouTubeExample,
                            layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 3 else 4,
                            focusOn = var16.focusOn == 3,
                            isVisibilityNoOne = isVisibilityNoOne,
                            setKeyboardOffset = setKeyboardOffset
                        }),
                        Twitch = React.createElement(EditSocialNetworksItem, {
                            textChanged = var6,
                            networkTitle = var15.Twitch,
                            initialText = var5,
                            placeholderText = var15.TwitchExample,
                            layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 4 else 5,
                            focusOn = var16.focusOn == 4,
                            isVisibilityNoOne = isVisibilityNoOne,
                            setKeyboardOffset = setKeyboardOffset
                        }),
                        Guilded = React.createElement(EditSocialNetworksItem, {
                            textChanged = var8,
                            networkTitle = var15.Guilded,
                            initialText = var7,
                            placeholderText = var15.GuildedExample,
                            layoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 5 else 6,
                            focusOn = var16.focusOn == 5,
                            isVisibilityNoOne = isVisibilityNoOne,
                            setKeyboardOffset = setKeyboardOffset
                        }),
                        Visibility = 0
                    }

                    local createElement2 = React.createElement
                    local tbl4 = {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = if var17 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then 6 else 1,
                        ZIndex = 2
                    }

                    local tbl5 = {
                        UIListLayout = React.createElement(
                            "UIListLayout",
                            {
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                Padding = UDim.new(0, 12)
                            }
                        ),
                        NetworkLabel = React.createElement("TextLabel", {
                            LayoutOrder = -1,
                            BackgroundTransparency = 1,
                            FontFace = normalizeFontFace(var18.Tokens.Typography.BodyLarge.Font),
                            Text = var15.VisibleTo,
                            TextSize = textSize,
                            TextColor3 = theme.TextDefault.Color,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            RichText = true,
                            ZIndex = 0
                        }),
                        Dropdown = React.createElement(DropdownMenu, {
                            placeholder = var15[defaultKey],
                            onChange = onChange,
                            screenSize = Vector2.new(math.clamp(screenSize.X - 48, 272, 400) - 48, 640),
                            height = UDim.new(0, textSize + 20),
                            dropdownMenuListPositionFixed = true,
                            cellDatas = {
                                {
                                    text = var15.AllUsers,
                                    key = Constants.VisibilitySettings.AllUsers
                                },
                                {
                                    text = var15.FriendsFollowingAndFollowers,
                                    key = Constants.VisibilitySettings.FriendsFollowingAndFollowers
                                },
                                {
                                    text = var15.FriendsAndFollowing,
                                    key = Constants.VisibilitySettings.FriendsAndFollowing
                                },
                                {
                                    text = var15.Friends,
                                    key = Constants.VisibilitySettings.Friends
                                },
                                {
                                    text = var15.NoOne,
                                    key = Constants.VisibilitySettings.NoOne
                                }
                            },
                            showDropShadow = true,
                            defaultKey = defaultKey
                        })
                    }
                    tbl3.Visibility = createElement2("Frame", tbl4, tbl5)
                    return createElement("Frame", tbl2, tbl3)
                end,
                buttonStackInfo = {
                    buttons = {
                        {
                            buttonType = ButtonType.Secondary,
                            props = {
                                onActivated = tbl1.cancelOnActivated,
                                text = var15.cancelButtonText
                            }
                        },
                        {
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                onActivated = onSave,
                                text = var15.saveButtonText
                            }
                        }
                    },
                    buttonHeight = 48,
                    marginBetween = 6,
                    forcedFillDirection = Enum.FillDirection.Horizontal
                }
            })
        }
    )
end
