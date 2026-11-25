-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local React = require(PurchasePromptParent.React)
local getFirstFocusableDescendant = require(PurchasePromptParent.FocusNavigationUtils).getFirstFocusableDescendant
local Foundation = require(PurchasePromptParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Avatar = Foundation.Avatar
local Button = Foundation.Button
local TextInput = Foundation.TextInput
local SearchInput = Foundation.SearchInput
local Toggle = Foundation.Toggle
local Chip = Foundation.Chip
local Menu = Foundation.Menu
local ScrollView = Foundation.ScrollView
local useTokens = Foundation.Hooks.useTokens
local Sheet = Foundation.Sheet
local AvatarSize = Foundation.Enums.AvatarSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local InputFocusBehavior = Foundation.Enums.InputFocusBehavior
local InputSize = Foundation.Enums.InputSize

local function renderPlayerRow(viewProps, tbl1, layoutOrder: number)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "row align-y-center gap-medium size-full-0 auto-y",
        LayoutOrder = layoutOrder
    }
    local tbl3 = {
        Avatar = React.createElement(Avatar, { userId = tbl1.userId, size = AvatarSize.Small, LayoutOrder = 1 }),
        Name = React.createElement(FoundationText, {
            Text = tbl1.displayName,
            tag = "fill auto-xy text-body-medium text-align-x-left text-truncate-end content-default",
            LayoutOrder = 2
        }),
        AddButton = React.createElement(Button, {
            testId = `--purchase-prompt-button-add-player-{tbl1.userId}`,
            text = viewProps.locales.add,
            icon = if tbl1.isAdded then IconName.Check else IconName.PlusLarge,
            variant = if tbl1.isAdded then ButtonVariant.SoftEmphasis else ButtonVariant.Standard,
            size = InputSize.Small,
            onActivated = tbl1.onToggleAdded,
            LayoutOrder = 3
        })
    }
    return createElement(var1, tbl2, tbl3)
end

local function renderPlayerList(viewProps)
    local result = {}
    for k, player in viewProps.players do
        result[`Player{player.userId}`] = renderPlayerRow(viewProps, player, k)
    end
    if #viewProps.players == 0 then
        result.Empty = React.createElement(
            FoundationText,
            {
                Text = viewProps.locales.noOne,
                tag = "auto-xy text-body-medium text-align-x-left content-muted"
            }
        )
    end

    result.MaxHeight = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(math.huge, 180) })

    return result
end

local function renderAddedPlayerChips(viewProps)
    if #viewProps.addedPlayers == 0 then
        return nil
    end

    local tbl1 = ({})
    for layoutOrder, addedPlayer in viewProps.addedPlayers do
        local str1 = `Added{addedPlayer.userId}`
        tbl1[str1] = React.createElement(Chip, {
            testId = `--purchase-prompt-chip-added-player-{addedPlayer.userId}`,
            text = addedPlayer.displayName,
            leading = {
                type = "AvatarGroup",
                props = {
                    avatars = { addedPlayer.userId }
                }
            },
            trailing = IconName.X,
            onActivated = addedPlayer.onRemove,
            LayoutOrder = layoutOrder
        })
    end
    return React.createElement(View, { tag = "row wrap gap-small size-full-0 auto-y", LayoutOrder = 3 }, tbl1)
end

