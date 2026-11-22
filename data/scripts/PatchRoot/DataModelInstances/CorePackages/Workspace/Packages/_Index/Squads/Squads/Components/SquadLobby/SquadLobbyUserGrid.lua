-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local dependencies = require(Squads.dependencies)

local SquadsParent = Squads.Parent
local React = require(SquadsParent.React)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local Cryo = dependencies.Cryo
local Foundation = dependencies.Foundation
local Roact = dependencies.Roact
local useSelector = dependencies.Hooks.useSelector
local SquadState = require(SquadsParent.SquadsCore.Enums).SquadState
local useSquadState = require(SquadsParent.SquadsCore.Hooks).useSquadState

local useTokens = Foundation.Hooks.useTokens

local _ModelTypes = require(Squads.Common.ModelTypes)
local SquadUserPartyStatus = require(Squads.Enums.SquadUserPartyStatus)

local SquadLobbyUserCard = require(script.Parent.SquadLobbyUserCard)
local SquadLobbyUpsellCard = require(script.Parent.SquadLobbyUpsellCard)

local FFlagEnableSquadRegroupExperimentationSmallScreenFix = require(SquadsParent.SharedFlags).FFlagEnableSquadRegroupExperimentationSmallScreenFix

return function(tbl1)
    local var1 = useTokens()
    local num1 = tonumber(useLocalUserId()) or 0
    local var2 = useSquadState()

    local medium = var1.Gap.Medium
    local xLarge = var1.Padding.XLarge
    local var3, var4, var5 = React.useMemo(function()
        if tbl1.containerSize.Y == 0 or tbl1.containerSize.X == 0 then
            return Vector2.new(0, 0), 0, 0
        end

        local var3 = tbl1.containerSize.X - xLarge * 2
        local var4 = var3 / tbl1.containerSize.Y

        local var5 = if var2 == SquadState.Active then math.max(#Cryo.List.filter(tbl1.users, function(arg1): boolean
            return arg1.partyStatus ~= SquadUserPartyStatus.Inactive
        end), 2) else 1

        local bool1 = var5 <= 3 and var4 > 1.75 and var5 * 120 + (var5 - 1) * medium <= var3
        local var6

        if bool1 then
            var6 = var5
            var5 = 1
        elseif var5 <= 3 then
            var6 = 1
        else
            var5 = math.ceil(var5 / 2)
            var6 = 2
        end

        local num2 = math.min(var5, math.clamp(math.floor((tbl1.containerSize.Y + medium) / (120 + medium)), 1, 3))

        local x = (var3 + medium) / var6 - medium
        local y = if FFlagEnableSquadRegroupExperimentationSmallScreenFix then math.max(120, tbl1.containerSize.Y + medium) / num2 - medium else (tbl1.containerSize.Y + medium) / num2 - medium
        return Vector2.new(x, y), var5, var6
    end, {
        medium,
        tbl1.containerSize,
        tbl1.users,
        xLarge
    })
    local var6 = React.useCallback(function(arg1)
        return arg1.Squad.UserBlocking.isBlockedByMe
    end, {})

    local var7 = useSelector(var6)

    local var8 = React.useMemo(function()
        if var3.X == 0 or var3.Y == 0 then
            return {}
        end

        local tbl2 = {}

        local function func1(layoutOrder, user, isConnecting: boolean)
            return React.createElement(SquadLobbyUserCard, {
                size = UDim2.fromOffset(var3.X, var3.Y),
                isBlocked = var7[tostring(user.userId)],
                isConnecting = isConnecting,
                layoutOrder = layoutOrder,
                onActivated = tbl1.onUserCardActivated,
                user = user,
                isInExperience = tbl1.isInExperience,
                openSquadVoiceAbuseReport = tbl1.openSquadVoiceAbuseReport
            })
        end

        for i, user in ipairs(tbl1.users) do
            if user.partyStatus == SquadUserPartyStatus.Inactive then
                continue
            end
            if user.userId == num1 then
                local isConnecting = user.partyStatus == SquadUserPartyStatus.Connecting
                table.insert(tbl2, func1(0, user, isConnecting))
            else
                local isConnecting = user.partyStatus == SquadUserPartyStatus.Connecting
                table.insert(tbl2, func1(i, user, isConnecting))
            end
        end

        if #tbl2 == 1 and var2 ~= SquadState.Initializing then
            table.insert(
                tbl2,
                (React.createElement(SquadLobbyUpsellCard, {
                    size = UDim2.fromOffset(var3.X, var3.Y),
                    layoutOrder = #tbl2 + 1,
                    navigateToHomePage = tbl1.navigateToHomePage,
                    navigateToSquadInviteFriends = tbl1.navigateToSquadInviteFriends
                }))
            )
        end

        local result = ({})
        for layoutOrder = 1, var4 do
            local tbl3 = ({})

            for j = 1, var5 do
                local var8 = (layoutOrder - 1) * var5 + j
                if tbl2[var8] then
                    tbl3["Card" .. var8] = tbl2[var8]
                end
            end

            tbl3.UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, medium)
            })

            local str1 = "Row" .. layoutOrder
            result[str1] = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, var3.Y),
                    BackgroundTransparency = 1,
                    LayoutOrder = layoutOrder
                },
                tbl3
            )
        end

        return result
    end, {
        var3,
        medium,
        var7,
        num1,
        var5,
        var4,
        tbl1.navigateToHomePage,
        tbl1.navigateToSquadInviteFriends,
        tbl1.onUserCardActivated,
        tbl1.openSquadVoiceAbuseReport,
        tbl1.users,
        var2
    })

    var8.UIListLayout = React.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, medium)
    })

    var8.UIPadding = React.createElement(
        "UIPadding",
        {
            PaddingBottom = tbl1.paddingBottom,
            PaddingLeft = UDim.new(0, xLarge),
            PaddingRight = UDim.new(0, xLarge)
        }
    )
    return Roact.createFragment(var8)
end
