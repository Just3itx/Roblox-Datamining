-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local React = require(UserSearchParent.React)

local UIBlox = require(UserSearchParent.UIBlox)
local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconButton = UIBlox.App.Button.IconButton
local Images = UIBlox.App.ImageSet.Images

local AppHeaderBar = require(UserSearchParent.AppHeaderBar)

local useLocalization = require(UserSearchParent.Localization).Hooks.useLocalization

local UserSearchHeaderInput = require(script.Parent.UserSearchHeaderInput)

local FFlagUserSearchGoBackOnCancel = require(UserSearchParent.SharedFlags).FFlagUserSearchGoBackOnCancel

local function UserSearchHeaderBar(tbl1)
    local searchKeyword = tbl1.searchKeyword
    local onSubmitSearch = tbl1.onSubmitSearch
    local onBackClick = tbl1.onBackClick
    local focusOnSearchInput = tbl1.focusOnSearchInput
    local headerHeight = tbl1.headerHeight

    local var1 = useLocalization({
        titleText = "Feature.AddFriends.Label.InputPlaceholder.SearchForPeopleAltCapitalization",
        placeholderText = "Feature.AddFriends.Label.InputPlaceholder.SearchForPeopleAltCapitalization",
        cancelText = "Feature.Chat.Action.Cancel"
    })

    local shouldHideSecondaryLeftItem, var3 = React.useState(true)
    local captureFocusOnMount, var5 = React.useState(focusOnSearchInput)
    local initialInputText, var7 = React.useState(searchKeyword)

    local onActivated = React.useCallback(function()
        var3(true)
        var5(true)
    end, {})

    local onCancel = React.useCallback(function()
        if FFlagUserSearchGoBackOnCancel then
            var7("")
            onBackClick()
            return
        end
        var3(false)
        var7("")
    end, { if FFlagUserSearchGoBackOnCancel then onBackClick else nil })

    local renderLeft = React.useMemo(function()
        if shouldHideSecondaryLeftItem then
            return function() end
        end
        return AppHeaderBar.makeBackButton(function()
            onBackClick()
        end)
    end, { shouldHideSecondaryLeftItem, onBackClick })

    local renderCenter = React.useCallback(function()
        if not shouldHideSecondaryLeftItem then
            return nil
        end
        return React.createElement(UserSearchHeaderInput, {
            initialInputText = initialInputText,
            searchPlaceholderText = var1.placeholderText,
            cancelText = var1.cancelText,
            captureFocusOnMount = captureFocusOnMount,
            onSubmit = onSubmitSearch,
            onCancel = onCancel
        })
    end, {
        shouldHideSecondaryLeftItem,
        searchKeyword,
        captureFocusOnMount,
        onSubmitSearch,
        onCancel,
        var1.placeholderText,
        var1.cancelText
    })

    local renderRight = React.useCallback(function()
        if shouldHideSecondaryLeftItem then
            return nil
        end
        return React.createElement(
            IconButton,
            {
                size = UDim2.fromOffset(0, 0),
                icon = Images["icons/common/search"],
                onActivated = onActivated
            }
        )
    end, { shouldHideSecondaryLeftItem, onActivated })

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, headerHeight)
    }, {
        headerBar = React.createElement(HeaderBar, {
            title = var1.titleText,
            renderLeft = renderLeft,
            renderCenter = renderCenter,
            renderRight = renderRight,
            shouldHideSecondaryLeftItem = shouldHideSecondaryLeftItem,
            barHeight = headerHeight,
            isSecondary = true,
            paddingTop = UDim.new(0, 0),
            paddingBottom = UDim.new(0, 0)
        })
    })
end

return UserSearchHeaderBar
