-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent
local Context = FriendsMenu.Context

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local normalizeFontFace = require(FriendsMenuParent.Foundation).Utility.normalizeFontFace
local useLocalization = require(FriendsMenuParent.Localization).Hooks.useLocalization
local Responsive = require(FriendsMenuParent.Responsive)
local useFocusGuiObject = require(FriendsMenuParent.ReactFocusNavigation).useFocusGuiObject
local useLastInputMode = require(FriendsMenuParent.FocusNavigationUtils).useLastInputMode

local useStyle = UIBlox.Core.Style.useStyle

local Constants = require(FriendsMenu.Constants)
local FriendsMenuUserCard = require(script.Parent.FriendsMenuUserCard)
local SelectedUsersContext = require(Context.SelectedUsersContext)

return function(tbl1)
    local var1 = React.useContext(SelectedUsersContext)
    local var2 = Responsive.useBreakpointYOrLarger(Responsive.Keys.Medium)

    local var3 = useLastInputMode()
    local var4 = useFocusGuiObject()

    local var5 = React.useRef({})
    local var6 = React.useRef(nil)

    local var7 = useStyle()
    local theme = var7.Theme
    local font = var7.Font

    local var8 = useLocalization({
        selectedFriendsCountText = {
            "Feature.FriendsMenu.Label.SelectedFriendsCount",
            numerator = var1.selectedFriendsSize,
            denominator = tbl1.selectionLimit
        },
        selectedFriendsCountNoLimitText = {
            "Feature.FriendsMenu.Label.SelectedFriendsCountNoLimit",
            selectedCount = var1.selectedFriendsSize
        }
    })

    local var9 = React.useMemo(function()
        var5.current = {}
        local result = ({})
        result.UIListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        local tbl2 = {}
        for userId, userData in pairs(var1.selectedFriends) do
            table.insert(tbl2, { userId = userId, userData = userData })
        end
        table.sort(tbl2, function(arg1, arg2): boolean
            return arg1.userData.layoutOrder < arg2.userData.layoutOrder
        end)

        for current, value in ipairs(tbl2) do
            local userId = value.userId
            local userData = value.userData

            local str1 = "User-" .. tostring(userId)
            local createElement = React.createElement
            local var9 = FriendsMenuUserCard
            local tbl3 = {
                displayName = userData.displayName,
                layoutOrder = userData.layoutOrder,
                userId = userId,
                unremovable = userData.unremovable,
                onRemoved = 0,
                ref = 0
            }

            function tbl3.onRemoved()
                var6.current = current
            end
            function tbl3.ref(arg1)
                var5.current[current] = arg1
            end

            result[str1] = createElement(var9, tbl3)
        end

        return result
    end, { var1.selectedFriends })

    React.useEffect(function()
        if not var6.current or var3 ~= "Focus" then
            return
        end

        local current = var5.current
        local currentLen = #current
        if currentLen == 0 then
            var6.current = nil
            return
        end

        local var10 = current[math.clamp(var6.current, 1, currentLen)]
        if var10 and var10.Parent then
            var4(var10)
        end

        var6.current = nil
    end, { var1.selectedFriends, var4, var3 })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        VerticalLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        SelectedFriendsText = React.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var7.Tokens.Typography.TitleLarge.Font),
            LayoutOrder = 0,
            Text = if tbl1.selectionLimit then var8.selectedFriendsCountText else var8.selectedFriendsCountNoLimitText,
            TextColor3 = theme.TextEmphasis.Color,
            TextSize = font.BaseSize * font.Header2.RelativeSize,
            TextTransparency = theme.TextEmphasis.Transparency,
            TextXAlignment = Enum.TextXAlignment.Left
        }),
        SelectedUsers = 0
    }
    local element

    if var1.selectedFriendsSize == 0 or not var2 then
        element = nil
    else
        element = React.createElement("ScrollingFrame", {
            Size = UDim2.new(1, 0, 0, Constants.FRIEND_MENU_CARD_SIZE),
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.X,
            Selectable = false
        }, var9)
    end

    tbl3.SelectedUsers = element
    return createElement(str1, tbl2, tbl3)
end