local function PeopleSearch(tbl1)
    local viewProps = tbl1.viewProps
    local var1 = React.useRef(nil)
    local offset, var2 = React.useState(0)
    local var3, var4 = React.useState(nil)

    local searchResults = viewProps.searchResults

    local items = React.useMemo(function()
        local result = {}
        for k, searchResult in searchResults do
            table.insert(result, {
                id = searchResult.userId,
                text = searchResult.displayName,
                leading = {
                    type = "Avatar",
                    userId = searchResult.userId
                },
                ref = if k == 1 then var4 else nil
            })
        end

        return result
    end, { searchResults })

    local onActivated = React.useCallback(function(userId)
        for _, searchResult in searchResults do
            if searchResult.userId == userId then
                searchResult.onSelected()
                return
            end
        end
    end, { searchResults })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize.X)
    end, {})

    React.useEffect(function()
        local nextSelectionUp = if var1.current then getFirstFocusableDescendant(var1.current) else nil
        local nextSelectionDown = var3
        if nextSelectionUp == nil or nextSelectionDown == nil then
            return nil
        end
        nextSelectionUp.NextSelectionDown = nextSelectionDown
        nextSelectionDown.NextSelectionUp = nextSelectionUp
        return function()
            nextSelectionUp.NextSelectionDown = nil
            nextSelectionDown.NextSelectionUp = nil
        end
    end, { var3 })

    return React.createElement(View, {
        tag = "size-full-0 auto-y",
        ref = var1,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        LayoutOrder = tbl1.LayoutOrder
    }, {
        Search = React.createElement(SearchInput, {
            testId = "--purchase-prompt-searchinput-people",
            text = viewProps.searchText,
            placeholder = viewProps.locales.searchPeople,
            onChanged = viewProps.onSearchTextChanged,
            width = UDim.new(1, 0)
        }),
        Results = React.createElement(Menu, {
            testId = "--purchase-prompt-menu-search-results",
            isOpen = viewProps.isSearchMenuOpen,
            items = items,
            anchorRef = var1,
            width = UDim.new(0, offset),
            maxHeight = 240,
            onPressedOutside = viewProps.onSearchMenuDismissed,
            onActivated = onActivated
        })
    })
end

local function renderPrivateServerLink(viewProps)
    local createElement = React.createElement
    local var1 = View
    local tbl1 = { tag = "col gap-small size-full-0 auto-y", LayoutOrder = 4 }

    local tbl2 = {
        Header = React.createElement(View, {
            tag = "row align-y-center gap-medium size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Text = React.createElement(View, { tag = "col fill gap-xsmall auto-y", LayoutOrder = 1 }, {
                Heading = React.createElement(
                    FoundationText,
                    {
                        Text = viewProps.locales.privateServerLink,
                        tag = "auto-xy text-heading-small content-emphasis",
                        LayoutOrder = 1
                    }
                ),
                Description = React.createElement(
                    FoundationText,
                    {
                        Text = viewProps.locales.anyoneWithThisLinkCanJoin,
                        tag = "auto-xy text-body-small content-muted",
                        LayoutOrder = 2
                    }
                )
            }),
            Generate = if viewProps.link == nil then React.createElement(Button, {
                testId = "--purchase-prompt-button-generate-link",
                text = viewProps.locales.generate,
                variant = ButtonVariant.Standard,
                size = InputSize.Small,
                isLoading = viewProps.isGeneratingLink,
                onActivated = viewProps.onGenerateLink,
                LayoutOrder = 2
            }) else nil
        }),
        Field = 0
    }

    local createElement2 = React.createElement
    local var2 = TextInput
    local tbl3 = {
        testId = "--purchase-prompt-textinput-link",
        label = "",
        text = viewProps.linkText,
        placeholder = viewProps.locales.generateLinkPlaceholder,
        onChanged = viewProps.onLinkTextChanged,
        isDisabled = viewProps.link == nil,
        focusBehavior = InputFocusBehavior.Highlight,
        iconTrailing = if viewProps.link then {
            name = if viewProps.isLinkCopied then IconName.Check else IconName.TwoStackedSquares,
            onActivated = viewProps.onCopyLink
        } else nil,
        width = UDim.new(1, 0),
        LayoutOrder = 2
    }
    tbl2.Field = createElement2(var2, tbl3)
    return createElement(var1, tbl1, tbl2)
end

