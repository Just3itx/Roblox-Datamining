-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent
local FFlagPeopleTabUseProfileFrameThumbnail = require(PeopleReactView.Flags.FFlagPeopleTabUseProfileFrameThumbnail)

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local PeopleService = require(PeopleReactViewParent.PeopleService)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)
local UserProfiles = require(PeopleReactViewParent.UserProfiles)
local RobloxAppHooks = require(PeopleReactViewParent.RobloxAppHooks)
local RobloxAppEnums = require(PeopleReactViewParent.RobloxAppEnums)

local Avatar = Foundation.Avatar
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useSignalBinding = SignalsReact.useSignalBinding
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation
local useIsRobloxSubscriber = UserProfiles.Hooks.useIsRobloxSubscriber

local useInExperienceCombinedName = require(PeopleReactView.Hooks.useInExperienceCombinedName)

local PlatformName = require(PeopleReactView.Components.Buttons.PlatformName)
local PersonButtonRow = require(PeopleReactView.Components.List.PersonButtonRow)
local PeoplePageLayoutContext = require(PeopleReactView.PeoplePageLayoutContext)

local formatUsername = UserProfiles.Formatters.formatUsername

local FFlagEnableBlackbirdCheck = require(PeopleReactViewParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagPeopleListButtonOverflow = require(PeopleReactView.Flags.FFlagPeopleListButtonOverflow)
local bool1 = game:DefineFastFlag("PlayerListRefactorUsernameFormatting", false)
local GetFFlagAddPeoplePageCardLayout = PeopleService.getService("Flags").GetFFlagAddPeoplePageCardLayout

local function PersonRow(tbl1)
    local var1 = useTokens()
    local bool2 = useDeviceOrientation() == RobloxAppEnums.DeviceOrientationMode.Portrait
    local var2 = React.useContext(PeoplePageLayoutContext)
    local col = bool2 or FFlagPeopleListButtonOverflow and var2.isCompact
    local var4 = if FFlagEnableBlackbirdCheck then useIsRobloxSubscriber(tostring(tbl1.person.UserId)) else nil
    local personRowRef = React.useRef(nil)

    local ref = React.useCallback(function(current)
        PeopleService.getService("FocusNavigationService").registerFrame(current, tbl1.person.UserId)
        personRowRef.current = current
    end, { tbl1.person.UserId })

    local var7

    if GetFFlagAddPeoplePageCardLayout() then
        var7 = useInExperienceCombinedName(tbl1.person.UserId, tbl1.person.DisplayName)
    else
        local var8 = React.useMemo(function()
            return PeopleService.getService("PeopleListStore")
        end, {})

        local var9 = React.useMemo(function()
            return var8.getProfile(tbl1.person.UserId)
        end, { tbl1.person.UserId })

        var7 = useSignalBinding(var9):map(function(arg1)
            return if arg1 and string.len(arg1) > 0 then arg1 else tbl1.person.DisplayName
        end)
    end

    local backgroundStyle = {
        Color3 = var1.Color.Shift.Shift_300.Color3,
        Transparency = var1.Color.Shift.Shift_300.Transparency
    }

    local element = React.createElement(Avatar, {
        userId = tbl1.person.UserId,
        size = InputSize.Large,
        backgroundStyle = backgroundStyle,
        includeProfileFrame = FFlagPeopleTabUseProfileFrameThumbnail,
        LayoutOrder = 1
    })

    local element2 = React.createElement(FoundationText, {
        Text = var7,
        textStyle = {
            Color3 = var1.Color.Content.Default.Color3
        },
        tag = "text-label-medium auto-xy text-align-x-left text-truncate-end",
        LayoutOrder = 1
    })

    local createElement = React.createElement
    local var8 = View
    local tbl3 = {
        tag = {
            ["padding-small row bg-surface-200 radius-medium"] = true,
            ["size-full-2600 gap-medium"] = col,
            ["size-full-1500"] = not col
        },
        LayoutOrder = tbl1.layoutOrder,
        ref = ref
    }
    local tbl4 = {
        PortraitAvatar = col and element or nil,
        RowContent = 0
    }
    local createElement2 = React.createElement
    local var9 = View
    local tbl5 = {
        tag = {
            ["gap-medium size-full align-y-center text-no-wrap"] = true,
            ["flex-between row"] = not col,
            col = col
        },
        LayoutOrder = 2
    }

    local tbl6 = { LeftContent = 0, RightContent = 0 }
    local createElement3 = React.createElement
    local var10 = View
    local tbl7 = {
        tag = {
            ["row gap-medium align-y-center text-no-wrap"] = true,
            ["size-full-0 auto-y"] = col,
            ["size-0-full auto-x"] = not col
        },
        LayoutOrder = 1
    }

    local tbl8 = {
        Avatar = not col and element or nil,
        NameContainer = 0
    }
    local createElement4 = React.createElement
    local var11 = View
    local tbl9 = { tag = "col gap-small auto-xy flex-evenly", LayoutOrder = 2 }

    local tbl10 = { DisplayName = 0, UserName = 0 }
    if FFlagEnableBlackbirdCheck and var4 then
        element2 = React.createElement(View, {
            tag = "row gap-xsmall auto-xy align-y-center",
            LayoutOrder = 1
        }, {
            Name = element2,
            SubscriptionBadge = React.createElement(Icon, {
                name = IconName.RobloxPlus,
                size = IconSize.Small,
                style = {
                    Color3 = var1.Color.Content.Default.Color3
                },
                LayoutOrder = 2
            })
        })
    end

    tbl10.DisplayName = element2

    tbl10.UserName = React.createElement(FoundationText, {
        Text = if bool1 then formatUsername(tbl1.person.Name) else "@" .. tbl1.person.Name,
        tag = "text-caption-small auto-xy text-align-x-left content-muted text-truncate-end",
        LayoutOrder = 2
    })
    tbl8.NameContainer = createElement4(var11, tbl9, tbl10)
    tbl6.LeftContent = createElement3(var10, tbl7, tbl8)

    tbl6.RightContent = React.createElement(View, {
        tag = "row auto-x size-0-1000 gap-medium",
        LayoutOrder = 2
    }, {
        PersonButtonRow = React.createElement(
            PersonButtonRow,
            {
                userId = tbl1.person.UserId,
                index = tbl1.layoutOrder,
                personRowRef = personRowRef
            }
        ),
        PlatformNameSection = React.createElement(PlatformName, { UserId = tbl1.person.UserId })
    })
    tbl4.RowContent = createElement2(var9, tbl5, tbl6)
    return createElement(var8, tbl3, tbl4)
end

return PersonRow