local function VIPServerConfigurationView(viewProps)
    local var1 = useTokens()

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl1 = {
        onClose = viewProps.onDismiss,
        preferCenterSheet = true,
        ref = viewProps.focusRootRef,
        testId = "VIPServerConfigurationView"
    }
    local tbl2 = {
        Header = React.createElement(Sheet.Header, {}, {
            Title = React.createElement(
                FoundationText,
                {
                    Text = viewProps.locales.title,
                    tag = "auto-xy text-heading-small text-align-x-left content-default"
                }
            )
        }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local tbl3 = { LayoutOrder = 2 }

    local tbl4 = {
        Body = React.createElement(View, { tag = "col gap-large size-full-0 auto-y" }, {
            ServerName = React.createElement(TextInput, {
                testId = "--purchase-prompt-textinput-server-name",
                label = viewProps.locales.serverName,
                text = viewProps.serverName,
                onChanged = viewProps.onServerNameChanged,
                width = UDim.new(1, 0),
                LayoutOrder = 1
            }),
            WhoCanJoin = React.createElement(View, {
                tag = "col gap-small size-full-0 auto-y",
                LayoutOrder = 2
            }, {
                Heading = React.createElement(
                    FoundationText,
                    {
                        Text = viewProps.locales.whoCanJoin,
                        tag = "auto-xy text-heading-small content-emphasis",
                        LayoutOrder = 1
                    }
                ),
                Search = React.createElement(PeopleSearch, { viewProps = viewProps, LayoutOrder = 2 }),
                AddedPlayers = renderAddedPlayerChips(viewProps),
                InThisServer = React.createElement(
                    FoundationText,
                    {
                        Text = viewProps.locales.inThisServer,
                        tag = "auto-xy text-title-small content-default",
                        LayoutOrder = 4
                    }
                ),
                PlayerList = React.createElement(ScrollView, {
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    layout = {
                        FillDirection = Enum.FillDirection.Vertical,
                        Padding = UDim.new(0, var1.Gap.Small)
                    },
                    scroll = {
                        ScrollingDirection = Enum.ScrollingDirection.Y,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        CanvasSize = UDim2.fromScale(0, 0)
                    },
                    LayoutOrder = 5
                }, (renderPlayerList(viewProps)))
            }),
            FriendsAllowed = React.createElement(
                View,
                { tag = "row align-y-center gap-medium size-full-0 auto-y", LayoutOrder = 3 },
                {
                    Text = React.createElement(View, {
                        tag = "col fill gap-xxsmall auto-y",
                        LayoutOrder = 1
                    }, {
                        Label = React.createElement(
                            FoundationText,
                            {
                                Text = viewProps.locales.friendsAllowed,
                                tag = "auto-xy text-body-medium content-emphasis",
                                LayoutOrder = 1
                            }
                        ),
                        Description = React.createElement(FoundationText, {
                            Text = viewProps.locales.friendsAllowedDescription,
                            tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-muted",
                            LayoutOrder = 2
                        })
                    }),
                    Toggle = React.createElement(Toggle, {
                        testId = "--purchase-prompt-toggle-friends-allowed",
                        label = "",
                        isChecked = viewProps.friendsAllowed,
                        onActivated = viewProps.onFriendsAllowedChanged,
                        LayoutOrder = 2
                    })
                }
            ),
            PrivateServerLink = renderPrivateServerLink(viewProps),
            Error = if viewProps.hasError then React.createElement(FoundationText, {
                testId = "--purchase-prompt-text-error",
                Text = viewProps.locales.somethingWentWrong,
                tag = "auto-xy text-body-medium content-system-alert",
                LayoutOrder = 5
            }) else nil
        })
    }
    tbl2.Content = createElement2(content, tbl3, tbl4)

    tbl2.Actions = React.createElement(Sheet.Actions, { LayoutOrder = 3 }, {
        Continue = React.createElement(Button, {
            testId = "--purchase-prompt-button-continue",
            text = viewProps.locales.continue,
            variant = ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill,
            onActivated = viewProps.onSave,
            isLoading = viewProps.isSaving
        })
    })
    return createElement(root, tbl1, tbl2)
end

return VIPServerConfigurationView
